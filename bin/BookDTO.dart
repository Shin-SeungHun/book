class BookDTO {
  String name;
  String author;
  int price;
  Set<int> nums; // 중복되지 않도록 고유번호는 set값으로 저장

  BookDTO(this.name, this.author, this.price, this.nums);

  @override
  String toString() {
    return '도서 이름 : $name, 도서 저자 : $author, 도서 가격 : $price, 도서 고유번호 : $nums\n';
  }
}
