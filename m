From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP totally fucked?
Date: Tue, 06 Mar 2012 12:15:40 -0800
Message-ID: <878vjdfpub.fsf@ti.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
	<20120303180428.GA10293@atomide.com>
	<201203031829.06992.arnd@arndb.de>
	<20120303210521.GE10293@atomide.com>
	<20120304155909.GA14466@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36402 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030950Ab2CFUPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 15:15:43 -0500
Received: by mail-gy0-f181.google.com with SMTP id z13so3648088ghb.26
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 12:15:42 -0800 (PST)
In-Reply-To: <20120304155909.GA14466@n2100.arm.linux.org.uk> (Russell King's
	message of "Sun, 4 Mar 2012 15:59:09 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Mar 03, 2012 at 01:05:21PM -0800, Tony Lindgren wrote:
>> * Arnd Bergmann <arnd@arndb.de> [120303 09:57]:
>> > On Saturday 03 March 2012, Tony Lindgren wrote:
>> > > Well 85631d2 builds fine, looks like now some more includes of
>> > > plat/hardware.h are now needed.Have not yet tracked down which
>> > > commit triggers the build errors. Eventually those should become
>> > > local headers too..
>> > 
>> > I've tried building arm-soc/for-next and rmk/for-next, they are both
>> > fine, just merging the two gives me the same build errors that Russell
>> > saw.
>> > 
>> > Adding plat/hardware.h in all files that break solves the problems,
>> > aside from the iommu dependency for rpmsg for which Ohad has provided
>> > a fix already that I should pull.
>> 
>> Here's a patch for you to the cleanup branch to fix the hardware.h
>> build errors.
>
> Right, with this applied, things are better:
>
> 1. omap3430ldp allnoconfig is the first build without warnings, congrats.
> 2. omap4430sdp allnoconfig has a bunch of new section mismatch warnings,
>    a couple of compiler warnings, and builds:
>
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x183c): Section mismatch in reference from the function omap2_init_processor_devices() to the function .init.text:_init_omap_device()
> The function omap2_init_processor_devices() references
> the function __init _init_omap_device().
> This is often because omap2_init_processor_devices lacks a __init 
> annotation or the annotation of _init_omap_device is wrong.
>
> arch/arm/mach-omap2/io.c:51: warning: 'omap24xx_io_desc' defined but not used
> arch/arm/mach-omap2/omap-wakeupgen.c:181: warning: 'wakeupgen_irqmask_all' defined but not used

And here's a fix for the wakeupgen one.

Kevin

>From 9f6b1ac3b6012fdb2001dbec14ac3d72d81b50d8 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 6 Mar 2012 12:00:25 -0800
Subject: [PATCH] ARM: OMAP2+: PM: fix wakeupgen warning when hotplug disabled

When CONFIG_HOTPLUG_CPU=n, there are unused functions in wakeupgen:

arch/arm/mach-omap2/omap-wakeupgen.c:181: warning: 'wakeupgen_irqmask_all' defined but not used

Fix this by moving all the functions only used when CONFIG_HOTPLUG_CPU=y
together and wrapping in an #ifdef.

No functional changes.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |   53 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index d3d8971..42cd7fb 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -43,7 +43,6 @@
 
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
-static DEFINE_PER_CPU(u32 [NR_REG_BANKS], irqmasks);
 static DEFINE_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[NR_IRQS];
 
@@ -67,14 +66,6 @@ static inline void sar_writel(u32 val, u32 offset, u8 idx)
 	__raw_writel(val, sar_base + offset + (idx * 4));
 }
 
-static void _wakeupgen_set_all(unsigned int cpu, unsigned int reg)
-{
-	u8 i;
-
-	for (i = 0; i < NR_REG_BANKS; i++)
-		wakeupgen_writel(reg, i, cpu);
-}
-
 static inline int _wakeupgen_get_irq_info(u32 irq, u32 *bit_posn, u8 *reg_index)
 {
 	unsigned int spi_irq;
@@ -130,22 +121,6 @@ static void _wakeupgen_set(unsigned int irq, unsigned int cpu)
 	wakeupgen_writel(val, i, cpu);
 }
 
-static void _wakeupgen_save_masks(unsigned int cpu)
-{
-	u8 i;
-
-	for (i = 0; i < NR_REG_BANKS; i++)
-		per_cpu(irqmasks, cpu)[i] = wakeupgen_readl(i, cpu);
-}
-
-static void _wakeupgen_restore_masks(unsigned int cpu)
-{
-	u8 i;
-
-	for (i = 0; i < NR_REG_BANKS; i++)
-		wakeupgen_writel(per_cpu(irqmasks, cpu)[i], i, cpu);
-}
-
 /*
  * Architecture specific Mask extension
  */
@@ -170,6 +145,33 @@ static void wakeupgen_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static DEFINE_PER_CPU(u32 [NR_REG_BANKS], irqmasks);
+
+static void _wakeupgen_save_masks(unsigned int cpu)
+{
+	u8 i;
+
+	for (i = 0; i < NR_REG_BANKS; i++)
+		per_cpu(irqmasks, cpu)[i] = wakeupgen_readl(i, cpu);
+}
+
+static void _wakeupgen_restore_masks(unsigned int cpu)
+{
+	u8 i;
+
+	for (i = 0; i < NR_REG_BANKS; i++)
+		wakeupgen_writel(per_cpu(irqmasks, cpu)[i], i, cpu);
+}
+
+static void _wakeupgen_set_all(unsigned int cpu, unsigned int reg)
+{
+	u8 i;
+
+	for (i = 0; i < NR_REG_BANKS; i++)
+		wakeupgen_writel(reg, i, cpu);
+}
+
 /*
  * Mask or unmask all interrupts on given CPU.
  *	0 = Mask all interrupts on the 'cpu'
@@ -191,6 +193,7 @@ static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
 	}
 	spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
+#endif
 
 #ifdef CONFIG_CPU_PM
 /*
-- 
1.7.9.2

