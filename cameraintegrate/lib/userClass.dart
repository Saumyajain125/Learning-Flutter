class User {
  String firstName, lastName, email, mobile;

  User(this.firstName, this.lastName, this.email, this.mobile);

  User.def() {
    this.firstName = 'nothing';
    this.lastName = 'nohtig';
    this.email = '.com';
    this.mobile = '0000000000';
  }

  String get fn {
    return this.firstName;
  }

  set fn(String val) {
    this.firstName = val;
  }
}