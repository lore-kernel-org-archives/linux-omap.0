From: James Adams <james.r.adams@gmail.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Mon, 22 Nov 2010 15:26:29 +0000
Message-ID: <AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35955 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0KVP0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 10:26:31 -0500
Received: by pxi15 with SMTP id 15so1443524pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 07:26:30 -0800 (PST)
In-Reply-To: <AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Hari,

Please see output below - hopefully there are some clues in there? many=
 thanks,

James

I/ActivityManager(  966): Starting activity: Intent {
act=3Dandroid.intent.action.
MAIN cat=3D[android.intent.category.LAUNCHER] flg=3D0x10200000
cmp=3Dcom.android.devel
opment/.Development }
I/ActivityManager(  966): Start proc com.android.development for
activity com.an
droid.development/.Development: pid=3D1249 uid=3D10016 gids=3D{3003}
binder_open: 1249:1249
binder_mmap: 1249 44682000-44780000 (1016 K) vma 200075 pagep 30f
D/dalvikvm(  933): GC freed 281 objects / 10696 bytes in 225ms
D/dalvikvm(  933): GC freed 50 objects / 2232 bytes in 64ms
D/dalvikvm(  933): GC freed 2 objects / 48 bytes in 57ms
I/ActivityManager(  966): Displayed activity
com.android.development/.Developmen
t: 898 ms (total 898 ms)
I/ActivityManager(  966): Starting activity: Intent {
act=3Dandroid.intent.action.
MAIN cat=3D[android.intent.category.TEST] flg=3D0x10000000
cmp=3Dcom.android.developme
nt/.MediaScannerActivity }
D/MediaScannerService( 1073): start scanning volume external
I/ActivityManager(  966): Displayed activity
com.android.development/.MediaScann
erActivity: 294 ms (total 294 ms)
D/dalvikvm( 1073): GC freed 6291 objects / 312432 bytes in 66ms
V/MediaProvider( 1073): we got work to do for checkThumbnail:
/sdcard/videos/wal
l_e_720p.m4v, there are still 0 tasks left in queue
D/omx_interface(  934): TIOMXInterface: creating interface
D/omx_interface(  934): Calling DLOPEN on OMX_CORE_LIBRARY
(libOMX_Core.so)
D/omx_interface(  934): DLOPEN SUCCEEDED (libOMX_Core.so)
D/omx_interface(  934): TIOMXInterface: library lookup success
D/TIOMX_CORE(  934): init count =3D 1
D/MediaScanner( 1073):  prescan time: 189ms
D/MediaScanner( 1073):     scan time: 1019ms
D/MediaScanner( 1073): postscan time: 2ms
D/MediaScanner( 1073):    total time: 1210ms
D/MediaScannerService( 1073): done scanning volume external
E/MetadataDriver(  934): handleQueryTrackSelectionHelper()
I/TI_Parser_Utils(  934): iGetAVCConfigInfo:: 909:
entropy_coding_mode_flag =3D 0
I/TI_Parser_Utils(  934): iGetAVCConfigInfo:: 909:
entropy_coding_mode_flag =3D 0
I/TI_Parser_Utils(  934): iGetAVCConfigInfo:: 909:
entropy_coding_mode_flag =3D 0
D/TIOMX_CORE(  934): Found component OMX.TI.Video.Decoder with refCount
0
D/TI_Video_Decoder(  934): OMX_ComponentInit():296 TI Video Decoder
D/TI_Video_Decoder(  934): VIDDEC_InitDSP_H264Dec():6570 Before
Rounding: nFrame
Width =3D 1280, nFrameHeight =3D 544
D/TI_Video_Decoder(  934): VIDDEC_InitDSP_H264Dec():6573 After Rounding=
:
nFrameW
idth =3D 1280, nFrameHeight =3D 544
drivers/dsp/bridge/services/sync.c, line 357: Assertion (0) failed.
drivers/dsp/bridge/services/sync.c, line 357: Assertion (0) failed.
D/TI_Video_Decoder(  934): VIDDEC_InitDSP_H264Dec():6619
LCML_InitMMCodec Failed
!...80001009
D/TI_Video_Decoder(  934): VIDDEC_HandleCommand():1950 LCML Error 1
D/TI_Video_Decoder(  934): OMX_VidDec_Thread():165 Error in Select
I/DEBUG   (  930): *** *** *** *** *** *** *** *** *** *** *** *** ***
*** *** *
**
I/DEBUG   (  930): Build fingerprint:
'generic/zoom2/zoom2/zoom2:2.1/ERD79/eng.a
=2E20101027.181041:eng/test-keys'
I/DEBUG   (  930): pid: 934, tid: 1258  >>> /system/bin/mediaserver <<<
I/DEBUG   (  930): signal 11 (SIGSEGV), fault addr deadbaad
I/DEBUG   (  930):  r0 00000000  r1 afe13329  r2 00000027  r3 00000054
I/DEBUG   (  930):  r4 afe3ae08  r5 00000000  r6 00000000  r7 0000a000
I/DEBUG   (  930):  r8 00100000  r9 a9d1c1d5  10 40c08000  fp 0000c8a0
I/DEBUG   (  930):  ip 00002ed8  sp 40d07b28  lr deadbaad  pc afe109e0
cpsr 600
00030
I/DEBUG   (  930):          #00  pc 000109e0  /system/lib/libc.so
I/DEBUG   (  930):          #01  pc 0000b332  /system/lib/libc.so
I/DEBUG   (  930):          #02  pc 00032936
/system/lib/libOMX.TI.Video.Decode
r.so
I/DEBUG   (  930):          #03  pc 0000111e  /system/lib/libOMX_Core.s=
o
I/DEBUG   (  930):          #04  pc 00039f90
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #05  pc 000aad68
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #06  pc 000ad364
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #07  pc 000a0144
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #08  pc 0009e348
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #09  pc 0009f5ea
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #10  pc 000939fa
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #11  pc 00093a2a
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #12  pc 00096c42
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #13  pc 00089446
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #14  pc 0002b0cc
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #15  pc 0002b334
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #16  pc 0002b6ec
/system/lib/libopencore_common.so
I/DEBUG   (  930):          #17  pc 000a3118
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #18  pc 000a313a
/system/lib/libopencore_player.so
I/DEBUG   (  930):          #19  pc 0001c23c  /system/lib/libutils.so
I/DEBUG   (  930):          #20  pc 0000fd74  /system/lib/libc.so
I/DEBUG   (  930):          #21  pc 0000f840  /system/lib/libc.so
I/DEBUG   (  930):
I/DEBUG   (  930): code around pc:
I/DEBUG   (  930): afe109d0 f8442001 4798000c e054f8df 26002227
I/DEBUG   (  930): afe109e0 2000f88e ef4cf7fb f7fd2106 f04fe822
I/DEBUG   (  930): afe109f0 91035180 460aa901 96012006 f7fc9602
I/DEBUG   (  930):
I/DEBUG   (  930): code around lr:
I/DEBUG   (  930): deadba9c ffffffff ffffffff ffffffff ffffffff
I/DEBUG   (  930): deadbaac ffffffff ffffffff ffffffff ffffffff
I/DEBUG   (  930): deadbabc ffffffff ffffffff ffffffff ffffffff
I/DEBUG   (  930):
I/DEBUG   (  930): stack:
I/DEBUG   (  930):     40d07ae8  000000a1
I/DEBUG   (  930):     40d07aec  afe13359  /system/lib/libc.so
I/DEBUG   (  930):     40d07af0  afe3b02c  /system/lib/libc.so
I/DEBUG   (  930):     40d07af4  afe3afd8  /system/lib/libc.so
I/DEBUG   (  930):     40d07af8  00000000
I/DEBUG   (  930):     40d07afc  afe14373  /system/lib/libc.so
I/DEBUG   (  930):     40d07b00  afe13329  /system/lib/libc.so
I/DEBUG   (  930):     40d07b04  afe13329  /system/lib/libc.so
I/DEBUG   (  930):     40d07b08  00000054
I/DEBUG   (  930):     40d07b0c  afe3ae08  /system/lib/libc.so
I/DEBUG   (  930):     40d07b10  00000000
I/DEBUG   (  930):     40d07b14  40d07b3c
I/DEBUG   (  930):     40d07b18  0000a000  [heap]
I/DEBUG   (  930):     40d07b1c  afe135cb  /system/lib/libc.so
I/DEBUG   (  930):     40d07b20  df002777
I/DEBUG   (  930):     40d07b24  e3a070ad
I/DEBUG   (  930): #00 40d07b28  afe3db74
I/DEBUG   (  930):     40d07b2c  afe0f110  /system/lib/libc.so
I/DEBUG   (  930):     40d07b30  afe3ae08  /system/lib/libc.so
I/DEBUG   (  930):     40d07b34  00030770  [heap]
I/DEBUG   (  930):     40d07b38  4138d180
I/DEBUG   (  930):     40d07b3c  fffffbdf
I/DEBUG   (  930):     40d07b40  afe3ae08  /system/lib/libc.so
I/DEBUG   (  930):     40d07b44  afe3d9bc
I/DEBUG   (  930):     40d07b48  4138d180
I/DEBUG   (  930):     40d07b4c  afe0b337  /system/lib/libc.so
I/DEBUG   (  930): #01 40d07b50  00100000
I/DEBUG   (  930):     40d07b54  0006d5e0  [heap]
I/DEBUG   (  930):     40d07b58  00002bb4
I/DEBUG   (  930):     40d07b5c  00000000
I/DEBUG   (  930):     40d07b60  00000000
I/DEBUG   (  930):     40d07b64  80c3d0f8
/system/lib/libOMX.TI.Video.Decoder.s
o
I/DEBUG   (  930):     40d07b68  00030770  [heap]
I/DEBUG   (  930):     40d07b6c  0000c8a0  [heap]
I/DEBUG   (  930):     40d07b70  40d07bf4
I/DEBUG   (  930):     40d07b74  80c32939
/system/lib/libOMX.TI.Video.Decoder.s


On Mon, Nov 22, 2010 at 1:23 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
> James,
>
> On Mon, Nov 22, 2010 at 7:14 AM, James Adams <james.r.adams@gmail.com=
> wrote:
>> Hi All,
>>
>> We are running Android on a custom Gumstix Overo Water platform. We
>> have ported the 25.12 Zoom2 release to do this.
>>
>> It is almost working except that when trying to decode H264 videos
>> with resolution above 640x480 (either horizontally or vertically, e.=
g.
>> 640*544) the DSP module appears to crash. Decoding anything at VGA o=
r
>> below is working fine.
>>
>> DSP bridge is configured with 0x600000 memory (but larger doesn't se=
em
>> to help). =A0Is anyone aware of other configuration options that we
>> should be checking (e.g. in DSP bridge, OMAP video drivers, or
>> android?) that might cause large video decodes to fail?
>
> Can you please post any error/failure logs ?
>
>
> Thank you,
> Best regards,
> Hari Kanigeri
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
