From: Adam Wozniak <awozniak@irobot.com>
Subject: need help debugging ISP problem
Date: Mon, 5 Nov 2012 16:02:08 -0800
Message-ID: <50985380.8000706@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:33632
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab2KFACj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 19:02:39 -0500
Received: from mail155-ch1 (localhost [127.0.0.1])	by
 mail155-ch1-R.bigfish.com (Postfix) with ESMTP id DAAFD480144	for
 <linux-omap@vger.kernel.org>; Tue,  6 Nov 2012 00:02:37 +0000 (UTC)
Received: from CH1EHSMHS020.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])	by mail155-ch1.bigfish.com (Postfix) with ESMTP id
 725A7420112	for <linux-omap@vger.kernel.org>; Tue,  6 Nov 2012 00:02:35 +0000
 (UTC)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm working with a custom board based on an Overo WaterStorm com. The 
processor is a DM3730.  The kernel is 2.6.32 based.

I'm trying to stress test the camera ISP by rapidly opening and closing 
the video device with ( while true; do gst-launch v4l2src 
device=/dev/video0 ! video/x-raw-yuv,width=320,height=240 ! 
ffmpegcolorspace ! pngenc snapshot=true ! fakesink; done )

After many iterations, I will see the kernel spit out:

[ 2502.802795] Unhandled fault: external abort on non-linefetch (0x1028) 
at 0xfa0bce04
[ 2502.810516] Internal error: : 1028 [#1]
[ ... ]
[ 2502.846893] PC is at isp_reg_readl+0x18/0x20
[ 2502.851196] LR is at isp_reg_readl+0x10/0x20
[ ... ]
[ 2503.296447] [<c02954a0>] (isp_reg_readl+0x18/0x20) from [<c02954f8>] 
(isp_reg_and_or+0x1c/0x38)
[ 2503.305206] [<c02954f8>] (isp_reg_and_or+0x1c/0x38) from [<c029bad0>] 
(isppreview_config_cfa+0x38/0x90)
[ 2503.314666] [<c029bad0>] (isppreview_config_cfa+0x38/0x90) from 
[<c029bc5c>] (isppreview_config_datapath+0x134/0x330)
[ 2503.325347] [<c029bc5c>] (isppreview_config_datapath+0x134/0x330) 
from [<c029be68>] (isppreview_s_pipeline+0x10/0xd0)
[ 2503.336029] [<c029be68>] (isppreview_s_pipeline+0x10/0xd0) from 
[<c0296e98>] (isp_s_pipeline+0x1d8/0x280)
[ 2503.345672] [<c0296e98>] (isp_s_pipeline+0x1d8/0x280) from 
[<bf036b98>] (cammux_streamon+0x218/0xa28 [cammux])
[ ... ]


The register we're trying to access here is the ISP PRV_PCR.  If I try 
to add debug code to read ISP_CTRL right before the fault, the ISP_CTRL 
access faults in the same way (i.e. the whole ISP is borked, not just 
the previewer).

At first I thought the clocks were being disabled somehow, but tracking 
them seems to indicate that's not the case.  Adding an early return in 
arch/arm/mach/omap2/clock.c omap2_dflt_clk_disable() (i.e. to disable 
disabling of clocks) does NOT help.

What else might I be missing?  What is necessary to be able to read the 
ISP registers?

--Adam

