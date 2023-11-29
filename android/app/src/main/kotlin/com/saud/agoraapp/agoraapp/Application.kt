package com.saud.agoraapp.agoraapp

import android.media.MediaCas
import com.saud.agoraapp.agoraapp.FirebaseCloudMessagingPlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService

class Application : FlutterApplication(),PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry) {
        FirebaseCloudMessagingPlugin.registerWith(registry!!)
    }

}