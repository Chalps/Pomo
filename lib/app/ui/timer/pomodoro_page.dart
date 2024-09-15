import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomo_app/app/ui/widgets/custom_app_button.dart';
import 'package:signals/signals_flutter.dart';

const int totalTime = 1;

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  final remainingDuration = signal<Duration>(const Duration(minutes: totalTime),
      debugLabel: 'Actual Time');
  final totalDuration = signal<Duration>(const Duration(minutes: totalTime),
      debugLabel: 'Max Time');
  final _timer = signal<Timer?>(null, debugLabel: 'Timer');
  final isRunning = signal<bool>(false, debugLabel: 'Is Paused');

  bool get hasReachedTimeLimit => remainingDuration.value.inMilliseconds <= 0;

  double get progress {
    // Calculate progress as a fraction of the total time
    return (totalDuration.value.inMilliseconds -
            remainingDuration.value.inMilliseconds) /
        totalDuration.value.inMilliseconds;
  }

  void startTimer() {
    if (isRunning.value) return;
    _timer.value = Timer.periodic(const Duration(milliseconds: 1), (_) {
      if (!hasReachedTimeLimit) {
        remainingDuration.value -= const Duration(milliseconds: 1);
      } else {
        _timer.value?.cancel();
        isRunning.value = false;
        // TODO: Success Notification
      }
    });
    isRunning.value = true;
  }

  void stopTimer() {
    _timer.value?.cancel();
    isRunning.value = false;
  }

  void resetTimer() {
    stopTimer();
    _timer.value = null;
    remainingDuration.value = totalDuration.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Watch.builder(builder: (context) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress, // Value of the progress from 0 to 1
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                ),
                // Display the remaining time in the center of the progress bar
                Text(
                  '${remainingDuration.value.inMinutes}:${(remainingDuration.value.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 36),
                ),
              ],
            );
          }),
          Watch.builder(
            builder: (context) {
              if (_timer.value == null) {
                return CustomElevatedIconButton(
                  onPressed: () => startTimer(),
                  label: const Text('Start'),
                  icon: const Icon(Iconsax.play),
                );
              } else if (isRunning.value) {
                return CustomElevatedIconButton(
                  onPressed: () => stopTimer(),
                  label: const Text('Pause'),
                  icon: const Icon(Iconsax.pause),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomElevatedIconButton(
                      onPressed: () => startTimer(),
                      label: const Text('Start'),
                      icon: const Icon(Iconsax.play),
                    ),
                    const SizedBox(width: 10),
                    CustomElevatedIconButton(
                      onPressed: () => resetTimer(),
                      label: const Text('Reset'),
                      icon: const Icon(Iconsax.refresh),
                    ),
                  ],
                );
              }
            },
            dependencies: [isRunning, _timer],
          ),
        ],
      ),
    );
  }
}
