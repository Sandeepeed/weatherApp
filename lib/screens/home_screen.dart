import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/search_controller.dart';
import 'package:weather_app/utils/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchWeatherController controller =
        Get.put(SearchWeatherController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              transform: const GradientRotation(4),
              colors: [Colors.blue.shade300, Colors.blue.shade200],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TextField(
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.getData();
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Enter City Here',
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: controller.textEditingController,
                  onSubmitted: (String e) {
                    controller.getData();
                  },
                ),
                Obx(() => Visibility(
                      replacement: Column(
                        children: [
                          heightBox(80),
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ],
                      ),
                      visible: controller.stateLoad.isTrue,
                      child: Column(
                        children: [
                          heightBox(40),
                          textWidget(
                              text:
                                  '${controller.weatherData.value.currentData?.temp.toString()}°C',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontColor: Colors.white),
                          // heightBox(10),
                          textWidget(
                              text:
                                  '${controller.weatherData.value.locationModel?.name.toString()}, ${controller.weatherData.value.locationModel?.country.toString()} ',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontColor: Colors.white),
                          heightBox(10),
                          textWidget(
                              text:
                                  '${controller.weatherData.value.currentData?.description}',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontColor: Colors.white),
                          heightBox(10),
                          textWidget(
                              text:
                                  'Wind Speed: ${controller.weatherData.value.currentData?.windSpeed.toString()} km/hr',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontColor: Colors.white),
                          heightBox(10),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
