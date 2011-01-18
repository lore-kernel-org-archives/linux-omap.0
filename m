From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap1: Fix sched_clock for the MPU timer (Re: State of
 LDP3430 platform)
Date: Tue, 18 Jan 2011 14:26:13 -0800
Message-ID: <20110118222613.GS4957@atomide.com>
References: <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
 <20110115233744.GA18159@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
 <4D3309F9.8090900@gmail.com>
 <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17337 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1ARW03 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 17:26:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Paul Walmsley <paul@pwsan.com> [110118 11:35]:
> 
> Here's a slightly updated version of this patch, fixing a bug in one of 
> the comments, and revising the commit message.  There's no functional 
> difference between this and the previous version of this patch.

Thanks, here are two patches to fix the MPU timer, and then allow
compiling in both the MPU timer and the 32KiHz timer.

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 18 Jan 2011 13:25:39 -0800
Subject: [PATCH] omap1: Fix sched_clock for the MPU timer

Otherwise systems using the MPU timer will hang.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -44,11 +44,14 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 
 #include <asm/system.h>
 #include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/irq.h>
+#include <asm/sched_clock.h>
+
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
@@ -67,7 +70,7 @@ typedef struct {
 ((volatile omap_mpu_timer_regs_t*)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
 				 (n)*OMAP_MPU_TIMER_OFFSET))
 
-static inline unsigned long omap_mpu_timer_read(int nr)
+static inline unsigned long notrace omap_mpu_timer_read(int nr)
 {
 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
 	return timer->read_tim;
@@ -212,11 +215,21 @@ static struct clocksource clocksource_mpu = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static DEFINE_CLOCK_DATA(cd);
+
+static void notrace mpu_update_sched_clock(void)
+{
+	u32 cyc = mpu_read(&clocksource_mpu);
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+
 static void __init omap_init_clocksource(unsigned long rate)
 {
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
+	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
+
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
 	omap_mpu_timer_start(1, ~0, 1);
 
