# Tüm Sceneform sınıflarını koru
-keep class com.google.ar.sceneform.** { *; }
-dontwarn com.google.ar.sceneform.**

# Desugar runtime içindeki ThrowableExtension sınıfını koru
-keep class com.google.devtools.build.android.desugar.runtime.ThrowableExtension { *; }
-dontwarn com.google.devtools.build.android.desugar.runtime.ThrowableExtension
