class TodoData {
  String time;
  String content;

  TodoData(this.time, this.content);

  TodoData.fromJson(Map<String, dynamic> json) {
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
