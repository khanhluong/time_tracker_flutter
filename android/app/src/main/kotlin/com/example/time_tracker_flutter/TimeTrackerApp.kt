package com.example.time_tracker_flutter

import android.content.Context
import androidx.multidex.MultiDex
import androidx.multidex.MultiDexApplication

class TimeTrackerApp: MultiDexApplication() {

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}