class TodayTodoData {
  String time;
  String content;

  TodayTodoData(this.time, this.content);

  TodayTodoData.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['content'] = this.content;
    return data;
  }
}
