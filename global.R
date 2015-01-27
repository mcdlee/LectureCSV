# import member and timetable
member <- read.csv("conf/member.csv", fileEncoding="big5")
timing <- read.csv("conf/timing.csv", fileEncoding="big5")
type <- read.csv("conf/type-list.csv", fileEncoding="big5")
city <- read.csv("conf/city.csv", fileEncoding="big5")

# For choice of member
member_choice <- member$number
names(member_choice) <- member$name

# For choice of timing
timing_choice <- timing$number
names(timing_choice) <- timing$type

# For type
type_choice <- type$id
names(type_choice) <- type$classification

# For city
city_choice <- sprintf("%.2d", city$id)
names(city_choice) <- city$city

filtered <- function(cond, table){
  A <- subset(table, number %in% cond)
  return(A)
}


# For ROC
ROCdate <- function(date) {
  charDay <- as.character.Date(date, format = "%m-%d")
  charYear <- as.integer(as.character.Date(date, format = "%Y"))-1911
  return(paste(charYear, charDay, sep="-"))
}


old_form <- function(lec_number, lec_name, lec_type, lec_date, lec_time, lec_city, member_table){
  B <- data.frame(member_table$id,
                  lec_name,
                  lec_date,
                  member_table$name,
                  "6", lec_type, lec_city, "1",
                  lec_date,
                  lec_time$digitalCredit + lec_time$physicalCredit, "1",
                  "", "", "", "",
                  "2", lec_time$digitalCredit, lec_time$physicalCredit,
                  lec_number)
  colnames(B) <- c("*身分證字號",
                   "*名稱",
                   "*起始日期",
                   "*姓名",
                   "*學位學分",	"*班別類別", "*上課縣市", "期別", 
                   "*終迄日期",
                   "*訓練總數", "*訓練總數單位",
                   "訓練成績", "證件字號", "出勤上課狀況", "生日",
                   "*學習性質", "*數位時數", "*實體時數",
                   "課程代碼")
  return(B)
}

new_form <- function(lec_number, lec_name, lec_type, lec_date, lec_time, lec_city, member_table){
  C <- data.frame(member_table$id,
                  lec_name,
                  lec_date,
                  lec_time$since,
                  lec_date,
                  lec_time$to,
                  member_table$name,
                  "6", lec_type, lec_city, "1",
                  lec_time$digitalCredit + lec_time$physicalCredit, "1",
                  "", "", "", "",
                  "2", lec_time$digitalCredit, lec_time$physicalCredit,
                  lec_number,
                  lec_date,
                  lec_time$since,
                  lec_date,
                  lec_time$to)
  colnames(C) <- c("*身分證字號",
                   "*課程名稱",
                   "*開課起始日期",
                   "*開課起始時間",
                   "*開課結束日期",
                   "*開課結束時間",
                   "*姓名",
                   "*學位學分",  "*課程類別代碼", "*上課縣市", "期別",
                   "*訓練總數",  "*訓練總數單位",
                   "訓練成績", "證件字號", "出勤上課狀況", "生日",
                   "*學習性質", "*數位時數", "*實體時數",
                   "課程代碼",
                   "*實際上課起始日期",
                   "*實際上課起始時間",
                   "*實際上課結束日期",
                   "*實際上課結束時間")
  return(C)
}