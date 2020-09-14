package com.example.gait_mobile_app;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private Intent service;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        service = new Intent(MainActivity.this, SensorService.class);

        new MethodChannel(getFlutterView(), "com.example.gait_mobile_app.sensor").setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("startService")) {
                        startService();
                        result.success("sensor service started");
                    }
                    if (call.method.equals("stopService")) {
                        stopService();
                        result.success("sensor service stopped");
                    }
                }
        );
    }


    private void startService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(service);
        } else {
            startService(service);
        }
    }

    private void stopService() {
        stopService(service);
    }
}
