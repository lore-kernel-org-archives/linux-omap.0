From: =?ISO-8859-15?Q?Robert_W=F6rle?= <rwoerle@mibtec.de>
Subject: Re: Omapdss Managers confusion
Date: Wed, 16 Feb 2011 10:08:31 +0100
Message-ID: <4D5B940F.8060101@mibtec.de>
References: <4D5B8C32.1070708@mibtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64554 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737Ab1BPJId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 04:08:33 -0500
In-Reply-To: <4D5B8C32.1070708@mibtec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

never mind ..
i think i found it .. my board code named my video device "tft" instead=
=20
of "lcd"

duhhh

sorry to bother anyone

Rob

Am 16.02.2011 09:34, schrieb Robert W=F6rle:
> Dear All
>
> May someon drop me a line about the following
>
> I am trying to run up a good gst pipeline ( to start with =20
> videotestsrc) but i am running into this
>
> My Device: igep0030 module
> my kernel:  2.6.35.9  from here (=20
> http://git.igep.es/?p=3Dpub/scm/linux-omap-2.6.git;a=3Dsummary)
> cmdline is : omapfb.mode=3Dlcd:1024x768MR@60 ubi.mtd=3D4 rootfstype=3D=
ubifs=20
> root=3Dubi0 console=3DttyS0,115200n8 video=3Domapfb:vram:2M,vram:4M=20
> mem=3D88M@0x80000000 mem=3D384M@0x88000000
>
> All is compiled with openembedded.
>
> When i play this:
>
> root@biogas:~# DMAI_DEBUG=3D2 gst-launch --gst-debug=3D2  videotestsr=
c !=20
> TIDmaiVideo
> Sink autoselect=3DTRUE displayDevice=3D/dev/fb0 videoStd=3DVGA
> @0x000e8885:[T:0x402f2000] ti.sdo.dmai - [Dmai] Dmai log level set to=
=20
> '2'. Note that calling CERuntime_init after this point may cause=20
> unexpected change to DMAI tracing behavior.
> Setting pipeline to PAUSED ...
> Pipeline is PREROLLING ...
> Pipeline is PREROLLED ...
> Setting pipeline to PLAYING ...
> New clock: GstSystemClock
> @0x00104dc1:[T:0x4185a490] ti.sdo.dmai - [Buffer] Alloc Buffer of siz=
e=20
> 153600 at 0x419c7000 (0x868e7000 phys)
> @0x0010589a:[T:0x4185a490] ti.sdo.dmai - [Dmai] Unknown Device Output=
=20
> Found
> @0x001058f6:[T:0x4185a490] ti.sdo.dmai - [Dmai] Failed to Detect=20
> Current Display Output.
> @0x00105914:[T:0x4185a490] ti.sdo.dmai - [Dmai] Attempting to change =
to 3
> @0x00105951:[T:0x4185a490] ti.sdo.dmai - [Display] Failed to setup=20
> sysfs variables
> @0x00105a45:[T:0x4185a490] ti.sdo.dmai - [Dmai] Unknown Device Output=
=20
> Found
> @0x00105a64:[T:0x4185a490] ti.sdo.dmai - [Dmai] Failed to Detect=20
> Current Display Output.
> @0x00105a82:[T:0x4185a490] ti.sdo.dmai - [Dmai] Attempting to change =
to 3
>
> this loops till i stop the pipeline
>
>
> I followed the code into=20
> davinci_multimedia_application_interface/dmai/packages/ti/sdo/dmai/li=
nux/omap3530/_Sysfs.c=20
>
> where it loops on working out the managers ( waiting for either "lcd"=
=20
> "tv" or "dvi")
>
> also
> kernel/drivers/video/omap2/dss/manager.c  supports only "lcd" and "tv=
"=20
> as managers
> but my kernel shows
>
> root@biogas:~# cat /sys/devices/platform/omapdss/manager0/display
> tft
>
> So do i ve a miscombination of versions here ( one knowing about a ne=
w=20
> "tft" manager and one not ) ?
>
> All Documents i find never talk about "tft" , where is this coming fr=
om ?
>
> Any hints
>
> Thanks in advance
>
> Rob
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
