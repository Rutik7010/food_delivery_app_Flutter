import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/Category.dart';
import 'package:food_delivery_app/models/Food.dart';
import 'package:food_delivery_app/resourese/auth_methods.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:food_delivery_app/widgets/foodTitleWidget.dart';


class CategoryListPage extends StatefulWidget {
  final Category category;
  CategoryListPage(this.category);
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {

  //for database
  AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child:
           Column(
            children: [
              Container(
                  alignment: Alignment.bottomLeft,
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(80.0)
                    ),
                    image:DecorationImage(image: NetworkImage(widget.category.image),fit: BoxFit.cover),
                  ),
                  child: Stack(
                    children: [
                      Container(height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(80.0)
                          ),
                          gradient: LinearGradient(colors: [Colors.black45,Colors.transparent],begin: Alignment.bottomCenter,end: Alignment.topCenter
                          ),),),
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.category.name,style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color: UniversalVariables.whiteColor),),
                    ),
                  ],),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                decoration: BoxDecoration(
                  color: UniversalVariables.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("12 restaurants",style: TextStyle(color: Colors.black45),),
                        IconButton(
                          icon: Icon(Icons.menu,color: UniversalVariables.orangeColor,),
                          onPressed: ()=>null,
                        )
                      ],
                    ),
                     createFoodList(),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
  createFoodList(){
    return Container(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<Food>>(
            stream: _authMethods.fetchSpecifiedFoods(widget.category.keys).asStream(),
            builder: (context,AsyncSnapshot<List<Food>> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_,index){
                     return FoodTitleWidget(
                     snapshot.data[index],
                  );
                }
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          ),
    );
  }
}
