From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap1: Fix booting for 15xx and 730 with omap1_defconfig
 (Re: State of LDP3430 platform)
Date: Tue, 18 Jan 2011 14:35:36 -0800
Message-ID: <20110118223536.GT4957@atomide.com>
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
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12194 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1ARWfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 17:35:53 -0500
Content-Disposition: inline
In-Reply-To: <20110118222613.GS4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

For omap15xx and 730 we need to use the MPU timer
as the 32K timer is not available. For omap16xx
we want to use the 32K timer because of PM. Fix this
by allowing to build in both timers.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -9,6 +9,7 @@ config ARCH_OMAP730
 	depends on ARCH_OMAP1
 	bool "OMAP730 Based System"
 	select CPU_ARM926T
+	select OMAP_MPU_TIMER
 	select ARCH_OMAP_OTG
 
 config ARCH_OMAP850
@@ -22,6 +23,7 @@ config ARCH_OMAP15XX
 	default y
 	bool "OMAP15xx Based System"
 	select CPU_ARM925T
+	select OMAP_MPU_TIMER
 
 config ARCH_OMAP16XX
 	depends on ARCH_OMAP1
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,12 +3,11 @@
 #
 
 # Common support
-obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o dma.o
+obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
-obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
 # Power Management
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -57,6 +57,8 @@
 
 #include <plat/common.h>
 
+#ifdef CONFIG_OMAP_MPU_TIMER
+
 #define OMAP_MPU_TIMER_BASE		OMAP_MPU_TIMER1_BASE
 #define OMAP_MPU_TIMER_OFFSET		0x100
 
@@ -237,12 +239,7 @@ static void __init omap_init_clocksource(unsigned long rate)
 		printk(err, clocksource_mpu.name);
 }
 
-/*
- * ---------------------------------------------------------------------------
- * Timer initialization
- * ---------------------------------------------------------------------------
- */
-static void __init omap_timer_init(void)
+static void __init omap_mpu_timer_init(void)
 {
 	struct clk	*ck_ref = clk_get(NULL, "ck_ref");
 	unsigned long	rate;
@@ -257,13 +254,38 @@ static void __init omap_timer_init(void)
 
 	omap_init_mpu_timer(rate);
 	omap_init_clocksource(rate);
-	/*
-	 * XXX Since this file seems to deal mostly with the MPU timer,
-	 * this doesn't seem like the correct place for the sync timer
-	 * clocksource init.
-	 */
-	if (!cpu_is_omap7xx() && !cpu_is_omap15xx())
-		omap_init_clocksource_32k();
+}
+
+#else
+static inline void omap_mpu_timer_init(void)
+{
+	pr_err("Bogus timer, should not happen\n");
+}
+#endif	/* CONFIG_OMAP_MPU_TIMER */
+
+static inline int omap_32k_timer_usable(void)
+{
+	int res = false;
+
+	if (cpu_is_omap730() || cpu_is_omap15xx())
+		return res;
+
+#ifdef CONFIG_OMAP_32K_TIMER
+	res = omap_32k_timer_init();
+#endif
+
+	return res;
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * Timer initialization
+ * ---------------------------------------------------------------------------
+ */
+static void __init omap_timer_init(void)
+{
+	if (!omap_32k_timer_usable())
+		omap_mpu_timer_init();
 }
 
 struct sys_timer omap_timer = {
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -52,10 +52,9 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
+#include <plat/common.h>
 #include <plat/dmtimer.h>
 
-struct sys_timer omap_timer;
-
 /*
  * ---------------------------------------------------------------------------
  * 32KHz OS timer
@@ -181,14 +180,14 @@ static __init void omap_init_32k_timer(void)
  * Timer initialization
  * ---------------------------------------------------------------------------
  */
-static void __init omap_timer_init(void)
+bool __init omap_32k_timer_init(void)
 {
+	omap_init_clocksource_32k();
+
 #ifdef CONFIG_OMAP_DM_TIMER
 	omap_dm_timer_init();
 #endif
 	omap_init_32k_timer();
-}
 
-struct sys_timer omap_timer = {
-	.init		= omap_timer_init,
-};
+	return true;
+}
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -144,12 +144,9 @@ config OMAP_IOMMU_DEBUG
 config OMAP_IOMMU_IVA2
 	bool
 
-choice
-	prompt "System timer"
-	default OMAP_32K_TIMER if !ARCH_OMAP15XX
-
 config OMAP_MPU_TIMER
 	bool "Use mpu timer"
+	depends on ARCH_OMAP1
 	help
 	  Select this option if you want to use the OMAP mpu timer. This
 	  timer provides more intra-tick resolution than the 32KHz timer,
@@ -158,6 +155,7 @@ config OMAP_MPU_TIMER
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
 	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
+	default y if (ARCH_OMAP16XX || ARCH_OMAP2PLUS)
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
@@ -165,8 +163,6 @@ config OMAP_32K_TIMER
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
 	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4.
 
-endchoice
-
 config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
 	depends on ARCH_OMAP3 && PM
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -36,8 +36,6 @@
 
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
-#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
-
 #include <linux/clocksource.h>
 
 /*
@@ -195,6 +193,3 @@ int __init omap_init_clocksource_32k(void)
 	}
 	return 0;
 }
-
-#endif	/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX)) */
-
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -35,6 +35,7 @@ struct sys_timer;
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
+extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
 
 extern void omap_reserve(void);
