From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Mon, 29 Sep 2008 10:44:45 +0300
Message-ID: <20080929104445.5040e737.jarkko.nikula@nokia.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
	<a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com>
	<20080904094655.GB10426@flint.arm.linux.org.uk>
	<20080904161033.GQ23085@atomide.com>
	<20080904161248.GC2309@flint.arm.linux.org.uk>
	<20080904162917.GR23085@atomide.com>
	<20080904170733.GD2309@flint.arm.linux.org.uk>
	<20080904175810.GS23085@atomide.com>
	<alpine.DEB.1.00.0809042312410.25143@utopia.booyaka.com>
	<alpine.DEB.1.00.0809042357360.25143@utopia.booyaka.com>
	<dfeb90390809282216p73e30653l399b165e464440cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53545 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYI2HpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 03:45:25 -0400
In-Reply-To: <dfeb90390809282216p73e30653l399b165e464440cc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <arunks@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>

On Mon, 29 Sep 2008 10:46:33 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> The system hangs when there is a request for mcbsp in the platform
> driver of omap ie.. at
> File:sound/soc/omap/omap-mcbsp.c
> Function: omap_mcbsp_dai_startup
> omap_mcbsp_request(mcbsp_data->bus_id);
> This is executed when we do an aplay.
> 
Was this patch included?

commit f9d06c24f43b7620b14e4dd6dbf667fa68457766
Author: Jarkko Nikula <jarkko.nikula@nokia.com>
Date:   Mon Sep 22 16:47:51 2008 +0300

    ARM: OMAP: Fixes to omap_mcbsp_request function

    Bootloader may let McBSP logic running so make sure that block is
idle before requesting IRQs. Also make sure that TX and RX waitqueues
are initialized before request_irq.

Also you can get some debug messages from mcbsp by patch below and
"echo 8 > /proc/sys/kernel/printk" in your target before executing
aplay.

---
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 798c91e..2bfb177 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -12,6 +12,7 @@
  * Multichannel mode not supported.
  */
 
+#define DEBUG
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
---

> In the ALSA driver(sound/arm/omap/omap-alsa.c:513) the
> omap_mcbsp_request() is during the boot time.
> There no issues.
> 
> So during my testing of the ASOC driver i comment out
> omap_mcbsp_request(mcbsp_data->bus_id); from
> platform driver (sound/soc/omap/omap-mcbsp.c) and insted requested the
> omap_mcbsp in my
> moudule_init of machine driver(ie sound/soc/omap/osk.c).
> 
Legacy driver is doing some clock setup in snd_omap_alsa_post_probe
before omap_mcbsp_request.

	alsa_codec_config->codec_clock_setup();
	alsa_codec_config->codec_clock_on();

	omap_mcbsp_request(AUDIO_MCBSP);

If my patch wasn't included I can understand that it would explain why
legacy driver is working. If it was, then there still might be some
registers which must be set to reset default before requesting irqs in
omap_mcbsp_request.


Jarkko
