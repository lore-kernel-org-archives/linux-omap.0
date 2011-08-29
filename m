From: <hvaibhav@ti.com>
Subject: [RFC PATCH-V2 1/4] AM335X: Update common omap platform files
Date: Mon, 29 Aug 2011 18:16:13 +0530
Message-ID: <1314621976-25750-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60520 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab1H2Mqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 08:46:33 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch updates the common platform files with AM335X device
support.

The approach taken in this patch is,
AM33XX device will be considered as OMAP3 variant, and a separate
SoC class created for AM33XX family of devices with a subclass type
for AM335X device which is newly added device in the family.

This means, cpu_is_omap34xx(), cpu_is_am33xx() and cpu_is_am335x()
checks will return success on AM335X.
A kernel config option CONFIG_SOC_OMAPAM33XX is added under OMAP3
to include support for AM33XX build.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Kconfig                   |    5 +++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    1 +
 arch/arm/plat-omap/include/plat/cpu.h         |   23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index cc4f213..f437e70 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -78,6 +78,11 @@ config SOC_OMAPTI81XX
 	depends on ARCH_OMAP3
 	default y

+config SOC_OMAPAM33XX
+	bool "AM33XX support"
+	depends on ARCH_OMAP3
+	default y
+
 config OMAP_PACKAGE_ZAF
        bool

diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 3c50ec8..991e72c 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -41,6 +41,7 @@ struct omap_clk {
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
 #define CK_TI814X	(1 << 14)
+#define CK_AM335X	(1 << 15)	/* AM335x specific clocks */


 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 1c41292..b5d7447 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -60,6 +60,7 @@ struct clkops {
 #define RATE_IN_TI816X		(1 << 6)
 #define RATE_IN_4460		(1 << 7)
 #define RATE_IN_TI814X		(1 << 8)
+#define RATE_IN_AM335X		(1 << 9)

 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index f4ebbae..4f04ae0 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -106,6 +106,12 @@ static inline int is_ti ##class (void)		\
 	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
 }

+#define IS_AM_CLASS(class, id)			\
+static inline int is_am ##class (void)		\
+{							\
+	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
+}
+
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)

 #define IS_OMAP_SUBCLASS(subclass, id)			\
@@ -120,6 +126,12 @@ static inline int is_ti ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }

+#define IS_AM_SUBCLASS(subclass, id)			\
+static inline int is_am ##subclass (void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(7xx, 0x07)
 IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
@@ -128,6 +140,7 @@ IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)

 IS_TI_CLASS(81xx, 0x81)
+IS_AM_CLASS(33xx, 0x33)

 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
@@ -138,6 +151,7 @@ IS_OMAP_SUBCLASS(446x, 0x446)

 IS_TI_SUBCLASS(816x, 0x816)
 IS_TI_SUBCLASS(814x, 0x814)
+IS_AM_SUBCLASS(335x, 0x335)

 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -150,6 +164,7 @@ IS_TI_SUBCLASS(814x, 0x814)
 #define cpu_is_ti81xx()			0
 #define cpu_is_ti816x()			0
 #define cpu_is_ti814x()			0
+#define cpu_is_am335x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -358,6 +373,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
+# undef cpu_is_am33xx
+# undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -376,6 +393,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
+# define cpu_is_am33xx()		is_am33xx()
+# define cpu_is_am335x()		is_am335x()
 #endif

 # if defined(CONFIG_ARCH_OMAP4)
@@ -431,6 +450,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8148_REV_ES2_0	(TI814X_CLASS | (OMAP_REVBITS_01 << 8))
 #define TI8148_REV_ES2_1	(TI814X_CLASS | (OMAP_REVBITS_02 << 8))

+#define AM335X_CLASS		0x33500034
+#define AM335X_REV_ES1_0	AM335X_CLASS
+
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
 #define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20 << 8))
@@ -471,6 +493,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_TI816X			(1 << 14)
 #define CHIP_IS_OMAP4460ES1_0		(1 << 15)
 #define CHIP_IS_TI814X			(1 << 16)
+#define CHIP_IS_AM335X			(1 << 17)

 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)

--
1.6.2.4

