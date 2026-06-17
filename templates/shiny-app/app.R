# ============================================
# Quarto Craft - Shiny App Template
# ============================================
# Pretendard + bslib 기반 한국어 대시보드

library(shiny)
library(bslib)

# --- Quarto Craft 테마 ---
quarto_craft_theme <- bs_theme(
  version = 5,
  preset = "shiny",

  # 색상 토큰
  primary   = "#4F46E5",
  secondary = "#525252",
  success   = "#10B981",
  info      = "#3B82F6",
  warning   = "#F59E0B",
  danger    = "#EF4444",
  bg        = "#FFFFFF",
  fg        = "#171717",


  # 타이포그래피 토큰
  base_font = font_google("Noto Sans KR", wght = c(300, 400, 500, 600, 700)),
  code_font = font_google("JetBrains Mono", wght = c(400, 500, 700)),
  heading_font = font_google("Noto Sans KR", wght = c(600, 700)),
  font_scale = 1.0,

  # 간격 / 모서리
  "border-radius" = "0.5rem",
  "card-border-radius" = "0.75rem"
)

# --- UI ---
ui <- page_navbar(
  title = tags$span(
    tags$img(src = "logo-favicon.svg", height = "28px", style = "margin-right: 8px; vertical-align: middle;"),
    "Quarto Craft"
  ),
  theme = quarto_craft_theme,
  lang = "ko",
  fillable = TRUE,

  # 탭 1: 개요
  nav_panel(
    title = "개요",
    icon = icon("chart-line"),

    layout_columns(
      col_widths = c(4, 4, 4),

      value_box(
        title = "총 항목",
        value = textOutput("total_count"),
        showcase = icon("database"),
        theme = "primary"
      ),
      value_box(
        title = "평균값",
        value = textOutput("mean_value"),
        showcase = icon("calculator"),
        theme = "success"
      ),
      value_box(
        title = "최대값",
        value = textOutput("max_value"),
        showcase = icon("arrow-up"),
        theme = "info"
      )
    ),

    layout_columns(
      col_widths = c(8, 4),

      card(
        card_header("데이터 시각화"),
        plotOutput("main_plot", height = "400px")
      ),
      card(
        card_header("요약 통계"),
        tableOutput("summary_table")
      )
    )
  ),

  # 탭 2: 데이터
  nav_panel(
    title = "데이터",
    icon = icon("table"),

    layout_sidebar(
      sidebar = sidebar(
        title = "필터",
        selectInput("dataset", "데이터셋",
          choices = c("mtcars", "iris", "airquality"),
          selected = "mtcars"
        ),
        sliderInput("n_rows", "표시 행 수",
          min = 5, max = 50, value = 15
        )
      ),

      card(
        card_header("데이터 테이블"),
        DT::DTOutput("data_table")
      )
    )
  ),

  # 탭 3: 정보
  nav_panel(
    title = "정보",
    icon = icon("info-circle"),

    card(
      card_header("Quarto Craft 디자인 시스템"),
      card_body(
        markdown("
### 디자인 토큰

이 Shiny 앱은 **Quarto Craft** 디자인 시스템의 토큰을 `bslib` 테마에 매핑하여 사용합니다.

| 토큰 | 값 | 용도 |
|------|-----|------|
| Primary | `#4F46E5` | 주요 강조색 (인디고) |
| Success | `#10B981` | 성공/긍정 상태 |
| Warning | `#F59E0B` | 주의/경고 상태 |
| 본문 폰트 | Noto Sans KR | 한국어 본문 |
| 코드 폰트 | JetBrains Mono | 코드 블록 |

### 사용 방법

`quarto_craft_theme`를 `bs_theme()` 대신 사용하면 동일한 디자인 시스템이 적용됩니다.
        ")
      )
    )
  ),

  nav_spacer(),
  nav_item(
    tags$a(
      icon("github"), "GitHub",
      href = "https://github.com",
      target = "_blank",
      class = "nav-link"
    )
  )
)

# --- Server ---
server <- function(input, output, session) {

  # 데이터 선택
  selected_data <- reactive({
    switch(input$dataset,
      "mtcars" = mtcars,
      "iris" = iris,
      "airquality" = airquality
    )
  })

  # 개요 탭
  output$total_count <- renderText({
    format(nrow(selected_data()), big.mark = ",")
  })

  output$mean_value <- renderText({
    round(mean(selected_data()[[1]], na.rm = TRUE), 1)
  })

  output$max_value <- renderText({
    round(max(selected_data()[[1]], na.rm = TRUE), 1)
  })

  output$main_plot <- renderPlot({
    df <- selected_data()
    col1 <- names(df)[1]
    col2 <- names(df)[2]

    par(
      family = "sans",
      mar = c(4, 4, 2, 1),
      bg = "#FFFFFF",
      col.axis = "#525252",
      col.lab = "#404040"
    )

    plot(df[[1]], df[[2]],
      pch = 19, col = adjustcolor("#4F46E5", alpha.f = 0.6),
      cex = 1.2,
      xlab = col1, ylab = col2,
      main = paste(col1, "vs", col2),
      col.main = "#171717",
      font.main = 2
    )
    grid(col = "#E5E5E5", lty = 1)
  })

  output$summary_table <- renderTable({
    df <- selected_data()
    data.frame(
      "통계" = c("행 수", "열 수", "평균 (1열)", "표준편차 (1열)"),
      "값" = c(
        nrow(df),
        ncol(df),
        round(mean(df[[1]], na.rm = TRUE), 2),
        round(sd(df[[1]], na.rm = TRUE), 2)
      )
    )
  }, striped = TRUE, hover = TRUE, bordered = FALSE)

  # 데이터 탭
  output$data_table <- DT::renderDT({
    df <- head(selected_data(), input$n_rows)
    DT::datatable(df,
      options = list(
        pageLength = 10,
        language = list(
          search = "검색:",
          lengthMenu = "_MENU_ 행 표시",
          info = "_TOTAL_ 건 중 _START_-_END_",
          paginate = list(previous = "이전", `next` = "다음")
        )
      ),
      class = "stripe hover"
    )
  })
}

shinyApp(ui, server)
