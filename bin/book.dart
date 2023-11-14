import 'dart:io';
import 'dart:math';
import 'BookDTO.dart';

int? nums;
List bookList = [];

void main() {
  init();
}

void init() {
  // 사용자로부터 입력 받기

  // 입력 받은 내용 출력
//  print('선택 : $userInput');
  while (true) {
    print("1. 도서 등록, 2. 전체 도서 목록, 3. 도서 조회, 4. 도서 삭제, 5. 도서 정보 수정, 0. 프로그램 종료");

    String userInput = stdin.readLineSync()!;

    // 문자열을 숫자로 변환
    int input = int.parse(userInput);

    switch (input) {
      case 0:
        print('프로그램이 종료되었습니다.');
        return;
      case 1:
        bookRegist(); // 등록
        break;
      case 2:
        getBookList(); // 전체 리스트
        break;
      case 3:
        searchBook(); // 조회
        break;
      case 4:
        bookDel(); // 삭제
        break;
      case 5:
        bookEdit(); // 정보 수정
        break;
      default:
        print('0~5만 입력하세요');
        break;
    }
  }
}

void bookEdit() {
  while (true) {
    print("1. 도서 수정하기, 2. 돌아가기");

    String userInput = stdin.readLineSync()!;
    // 문자열을 숫자로 변환
    int input = int.parse(userInput);

    switch (input) {
      case 1:
        edit(); // 수정
        break;
      case 2:
//        print('2. 돌아가기'); // 돌아가기
        return;

      default:
        print('1~2만 입력하세요');
        break;
    }
  }
}

void edit() {
  print('수정하실 도서의 고유 번호를 입력해주세요 : ');
  String bookNums = stdin.readLineSync()!;

  // 입력값과 일치하는 도서 찾기
  var foundBooks =
      bookList.where((book) => book.nums.contains(int.tryParse(bookNums)));

  if (foundBooks.isNotEmpty) {
    print('조회한 도서:');
    foundBooks.forEach((book) => print(book));

    // 수정 여부 확인
    print('위 도서를 수정하시겠습니까? (y/n): ');
    String equals = stdin.readLineSync()!;

    if (equals == 'y') {
      // 조회한 도서 수정
      if (foundBooks.length == 1) {
        BookDTO bookToEdit = foundBooks.first;

        // 수정할 정보 입력
        print('수정할 도서 이름: ');
        String? editBookName = stdin.readLineSync();
        print('수정할 도서 저자: ');
        String? editAuthor = stdin.readLineSync();
        print('수정할 도서 가격: ');
        String editPrice = stdin.readLineSync()!;
        int editBookPrice = int.parse(editPrice);

        // 도서 수정
        bookList.remove(bookToEdit); // 기존 도서 삭제
        bookToEdit.name = editBookName ?? bookToEdit.name;
        bookToEdit.author = editAuthor ?? bookToEdit.author;
        bookToEdit.price = editBookPrice;
        bookList.add(bookToEdit); // 수정된 도서 추가

        print('도서가 수정되었습니다.');

        print('수정한 도서 : $bookToEdit');
      }
    } else {
      print('도서 수정을 취소했습니다.');
    }
  } else {
    print('일치하는 도서를 찾을 수 없습니다.');
  }
}

void bookDel() {
  while (true) {
    print("1. 도서 삭제하기, 2. 돌아가기");

    String userInput = stdin.readLineSync()!;
    // 문자열을 숫자로 변환
    int input = int.parse(userInput);

    switch (input) {
      case 1:
        del(); // 삭제
        break;
      case 2:
//        print('2. 돌아가기'); // 돌아가기
        return;

      default:
        print('1~2만 입력하세요');
        break;
    }
  }
}

void del() {
  print('삭제하실 도서의 고유 번호를 입력해주세요: ');
  String bookNums = stdin.readLineSync()!;

  // 입력값과 일치하는 도서 찾기
  var foundBooks =
      bookList.where((book) => book.nums.contains(int.tryParse(bookNums)));

  if (foundBooks.isNotEmpty) {
    print('조회한 도서:');
    foundBooks.forEach((book) => print(book));

    // 삭제 여부 확인
    print('위 도서를 삭제하시겠습니까? (y/n): ');
    String equals = stdin.readLineSync()!;
    if (equals == 'y') {
      // 조회한 도서 삭제
      bookList.removeWhere((book) => foundBooks.contains(book));
      print('도서가 삭제되었습니다.');
    } else {
      print('도서 삭제를 취소했습니다.');
    }
  } else {
    print('일치하는 도서를 찾을 수 없습니다.');
  }
}

void searchBook() {
  print("도서 목록 조회");

  while (true) {
    print("1. 도서 고유번호 조회, 2. 도서 이름 조회, 3. 돌아가기");

    String userInput = stdin.readLineSync()!;
    // 문자열을 숫자로 변환
    int input = int.parse(userInput);

    switch (input) {
      case 1:
        searchNums(); // 번호 조회
        break;
      case 2:
        searchBookName(); // 이름 조회
        break;
      case 3:
        return;

      default:
        print('1~3만 입력하세요');
        break;
    }
  }
}

void searchNums() {
  print("조회하실 도서의 고유번호를 입력해주세요 : ");
  String bookNums = stdin.readLineSync()!;

  // 입력값과 일치하는 도서 찾기
  var foundBooks =
      bookList.where((book) => book.nums.contains(int.tryParse(bookNums)));

  if (foundBooks.isNotEmpty) {
    print('조회한 도서:');
    foundBooks.forEach((book) => print(book));
  } else {
    print('일치하는 도서를 찾을 수 없습니다.');
  }
}

void searchBookName() {
  print("조회하실 도서의 이름을 입력해주세요 : ");
  String bookName = stdin.readLineSync()!;

  // 입력값과 일치하는 도서 찾기
  var foundBooks = bookList.where((book) => book.name == bookName);

  if (foundBooks.isNotEmpty) {
    print('조회한 도서 목록 : ');
    foundBooks.forEach((book) => print(book));
  } else {
    print('일치하는 도서를 찾을 수 없습니다.');
  }
}

void getBookList() {
  print('전체 도서 목록');
  print(bookList);
}

void bookRegist() {
  print("도서 등록");
  while (true) {
    print("1. 도서 등록하기, 2. 돌아가기");

    String userInput = stdin.readLineSync()!;
    // 문자열을 숫자로 변환
    int input = int.parse(userInput);

    switch (input) {
      case 1:
        regist(); // 등록
        break;
      case 2: // 돌아가기
        return;

      default:
        print('1~2만 입력하세요');
        break;
    }
  }
}

void regist() {
  print('등록할 도서 이름 : ');
  String? bookName = stdin.readLineSync()!;

  print('등록할 도서 저자 : ');
  String? author = stdin.readLineSync()!;

  print('등록할 도서 가격 : ');
  String price = stdin.readLineSync()!;

  // 문자열을 숫자로 변환
  int bookPrice = int.parse(price);

  nums = Random().nextInt(9000) + 1000; // 4자리 숫자 생성 - 1000 이상 9999 이하

  BookDTO book =
      BookDTO(bookName, author, bookPrice, {nums!}); // Set으로 초기화할 때에는 중괄호 {} 사용

  print('등록한 도서 :\n $book');

  bookList.add(book); // list에 book인스턴스 추가
//  print(bookList);
}
