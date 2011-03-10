From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Thu, 10 Mar 2011 09:56:11 -0800
Message-ID: <20110310175611.GV26463@atomide.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
 <20110309220241.GR26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD852@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20707 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1CJR4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:56:24 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD852@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110310 07:25]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Thursday, March 10, 2011 3:33 AM
> > To: DebBarma, Tarun Kanti
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device
> > driver
> > 
> > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> > > switch-over to platform device driver through following changes:
> > > (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> > > in timer-gp.c. This is equivalent of timer_init()->timer->init().
> > > (b) modify plat-omap/dmtimer routines to use new register map and
> > > platform data.
> > 
> > This patch breaks booting for 2420 and makes boot hang early
> > on 2430. Note that to test with omap-for-linus branch you need
> > to disable the following in omap2plus_defconfig:
> > 
> > CONFIG_ARCH_OMAP3
> > CONFIG_ARCH_OMAP4
> > CONFIG_CPU_32v6K
> I disabled above options on omap-for-linus *WITHOUT* my patch series.
> I am still seeing crash. Here is the log.
> I tried on two different setups. Not sure if I am missing something.

Hmm sounds like H4 needs some attention. Can you try the following
completely untested patch?

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 10 Mar 2011 09:51:29 -0800
Subject: [PATCH] omap: Fix H4 init_irq to not call h4_init_flash

There should be no reason to call h4_init_flash this
early. It causes problems as things are not yet initialized.

Note: This patch has not been tested.

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -299,7 +299,6 @@ static void __init omap_h4_init_early(void)
 static void __init omap_h4_init_irq(void)
 {
 	omap_init_irq();
-	h4_init_flash();
 }
 
 static struct at24_platform_data m24c01 = {
@@ -372,6 +371,7 @@ static void __init omap_h4_init(void)
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
+	h4_init_flash();
 }
 
 static void __init omap_h4_map_io(void)
