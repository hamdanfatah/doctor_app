import 'package:dokter/models/doctor.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final DoctorModel doctorModel;
  const DetailPage({required this.doctorModel, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<CalendarModel> calendarData = [];
  List<TimeModel> timeData = [];

  @override
  void initState() {
    super.initState();
    calendarData = widget.doctorModel.calendar;
    timeData = widget.doctorModel.time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 100,
        leadingWidth: 100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff050618).withOpacity(0.06),
                        blurRadius: 25,
                        offset: const Offset(0, 4))
                  ]),
              child: const Icon(Icons.arrow_back),
            )),
        title: const Text(
          "Detail Doctor",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            info(),
            const SizedBox(
              height: 30,
            ),
            calender(),
            const SizedBox(
              height: 20,
            ),
            time(),
            const Spacer(),
            bookButton()
          ],
        ),
      ),
    );
  }

  Widget info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: Row(
            children: [
              Container(
                width: 90,
                decoration: BoxDecoration(
                    color: widget.doctorModel.imageBox,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage(widget.doctorModel.image))),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorModel.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.doctorModel.specialities[1],
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.doctorModel.score.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Biography',
          style: TextStyle(
              color: Color(0xff09121c),
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.doctorModel.bio,
          style: TextStyle(
              color: const Color(0xff09121c).withOpacity(0.7),
              fontWeight: FontWeight.w300,
              fontSize: 12),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Specialities",
          style: TextStyle(
              color: Color(0xff09121c),
              fontWeight: FontWeight.w400,
              fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Text(
                  widget.doctorModel.specialities[index],
                  style: const TextStyle(
                      color: Color(0xff09121C),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w300),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount: widget.doctorModel.specialities.length),
        )
      ],
    );
  }

  Widget calender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calendar',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  for (var item in calendarData) {
                    item.isSelected = false;
                  }
                  calendarData[index].isSelected = true;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: calendarData[index].isSelected
                        ? const Color(0xff51A8FF)
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 25,
                          color: calendarData[index].isSelected
                              ? const Color(0xff51A8FF).withOpacity(0.45)
                              : const Color(0xff050618).withOpacity(0.05))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          calendarData[index].dayNumber.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: calendarData[index].isSelected
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text(
                          calendarData[index].dayName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: calendarData[index].isSelected
                                  ? Colors.white
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 50,
            ),
            itemCount: calendarData.length,
          ),
        )
      ],
    );
  }

  Widget time() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    for (var item in timeData) {
                      item.isSelected = false;
                    }
                    timeData[index].isSelected = true;
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: timeData[index].isSelected
                            ? const Color(0xff51A8FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(44),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 25,
                            color: timeData[index].isSelected
                                ? const Color(0xff51A8FF).withOpacity(0.45)
                                : const Color(0xff050618).withOpacity(0.05),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        timeData[index].time,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: timeData[index].isSelected
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 30,
                  ),
              itemCount: timeData.length),
        )
      ],
    );
  }

  Widget bookButton() {
    return MaterialButton(
      onPressed: () {},
      height: 55,
      minWidth: double.infinity,
      color: const Color(0xff51A8ff),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: const Text(
        'Book Appointment',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
