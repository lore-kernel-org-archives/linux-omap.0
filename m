From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RESEND PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Tue, 3 Jul 2012 18:30:47 +0530
Message-ID: <1341320447-18918-2-git-send-email-hvaibhav@ti.com>
References: <1341320447-18918-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47800 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520Ab2GCNJH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 09:09:07 -0400
In-Reply-To: <1341320447-18918-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

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
[tony@atomide.com: fixed typo, updated for soc_is changes]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Rebasing and resubmitting on top of devel-am33xx branch.

 arch/arm/mach-omap2/Kconfig           |    4 +++-
 arch/arm/mach-omap2/Makefile          |    5 +++++
 arch/arm/mach-omap2/common.c          |    2 ++
 arch/arm/plat-omap/include/plat/cpu.h |    9 ++++++---
 arch/arm/plat-omap/sram.c             |    2 +-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4cf5142..0ab4c5e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -85,8 +85,10 @@ config SOC_TI81XX

 config SOC_AM33XX
 	bool "AM33XX support"
-	depends on ARCH_OMAP3
 	default y
+	select CPU_V7
+	select ARM_CPU_SUSPEND if PM
+	select MULTI_IRQ_HANDLER

 config OMAP_PACKAGE_ZAF
        bool
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a4cf932..ef2585b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,6 +16,7 @@ secure-common				= omap-smc.o omap-secure.o
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_AM33XX) += irq.o $(hwmod-common)

 ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
 obj-y += mcbsp.o
@@ -100,6 +101,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o

 # OMAP powerdomain framework
@@ -115,6 +117,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o

@@ -133,6 +136,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o

@@ -152,6 +156,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o

 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 8a6953a..a7aa538 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -134,7 +134,9 @@ void __init ti81xx_map_io(void)
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

