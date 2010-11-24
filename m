From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Tue, 23 Nov 2010 18:17:02 -0600
Message-ID: <AANLkTi=oTopYGPPcH_Ux-pfG4BNvmVJCCoHaxR=k-eiQ@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
	<AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
	<AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
	<AANLkTinkMPb4Htv4GN8--PZP0UdkWuyXiLYvRC3QasWD@mail.gmail.com>
	<AANLkTim6++ATTJ=BCssvLYKRek0EXKVPMGgKH1WMNuRM@mail.gmail.com>
	<AANLkTinpR2S1vGaRr=DMALxWjb1X-4TPkhwXZbZhXbwj@mail.gmail.com>
	<AANLkTikYfYxUWBLL0qdnAEpoKSMGB6DTNXhUXJh_Enqv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58128 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754351Ab0KXARF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 19:17:05 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so2809028ewy.33
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 16:17:04 -0800 (PST)
In-Reply-To: <AANLkTikYfYxUWBLL0qdnAEpoKSMGB6DTNXhUXJh_Enqv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: James Adams <james.r.adams@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Hi James,

On Tue, Nov 23, 2010 at 8:34 AM, James Adams <james.r.adams@gmail.com> =
wrote:
> A bit more information about why videos are not playing in a port of
> Zoom2 to gumstix:
>
> 2)
> If I use the OpenCORE unit tests I can successfully decode:
> =A0 VGA movies with software codec
> =A0 1280*544 movie with software codec
> =A0 VGA movies with DSP codec
> but it fails for the 1280x544 movie with DSP codec.
>
> This is the error log:
> =A0 pvplayer_engine_test -test 1 1 -source wall720p.mp4
> =A0 SDK Labeled: PVDEV_CORE_RELEASE_6.506.4.1 built on 20090312
>
> =A0 Test Program for pvPlayer engine class.
> =A0 =A0 Input file name 'wall720p.mp4'
> =A0 =A0 Test case range 1 to 1
> =A0 =A0 Compressed output Video(No) Audio(No)
> =A0 =A0 Log level 8; Log node 0 Log Text 0 Log Mem 0
>
> =A0 Starting Test 1: Open-Play-Stop-Reset
>
> =A0 ****************LCML ERROR : DSP ************************
> =A0 Error: Create the Node : Err Num =3D 8000800c
> =A0 ****************LCML ERROR : DSP ************************
>

It looks that your system is getting ride of memory and it is failing
in the creation stage of a DSP node.
I  suggest you to free all the not needed resources before trying to
decode the 1280x544 movie with the DSP decoders, There are a couple of
minor allocations done during the node create stage.
To debug it you can take a look to the bridge code:
drivers/dsp/bridge/
Basically communication with the DSP is handled by such driver[1].
The error should be coming from drivers/dsp/bridge/rmgr/node.c
in the node_create() function.

> 3)
> I can't find this 8000800c number defined anywhere in the Android tre=
e.
> Any idea what it means?

=46or this version of the bridge driver  0x8000800c should mean a
"DSP_EMEMORY" error, find it in [2]. You can take a look in the driver
mentioned above for the place where you are getting that error.
=46unctions where you can get that error in the node's create phase are=
:

1) drivers/dsp/bridge/rmgr/Nldr.c
LoadLib()

2) drivers/dsp/bridge/pmgr/Dbll.c
DBLL_open()

3) drivers/dsp/bridge/rmgr/Dbdcd.c
GetDepLibInfo()


4) drivers/dsp/bridge/pmgr/Dbll.c
DBLL_load()

5) drivers/dsp/bridge/rmgr/rmm.c
RMM_alloc()
    - When calling to allocBlock()
    - When allocate list element for new section.


>
> 4)
> Using the software codec from inside the Android Gallery application =
I
> still get the same errors as mentioned before about missing video buf=
fer
> addresses.

In general, OpenCore/Omx question should go to a different list, since
it is not kernel specific, i would suggest you to contact your vendor
to point you to the correct support team.

Regards,
Rene Sapiens
--
[1] http://omapzoom.org/wiki/DSPBridge_Project#Documents
[2] http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dblob;f=3Darch/arm/=
plat-omap/include/dspbridge/errbase.h;h=3Df04c005c06adb253a3b2f8886ba38=
e4475b578b3;hb=3Drefs/heads/p-android-omap-2.6.29-eclair#l130
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
