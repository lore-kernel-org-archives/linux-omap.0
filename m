From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Tue, 8 May 2012 20:53:50 +0530
Message-ID: <1336490630-7272-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57921 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab2EHP2a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 11:28:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Initially, we decided to make am33xx family of device to fall
under omap3 class (cpu_is_omap34xx() = true), since it carries
Cortex-A8 core. But while adding complete baseport support
(like, clock, power and hwmod) support, it is observed that,
we are creating more and more problems by treating am33xx device
as omap3 family, as nothing matches between them
(except cortex-A8 mpu).

So,  after long discussion we have came to the conclusion that,
we should not consider am33xx device as omap3 family, instead
create separate class (SOC_OMAPAM33XX) under OMAP2PLUS.
This means, for am33xx device, cpu_is_omap34xx() will return false,
and only cpu_is_am33xx() will be true.

Please refer to the link below, for mailing-list discussion on this -

http://www.spinics.net/lists/linux-omap/msg69439.html

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Kconfig           |    5 ++++-
 arch/arm/mach-omap2/Makefile          |    6 ++++++
 arch/arm/mach-omap2/common.c          |    2 ++
 arch/arm/plat-omap/include/plat/cpu.h |    9 ++++++---
 arch/arm/plat-omap/sram.c             |    2 +-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 93bf5e2..182aa0c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -123,8 +123,11 @@ config SOC_OMAPTI81XX
 
 config SOC_OMAPAM33XX
 	bool "AM33XX support"
-	depends on ARCH_OMAP3
+	depends on ARCH_OMAP2PLUS
 	default y
+	select CPU_V7
+	select ARM_CPU_SUSPEND if PM
+	select MULTI_IRQ_HANDLER
 	select SOC_HAS_DPLL_IDLE
 	select SOC_HAS_DPLL_RECAL
 	select SOC_HAS_DPLL_SDDIV
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d8604a3..94a5982 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,6 +16,7 @@ secure-common				= omap-smc.o omap-secure.o
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_OMAPAM33XX) += irq.o $(hwmod-common)
 
 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -93,6 +94,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
 					   prminst44xx.o vc44xx_data.o \
 					   vp44xx_data.o prm44xx.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= prcm.o
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
@@ -102,6 +104,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -116,6 +119,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(powerdomain-common)
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o \
@@ -132,6 +136,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clockdomain-common) \
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common) \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(clockdomain-common)
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
@@ -149,6 +154,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(clock-common) dpll3xxx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index ad8626d..2e83da8 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -130,7 +130,9 @@ void __init ti81xx_map_io(void)
 {
 	omapti81xx_map_common_io();
 }
+#endif
 
+#if defined(CONFIG_SOC_OMAPAM33XX)
 #define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + \
 				TI81XX_CONTROL_DEVICE_ID - 0x204)
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..90c3092 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -357,8 +357,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
-# undef cpu_is_am33xx
-# undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -378,6 +376,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
+#endif
+
+# if defined(CONFIG_SOC_OMAPAM33XX)
+# undef cpu_is_am33xx
+# undef cpu_is_am335x
 # define cpu_is_am33xx()		is_am33xx()
 # define cpu_is_am335x()		is_am335x()
 #endif
@@ -433,7 +436,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8148_REV_ES2_0	(TI814X_CLASS | (0x1 << 8))
 #define TI8148_REV_ES2_1	(TI814X_CLASS | (0x2 << 8))
 
-#define AM335X_CLASS		0x33500034
+#define AM335X_CLASS		0x33500033
 #define AM335X_REV_ES1_0	AM335X_CLASS
 
 #define OMAP443X_CLASS		0x44300044
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 477363c..564cb4c 100644
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
-- 
1.7.0.4

