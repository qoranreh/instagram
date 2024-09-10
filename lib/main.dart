
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:instagram/notification.dart';
import 'package:instagram/notification_servic.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initalizeApp(
    options: DefaultFire
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=> Store1()),
          ChangeNotifierProvider(create: (c)=> Store2())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: style.theme,
           home: MyApp()
          ),
      )
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


//변수 넣는 곳
var tap =0;
var images = ['assets/images.jpeg','assets/images (1).jpeg','assets/Instagram1.jpeg'];
var imagesNum=0;
var data=[];//왜 얘 MyApp class 안에 못넣음?



class _MyAppState extends State<MyApp> {
  var userImage;//이미지 저장
  var userContent;

//함수넣는 곳
saveData() async{
  var storage = await SharedPreferences.getInstance();//저장공간을 쓰기위해 오픈.
  var map= {'age' : 20};
  storage.setString('map', jsonEncode(map));
  var result = storage.get('map');

  print(result);

}
  getData()async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    //링크 변수에 넣어쓰기
    var result2=jsonDecode(result.body);
    setState(() {
      data=result2;
    });
  }
  setUserContent(a){
    setState(() {
      userContent=a;
    });
  }
  addMyData(){
    var myData = {//유저의 게시물 완성
      'id': data.length,
      'image': userImage,
      'likes':5,
      'date':'July 25',
      'content': userContent,
      'liked' : false,
      'user':'John Kim'
    };
    setState(() {//datestate에 이 게시물 넣기 .
      data.insert(0, myData);
    });
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getData();
    saveData();
    initNotification(context);
    _requestNotificationPermissions();
  }
  void _requestNotificationPermissions() async {
    //알림 권한 요청
    final status = await NotificationService().requestNotificationPermissions();
    if (status.isDenied && context.mounted) {
      showDialog(
        // 알림 권한이 거부되었을 경우 다이얼로그 출력
        context: context,
        builder: (context) => AlertDialog(
          title: Text('알림 권한이 거부되었습니다.'),
          content: Text('알림을 받으려면 앱 설정에서 권한을 허용해야 합니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('설정'), //다이얼로그 버튼의 죄측 텍스트
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); //설정 클릭시 권한설정 화면으로 이동
              },
            ),
            TextButton(
              child: Text('취소'), //다이얼로그 버튼의 우측 텍스트
              onPressed: () => Navigator.of(context).pop(), //다이얼로그 닫기
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: (){
          showNotification();
          NotificationService();
      },),
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
              onPressed: ()async{

                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                if(image != null){
                  setState(() {
                    userImage = File(image.path);
                  });
                }
    
                Navigator.push(context,
                    MaterialPageRoute(builder: (c)=>
                        Upload(
                        userImage:userImage,
                        setUserContent: setUserContent,
                        addMyData:addMyData
                        )
                    
                    )
                );
              },
              icon: Icon(Icons.add_box_outlined,)
          )
        ],
      ),
      body: [homeMain(data:data,images:images),Text('샵페이지')][tap]
      ,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tap=i;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: '쇼핑')
      ],)
    );

  }
}
class homeMain extends StatefulWidget {
   homeMain({super.key,this.data,this.images});
  final data;
  final images;

  @override
  State<homeMain> createState() => _homeMainState();
}
class _homeMainState extends State<homeMain> {
  var scroll= ScrollController();
  var result3;
  var result4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener((){
      if(scroll.position.pixels==scroll.position.maxScrollExtent) {
        result3 = http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
          //링크 변수에 넣어쓰기
        setState(() {
          data.add(jsonDecode(result3));
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: widget.data.length, controller:scroll,itemBuilder: (c,i){
        if(widget.data.isNotEmpty){

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                  children: [

                    Container(
                        child:
                        widget.data[i]['image'].runtimeType==String
                            ?Image.network(widget.data[i]['image'])
                            : Image.file(widget.data[i]['image'])

                    )
                    ,
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              child: Text(widget.data[i]['user']),
                              onTap: (){
                                Navigator.push(context,
                                PageRouteBuilder(
                                    pageBuilder: (c,a1,a2)=>Profile(data:data,i:i),
                                    transitionsBuilder: (c, a1, a2, child) =>
                                    SlideTransition(position: Tween(
                                      begin: Offset(-1.0,0.0),
                                      end: Offset(0.0,0.0),
                                    ).animate(a1),
                                      child: child,
                                    )


                                )
                                );
                              },
                          ),
                          Text('좋아요 ${widget.data[i]['likes'].toString()}'),
                          Text(widget.data[i]['user']??''),
                          Text(widget.data[i]['content']??'')
                        ],
                      ),
                    )
                  ]),
            ),
          );
        }
        else{
          Text('로딩중');
        }
      },);
  }
}

class Upload extends StatelessWidget {
  Upload({super.key,this.userImage,this.setUserContent,this.addMyData});
  var setUserContent;
  var userImage;
  var textInput =TextEditingController();
  var data;
  var addMyData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          addMyData();
          Navigator.pop(context);
        }, icon: Icon(Icons.send))
      ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이미지업로드화면'),
          Image.file(userImage),
          TextField(onChanged: (text){ setUserContent=text;          },),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close)),
          IconButton(onPressed: (){
            Navigator.pop(context);
            //버튼 누를시 이미지데이터 추가, 좋아요 기본 0, context추가
            data[3]['image'];
          }, icon: Icon(Icons.navigate_next))

        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key,this.data,this.i});
  final data;
  final i;
  @override
  Widget build(BuildContext context) {
    print(context.read<Store1>().profileImage.length);
    return Scaffold(
      appBar: AppBar(title: Text(data[i]['user']),),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                (c,i) => Container(child: Image.network(context.read<Store1>().profileImage[i]),),
              childCount: context.read<Store1>().profileImage.length//격자 몇개 만들 것
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),

          )
        ],)
    );
  }
}
class ProfileHeader  extends StatelessWidget {
  const ProfileHeader ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(radius: 30,
              backgroundColor: Colors.grey,
            ),
            Text('팔로워 ${context.read<Store1>().follow}명'),
            ElevatedButton(onPressed: (){
              context.read<Store1>().addfollow();
            }, child: Text('팔로우')
            ),ElevatedButton(onPressed: (){
              context.read<Store1>().getData();
              print(context.read<Store1>().profileImage);
            }, child: Text('사진가져오기 '))
          ],
        ),

      ],
    );
  }
}


class Store1 extends ChangeNotifier {

  var name = 'john kim';
  var follow = 0;
  var friend= false;
  var profileImage = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage =result2;
    notifyListeners();
    print(profileImage);
  }

  addfollow(){
    if(friend==false
    ){
      follow++;
      friend=true;
    }
    else//버튼을 이미 눌름 .
      {
        follow--;
        friend=false;
        //정보 저장 해제
      }
    notifyListeners();
  }
  changeName(){
    name ='john park';
    notifyListeners();
  }
}
class Store2 extends ChangeNotifier {

}