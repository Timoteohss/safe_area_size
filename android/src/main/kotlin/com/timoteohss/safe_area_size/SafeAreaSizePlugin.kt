package com.timoteohss.safe_area_size

import android.graphics.Rect
import android.util.DisplayMetrics
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.Exception

class SafeAreaSizePlugin: MethodCallHandler {
  companion object {
    lateinit var mRegistrar: Registrar

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      mRegistrar = registrar
      val channel = MethodChannel(registrar.messenger(), "safe_area_size")
      channel.setMethodCallHandler(SafeAreaSizePlugin())
    }
  }

  private fun getStatusBar(): Int {
    val rect = Rect()
    mRegistrar.activity().window.decorView.getWindowVisibleDisplayFrame(rect)
    return (rect.top / mRegistrar.activity().resources.displayMetrics.density).toInt()
  }

  private fun getNavigationBar(): Int {
    val rect = Rect()
    mRegistrar.activity().window.decorView.getWindowVisibleDisplayFrame(rect)

    val displayMetrics = DisplayMetrics()
    mRegistrar.activity().windowManager.defaultDisplay.getMetrics(displayMetrics)
    val navSize = displayMetrics.heightPixels - rect.bottom

    return (navSize / mRegistrar.activity().resources.displayMetrics.density).toInt()
  }

    private fun getDisplayCutout(): Int {
        return (mRegistrar.activity().window.decorView.rootWindowInsets.displayCutout.safeInsetTop / mRegistrar.activity().resources.displayMetrics.density).toInt()
    }


  override fun onMethodCall(call: MethodCall, result: Result) {

    when(call.method) {
      "getStatusBar" -> result.success(getStatusBar())
      "getNavigationBar" -> result.success(getNavigationBar())
      "getDisplayCutout" -> result.success(getDisplayCutout())
      else -> result.notImplemented()
    }
  }
}
