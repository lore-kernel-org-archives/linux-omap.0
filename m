From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V2] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Thu, 10 May 2012 11:01:59 -0700
Message-ID: <20120510180159.GF21851@atomide.com>
References: <1336562667-6741-1-git-send-email-hvaibhav@ti.com>
 <20120509185435.GU5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14374 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760184Ab2EJSCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:02:02 -0400
Content-Disposition: inline
In-Reply-To: <20120509185435.GU5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Tony Lindgren <tony@atomide.com> [120509 11:58]:
> * Vaibhav Hiremath <hvaibhav@ti.com> [120509 04:28]:
> > Initially, we decided to make am33xx family of device to fall
> > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > Cortex-A8 core. But while adding complete baseport support
> > (like, clock, power and hwmod) support, it is observed that,
> > we are creating more and more problems by treating am33xx device
> > as omap3 family, as nothing matches between them
> > (except cortex-A8 mpu).
> 
> Thanks applying into devel-soc after updating for soc_is change
> and fixing typo in the description that stil said OMAPAM. Updated
> patch below.

Turns out we still need to add defined(CONFIG_SOC_AM33XX) around
__omap2_set_globals() to keep compile working when omap4 + am33xx
are selected without omap2 or 3. Also removed the "default y"
for am33xx as that's where we're heading to anyways.

Updated patch below.

Tony


>From 54891e60bc79c43c2dbc8351f62ac5c3e8eb3592 Mon Sep 17 00:00:00 2001
From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Wed, 9 May 2012 16:54:27 +0530
Subject: [PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class

Initially, we decided to make am33xx family of device to fall
under omap3 class (cpu_is_omap34xx() = true), since it carries
Cortex-A8 core. But while adding complete baseport support
(like, clock, power and hwmod) support, it is observed that,
we are creating more and more problems by treating am33xx device
as omap3 family, as nothing matches between them
(except cortex-A8 mpu).

So,  after long discussion we have came to the conclusion that,
we should not consider am33xx device as omap3 family, instead
create separate class (SOC_AM33XX) under OMAP2PLUS.
This means, for am33xx device, cpu_is_omap34xx() will return false,
and only cpu_is_am33xx() will be true.

Please refer to the link below, for mailing-list discussion on this -

http://www.spinics.net/lists/linux-omap/msg69439.html

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
[tony@atomide.com: fixed typo, updated for soc_is]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 61bf3c3..5bc2604 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -84,8 +84,9 @@ config SOC_TI81XX
 
 config SOC_AM33XX
 	bool "AM33XX support"
-	depends on ARCH_OMAP3
-	default y
+	select CPU_V7
+	select ARM_CPU_SUSPEND if PM
+	select MULTI_IRQ_HANDLER
 
 config OMAP_PACKAGE_ZAF
        bool
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7cdb940..288e1a3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,6 +16,7 @@ secure-common				= omap-smc.o omap-secure.o
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -90,6 +91,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm_mpu44xx.o prminst44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o prm44xx.o
+obj-$(CONFIG_SOC_AM33XX)		+= prcm.o
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -99,6 +101,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -113,6 +116,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
@@ -129,6 +133,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
@@ -146,6 +151,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 1549c11..355635e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -29,7 +29,8 @@
 
 /* Global address base setup code */
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_SOC_AM33XX)
 
 static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 {
@@ -134,7 +135,9 @@ void __init ti81xx_map_io(void)
 {
 	omapti81xx_map_common_io();
 }
+#endif
 
+#if defined(CONFIG_SOC_AM33XX)
 #define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + \
 				TI81XX_CONTROL_DEVICE_ID - 0x204)
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 297245d..75e1319 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -360,8 +360,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
 # undef soc_is_am35xx
-# undef cpu_is_am33xx
-# undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -382,6 +380,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
 # define soc_is_am35xx()		is_am35xx()
+#endif
+
+# if defined(CONFIG_SOC_AM33XX)
+# undef cpu_is_am33xx
+# undef cpu_is_am335x
 # define cpu_is_am33xx()		is_am33xx()
 # define cpu_is_am335x()		is_am335x()
 #endif
@@ -441,7 +444,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define AM35XX_REV_ES1_0	AM35XX_CLASS
 #define AM35XX_REV_ES1_1	(AM35XX_CLASS | (0x1 << 8))
 
-#define AM335X_CLASS		0x33500034
+#define AM335X_CLASS		0x33500033
 #define AM335X_REV_ES1_0	AM335X_CLASS
 
 #define OMAP443X_CLASS		0x44300044
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index f9a8c53..982e8bc 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -85,7 +85,7 @@ static int is_sram_locked(void)
 			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
 		}
-		if (cpu_is_omap34xx() && !cpu_is_am33xx()) {
+		if (cpu_is_omap34xx()) {
 			__raw_writel(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
 			__raw_writel(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
