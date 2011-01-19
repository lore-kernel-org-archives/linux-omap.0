From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap1: Fix sched_clock for the MPU timer (Re: State of
 LDP3430 platform)
Date: Wed, 19 Jan 2011 10:44:53 -0800
Message-ID: <20110119184452.GZ4957@atomide.com>
References: <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
 <20110115233744.GA18159@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
 <4D3309F9.8090900@gmail.com>
 <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
 <20110118222613.GS4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57946 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab1ASSpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 13:45:09 -0500
Content-Disposition: inline
In-Reply-To: <20110118222613.GS4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Tony Lindgren <tony@atomide.com> [110118 14:25]:
> * Paul Walmsley <paul@pwsan.com> [110118 11:35]:
> > 
> > Here's a slightly updated version of this patch, fixing a bug in one of 
> > the comments, and revising the commit message.  There's no functional 
> > difference between this and the previous version of this patch.
> 
> Thanks, here are two patches to fix the MPU timer, and then allow
> compiling in both the MPU timer and the 32KiHz timer.

I've updated this patch with the following fix to reset the timer
first to get correct PRINTK_TIME timestamps.

Regards,

Tony

--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -228,10 +228,9 @@ static void __init omap_init_clocksource(unsigned long rate)
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
-	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
-
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
 	omap_mpu_timer_start(1, ~0, 1);
+	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
 
 	if (clocksource_register_hz(&clocksource_mpu, rate))
 		printk(err, clocksource_mpu.name);
