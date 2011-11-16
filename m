From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: [android-building] Issues running ICS on PandaBoard?
Date: Wed, 16 Nov 2011 10:30:20 -0600
Message-ID: <CAP7cwtvPeJG5YCRy6tadnvYkgOrM39Gs8yHb7fqYdgKyBACaiA@mail.gmail.com>
References: <CADSo0PHGd_CmVyhTEJaXHi3ZEfWqNV0CCMdZvOAwKmrDEHmBpA@mail.gmail.com>
	<CAP7cwttvd+=+tCakn0Cvt21Z6tpZJ4MEGn-594ssd=Z73eGMnQ@mail.gmail.com>
	<CAP7cwtuNK2aSGT8p13R1cEQZ_kyUP4UK0gxC42mzVOwzvmSELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47708 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab1KPQaX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 11:30:23 -0500
Received: by eye27 with SMTP id 27so633857eye.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 08:30:21 -0800 (PST)
In-Reply-To: <CAP7cwtuNK2aSGT8p13R1cEQZ_kyUP4UK0gxC42mzVOwzvmSELw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: android-building@googlegroups.com
Cc: linux-omap@vger.kernel.org

On Wed, Nov 16, 2011 at 8:40 AM, Xianghua Xiao <xiaoxianghua@gmail.com>=
 wrote:
> On Wed, Nov 16, 2011 at 8:05 AM, Xianghua Xiao <xiaoxianghua@gmail.co=
m> wrote:
>> The graphic display is not really working on pandaboard for me.
>>
>> 1. from the README, this step is not working:
>> ---------------------------
>> # Initial setup, part 2:# With no SD card inserted, plug USB first,
>> then the power cord,# =C2=A0 and load fastboot over
>> USB:device/ti/panda/usbboot
>> device/ti/panda/bootloader.bin---------------------------
>> I tried the built-in second stage and the xload.bin, neither worked,
>> instead it's shown "waiting for OMAP44xx device..." forever. Tried t=
o
>> reboot the board, no help.
>>
>> I had to fdisk the SD card, make a vfat partition, and copy MLO
>> (xloader) and u-boot.bin(bootloader), similar to what Zach did. That
>> got things going.
>>
>> 2. After boot up the LCD is activated but no UI shown, instead from
>> the serial port I saw(I'm using a 8GB SD):
>> [ =C2=A0332.338378] binder: release 1094:1094 transaction 5649 in, s=
till active
>> [ =C2=A0332.347045] binder: send failed reply for transaction 5649 t=
o 1099:1102
>> [ =C2=A0332.347045] init: untracked pid 1090 exited
>> [ =C2=A0337.582763] binder: release 1108:1108 transaction 5733 in, s=
till active
>> [ =C2=A0337.597442] init: untracked pid 1104 exited
>> [ =C2=A0337.602050] binder: send failed reply for transaction 5733 t=
o 1113:1116
>> [ =C2=A0337.618164] init: untracked pid 1118 exited
>> [ =C2=A0342.709594] binder: release 1142:1142 transaction 5862 in, s=
till active
>> [ =C2=A0342.709747] binder: send failed reply for transaction 5862 t=
o 1147:1149
>> [ =C2=A0342.732299] init: untracked pid 1138 exited
>> [ =C2=A0348.290924] binder: release 1154:1158 transaction 5946 in, s=
till active
>> [ =C2=A0348.298156] binder: send failed reply for transaction 5946 t=
o 1159:1161
>> [ =C2=A0348.311950] init: untracked pid 1150 exited
>> [ =C2=A0348.320831] init: untracked pid 1163 exited
>>
>> Xianghua
>>
>> On Tue, Nov 15, 2011 at 5:50 PM, Jean-Baptiste Queru <jbq@android.co=
m> wrote:
>>> The master branch of AOSP includes experimental support for
>>> PandaBoard, so that's supposed to be buildable right out of the box
>>> without jumping through any hoops.
>>>
>>> I'd like to know if someone has tried following the instructions an=
d
>>> managed to successfully build, flash, and run on PandaBoard with th=
e
>>> graphics libraries at
>>> http://code.google.com/android/nexus/drivers.html and the instructi=
ons
>>> in device/ti/panda/README.
>>>
>>> If there are any issues trying to run on PandaBoard, please let me =
know.
>>>
>>> I'm eagerly looking forward to seeing cool ICS-based customized
>>> systems running on PandaBoard. The ball is in your camp!
>>>
>>> JBQ
>>>
>>> --
>>> Jean-Baptiste M. "JBQ" Queru
>>> Software Engineer, Android Open-Source Project, Google.
>>>
>>> Questions sent directly to me that have no reason for being private
>>> will likely get ignored or forwarded to a public forum with no furt=
her
>>> warning.
>>>
>>> --
>>> You received this message because you are subscribed to the "Androi=
d Building" mailing list.
>>> To post to this group, send email to android-building@googlegroups.=
com
>>> To unsubscribe from this group, send email to
>>> android-building+unsubscribe@googlegroups.com
>>> For more options, visit this group at
>>> http://groups.google.com/group/android-building?hl=3Den
>>>
>>
>
> bootcmd:console=3DttyO2,115200n8 mem=3D512M init=3D/init vram=3D32M
> omapfb.vram=3D0:16M androidboot.console=3DttyO2
>
> logcat, something is wrong with the imgtec drivers?
>
> D/AndroidRuntime( 3925): >>>>>> AndroidRuntime START
> com.android.internal.os.ZygoteInit <<<<<<
> D/AndroidRuntime( 3925): CheckJNI is ON
> I/SamplingProfilerIntegration( 3925): Profiling disabled.
> I/Zygote =C2=A0( 3925): Preloading classes...
> D/dalvikvm( 3925): GC_EXPLICIT freed 36K, 85% free 407K/2560K, paused=
 0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 4K, 82% free 471K/2560K, paused =
0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 19K, 81% free 505K/2560K, paused=
 0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 28K, 80% free 532K/2560K, paused=
 0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 15K, 78% free 573K/2560K, paused=
 1ms+1ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 28K, 77% free 600K/2560K, paused=
 0ms+1ms
> D/TextLayoutCache( 3925): Using debug level: 0 - Debug Enabled: 0
> D/dalvikvm( 3925): GC_EXPLICIT freed 26K, 76% free 631K/2560K, paused=
 0ms+0ms
> W/Zygote =C2=A0( 3925): Class not found for preloading: android.media=
=2EAudioManager$2
> I/dalvikvm( 3925): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> D/MtpDeviceJNI( 3925): register_android_mtp_MtpDevice
> I/dalvikvm( 3925): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> I/dalvikvm( 3925): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> W/Zygote =C2=A0( 3925): Class not found for preloading:
> android.media.IRemoteControlClientDispatcher
> W/Zygote =C2=A0( 3925): Class not found for preloading:
> android.media.IRemoteControlClientDispatcher$Stub
> D/dalvikvm( 3925): GC_EXPLICIT freed 23K, 74% free 676K/2560K, paused=
 0ms+0ms
> D/dalvikvm( 3925): GC_FOR_ALLOC freed 221K, 63% free 966K/2560K, paus=
ed 10ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 35K, 61% free 1014K/2560K, pause=
d 2ms+8ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 27K, 60% free 1043K/2560K, pause=
d 1ms+9ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 8K, 58% free 1091K/2560K, paused=
 0ms+8ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 23K, 55% free 1157K/2560K, pause=
d 0ms+5ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 48K, 44% free 1436K/2560K, pause=
d 3ms+16ms
> W/Zygote =C2=A0( 3925): Class not found for preloading:
> android.text.TextDirectionHeuristics$CharCount
> W/Zygote =C2=A0( 3925): Class not found for preloading:
> android.text.method.WordIterator$1
> D/dalvikvm( 3925): GC_EXPLICIT freed 34K, 43% free 1471K/2560K, pause=
d 0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 31K, 42% free 1493K/2560K, pause=
d 0ms+13ms
> I/dalvikvm( 3925): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libwebcore.so)
> D/dalvikvm( 3925): No JNI_OnLoad found in
> /system/lib/libchromium_net.so 0x0, skipping init
> D/dalvikvm( 3925): GC_EXPLICIT freed 26K, 40% free 1541K/2560K, pause=
d 4ms+13ms
> W/Zygote =C2=A0( 3925): Class not found for preloading: android.widge=
t.EdgeGlow
> D/dalvikvm( 3925): GC_EXPLICIT freed 24K, 39% free 1570K/2560K, pause=
d 3ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 65K, 38% free 1611K/2560K, pause=
d 4ms+0ms
> E/PhonePolicy( 3925): Could not preload class for phone policy:
> com.android.internal.policy.impl.PhoneWindow$ContextMenuCallback
> D/dalvikvm( 3925): GC_EXPLICIT freed 32K, 37% free 1632K/2560K, pause=
d 4ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 28K, 36% free 1661K/2560K, pause=
d 0ms+19ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 25K, 34% free 1691K/2560K, pause=
d 0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 32K, 33% free 1717K/2560K, pause=
d 4ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 32K, 32% free 1745K/2560K, pause=
d 4ms+12ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 71K, 30% free 1800K/2560K, pause=
d 3ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 39K, 30% free 1816K/2560K, pause=
d 4ms+13ms
> I/System =C2=A0( 3925): Loaded time zone names for =C2=A0in 1130ms (1=
119ms in ICU)
> I/SurfaceFlinger( 3929): SurfaceFlinger is starting
> I/SurfaceFlinger( 3929): SurfaceFlinger's main thread ready to run.
> Initializing graphics H/W...
> D/libEGL =C2=A0( 3929): loaded /system/lib/egl/libGLES_android.so
> D/libEGL =C2=A0( 3929): loaded /vendor/lib/egl/libEGL_POWERVR_SGX540_=
120.so
> D/libEGL =C2=A0( 3929): loaded /vendor/lib/egl/libGLESv1_CM_POWERVR_S=
GX540_120.so
> D/libEGL =C2=A0( 3929): loaded /vendor/lib/egl/libGLESv2_POWERVR_SGX5=
40_120.so
> I/System =C2=A0( 3925): Loaded time zone names for en_US in 659ms (65=
3ms in ICU)
> D/dalvikvm( 3925): GC_EXPLICIT freed 325K, 25% free 1933K/2560K, paus=
ed 2ms+6ms
> W/SurfaceFlinger( 3929): ro.sf.lcd_density not defined, using 160 dpi
> by default.
> E/libEGL =C2=A0( 3929): eglSetSwapRectangleANDROID:1460 error 3008 (E=
GL_BAD_DISPLAY)
> I/SurfaceFlinger( 3929): EGL informations:
> I/SurfaceFlinger( 3929): # of configs : 30
> I/SurfaceFlinger( 3929): vendor =C2=A0 =C2=A0: Android
> I/SurfaceFlinger( 3929): version =C2=A0 : 1.4 Android META-EGL
> I/SurfaceFlinger( 3929): extensions: EGL_KHR_image EGL_KHR_image_base
> EGL_KHR_image_pixmap EGL_KHR_gl_texture_2D_image
> EGL_KHR_gl_texture_cubemap_image EGL_KHR_gl_renderbuffer_image
> EGL_KHR_fence_sync EGL_ANDROID_image_native_buffer
> EGL_ANDROID_swap_rectangle EGL_NV_system_time
> I/SurfaceFlinger( 3929): Client API: OpenGL ES
> I/SurfaceFlinger( 3929): EGLSurface: 8-8-8-8, config=3D0x1
> I/SurfaceFlinger( 3929): OpenGL informations:
> I/SurfaceFlinger( 3929): vendor =C2=A0 =C2=A0: Imagination Technologi=
es
> I/SurfaceFlinger( 3929): renderer =C2=A0: PowerVR SGX 540
> I/SurfaceFlinger( 3929): version =C2=A0 : OpenGL ES-CM 1.1 build 1.8@=
279068
> I/SurfaceFlinger( 3929): extensions: GL_OES_byte_coordinates
> GL_OES_fixed_point GL_OES_single_precision GL_OES_matrix_get
> GL_OES_read_format GL_OES_compressed_paletted_texture
> GL_OES_point_sprite GL_OES_point_size_array GL_OES_matrix_palette
> GL_OES_draw_texture GL_OES_query_matrix GL_OES_texture_env_crossbar
> GL_OES_texture_mirrored_repeat GL_OES_texture_cube_map
> GL_OES_blend_subtract GL_OES_blend_func_separate
> GL_OES_blend_equation_separate GL_OES_stencil_wrap
> GL_OES_extended_matrix_palette GL_OES_framebuffer_object
> GL_OES_rgb8_rgba8 GL_OES_depth24 GL_OES_stencil8
> GL_OES_compressed_ETC1_RGB8_texture GL_OES_mapbuffer GL_OES_EGL_image
> GL_OES_EGL_image_external GL_EXT_multi_draw_arrays
> GL_OES_required_internalformat GL_IMG_read_format
> GL_IMG_texture_compression_pvrtc GL_IMG_texture_format_BGRA8888
> GL_EXT_texture_format_BGRA8888 GL_OES_egl_sync
> GL_IMG_vertex_array_object
> I/SurfaceFlinger( 3929): GL_MAX_TEXTURE_SIZE =3D 2048
> I/SurfaceFlinger( 3929): GL_MAX_VIEWPORT_DIMS =3D 2048 x 2048
> I/SurfaceFlinger( 3929): flags =3D 00010000
> E/ti_hwc =C2=A0( 3929): failed to open dsscomp (13)
> E/SurfaceFlinger( 3929): composer device failed to initialize
> (Permission denied)
> D/dalvikvm( 3925): GC_EXPLICIT freed 15K, 23% free 1994K/2560K, pause=
d 0ms+2ms
> F/libc =C2=A0 =C2=A0( 3929): Fatal signal 11 (SIGSEGV) at 0x000187ae =
(code=3D2)
> D/libEGL =C2=A0( 3934): loaded /system/lib/egl/libGLES_android.so
> D/libEGL =C2=A0( 3934): loaded /vendor/lib/egl/libEGL_POWERVR_SGX540_=
120.so
> D/libEGL =C2=A0( 3934): loaded /vendor/lib/egl/libGLESv1_CM_POWERVR_S=
GX540_120.so
> D/libEGL =C2=A0( 3934): loaded /vendor/lib/egl/libGLESv2_POWERVR_SGX5=
40_120.so
> D/dalvikvm( 3925): GC_EXPLICIT freed 51K, 21% free 2025K/2560K, pause=
d 2ms+5ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 28K, 20% free 2055K/2560K, pause=
d 0ms+5ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 38K, 20% free 2072K/2560K, pause=
d 0ms+2ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 32K, 19% free 2094K/2560K, pause=
d 0ms+7ms
> I/Zygote =C2=A0( 3925): ...preloaded 2252 classes in 4155ms.
> D/dalvikvm( 3925): GC_EXPLICIT freed 22K, 19% free 2099K/2560K, pause=
d 0ms+0ms
> I/Zygote =C2=A0( 3925): Preloading resources...
> D/dalvikvm( 3925): GC_EXPLICIT freed 1K, 16% free 2154K/2560K, paused=
 1ms+0ms
> I/DEBUG =C2=A0 ( 1841): *** *** *** *** *** *** *** *** *** *** *** *=
** ***
> *** *** ***
> I/DEBUG =C2=A0 ( 1841): Build fingerprint:
> 'Android/full_panda/panda:4.0.1/ITL41D/eng.xxiao.20111115.154111:eng/=
test-keys'
> I/DEBUG =C2=A0 ( 1841): pid: 3929, tid: 3930 =C2=A0>>> /system/bin/su=
rfaceflinger <<<
> I/DEBUG =C2=A0 ( 1841): signal 11 (SIGSEGV), code 2 (SEGV_ACCERR), fa=
ult
> addr 000187ae
> I/DEBUG =C2=A0 ( 1841): =C2=A0r0 00026580 =C2=A0r1 000280f8 =C2=A0r2 =
00000001 =C2=A0r3 000187af
> I/DEBUG =C2=A0 ( 1841): =C2=A0r4 00026550 =C2=A0r5 00000001 =C2=A0r6 =
0000fc70 =C2=A0r7 0000f918
> I/DEBUG =C2=A0 ( 1841): =C2=A0r8 00028100 =C2=A0r9 00000000 =C2=A010 =
00028140 =C2=A0fp 00000001
> I/DEBUG =C2=A0 ( 1841): =C2=A0ip 40182f30 =C2=A0sp 100ffdb8 =C2=A0lr =
400ab0fb =C2=A0pc 000187ae
> =C2=A0cpsr 60000030
> I/DEBUG =C2=A0 ( 1841): =C2=A0d0 =C2=A00000000000000000 =C2=A0d1 =C2=A0=
000002d000000500
> I/DEBUG =C2=A0 ( 1841): =C2=A0d2 =C2=A00000000000000000 =C2=A0d3 =C2=A0=
0000000000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d4 =C2=A00000000000000000 =C2=A0d5 =C2=A0=
0000000000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d6 =C2=A03f80000000000000 =C2=A0d7 =C2=A0=
000000003f800000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d8 =C2=A00000000000000000 =C2=A0d9 =C2=A0=
0000000000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d10 0000000000000000 =C2=A0d11 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d12 0000000000000000 =C2=A0d13 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d14 0000000000000000 =C2=A0d15 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d16 41d20b1c5877ae14 =C2=A0d17 3f50624d=
d2f1a9fc
> I/DEBUG =C2=A0 ( 1841): =C2=A0d18 41c9fe1127000000 =C2=A0d19 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d20 0000000000000000 =C2=A0d21 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d22 0000000000000000 =C2=A0d23 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d24 0000000000000000 =C2=A0d25 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d26 0000000000000000 =C2=A0d27 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d28 0000000000000000 =C2=A0d29 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d30 0000000000000000 =C2=A0d31 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0scr 20000010
> I/DEBUG =C2=A0 ( 1841):
> D/dalvikvm( 3925): GC_EXPLICIT freed 1K, 14% free 2205K/2560K, paused=
 5ms+2ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 3K, 13% free 2252K/2560K, paused=
 0ms+0ms
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#00 =C2=A0p=
c 000187ae
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#01 =C2=A0p=
c 000190f8
> /system/lib/libsurfaceflinger.so (_ZNK7android10HWComposer7prepareEv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#02 =C2=A0p=
c 0001cda0
> /system/lib/libsurfaceflinger.so
> (_ZN7android14SurfaceFlinger21setupHardwareComposerERNS_6RegionE)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#03 =C2=A0p=
c 0001cf7c
> /system/lib/libsurfaceflinger.so
> (_ZN7android14SurfaceFlinger13handleRepaintEv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#04 =C2=A0p=
c 0001e39c
> /system/lib/libsurfaceflinger.so
> (_ZN7android14SurfaceFlinger10threadLoopEv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#05 =C2=A0p=
c 00020cd6 =C2=A0/system/lib/libutils.so
> (_ZN7android6Thread11_threadLoopEPv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#06 =C2=A0p=
c 0002131c =C2=A0/system/lib/libutils.so
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#07 =C2=A0p=
c 00012c1c =C2=A0/system/lib/libc.so
> (__thread_entry)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#08 =C2=A0p=
c 00012770 =C2=A0/system/lib/libc.so
> (pthread_create)
> I/DEBUG =C2=A0 ( 1841):
> I/DEBUG =C2=A0 ( 1841): code around pc:
> I/DEBUG =C2=A0 ( 1841): 0001878c 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 0001879c 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 000187ac 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 000187bc 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 000187cc 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841):
> I/DEBUG =C2=A0 ( 1841): code around lr:
> I/DEBUG =C2=A0 ( 1841): 400ab0d8 2000bf14 0012f06f bf004770 620261c1
> I/DEBUG =C2=A0 ( 1841): 400ab0e8 bf004770 41f0e92d 68804604 6c0368e1
> I/DEBUG =C2=A0 ( 1841): 400ab0f8 bb084798 460268e1 46064603 4601684f
> I/DEBUG =C2=A0 ( 1841): 400ab108 68e5e016 1e83eb05 c010f8de 0f01f01c
> I/DEBUG =C2=A0 ( 1841): 400ab118 eb05bf18 eb051c83 bf181583 6008f8cc
> I/DEBUG =C2=A0 ( 1841):
> I/DEBUG =C2=A0 ( 1841): stack:
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd78 =C2=A007ffffff
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd7c =C2=A007ffffff
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd80 =C2=A007ffffff
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd84 =C2=A0100ffe14
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd88 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd8c =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd90 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd94 =C2=A00000fa98
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd98 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd9c =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffda0 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffda4 =C2=A040017c00
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffda8 =C2=A00000fad0
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdac =C2=A00000fae0
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdb0 =C2=A0df0027ad
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdb4 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): #01 100ffdb8 =C2=A000026550
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdbc =C2=A000000001
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdc0 =C2=A00000fc70
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdc4 =C2=A00000f918
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdc8 =C2=A000028100
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdcc =C2=A0400aeda5 =C2=A0/=
system/lib/libsurfaceflinger.so
> D/dalvikvm( 3925): GC_EXPLICIT freed 3K, 11% free 2299K/2560K, paused=
 0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 4K, 9% free 2347K/2560K, paused =
0ms+3ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 5K, 7% free 2397K/2560K, paused =
0ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 4K, 7% free 2444K/2627K, paused =
3ms+0ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 5K, 6% free 2489K/2627K, paused =
0ms+4ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 4K, 6% free 2539K/2691K, paused =
6ms+20ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 4K, 4% free 2588K/2691K, paused =
0ms+15ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 5K, 4% free 2649K/2755K, paused =
0ms+3ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 2K, 5% free 2698K/2819K, paused =
0ms+3ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 3K, 5% free 2745K/2883K, paused =
8ms+2ms
> D/dalvikvm( 3925): GC_EXPLICIT freed 6K, 4% free 2793K/2883K, paused =
0ms+1ms
> D/BootAnimation( 3934): SurfaceFlinger died, exiting...
> I/ServiceManager( =C2=A0 63): service 'SurfaceFlinger' died
> D/AndroidRuntime( 3938):
> D/AndroidRuntime( 3938): >>>>>> AndroidRuntime START
> com.android.internal.os.ZygoteInit <<<<<<
> D/AndroidRuntime( 3938): CheckJNI is ON
> I/SamplingProfilerIntegration( 3938): Profiling disabled.
> I/Zygote =C2=A0( 3938): Preloading classes...
> D/dalvikvm( 3938): GC_EXPLICIT freed 36K, 85% free 407K/2560K, paused=
 1ms+7ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 4K, 82% free 471K/2560K, paused =
7ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 19K, 81% free 505K/2560K, paused=
 1ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 28K, 80% free 532K/2560K, paused=
 1ms+1ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 15K, 78% free 573K/2560K, paused=
 1ms+2ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 28K, 77% free 600K/2560K, paused=
 0ms+3ms
> D/TextLayoutCache( 3938): Using debug level: 0 - Debug Enabled: 0
> D/dalvikvm( 3938): GC_EXPLICIT freed 26K, 76% free 631K/2560K, paused=
 0ms+0ms
> W/Zygote =C2=A0( 3938): Class not found for preloading: android.media=
=2EAudioManager$2
> I/dalvikvm( 3938): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> D/MtpDeviceJNI( 3938): register_android_mtp_MtpDevice
> I/dalvikvm( 3938): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> I/dalvikvm( 3938): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> W/Zygote =C2=A0( 3938): Class not found for preloading:
> android.media.IRemoteControlClientDispatcher
> W/Zygote =C2=A0( 3938): Class not found for preloading:
> android.media.IRemoteControlClientDispatcher$Stub
> D/dalvikvm( 3938): GC_EXPLICIT freed 23K, 74% free 676K/2560K, paused=
 2ms+2ms
> D/dalvikvm( 3938): GC_FOR_ALLOC freed 221K, 63% free 966K/2560K, paus=
ed 22ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 35K, 61% free 1014K/2560K, pause=
d 1ms+6ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 27K, 60% free 1043K/2560K, pause=
d 2ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 8K, 58% free 1091K/2560K, paused=
 1ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 23K, 55% free 1157K/2560K, pause=
d 2ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 48K, 44% free 1436K/2560K, pause=
d 4ms+0ms
> W/Zygote =C2=A0( 3938): Class not found for preloading:
> android.text.TextDirectionHeuristics$CharCount
> W/Zygote =C2=A0( 3938): Class not found for preloading:
> android.text.method.WordIterator$1
> D/dalvikvm( 3938): GC_EXPLICIT freed 34K, 43% free 1471K/2560K, pause=
d 3ms+11ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 31K, 42% free 1493K/2560K, pause=
d 2ms+0ms
> I/dalvikvm( 3938): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libwebcore.so)
> D/dalvikvm( 3938): No JNI_OnLoad found in
> /system/lib/libchromium_net.so 0x0, skipping init
> D/dalvikvm( 3938): GC_EXPLICIT freed 26K, 40% free 1541K/2560K, pause=
d 4ms+10ms
> W/Zygote =C2=A0( 3938): Class not found for preloading: android.widge=
t.EdgeGlow
> D/dalvikvm( 3938): GC_EXPLICIT freed 24K, 39% free 1570K/2560K, pause=
d 0ms+18ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 65K, 38% free 1611K/2560K, pause=
d 2ms+0ms
> E/PhonePolicy( 3938): Could not preload class for phone policy:
> com.android.internal.policy.impl.PhoneWindow$ContextMenuCallback
> D/dalvikvm( 3938): GC_EXPLICIT freed 32K, 37% free 1632K/2560K, pause=
d 3ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 28K, 36% free 1661K/2560K, pause=
d 1ms+14ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 25K, 34% free 1691K/2560K, pause=
d 3ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 32K, 33% free 1717K/2560K, pause=
d 0ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 32K, 32% free 1745K/2560K, pause=
d 4ms+20ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 71K, 30% free 1800K/2560K, pause=
d 4ms+5ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 39K, 30% free 1816K/2560K, pause=
d 3ms+0ms
> I/System =C2=A0( 3938): Loaded time zone names for =C2=A0in 1090ms (1=
085ms in ICU)
> I/SurfaceFlinger( 3942): SurfaceFlinger is starting
> I/SurfaceFlinger( 3942): SurfaceFlinger's main thread ready to run.
> Initializing graphics H/W...
> D/libEGL =C2=A0( 3942): loaded /system/lib/egl/libGLES_android.so
> D/libEGL =C2=A0( 3942): loaded /vendor/lib/egl/libEGL_POWERVR_SGX540_=
120.so
> D/libEGL =C2=A0( 3942): loaded /vendor/lib/egl/libGLESv1_CM_POWERVR_S=
GX540_120.so
> D/libEGL =C2=A0( 3942): loaded /vendor/lib/egl/libGLESv2_POWERVR_SGX5=
40_120.so
> W/SurfaceFlinger( 3942): ro.sf.lcd_density not defined, using 160 dpi
> by default.
> E/libEGL =C2=A0( 3942): eglSetSwapRectangleANDROID:1460 error 3008 (E=
GL_BAD_DISPLAY)
> I/SurfaceFlinger( 3942): EGL informations:
> I/SurfaceFlinger( 3942): # of configs : 30
> I/SurfaceFlinger( 3942): vendor =C2=A0 =C2=A0: Android
> I/SurfaceFlinger( 3942): version =C2=A0 : 1.4 Android META-EGL
> I/SurfaceFlinger( 3942): extensions: EGL_KHR_image EGL_KHR_image_base
> EGL_KHR_image_pixmap EGL_KHR_gl_texture_2D_image
> EGL_KHR_gl_texture_cubemap_image EGL_KHR_gl_renderbuffer_image
> EGL_KHR_fence_sync EGL_ANDROID_image_native_buffer
> EGL_ANDROID_swap_rectangle EGL_NV_system_time
> I/SurfaceFlinger( 3942): Client API: OpenGL ES
> I/SurfaceFlinger( 3942): EGLSurface: 8-8-8-8, config=3D0x1
> I/SurfaceFlinger( 3942): OpenGL informations:
> I/SurfaceFlinger( 3942): vendor =C2=A0 =C2=A0: Imagination Technologi=
es
> I/SurfaceFlinger( 3942): renderer =C2=A0: PowerVR SGX 540
> I/SurfaceFlinger( 3942): version =C2=A0 : OpenGL ES-CM 1.1 build 1.8@=
279068
> I/SurfaceFlinger( 3942): extensions: GL_OES_byte_coordinates
> GL_OES_fixed_point GL_OES_single_precision GL_OES_matrix_get
> GL_OES_read_format GL_OES_compressed_paletted_texture
> GL_OES_point_sprite GL_OES_point_size_array GL_OES_matrix_palette
> GL_OES_draw_texture GL_OES_query_matrix GL_OES_texture_env_crossbar
> GL_OES_texture_mirrored_repeat GL_OES_texture_cube_map
> GL_OES_blend_subtract GL_OES_blend_func_separate
> GL_OES_blend_equation_separate GL_OES_stencil_wrap
> GL_OES_extended_matrix_palette GL_OES_framebuffer_object
> GL_OES_rgb8_rgba8 GL_OES_depth24 GL_OES_stencil8
> GL_OES_compressed_ETC1_RGB8_texture GL_OES_mapbuffer GL_OES_EGL_image
> GL_OES_EGL_image_external GL_EXT_multi_draw_arrays
> GL_OES_required_internalformat GL_IMG_read_format
> GL_IMG_texture_compression_pvrtc GL_IMG_texture_format_BGRA8888
> GL_EXT_texture_format_BGRA8888 GL_OES_egl_sync
> GL_IMG_vertex_array_object
> I/SurfaceFlinger( 3942): GL_MAX_TEXTURE_SIZE =3D 2048
> I/SurfaceFlinger( 3942): GL_MAX_VIEWPORT_DIMS =3D 2048 x 2048
> I/SurfaceFlinger( 3942): flags =3D 00010000
> E/ti_hwc =C2=A0( 3942): failed to open dsscomp (13)
> E/SurfaceFlinger( 3942): composer device failed to initialize
> (Permission denied)
> F/libc =C2=A0 =C2=A0( 3942): Fatal signal 11 (SIGSEGV) at 0x000187ae =
(code=3D2)
> D/libEGL =C2=A0( 3947): loaded /system/lib/egl/libGLES_android.so
> D/libEGL =C2=A0( 3947): loaded /vendor/lib/egl/libEGL_POWERVR_SGX540_=
120.so
> D/libEGL =C2=A0( 3947): loaded /vendor/lib/egl/libGLESv1_CM_POWERVR_S=
GX540_120.so
> D/libEGL =C2=A0( 3947): loaded /vendor/lib/egl/libGLESv2_POWERVR_SGX5=
40_120.so
> I/System =C2=A0( 3938): Loaded time zone names for en_US in 324ms (32=
1ms in ICU)
> D/dalvikvm( 3938): GC_EXPLICIT freed 325K, 25% free 1933K/2560K, paus=
ed 1ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 15K, 23% free 1994K/2560K, pause=
d 2ms+4ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 51K, 21% free 2025K/2560K, pause=
d 0ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 28K, 20% free 2055K/2560K, pause=
d 3ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 38K, 20% free 2072K/2560K, pause=
d 1ms+0ms
> I/DEBUG =C2=A0 ( 1841): *** *** *** *** *** *** *** *** *** *** *** *=
** ***
> *** *** ***
> I/DEBUG =C2=A0 ( 1841): Build fingerprint:
> 'Android/full_panda/panda:4.0.1/ITL41D/eng.xxiao.20111115.154111:eng/=
test-keys'
> I/DEBUG =C2=A0 ( 1841): pid: 3942, tid: 3943 =C2=A0>>> /system/bin/su=
rfaceflinger <<<
> I/DEBUG =C2=A0 ( 1841): signal 11 (SIGSEGV), code 2 (SEGV_ACCERR), fa=
ult
> addr 000187ae
> I/DEBUG =C2=A0 ( 1841): =C2=A0r0 00026580 =C2=A0r1 000273e8 =C2=A0r2 =
00000001 =C2=A0r3 000187af
> I/DEBUG =C2=A0 ( 1841): =C2=A0r4 00026550 =C2=A0r5 00000001 =C2=A0r6 =
0000fc70 =C2=A0r7 0000f918
> I/DEBUG =C2=A0 ( 1841): =C2=A0r8 000273f0 =C2=A0r9 00000000 =C2=A010 =
00027430 =C2=A0fp 00000001
> I/DEBUG =C2=A0 ( 1841): =C2=A0ip 401eef30 =C2=A0sp 100ffdb8 =C2=A0lr =
400de0fb =C2=A0pc 000187ae
> =C2=A0cpsr 60000030
> I/DEBUG =C2=A0 ( 1841): =C2=A0d0 =C2=A00000000000000000 =C2=A0d1 =C2=A0=
000002d000000500
> I/DEBUG =C2=A0 ( 1841): =C2=A0d2 =C2=A00000000000000000 =C2=A0d3 =C2=A0=
0000000000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d4 =C2=A00000000000000000 =C2=A0d5 =C2=A0=
0000000000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d6 =C2=A03f80000000000000 =C2=A0d7 =C2=A0=
000000003f800000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d8 =C2=A00000000000000000 =C2=A0d9 =C2=A0=
0000000000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d10 0000000000000000 =C2=A0d11 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d12 0000000000000000 =C2=A0d13 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d14 0000000000000000 =C2=A0d15 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d16 41d21e2feed4ed91 =C2=A0d17 3f50624d=
d2f1a9fc
> I/DEBUG =C2=A0 ( 1841): =C2=A0d18 41ca041edf800000 =C2=A0d19 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d20 0000000000000000 =C2=A0d21 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d22 0000000000000000 =C2=A0d23 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d24 0000000000000000 =C2=A0d25 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d26 0000000000000000 =C2=A0d27 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d28 0000000000000000 =C2=A0d29 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0d30 0000000000000000 =C2=A0d31 00000000=
00000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0scr 20000010
> I/DEBUG =C2=A0 ( 1841):
> D/dalvikvm( 3938): GC_EXPLICIT freed 32K, 19% free 2094K/2560K, pause=
d 2ms+5ms
> I/Zygote =C2=A0( 3938): ...preloaded 2252 classes in 4442ms.
> D/dalvikvm( 3938): GC_EXPLICIT freed 22K, 19% free 2099K/2560K, pause=
d 2ms+0ms
> I/Zygote =C2=A0( 3938): Preloading resources...
> D/dalvikvm( 3938): GC_EXPLICIT freed 1K, 16% free 2154K/2560K, paused=
 0ms+1ms
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#00 =C2=A0p=
c 000187ae
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#01 =C2=A0p=
c 000190f8
> /system/lib/libsurfaceflinger.so (_ZNK7android10HWComposer7prepareEv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#02 =C2=A0p=
c 0001cda0
> /system/lib/libsurfaceflinger.so
> (_ZN7android14SurfaceFlinger21setupHardwareComposerERNS_6RegionE)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#03 =C2=A0p=
c 0001cf7c
> /system/lib/libsurfaceflinger.so
> (_ZN7android14SurfaceFlinger13handleRepaintEv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#04 =C2=A0p=
c 0001e39c
> /system/lib/libsurfaceflinger.so
> (_ZN7android14SurfaceFlinger10threadLoopEv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#05 =C2=A0p=
c 00020cd6 =C2=A0/system/lib/libutils.so
> (_ZN7android6Thread11_threadLoopEPv)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#06 =C2=A0p=
c 0002131c =C2=A0/system/lib/libutils.so
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#07 =C2=A0p=
c 00012c1c =C2=A0/system/lib/libc.so
> (__thread_entry)
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#08 =C2=A0p=
c 00012770 =C2=A0/system/lib/libc.so
> (pthread_create)
> I/DEBUG =C2=A0 ( 1841):
> I/DEBUG =C2=A0 ( 1841): code around pc:
> I/DEBUG =C2=A0 ( 1841): 0001878c 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 0001879c 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 000187ac 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 000187bc 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841): 000187cc 00000000 00000000 00000000 00000000
> I/DEBUG =C2=A0 ( 1841):
> I/DEBUG =C2=A0 ( 1841): code around lr:
> I/DEBUG =C2=A0 ( 1841): 400de0d8 2000bf14 0012f06f bf004770 620261c1
> I/DEBUG =C2=A0 ( 1841): 400de0e8 bf004770 41f0e92d 68804604 6c0368e1
> I/DEBUG =C2=A0 ( 1841): 400de0f8 bb084798 460268e1 46064603 4601684f
> I/DEBUG =C2=A0 ( 1841): 400de108 68e5e016 1e83eb05 c010f8de 0f01f01c
> I/DEBUG =C2=A0 ( 1841): 400de118 eb05bf18 eb051c83 bf181583 6008f8cc
> I/DEBUG =C2=A0 ( 1841):
> I/DEBUG =C2=A0 ( 1841): stack:
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd78 =C2=A007ffffff
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd7c =C2=A007ffffff
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd80 =C2=A007ffffff
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd84 =C2=A0100ffe14
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd88 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd8c =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd90 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd94 =C2=A00000fa98
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd98 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffd9c =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffda0 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffda4 =C2=A04017dc00
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffda8 =C2=A00000fad0
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdac =C2=A00000fae0
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdb0 =C2=A0df0027ad
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdb4 =C2=A000000000
> I/DEBUG =C2=A0 ( 1841): #01 100ffdb8 =C2=A000026550
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdbc =C2=A000000001
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdc0 =C2=A00000fc70
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdc4 =C2=A00000f918
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdc8 =C2=A0000273f0
> I/DEBUG =C2=A0 ( 1841): =C2=A0 =C2=A0 100ffdcc =C2=A0400e1da5 =C2=A0/=
system/lib/libsurfaceflinger.so
> D/dalvikvm( 3938): GC_EXPLICIT freed 1K, 14% free 2205K/2560K, paused=
 2ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 3K, 13% free 2252K/2560K, paused=
 0ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 3K, 11% free 2299K/2560K, paused=
 4ms+14ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 4K, 9% free 2347K/2560K, paused =
0ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 5K, 7% free 2397K/2560K, paused =
0ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 4K, 7% free 2444K/2627K, paused =
1ms+1ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 5K, 6% free 2489K/2627K, paused =
2ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 4K, 6% free 2539K/2691K, paused =
0ms+0ms
> D/dalvikvm( 3938): GC_EXPLICIT freed 4K, 4% free 2588K/2691K, paused =
1ms+2ms
> D/BootAnimation( 3947): SurfaceFlinger died, exiting...
> I/ServiceManager( =C2=A0 63): service 'SurfaceFlinger' died
> D/AndroidRuntime( 3951):
> D/AndroidRuntime( 3951): >>>>>> AndroidRuntime START
> com.android.internal.os.ZygoteInit <<<<<<
> D/AndroidRuntime( 3951): CheckJNI is ON
> I/SamplingProfilerIntegration( 3951): Profiling disabled.
> I/Zygote =C2=A0( 3951): Preloading classes...
> D/dalvikvm( 3951): GC_EXPLICIT freed 36K, 85% free 407K/2560K, paused=
 1ms+7ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 4K, 82% free 471K/2560K, paused =
7ms+0ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 19K, 81% free 505K/2560K, paused=
 1ms+3ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 28K, 80% free 532K/2560K, paused=
 0ms+2ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 15K, 78% free 573K/2560K, paused=
 0ms+3ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 28K, 77% free 600K/2560K, paused=
 1ms+2ms
> D/TextLayoutCache( 3951): Using debug level: 0 - Debug Enabled: 0
> D/dalvikvm( 3951): GC_EXPLICIT freed 26K, 76% free 631K/2560K, paused=
 1ms+3ms
> W/Zygote =C2=A0( 3951): Class not found for preloading: android.media=
=2EAudioManager$2
> I/dalvikvm( 3951): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> D/MtpDeviceJNI( 3951): register_android_mtp_MtpDevice
> I/dalvikvm( 3951): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> I/dalvikvm( 3951): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libmedia_jni.so)
> W/Zygote =C2=A0( 3951): Class not found for preloading:
> android.media.IRemoteControlClientDispatcher
> W/Zygote =C2=A0( 3951): Class not found for preloading:
> android.media.IRemoteControlClientDispatcher$Stub
> D/dalvikvm( 3951): GC_EXPLICIT freed 23K, 74% free 676K/2560K, paused=
 2ms+1ms
> D/dalvikvm( 3951): GC_FOR_ALLOC freed 222K, 63% free 965K/2560K, paus=
ed 22ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 34K, 61% free 1014K/2560K, pause=
d 0ms+7ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 27K, 60% free 1043K/2560K, pause=
d 2ms+2ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 8K, 58% free 1091K/2560K, paused=
 2ms+8ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 23K, 55% free 1157K/2560K, pause=
d 1ms+10ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 48K, 44% free 1436K/2560K, pause=
d 1ms+0ms
> W/Zygote =C2=A0( 3951): Class not found for preloading:
> android.text.TextDirectionHeuristics$CharCount
> W/Zygote =C2=A0( 3951): Class not found for preloading:
> android.text.method.WordIterator$1
> D/dalvikvm( 3951): GC_EXPLICIT freed 34K, 43% free 1470K/2560K, pause=
d 4ms+0ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 31K, 42% free 1493K/2560K, pause=
d 4ms+12ms
> I/dalvikvm( 3951): threadid=3D1: recursive native library load attemp=
t
> (/system/lib/libwebcore.so)
> D/dalvikvm( 3951): No JNI_OnLoad found in
> /system/lib/libchromium_net.so 0x0, skipping init
> D/dalvikvm( 3951): GC_EXPLICIT freed 26K, 40% free 1541K/2560K, pause=
d 4ms+12ms
> W/Zygote =C2=A0( 3951): Class not found for preloading: android.widge=
t.EdgeGlow
> D/dalvikvm( 3951): GC_EXPLICIT freed 24K, 39% free 1570K/2560K, pause=
d 1ms+12ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 65K, 38% free 1610K/2560K, pause=
d 4ms+2ms
> E/PhonePolicy( 3951): Could not preload class for phone policy:
> com.android.internal.policy.impl.PhoneWindow$ContextMenuCallback
> D/dalvikvm( 3951): GC_EXPLICIT freed 32K, 37% free 1632K/2560K, pause=
d 4ms+0ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 28K, 36% free 1661K/2560K, pause=
d 4ms+15ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 25K, 34% free 1691K/2560K, pause=
d 3ms+0ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 32K, 33% free 1717K/2560K, pause=
d 1ms+16ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 32K, 32% free 1745K/2560K, pause=
d 4ms+4ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 71K, 30% free 1800K/2560K, pause=
d 4ms+4ms
> D/dalvikvm( 3951): GC_EXPLICIT freed 39K, 30% free 1816K/2560K, pause=
d 3ms+4ms
> I/SurfaceFlinger( 3955): SurfaceFlinger is starting
> I/SurfaceFlinger( 3955): SurfaceFlinger's main thread ready to run.
> Initializing graphics H/W...
> D/libEGL =C2=A0( 3955): loaded /system/lib/egl/libGLES_android.so
> D/libEGL =C2=A0( 3955): loaded /vendor/lib/egl/libEGL_POWERVR_SGX540_=
120.so
> D/libEGL =C2=A0( 3955): loaded /vendor/lib/egl/libGLESv1_CM_POWERVR_S=
GX540_120.so
> D/libEGL =C2=A0( 3955): loaded /vendor/lib/egl/libGLESv2_POWERVR_SGX5=
40_120.so
> W/SurfaceFlinger( 3955): ro.sf.lcd_density not defined, using 160 dpi
> by default.
> E/libEGL =C2=A0( 3955): eglSetSwapRectangleANDROID:1460 error 3008 (E=
GL_BAD_DISPLAY)
> I/SurfaceFlinger( 3955): EGL informations:
> I/SurfaceFlinger( 3955): # of configs : 30
> I/SurfaceFlinger( 3955): vendor =C2=A0 =C2=A0: Android
> I/SurfaceFlinger( 3955): version =C2=A0 : 1.4 Android META-EGL
> I/SurfaceFlinger( 3955): extensions: EGL_KHR_image EGL_KHR_image_base
> EGL_KHR_image_pixmap EGL_KHR_gl_texture_2D_image
> EGL_KHR_gl_texture_cubemap_image EGL_KHR_gl_renderbuffer_image
> EGL_KHR_fence_sync EGL_ANDROID_image_native_buffer
> EGL_ANDROID_swap_rectangle EGL_NV_system_time
> I/SurfaceFlinger( 3955): Client API: OpenGL ES
> I/SurfaceFlinger( 3955): EGLSurface: 8-8-8-8, config=3D0x1
> I/SurfaceFlinger( 3955): OpenGL informations:
> I/SurfaceFlinger( 3955): vendor =C2=A0 =C2=A0: Imagination Technologi=
es
> I/SurfaceFlinger( 3955): renderer =C2=A0: PowerVR SGX 540
> I/SurfaceFlinger( 3955): version =C2=A0 : OpenGL ES-CM 1.1 build 1.8@=
279068
> I/SurfaceFlinger( 3955): extensions: GL_OES_byte_coordinates
> GL_OES_fixed_point GL_OES_single_precision GL_OES_matrix_get
> GL_OES_read_format GL_OES_compressed_paletted_texture
> GL_OES_point_sprite GL_OES_point_size_array GL_OES_matrix_palette
> GL_OES_draw_texture GL_OES_query_matrix GL_OES_texture_env_crossbar
> GL_OES_texture_mirrored_repeat GL_OES_texture_cube_map
> GL_OES_blend_subtract GL_OES_blend_func_separate
> GL_OES_blend_equation_separate GL_OES_stencil_wrap
> GL_OES_extended_matrix_palette GL_OES_framebuffer_object
> GL_OES_rgb8_rgba8 GL_OES_depth24 GL_OES_stencil8
> GL_OES_compressed_ETC1_RGB8_texture GL_OES_mapbuffer GL_OES_EGL_image
> GL_OES_EGL_image_external GL_EXT_multi_draw_arrays
> GL_OES_required_internalformat GL_IMG_read_format
> GL_IMG_texture_compression_pvrtc GL_IMG_texture_format_BGRA8888
> GL_EXT_texture_format_BGRA8888 GL_OES_egl_sync
> GL_IMG_vertex_array_object
> I/SurfaceFlinger( 3955): GL_MAX_TEXTURE_SIZE =3D 2048
> I/SurfaceFlinger( 3955): GL_MAX_VIEWPORT_DIMS =3D 2048 x 2048
> I/SurfaceFlinger( 3955): flags =3D 00010000
> E/ti_hwc =C2=A0( 3955): failed to open dsscomp (13)
> E/SurfaceFlinger( 3955): composer device failed to initialize
> (Permission denied)
> F/libc =C2=A0 =C2=A0( 3955): Fatal signal 11 (SIGSEGV) at 0x000187ae =
(code=3D2)
> D/libEGL =C2=A0( 3960): loaded /system/lib/egl/libGLES_android.so
> D/libEGL =C2=A0( 3960): loaded /vendor/lib/egl/libEGL_POWERVR_SGX540_=
120.so
> D/libEGL =C2=A0( 3960): loaded /vendor/lib/egl/libGLESv1_CM_POWERVR_S=
GX540_120.so
> D/libEGL =C2=A0( 3960): loaded /vendor/lib/egl/libGLESv2_POWERVR_SGX5=
40_120.so
> I/System =C2=A0( 3951): Loaded time zone names for =C2=A0in 399ms (39=
4ms in ICU)
>
Here is the kernel dump, it appears in 4.0.1 the kernel had issues
with display as well.


U-Boot 1.1.4-g1632ce3f-dirty (Apr  4 2011 - 13:13:46)

Load address: 0x80e80000
DRAM:  1024 MB
=46lash:  0 kB
Using default environment

In:    serial
Out:   serial
Err:   serial

efi partition table:
     256     128K xloader
     512     256K bootloader
    2048       8M boot
   18432     256M system
  542720     256M cache
 1067008     512M userdata
 2115584     903M media
Net:   KS8851SNL
Hit any key to stop autoboot:  0
kernel   @ 80008000 (3184264)
ramdisk  @ 81000000 (162911)

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.1-23108-g97cebce
(lockwood@sirsasana.cam.corp.google.com) (gcc version 4.4.3
(GCC) ) #13 SMP PREEMPT Mon Aug 29 12:34:05 EDT 2011
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=3D=
10c5387f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruct=
ion cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] Reserving 33554432 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES2.1
[    0.000000] SRAM: Mapped pa 0x40300000 to va 0xfe400000 size: 0xd000
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0b8d000 s6848 r8192 d1363=
2 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 120064
[    0.000000] Kernel command line: console=3DttyO2,115200n8 mem=3D512M
init=3D/init vram=3D32M omapfb.vram=3D0:16M andr
oidboot.console=3DttyO2
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 473MB =3D 473MB total
[    0.000000] Memory: 471908k/471908k available, 52380k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0041000   ( 228 kB)
[    0.000000]       .text : 0xc0041000 - 0xc05ea000   (5796 kB)
[    0.000000]       .data : 0xc05ea000 - 0xc063e580   ( 338 kB)
[    0.000000]        .bss : 0xc063e5a4 - 0xc07866b0   (1313 kB)
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0,
CPUs=3D2, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:410
[    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for
dpll_mpu_m2_ck.
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] Calibrating delay loop... 2007.19 BogoMIPS (lpj=3D783974=
4)
[    0.007873] pid_max: default: 32768 minimum: 301
[    0.070678] Mount-cache hash table entries: 512
[    0.070678] Initializing cgroup subsys debug
[    0.070678] Initializing cgroup subsys cpuacct
[    0.070678] Initializing cgroup subsys freezer
[    0.070678] CPU: Testing write buffer coherency: ok
[    0.071960] twd_timer_setup: no clock found
[    0.071960] Calibrating local timer... 491.78MHz.
[    0.117431] L310 cache controller enabled
[    0.117431] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL
0x5e470000, Cache size: 1048576 B
[    0.178466] CPU1: Booted secondary processor
[    0.247070] Brought up 2 CPUs
[    0.247100] SMP: Total of 2 processors activated (3972.37 BogoMIPS).
[    0.247375] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r emif_fw
[    0.249755] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va
for l3_instr
[    0.249755] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va
for l3_main_1
[    0.249755] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va
for l3_main_2
[    0.249786] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_abe
[    0.249786] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_cfg
[    0.249786] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_per
[    0.249816] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r l4_wkup
[    0.249816] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va
for mpu_private
[    0.249816] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va fo=
r sl2if
[    0.249877] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va
for usbhs_ohci
[    0.249877] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va
for usbhs_ehci
[    0.250122] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck=
=2E
[    0.257659] omap_hwmod: mcpdm: cannot be enabled (3)
[    0.260009] print_constraints: dummy:
[    0.260009] NET: Registered protocol family 16
[    0.260009] GPMC revision 6.0
[    0.260375] EMIF0 is enabled with IRQ142
[    0.260375] EMIF1 is enabled with IRQ143
[    0.261535] OMAP GPIO hardware version 0.1
[    0.262603] omap_mux_init: Add partition: #1: core, flags: 2
[    0.262939] omap_mux_init: Add partition: #2: wkup, flags: 2
[    0.262939] error setting wl12xx data
[    0.264587] _omap_mux_get_by_name: Could not find signal uart1_cts.u=
art1_cts
[    0.264587] _omap_mux_get_by_name: Could not find signal uart1_cts.u=
art1_cts
[    0.264587] omap_hwmod_mux_init: Could not allocate device mux entry
[    0.269927] Last reset was warm software reset (PRM_RSTST=3D0x3)
[    0.272491] OMAP DMA hardware revision 0.0
[    0.276824] bio: create slab <bio-0> at 0
[    0.277526] SCSI subsystem initialized
[    0.277862] usbcore: registered new interface driver usbfs
[    0.277862] usbcore: registered new interface driver hub
[    0.278106] usbcore: registered new device driver usb
[    0.292816] omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz
[    0.292816] Skipping twl internal clock init and using bootloader
value (unknown osc rate)
[    0.293640] twl6030: PIH (irq 39) chaining IRQs 368..387
[    0.294219] print_constraints: VUSB: 3300 mV normal standby
[    0.492462] twl6030_usb twl6030_usb: Initialized TWL6030 USB module
[    0.493438] print_constraints: VMMC: 1200 <--> 3000 mV at 3000 mV
normal standby
[    0.493774] print_constraints: VPP: 1800 <--> 2500 mV at 1900 mV
normal standby
[    0.493774] print_constraints: VCXIO: 1800 mV normal standby
[    0.494079] print_constraints: VDAC: 1800 mV normal standby
[    0.494689] print_constraints: VAUX2_6030: 1200 <--> 2800 mV at
1800 mV normal standby
[    0.495056] print_constraints: VAUX3_6030: 1000 <--> 3000 mV at
1200 mV normal standby
[    0.495330] print_constraints: CLK32KG:
[    0.495330] print_constraints: VANA: 2100 mV normal standby
[    0.506256] omap_i2c omap_i2c.2: bus 2 rev4.0 at 400 kHz
[    0.521453] omap_i2c omap_i2c.3: bus 3 rev4.0 at 100 kHz
[    0.536712] omap_i2c omap_i2c.4: bus 4 rev4.0 at 400 kHz
[    0.536865] omap-rproc omap-rproc.0: dsp is available
[    0.537200] omap-rproc omap-rproc.1: ipu is available
[    0.537200] Bluetooth: Core ver 2.16
[    0.537200] NET: Registered protocol family 31
[    0.537811] Bluetooth: HCI device and connection manager initialized
[    0.537811] Bluetooth: HCI socket layer initialized
[    0.537841] Bluetooth: L2CAP socket layer initialized
[    0.537841] Bluetooth: SCO socket layer initialized
[    0.537841] Switching to clocksource 32k_counter
[    0.541015] musb-hdrc: version 6.0, musb-dma, peripheral
[    0.541351] musb-hdrc musb-hdrc: USB Peripheral mode controller at
fc0ab000 using DMA, IRQ 124
[    0.541595] NET: Registered protocol family 2
[    0.542022] IP route cache hash table entries: 4096 (order: 2, 16384=
 bytes)
[    0.542022] TCP established hash table entries: 16384 (order: 5,
131072 bytes)
[    0.542999] TCP bind hash table entries: 16384 (order: 6, 393216 byt=
es)
[    0.544372] Switched to NOHz mode on CPU #0
[    0.544464] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    0.544464] TCP reno registered
[    0.544494] UDP hash table entries: 256 (order: 2, 16384 bytes)
[    0.544494] UDP-Lite hash table entries: 256 (order: 2, 16384 bytes)
[    0.544677] Switched to NOHz mode on CPU #1
[    0.545043] NET: Registered protocol family 1
[    0.545043] Trying to unpack rootfs image as initramfs...
[    0.545837] Freeing initrd memory: 156K
[    0.811492] ------------[ cut here ]------------
[    0.811492] WARNING: at arch/arm/mach-omap2/opp.c:74
omap_init_opp_table+0xb8/0x21c()
[    0.811553] omap_init_opp_table: no hwmod or odev for hsi, [17]
cannot add OPPs.
[    0.811553] Modules linked in:
[    0.811553] Backtrace:
[    0.811614] [<c004b8e0>] (dump_backtrace+0x0/0x10c) from
[<c0486584>] (dump_stack+0x18/0x1c)
[    0.811614]  r7:00000009 r6:0000004a r5:c0011b24 r4:dd43bf18
[    0.811676] [<c048656c>] (dump_stack+0x0/0x1c) from [<c0081138>]
(warn_slowpath_common+0x54/0x6c)
[    0.811676] [<c00810e4>] (warn_slowpath_common+0x0/0x6c) from
[<c00811f4>] (warn_slowpath_fmt+0x38/0x40)
[    0.811706]  r9:00000000 r8:00000000 r7:00000000 r6:00000015 r5:0000=
0011
[    0.811706] r4:c0039a24
[    0.811737] [<c00811bc>] (warn_slowpath_fmt+0x0/0x40) from
[<c0011b24>] (omap_init_opp_table+0xb8/0x21c)
[    0.811737]  r3:c048b4f0 r2:c056dfa4
[    0.811767] [<c0011a6c>] (omap_init_opp_table+0x0/0x21c) from
[<c0011d2c>] (omap4_opp_init+0x38/0xbc)
[    0.811767]  r7:00000013 r6:00000000 r5:c063e5c0 r4:c0032fe0
[    0.811828] [<c0011cf4>] (omap4_opp_init+0x0/0xbc) from
[<c00415a0>] (do_one_initcall+0x44/0x1a4)
[    0.811828]  r5:c063e5c0 r4:c0032fe0
[    0.811828] [<c004155c>] (do_one_initcall+0x0/0x1a4) from
[<c00083c8>] (kernel_init+0x90/0x138)
[    0.811828] [<c0008338>] (kernel_init+0x0/0x138) from [<c0084fac>]
(do_exit+0x0/0x6e0)
[    0.811889]  r5:c0008338 r4:00000000
[    0.811889] ---[ end trace 65f8ea860415c04f ]---
[    0.811889] ------------[ cut here ]------------
[    0.811889] WARNING: at arch/arm/mach-omap2/opp.c:74
omap_init_opp_table+0xb8/0x21c()
[    0.811950] omap_init_opp_table: no hwmod or odev for hsi, [18]
cannot add OPPs.
[    0.811950] Modules linked in:
[    0.811950] Backtrace:
[    0.811981] [<c004b8e0>] (dump_backtrace+0x0/0x10c) from
[<c0486584>] (dump_stack+0x18/0x1c)
[    0.811981]  r7:00000009 r6:0000004a r5:c0011b24 r4:dd43bf18
[    0.812011] [<c048656c>] (dump_stack+0x0/0x1c) from [<c0081138>]
(warn_slowpath_common+0x54/0x6c)
[    0.812011] [<c00810e4>] (warn_slowpath_common+0x0/0x6c) from
[<c00811f4>] (warn_slowpath_fmt+0x38/0x40)
[    0.812042]  r9:00000000 r8:00000000 r7:00000000 r6:00000015 r5:0000=
0012
[    0.812042] r4:c0039a3c
[    0.812072] [<c00811bc>] (warn_slowpath_fmt+0x0/0x40) from
[<c0011b24>] (omap_init_opp_table+0xb8/0x21c)
[    0.812072]  r3:c048b4f0 r2:c056dfa4
[    0.812103] [<c0011a6c>] (omap_init_opp_table+0x0/0x21c) from
[<c0011d2c>] (omap4_opp_init+0x38/0xbc)
[    0.812103]  r7:00000013 r6:00000000 r5:c063e5c0 r4:c0032fe0
[    0.812133] [<c0011cf4>] (omap4_opp_init+0x0/0xbc) from
[<c00415a0>] (do_one_initcall+0x44/0x1a4)
[    0.812133]  r5:c063e5c0 r4:c0032fe0
[    0.812164] [<c004155c>] (do_one_initcall+0x0/0x1a4) from
[<c00083c8>] (kernel_init+0x90/0x138)
[    0.812164] [<c0008338>] (kernel_init+0x0/0x138) from [<c0084fac>]
(do_exit+0x0/0x6e0)
[    0.812164]  r5:c0008338 r4:00000000
[    0.812194] ---[ end trace 65f8ea860415c050 ]---
[    0.812194] ------------[ cut here ]------------
[    0.812194] WARNING: at arch/arm/mach-omap2/opp.c:74
omap_init_opp_table+0xb8/0x21c()
[    0.812225] omap_init_opp_table: no hwmod or odev for aess, [19]
cannot add OPPs.
[    0.812225] Modules linked in:
[    0.812225] Backtrace:
[    0.812255] [<c004b8e0>] (dump_backtrace+0x0/0x10c) from
[<c0486584>] (dump_stack+0x18/0x1c)
[    0.812255]  r7:00000009 r6:0000004a r5:c0011b24 r4:dd43bf18
[    0.812286] [<c048656c>] (dump_stack+0x0/0x1c) from [<c0081138>]
(warn_slowpath_common+0x54/0x6c)
[    0.812316] [<c00810e4>] (warn_slowpath_common+0x0/0x6c) from
[<c00811f4>] (warn_slowpath_fmt+0x38/0x40)
[    0.812316]  r9:00000000 r8:00000000 r7:00000000 r6:00000015 r5:0000=
0013
[    0.812347] r4:c0039a54
[    0.812347] [<c00811bc>] (warn_slowpath_fmt+0x0/0x40) from
[<c0011b24>] (omap_init_opp_table+0xb8/0x21c)
[    0.812347]  r3:c048b4f0 r2:c056dfa4
[    0.812377] [<c0011a6c>] (omap_init_opp_table+0x0/0x21c) from
[<c0011d2c>] (omap4_opp_init+0x38/0xbc)
[    0.812377]  r7:00000013 r6:00000000 r5:c063e5c0 r4:c0032fe0
[    0.812408] [<c0011cf4>] (omap4_opp_init+0x0/0xbc) from
[<c00415a0>] (do_one_initcall+0x44/0x1a4)
[    0.812408]  r5:c063e5c0 r4:c0032fe0
[    0.812438] [<c004155c>] (do_one_initcall+0x0/0x1a4) from
[<c00083c8>] (kernel_init+0x90/0x138)
[    0.812438] [<c0008338>] (kernel_init+0x0/0x138) from [<c0084fac>]
(do_exit+0x0/0x6e0)
[    0.812469]  r5:c0008338 r4:00000000
[    0.812469] ---[ end trace 65f8ea860415c051 ]---
[    0.812469] ------------[ cut here ]------------
[    0.812500] WARNING: at arch/arm/mach-omap2/opp.c:74
omap_init_opp_table+0xb8/0x21c()
[    0.812500] omap_init_opp_table: no hwmod or odev for aess, [20]
cannot add OPPs.
[    0.812500] Modules linked in:
[    0.812530] Backtrace:
[    0.812530] [<c004b8e0>] (dump_backtrace+0x0/0x10c) from
[<c0486584>] (dump_stack+0x18/0x1c)
[    0.812530]  r7:00000009 r6:0000004a r5:c0011b24 r4:dd43bf18
[    0.812561] [<c048656c>] (dump_stack+0x0/0x1c) from [<c0081138>]
(warn_slowpath_common+0x54/0x6c)
[    0.812591] [<c00810e4>] (warn_slowpath_common+0x0/0x6c) from
[<c00811f4>] (warn_slowpath_fmt+0x38/0x40)
[    0.812591]  r9:00000000 r8:00000000 r7:00000000 r6:00000015 r5:0000=
0014
[    0.812622] r4:c0039a6c
[    0.812622] [<c00811bc>] (warn_slowpath_fmt+0x0/0x40) from
[<c0011b24>] (omap_init_opp_table+0xb8/0x21c)
[    0.812652]  r3:c048b4f0 r2:c056dfa4
[    0.812652] [<c0011a6c>] (omap_init_opp_table+0x0/0x21c) from
[<c0011d2c>] (omap4_opp_init+0x38/0xbc)
[    0.812652]  r7:00000013 r6:00000000 r5:c063e5c0 r4:c0032fe0
[    0.812683] [<c0011cf4>] (omap4_opp_init+0x0/0xbc) from
[<c00415a0>] (do_one_initcall+0x44/0x1a4)
[    0.812683]  r5:c063e5c0 r4:c0032fe0
[    0.812713] [<c004155c>] (do_one_initcall+0x0/0x1a4) from
[<c00083c8>] (kernel_init+0x90/0x138)
[    0.812713] [<c0008338>] (kernel_init+0x0/0x138) from [<c0084fac>]
(do_exit+0x0/0x6e0)
[    0.812744]  r5:c0008338 r4:00000000
[    0.812744] ---[ end trace 65f8ea860415c052 ]---
[    0.813598] omap-iommu omap-iommu.0: ducati registered
[    0.813659] omap-iommu omap-iommu.1: tesla registered
[    0.837249] ashmem: initialized
[    0.842742] fuse init (API version 7.16)
[    0.843200] msgmni has been set to 922
[    0.844177] io scheduler noop registered
[    0.844207] io scheduler deadline registered
[    0.844207] io scheduler cfq registered (default)
[    0.844299] start plist test
[    0.844299] end plist test
[    0.850555] OMAP DSS rev 4.0
[    0.860565] dsscomp: initializing.
[    0.860992] misc dsscomp: found 2 displays and 4 overlays
[    0.861206] could not allocate slot
[    0.861480] omap-rproc omap-rproc.1: powering up ipu
[    0.861816] virtio_rpmsg_bus virtio0: rpmsg backend virtproc probed
successfully
[    0.861816] virtio_rpmsg_bus virtio1: rpmsg backend virtproc probed
successfully
[    0.862823] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 104) is a=
 OMAP UART0
[    0.881805] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 105) is a=
 OMAP UART1
[    0.924011] omap_uart.2: ttyO2 at MMIO 0x48020000 (irq =3D 106) is a=
 OMAP UART2
[    2.363922] console [ttyO2] enabled
[    2.444793] omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq =3D 102) is a=
 OMAP UART3
[    2.578369] PVR: PVRCore_Init
[    2.581787] PVR: PVRSRVDriverProbe(pDevice=3Ddd4aa200)
[    2.587402] PVR: SGX register base: 0x56000000
[    2.592285] PVR: SGX register size: 65535
[    2.596710] PVR: SGX IRQ: 53
[    2.596710] PVR: EnableSystemClocks: Enabling System Clocks
[    2.605987] PVR_K:(Warning): EnableSGXClocks: Unable to scale SGX
frequency (EBUSY) [200, drivers/gpu/pvr/o
map4/sysutils_linux.c]
[    2.618804] Failed: change interconnect bandwidth to 250000000
[    2.625213] PVR_K:(Warning): DisableSGXClocks: Unable to scale SGX
frequency (EBUSY) [279, drivers/gpu/pvr/
omap4/sysutils_linux.c]
[    2.638244] Failed: change interconnect bandwidth to 0
[    2.643981] PVR: PVRCore_Init: major device 251
[    2.652313] brd: module loaded
[    2.660491] loop: module loaded
[    2.663940] PPP generic driver version 2.4.2
[    2.664855] PPP Deflate Compression module registered
[    2.669677] PPP BSD Compression module registered
[    2.681030] PPP MPPE Compression module registered
[    2.686279] NET: Registered protocol family 24
[    2.691253] usbcore: registered new interface driver asix
[    2.694305] usbcore: registered new interface driver cdc_ether
[    2.705108] usbcore: registered new interface driver smsc95xx
[    2.711456] usbcore: registered new interface driver net1080
[    2.717712] usbcore: registered new interface driver cdc_subset
[    2.724182] usbcore: registered new interface driver zaurus
[    2.730377] cdc_ncm: 01-June-2011
[    2.733367] usbcore: registered new interface driver cdc_ncm
[    2.733367] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    2.747558] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    2.753875] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus number 1
[    2.762084] ehci-omap ehci-omap.0: irq 109, io mem 0x4a064c00
[    2.791870] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    2.798248] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    2.805694] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    2.805694] usb usb1: Product: OMAP-EHCI Host Controller
[    2.813629] usb usb1: Manufacturer: Linux 3.0.1-23108-g97cebce ehci_=
hcd
[    2.826690] usb usb1: SerialNumber: ehci-omap.0
[    2.826690] hub 1-0:1.0: USB hub found
[    2.836212] hub 1-0:1.0: 3 ports detected
[    2.891784] usbcore: registered new interface driver cdc_acm
[    2.891784] cdc_acm: USB Abstract Control Model driver for USB
modems and ISDN adapters
[    2.906890] Initializing USB Mass Storage driver...
[    2.906890] usbcore: registered new interface driver usb-storage
[    2.906890] USB Mass Storage support registered.
[    2.924102] usbcore: registered new interface driver usbserial
[    2.924102] usbserial: USB Serial Driver core
[    2.935272] USB Serial support registered for Keyspan - (without fir=
mware)
[    2.942993] USB Serial support registered for Keyspan 1 port adapter
[    2.949981] USB Serial support registered for Keyspan 2 port adapter
[    2.956939] USB Serial support registered for Keyspan 4 port adapter
[    2.957000] usbcore: registered new interface driver keyspan
[    2.970214] keyspan: v1.1.5:Keyspan USB to Serial Converter Driver
[    3.169036] usb 1-1: new high speed USB device number 2 using ehci-o=
map
[    3.173645] android_usb gadget: Mass Storage Function, version: 2009=
/09/11
[    3.173675] android_usb gadget: Number of LUNs=3D1
[    3.173675]  lun0: LUN: removable file: (no medium)
[    3.173858] android_usb gadget: android_usb ready
[    3.173858] mousedev: PS/2 mouse device common for all mice
[    3.173858] i2c /dev entries driver
[    3.175048] lirc_dev: IR Remote Control driver registered, major 249
[    3.175048] IR NEC protocol handler initialized
[    3.175079] IR RC5(x) protocol handler initialized
[    3.175079] IR RC6 protocol handler initialized
[    3.175079] IR JVC protocol handler initialized
[    3.175079] IR Sony protocol handler initialized
[    3.175109] IR RC5 (streamzap) protocol handler initialized
[    3.175109] IR LIRC bridge handler initialized
[    3.177337] device-mapper: uevent: version 1.0.3
[    3.177337] device-mapper: ioctl: 4.20.0-ioctl (2011-02-02)
initialised: dm-devel@redhat.com
[    3.177337] Bluetooth: HCI UART driver ver 2.2
[    3.177337] Bluetooth: HCI H4 protocol initialized
[    3.177673] cpuidle: using governor ladder
[    3.177703] cpuidle: using governor menu
[    3.289062] usbcore: registered new interface driver usbhid
[    3.289062] usbhid: USB HID core driver
[    3.299468] logger: created 256K log 'log_main'
[    3.304656] logger: created 256K log 'log_events'
[    3.304656] logger: created 256K log 'log_radio'
[    3.314849] logger: created 256K log 'log_system'
[    3.321014] GACT probability NOT on
[    3.321014] Mirror/redirect action on
[    3.328765] u32 classifier
[    3.328765]     Actions configured
[    3.335418] Netfilter messages via NETLINK v0.30.
[    3.340545] nf_conntrack version 0.5.0 (7376 buckets, 29504 max)
[    3.348144] ctnetlink v0.93: registering with nfnetlink.
[    3.357208] xt_time: kernel timezone is -0000
[    3.366851] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.372833] arp_tables: (C) 2002 David S. Miller
[    3.372833] TCP cubic registered
[    3.382049] NET: Registered protocol family 10
[    3.390869] Mobile IPv6
[    3.390869] IPv6 over IPv4 tunneling driver
[    3.390869] NET: Registered protocol family 17
[    3.408172] NET: Registered protocol family 15
[    3.413238] Bluetooth: RFCOMM TTY layer initialized
[    3.418609] Bluetooth: RFCOMM socket layer initialized
[    3.424255] Bluetooth: RFCOMM ver 1.11
[    3.428344] NET: Registered protocol family 35
[    3.433624] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 1
[    3.441986] ThumbEE CPU extension supported.
[    3.441986] Registering SWP/SWPB emulation handler
[    3.452362] usb 1-1: New USB device found, idVendor=3D0424, idProduc=
t=3D9514
[    3.461456] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    3.469268] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    3.478729] Reprogramming LPDDR2 timings to 400000000 Hz
[    3.485015] mmc0: new high speed SD card at address 0001
[    3.485015] hub 1-1:1.0: USB hub found
[    3.485229] hub 1-1:1.0: 5 ports detected
[    3.499542] mmcblk0: mmc0:0001 00000 1.89 GiB
[    3.499664] Power Management for TI OMAP4.
[    3.499755] OMAP4 PM: Static dependency added between MPUSS <->
EMIF MPUSS <-> L4_PER/CFG and MPUSS <-> L3_
MAIN_1.
[    3.523437] Alternate GPT is invalid, using primary GPT.
[    3.529144]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
[    3.593536] Invalid Device Structure
[    3.752349] cannot apply mgr(lcd) on inactive device
[    3.758087] omapfb omapfb: failed to apply dispc config
[    3.767761] cannot apply mgr(tv) on inactive device
[    3.773437] omapfb omapfb: failed to apply dispc config
[    3.783020] cannot apply mgr(lcd2) on inactive device
[    3.788665] omapfb omapfb: failed to apply dispc config
[    3.798553] omapdss DPI: Could not find exact pixel clock.
Requested 74250 kHz, got 76800 kHz
[    3.810119] regulator_init_complete: VANA: incomplete constraints, l=
eaving on
[    3.817962] usb 1-1.1: new high speed USB device number 3 using ehci=
-omap
[    3.826568] regulator_init_complete: VDAC: incomplete constraints, l=
eaving on
[    3.834503] regulator_init_complete: VCXIO: incomplete constraints,
leaving on
[    3.842529] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.849609] Freeing init memory: 228K
[    3.937500] usb 1-1.1: New USB device found, idVendor=3D0424, idProd=
uct=3Dec00
[    3.937896] usb 1-1.1: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    3.955322] smsc95xx v1.0.4
[    3.976715] EXT4-fs (mmcblk0p4): mounted filesystem with ordered
data mode. Opts: (null)
[    4.044616] EXT4-fs (mmcblk0p6): mounted filesystem with ordered
data mode. Opts: (null)
[    4.054840] EXT4-fs (mmcblk0p5): VFS: Can't find ext4 filesystem
[    4.054901] smsc95xx 1-1.1:1.0: eth0: register 'smsc95xx' at
usb-ehci-omap.0-1.1, smsc95xx USB 2.0 Ethernet
, ce:96:6b:2e:82:6a
[    4.113861] init (1): /proc/1/oom_adj is deprecated, please use
/proc/1/oom_score_adj instead.
[    4.132537] init: cannot find '/system/etc/install-recovery.sh',
disabling 'flash_recovery'
[    4.143585] android_usb: already disabled
[    4.148345] usb 1-1.2: new low speed USB device number 4 using ehci-=
omap
[    4.155944] adb_bind_config
[    4.160858] adb_open
[    4.199829] android_usb gadget: high speed config #1: android
[    4.204071] omap-rproc omap-rproc.1: rproc_loader_cont: failed to
load ducati-m3.bin
[    4.301300] usb 1-1.2: New USB device found, idVendor=3D046d, idProd=
uct=3Dc063
[    4.308959] usb 1-1.2: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[    4.317932] usb 1-1.2: Product: DELL USB Laser Mouse
[    4.319793] usb 1-1.2: Manufacturer: DELL
[    4.337493] input: DELL DELL USB Laser Mouse as
/devices/platform/omap/usbhs_omap/ehci-omap.0/usb1/1-1/1-1.
2/1-1.2:1.0/input/input0
[    4.351104] generic-usb 0003:046D:C063.0001: input: USB HID v1.10
Mouse [DELL DELL USB Laser Mouse] on usb-
ehci-omap.0-1.2/input0
[    4.468688] PVR: Installing MISR with cookie c067ec1c
[    4.474121] PVR: Installing device LISR SGX ISR on IRQ 53 with
cookie dd4a1400
[    4.481872] PVR: OSUnMapPhysToLin: unmapping 65535 bytes from e0a600=
00
[    4.488800] PVR: SysFinalise: Version string: SGX revision =3D 1.2.0
shell@android:/ $ [    4.623931] usb 1-1.3: new low speed USB device
number 5 using ehci-omap
[    4.751678] usb 1-1.3: New USB device found, idVendor=3D04f3, idProd=
uct=3D0103
[    4.751678] usb 1-1.3: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    4.786437] input: HID 04f3:0103 as
/devices/platform/omap/usbhs_omap/ehci-omap.0/usb1/1-1/1-1.3/1-1.3:1.0/
input/input1
[    4.798309] generic-usb 0003:04F3:0103.0002: input: USB HID v1.10
Keyboard [HID 04f3:0103] on usb-ehci-omap
=2E0-1.3/input0
[    4.815826] input: HID 04f3:0103 as
/devices/platform/omap/usbhs_omap/ehci-omap.0/usb1/1-1/1-1.3/1-1.3:1.1/
input/input2
[    4.827758] generic-usb 0003:04F3:0103.0003: input: USB HID v1.10
Device [HID 04f3:0103] on usb-ehci-omap.0
-1.3/input1
[    6.739807] binder: release 70:70 transaction 113 in, still active
[    6.746398] binder: send failed reply for transaction 113 to 104:108
[    6.754943] init: untracked pid 71 exited
[    8.931884] init: untracked pid 105 exited
[   11.876129] binder: release 115:115 transaction 197 in, still active
[   11.882904] binder: send failed reply for transaction 197 to 121:124
[   11.891448] init: untracked pid 110 exited
[   12.128997] init: untracked pid 119 exited
[   16.457427] binder: release 127:137 transaction 281 in, still active
[   16.466094] binder: send failed reply for transaction 281 to 131:135
[   16.466156] init: untracked pid 125 exited
[   22.339385] init: untracked pid 126 exited
[   22.987060] binder: release 139:139 transaction 365 in, still active
[   22.994812] binder: send failed reply for transaction 365 to 144:147
[   23.001739] init: untracked pid 138 exited
[   25.958831] init: untracked pid 150 exited
[   26.328674] binder: release 152:152 transaction 449 in, still active
[   26.335601] binder: send failed reply for transaction 449 to 157:160
[   26.337982] init: untracked pid 151 exited
[   27.186126] init: untracked pid 163 exited
[   31.815765] binder: release 169:169 transaction 533 in, still active
[   31.817718] binder: send failed reply for transaction 533 to 174:177
[   31.865478] init: untracked pid 164 exited
[   37.257202] binder: release 182:186 transaction 617 in, still active
[   37.264007] binder: send failed reply for transaction 617 to 187:190
[   37.279541] init: untracked pid 178 exited
[   41.438262] binder: release 197:201 transaction 701 in, still active
[   41.445068] binder: send failed reply for transaction 701 to 202:204
[   41.460601] init: untracked pid 193 exited
[   46.838195] binder: release 210:214 transaction 785 in, still active
[   46.846099] binder: send failed reply for transaction 785 to 215:218
[   46.852996] init: untracked pid 206 exited
[   52.226043] binder: release 225:225 transaction 869 in, still active
[   52.226196] binder: send failed reply for transaction 869 to 230:232
[   52.248016] init: untracked pid 221 exited
[   56.138305] binder: release 239:239 transaction 953 in, still active
[   56.153045] init: untracked pid 235 exited
[   56.157592] binder: send failed reply for transaction 953 to 244:247
[   61.616912] binder: release 252:261 transaction 1037 in, still activ=
e
[   61.632385] init: untracked pid 248 exited
[   61.636871] binder: send failed reply for transaction 1037 to 257:26=
0
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
