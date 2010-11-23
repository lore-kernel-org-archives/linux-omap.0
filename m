From: James Adams <james.r.adams@gmail.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Tue, 23 Nov 2010 09:30:05 +0000
Message-ID: <AANLkTinpR2S1vGaRr=DMALxWjb1X-4TPkhwXZbZhXbwj@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
	<AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
	<AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
	<AANLkTinkMPb4Htv4GN8--PZP0UdkWuyXiLYvRC3QasWD@mail.gmail.com>
	<AANLkTim6++ATTJ=BCssvLYKRek0EXKVPMGgKH1WMNuRM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48510 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0KWJaG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 04:30:06 -0500
Received: by qyk11 with SMTP id 11so1738465qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 01:30:05 -0800 (PST)
In-Reply-To: <AANLkTim6++ATTJ=BCssvLYKRek0EXKVPMGgKH1WMNuRM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Hi Rene,

This email contains 2 error logs.  The first comes from trying to switc=
h
to using the software decoder.
Is there something else I need to do to revert to software codecs
perhaps?

The second error log is the stack trace when the watchdog timer calls
SYNC_EnterCS.

I am sorry for troubling you with all these newbie questions, I've done
quite a lot of Linux driver work before and have written my own embedde=
d
H264 and MPEG4 codecs, but I have only been looking at Android for a
couple of weeks and am finding it rather overwhelming how much there is
to learn!

If I try to switch back to software codecs by commenting out the
OMX.TI.Video.Decoder line in
hardware/ti/omx/system/src/openmax_il/omx_core/src/OMX_Core.c then I ge=
t
the following errors:

D/omx_interface(  934): TIOMXInterface: creating interface
D/omx_interface(  934): Calling DLOPEN on OMX_CORE_LIBRARY
(libOMX_Core.so)
D/omx_interface(  934): DLOPEN SUCCEEDED (libOMX_Core.so)
D/omx_interface(  934): TIOMXInterface: library lookup success
D/TIOMX_CORE(  934): init count =3D 1
I/ActivityManager(  966): Displayed activity
com.android.gallery/com.android.cam
era.MovieView: 540 ms (total 540 ms)
V/MovieView( 1145): hasFocus
D/VideoMio34xx(  934): Vendor(34xx) Specific CloseFrameBuf
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Video F
ormat Key, Value X-YUV-420
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Error,
unrecognized key x-pvmf/mediaxfer/output/rate;type=3Drel;valtype=3Dint3=
2
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Error,
unrecognized key x-pvmf/port/formattype;valtype=3Dint32
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Video W
idth, Value 320
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Video H
eight, Value 240
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Video D
isplay Height, Value 240
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Video D
isplay Width, Value 320
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Number
of Buffer, Value 2
D/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::setParametersSync(=
)
Buffer
Size, Value 115200
D/VideoMio34xx(  934): Calling Vendor(34xx) Specific initCheck
D/TIOverlay(  966): overlay_createOverlay:IN w=3D320 h=3D240 format=3D2=
2
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_createOverlay() ######
I/TIOverlay(  966): Opened video1/fd=3D60/obj=3D002dcf20/shm=3D59/size=3D=
4096
D/TIOverlay(  966): overlay_createOverlay: OUT
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setParameter() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setPosition() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setParameter() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setParameter() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setParameter() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setParameter() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_setParameter() ######
D/TIOverlay(  966):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_commit() ######
I/TIOverlay(  966): Position/X0/Y0/W240/H320
I/TIOverlay(  966): Adjusted Position/X0/Y0/W320/H240
I/TIOverlay(  966): Rotation/90
I/TIOverlay(  966): ColorKey/0
I/TIOverlay(  966): shared->dispH =3D 320, shared->dispW =3D 240
I/Overlay-V4L2(  966): dumping driver state:
I/Overlay-V4L2(  966): output pixfmt:
I/Overlay-V4L2(  966): w: 320
I/Overlay-V4L2(  966): h: 240
I/Overlay-V4L2(  966): color: 7
I/Overlay-V4L2(  966): UYVY
I/Overlay-V4L2(  966): v4l2_overlay window:
I/Overlay-V4L2(  966): window l: 0
I/Overlay-V4L2(  966): window t: 0
I/Overlay-V4L2(  966): window w: 320
I/Overlay-V4L2(  966): window h: 240
I/Overlay-V4L2(  966): output crop:
I/Overlay-V4L2(  966): crop l: 0
I/Overlay-V4L2(  966): crop t: 0
I/Overlay-V4L2(  966): crop w: 320
I/Overlay-V4L2(  966): crop h: 240
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_device_open() ######
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_initialize() ######
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_data_setParameter() ######
I/VideoMio34xx(  934): Actual resolution: 320x240
I/VideoMio34xx(  934): Video resolution: 320x240
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferCount() ######
D/VideoMio34xx(  934): number of buffers =3D 6
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferAddress() ######
I/TIOverlay(  934): Buffer/0/addr=3D40eb9000/len=3D155648
D/VideoMio34xx(  934): buffer =3D 0 allocated addr=3D0x40eb9000
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferAddress() ######
I/TIOverlay(  934): Buffer/1/addr=3D40edf000/len=3D155648
D/VideoMio34xx(  934): buffer =3D 1 allocated addr=3D0x40edf000
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferAddress() ######
I/TIOverlay(  934): Buffer/2/addr=3D40f05000/len=3D155648
D/VideoMio34xx(  934): buffer =3D 2 allocated addr=3D0x40f05000
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferAddress() ######
I/TIOverlay(  934): Buffer/3/addr=3D40f2b000/len=3D155648
D/VideoMio34xx(  934): buffer =3D 3 allocated addr=3D0x40f2b000
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferAddress() ######
I/TIOverlay(  934): Buffer/4/addr=3D40f51000/len=3D155648
D/VideoMio34xx(  934): buffer =3D 4 allocated addr=3D0x40f51000
D/TIOverlay(  934):  hardware/ti/omap3/liboverlay/overlay.cpp ######
Calling ove
rlay_getBufferAddress() ######
I/TIOverlay(  934): Buffer/5/addr=3D40f77000/len=3D155648
D/VideoMio34xx(  934): buffer =3D 5 allocated addr=3D0x40f77000
I/VideoMio34xx(  934): Ln 598 iVideoSubFormat X-YUV-420-PLANAR. do NOT
allocate
decoder buffer from overlay
W/MediaPlayer( 1145): info/warning (1, 44)
I/MediaPlayer( 1145): Info (1,44)
D/MediaPlayer( 1145): getMetadata
D/Omap3ALSA(  934): open called for devices 00000000 in mode 0...
E/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::writeAsync: aData
does not
match any v4l buffer address
I/Omap3ALSA(  934): Initialized ALSA PLAYBACK device default
E/AudioHardwareALSA(  934): RE-OPEN AFTER STANDBY:: took 79 msecs
W/AudioFlinger(  934): write blocked for 79 msecs, 2 delayed writes,
thread 0x25
1a8
E/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::writeAsync: aData
does not
match any v4l buffer address
E/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::writeAsync: aData
does not
match any v4l buffer address
E/VideoMio34xx(  934): AndroidSurfaceOutputOmap34xx::writeAsync: aData
does not
match any v4l buffer address

The stack trace is shown below.

[<c0412864>] (dump_stack+0x0/0x14) from [<c0278c18>]
(SYNC_EnterCS+0x48/0xe4)
[<c0278bd0>] (SYNC_EnterCS+0x0/0xe4) from [<c0279e24>]
(REG_GetValue+0x60/0xa0)
 r5:c05ba390 r4:c04f092c
[<c0279dc4>] (REG_GetValue+0x0/0xa0) from [<c027987c>]
(CFG_GetObject+0x60/0xe0)
 r7:cfa87a80 r6:00000002 r5:cf98fe94 r4:00000002
[<c027981c>] (CFG_GetObject+0x0/0xe0) from [<c02913c0>]
(DRV_GetFirstDevObject+0
x1c/0x4c)
 r5:c05ba3c0 r4:00000000
[<c02913a4>] (DRV_GetFirstDevObject+0x0/0x4c) from [<c02858e4>]
(DEV_GetFirst+0x
10/0x44)
[<c02858d4>] (DEV_GetFirst+0x0/0x44) from [<c027d430>]
(dsp_wdt_enable+0x44/0xe0
)
 r5:c05ba3c0 r4:00000000
[<c027d3ec>] (dsp_wdt_enable+0x0/0xe0) from [<c02820fc>]
(handle_hibernation_fro
mDSP+0x148/0x1ec)
 r5:cfaa0000 r4:00008000
[<c0281fb4>] (handle_hibernation_fromDSP+0x0/0x1ec) from [<c02810c0>]
(WMD_DEV_C
trl+0xfc/0x130)
 r7:cf98e000 r6:cf98ff34 r5:cc5f6a88 r4:cfb89e00
[<c0280fc4>] (WMD_DEV_Ctrl+0x0/0x130) from [<c027dc24>]
(io_mbox_msg+0x70/0x1d8)
 r7:cf98e000 r6:c05496c4 r5:cc5f6a88 r4:cfb89e00
[<c027dbb4>] (io_mbox_msg+0x0/0x1d8) from [<c0059308>]
(mbox_rx_work+0xf4/0x100)
 r5:cc5f6a88 r4:0000200a
[<c0059214>] (mbox_rx_work+0x0/0x100) from [<c007ebb0>]
(run_workqueue+0xc8/0x18
4)
[<c007eae8>] (run_workqueue+0x0/0x184) from [<c007f2dc>]
(worker_thread+0x104/0x
118)
 r9:00000000 r8:00000000 r7:cf811040 r6:cf94e140 r5:cf94e148
r4:cf98e000
[<c007f1d8>] (worker_thread+0x0/0x118) from [<c0082cb4>]
(kthread+0x54/0x80)
 r7:00000000 r6:00000000 r5:c007f1d8 r4:cf94e140
[<c0082c60>] (kthread+0x0/0x80) from [<c0070b1c>] (do_exit+0x0/0x7bc)
 r5:00000000 r4:00000000
drivers/dsp/bridge/services/sync.c, line 358: Assertion (0) failed.


On Mon, Nov 22, 2010 at 9:42 PM, Sapiens, Rene <rene.sapiens@ti.com> wr=
ote:
> James,
>
> On Mon, Nov 22, 2010 at 11:12 AM, James Adams <james.r.adams@gmail.co=
m> wrote:
>> Hi Rene,
>>
>> We have got the watchdog timer enabled at the moment (interval 5 sec=
onds).
>> The code does indeed point to the line as you say.
>> I tried using dump_stack and it was getting triggered by an interrup=
t
>> calling handle_hibernation_fromDSP which then called functions
>> eventually triggering the SYNC_entercs (via DEV_getfirst if I rememb=
er
>> right)
>> I certainly don't understand why this should happen, but it seems to
>> happen quite a lot (probably every 5 seconds...) and the lower
>> resolution videos didn't seem to mind so I have been ignoring it.
>>
>
> Looking at the drivers/dsp/bridge/wmd/tiomap3430_pwr.c file tagged
> with L25.12 release at [1] =A0I don't see feasible the path to have
> handle_hibernation_fromDSP() to get to SYNC_entercs(), so probably yo=
u
> have a newer or older version of the file.
>
> Basically what i was looking with those assertions is to see if those
> could be because of =A0a DSP WDT overflow. Also those assertions can
> fail because of the calling of IO_DispatchMsg by io_dpc(), if that's
> the case there should not be a problem. On the other hand if there is
> a WDT overflow those assertions could also fail.
>
> Can you double check by printing the call stack again when the
> assertion fails, just to see why for your case
> handle_hibernation_fromDSP() is failing in the assertion?
>
>> Is it a bad idea to use WDT?
>
> No, =A0it is ok =A0to use it.
>
> Regards,
> Rene Sapiens
> --
> [1] http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dblob;f=3Ddrivers=
/dsp/bridge/wmd/tiomap3430_pwr.c;h=3Df698b4475584e92467e03ecec96bc88794=
8275f9;hb=3D64b404e9f457f19537972e7f2424f4c73a8a7789#l116
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
