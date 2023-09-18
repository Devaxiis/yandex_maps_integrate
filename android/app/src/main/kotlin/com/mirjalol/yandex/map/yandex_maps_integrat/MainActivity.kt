package com.mirjalol.yandex.map.yandex_maps_integrat

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("53d1a0d8-9e35-45ec-b56a-4270a9fd3df8") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}