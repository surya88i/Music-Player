class User
{
  final String title;
  final String imgPath;
  final String subtitle;
  User({this.title,this.imgPath,this.subtitle});
}
List<User> getUsers(){
  return <User>[
    User(title: "Hamburg",imgPath: "assets/images/burger.png",subtitle: "Tasty Flutter"),
    User(title: "Burger",imgPath: "assets/images/sandwich.png",subtitle: "Tasty Flutter"),
    User(title:"Taco",imgPath: "assets/images/taco.png",subtitle: "Tasty Flutter"),
  ];
}