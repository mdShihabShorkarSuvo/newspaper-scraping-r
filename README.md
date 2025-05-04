# 📰 Newspaper Scraper Using R

This project scrapes news articles about **Bangladesh** from the online edition of an international newspaper using **R** and **RSelenium**. The goal is to collect a relevant corpus for **natural language processing (NLP)**, **sentiment analysis**, or **topic modeling** tasks.

The script navigates dynamic webpages using **Selenium**, extracts article titles, content, dates, and URLs, and saves them into a structured **CSV file**. This dataset can later be used in various R-based text mining and analysis workflows.

---

## ✅ Key Features

- Web scraping of dynamic content using **RSelenium**
- Extraction of **title**, **body text**, **publication date**, and **links**
- Data cleaning and formatting into a **CSV corpus**
- Suitable for **text analysis**, **LDA**, **emotion detection**, and more

---

## 📌 Use Cases

- Building a **news corpus** focused on **Bangladesh**
- **Academic research** or **media analysis**
- Training **topic models** or **sentiment classifiers**

---

## ⚙️ Installation & Usage

1. **Install Required R Packages**:

```r
install.packages("RSelenium")
install.packages("rvest")
install.packages("dplyr")
