From: =?ISO-8859-15?Q?Robert_W=F6rle?= <rwoerle@mibtec.de>
Subject: Omapdss Managers confusion
Date: Wed, 16 Feb 2011 09:34:58 +0100
Message-ID: <4D5B8C32.1070708@mibtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63802 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758717Ab1BPIfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 03:35:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dear All

May someon drop me a line about the following

I am trying to run up a good gst pipeline ( to start with  videotestsrc) 
but i am running into this

My Device: igep0030 module
my kernel:  2.6.35.9  from here ( 
http://git.igep.es/?p=pub/scm/linux-omap-2.6.git;a=summary)
cmdline is : omapfb.mode=lcd:1024x768MR@60 ubi.mtd=4 rootfstype=ubifs 
root=ubi0 console=ttyS0,115200n8 video=omapfb:vram:2M,vram:4M 
mem=88M@0x80000000 mem=384M@0x88000000

All is compiled with openembedded.

When i play this:

root@biogas:~# DMAI_DEBUG=2 gst-launch --gst-debug=2  videotestsrc ! 
TIDmaiVideo
Sink autoselect=TRUE displayDevice=/dev/fb0 videoStd=VGA
@0x000e8885:[T:0x402f2000] ti.sdo.dmai - [Dmai] Dmai log level set to 
'2'. Note that calling CERuntime_init after this point may cause 
unexpected change to DMAI tracing behavior.
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
@0x00104dc1:[T:0x4185a490] ti.sdo.dmai - [Buffer] Alloc Buffer of size 
153600 at 0x419c7000 (0x868e7000 phys)
@0x0010589a:[T:0x4185a490] ti.sdo.dmai - [Dmai] Unknown Device Output Found
@0x001058f6:[T:0x4185a490] ti.sdo.dmai - [Dmai] Failed to Detect Current 
Display Output.
@0x00105914:[T:0x4185a490] ti.sdo.dmai - [Dmai] Attempting to change to 3
@0x00105951:[T:0x4185a490] ti.sdo.dmai - [Display] Failed to setup sysfs 
variables
@0x00105a45:[T:0x4185a490] ti.sdo.dmai - [Dmai] Unknown Device Output Found
@0x00105a64:[T:0x4185a490] ti.sdo.dmai - [Dmai] Failed to Detect Current 
Display Output.
@0x00105a82:[T:0x4185a490] ti.sdo.dmai - [Dmai] Attempting to change to 3

this loops till i stop the pipeline


I followed the code into 
davinci_multimedia_application_interface/dmai/packages/ti/sdo/dmai/linux/omap3530/_Sysfs.c 

where it loops on working out the managers ( waiting for either "lcd" 
"tv" or "dvi")

also
kernel/drivers/video/omap2/dss/manager.c  supports only "lcd" and "tv" 
as managers
but my kernel shows

root@biogas:~# cat /sys/devices/platform/omapdss/manager0/display
tft

So do i ve a miscombination of versions here ( one knowing about a new 
"tft" manager and one not ) ?

All Documents i find never talk about "tft" , where is this coming from ?

Any hints

Thanks in advance

Rob

