import 'package:flutter/material.dart';

Future<Duration?> showDurationPicker({
  required BuildContext context,
  required Duration initialTime,
}) async {
  return showDialog<Duration>(
    context: context,
    builder: (context) {
      return _DurationPickerDialog(initialTime: initialTime);
    },
  );
}

class _DurationPickerDialog extends StatefulWidget {
  final Duration initialTime;

  _DurationPickerDialog({required this.initialTime});

  @override
  __DurationPickerDialogState createState() => __DurationPickerDialogState();
}

class __DurationPickerDialogState extends State<_DurationPickerDialog> {
  Duration _selectedDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Duration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DurationPicker(
            duration: _selectedDuration,
            onChange: (duration) {
              setState(() {
                _selectedDuration = duration;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedDuration);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

class DurationPicker extends StatefulWidget {
  final Duration duration;
  final ValueChanged<Duration> onChange;

  DurationPicker({required this.duration, required this.onChange});

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late int hours;
  late int minutes;

  @override
  void initState() {
    super.initState();
    hours = widget.duration.inHours;
    minutes = widget.duration.inMinutes % 60;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberPicker(
          value: hours,
          minValue: 0,
          maxValue: 23,
          onChanged: (value) {
            setState(() {
              hours = value;
              widget.onChange(Duration(hours: hours, minutes: minutes));
            });
          },
        ),
        Text('h'),
        NumberPicker(
          value: minutes,
          minValue: 0,
          maxValue: 59,
          onChanged: (value) {
            setState(() {
              minutes = value;
              widget.onChange(Duration(hours: hours, minutes: minutes));
            });
          },
        ),
        Text('m'),
      ],
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  NumberPicker(
      {required this.value,
      required this.minValue,
      required this.maxValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: value > minValue ? () => onChanged(value - 1) : null,
        ),
        Text('$value', style: TextStyle(fontSize: 24)),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}
