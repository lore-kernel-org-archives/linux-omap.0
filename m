From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v5 1/4] TI816X: Update common omap platform files
Date: Wed,  9 Feb 2011 22:25:55 +0530
Message-ID: <1297270555-32447-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51814 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab1BIQ4E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 11:56:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Hemant Pedanekar <hemantp@ti.com>

This patch updates the common platform files with TI816X support.

The approach taken in this patch is to add TI816X as part of OMAP3 variant where
the cpu class is considered as OMAP34XX and the type is TI816X. This means, both
cpu_is_omap34xx() and cpu_is_ti816x() checks return success on TI816X.

In addition, a kernel config option CONFIG_SOC_OMAPTI816X is also added under
OMAP3 to allow TI816X only build. This option leads to following main
possibilities:

 1) Multi-OMAP build with CONFIG_SOC_OMAPTI816X: The kernel built only for
 TI816X OMAP3 SoCs along with any other OMAP2/4 (e.g., OMAP4s). May not boot
 on other OMAP3 SoCs.

 2) OMAP3 only build with CONFIG_SOC_OMAPTI816X: This will build TI816X
 optimized kernel. May not boot on other OMAP3 SoCs.

 3) OMAP3 only, no CONFIG_SOC_OMAPTI816X: This will build kernel for all OMAP3s
 except TI816X. Note that cpu_is_ti816x checks will return fail.

As mentioned above (in (1) and (2)), selecting CONFIG_SOC_OMAPTI816X skips some
configurations which are required for OMAP3XXX devices but not applicable on
TI816X devices (e.g., dpll5 setting). Hence the kernel built with
CONFIG_SOC_OMAPTI816X may not boot on those OMAP3 devices.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig                   |   11 +++++++++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    1 +
 arch/arm/plat-omap/include/plat/common.h      |    1 +
 arch/arm/plat-omap/include/plat/cpu.h         |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/hardware.h    |    1 +
 6 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ae7f47d..0b921bc 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -72,6 +72,17 @@ config SOC_OMAP3430
 	default y
 	select ARCH_OMAP_OTG
 
+config SOC_OMAPTI816X
+	bool "TI816X SoC family specific build of OMAP3"
+	depends on ARCH_OMAP3
+	default n
+	help
+	 Select Y if you want a TI816X only build of OMAP3. This means the
+	 kernel built with this option may not boot on non TI816X OMAP3 SoCs.
+	 This restriction applies even for multi-omap builds. It is recommended
+	 to select N here if you wish to build a multi-omap kernel for booting
+	 on all OMAP3 based SoCs (including TI816X).
+
 config OMAP_PACKAGE_ZAF
        bool
 
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 256ab3f..f1899a3 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -38,6 +38,7 @@ struct omap_clk {
 #define CK_3517		(1 << 9)
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
+#define CK_TI816X	(1 << 12)
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 8eb0ada..d43e623 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -53,6 +53,7 @@ struct clkops {
 #define RATE_IN_3430ES2PLUS	(1 << 3)	/* 3430 ES >= 2 rates only */
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
+#define RATE_IN_TI816X		(1 << 6)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 29b2afb..1dd97e7 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -66,6 +66,7 @@ void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
+void omap2_set_globals_ti816x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 73d91ee..ee18ae0 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -105,6 +105,12 @@ static inline int is_omap ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_TI_SUBCLASS(subclass, id)			\
+static inline int is_ti ##subclass (void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(7xx, 0x07)
 IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
@@ -118,6 +124,8 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 IS_OMAP_SUBCLASS(363x, 0x363)
 IS_OMAP_SUBCLASS(443x, 0x443)
 
+IS_TI_SUBCLASS(816x, 0x816)
+
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
 #define cpu_is_omap16xx()		0
@@ -126,6 +134,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_ti816x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 
@@ -181,8 +190,10 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 # if defined(CONFIG_ARCH_OMAP3)
 #  undef  cpu_is_omap34xx
 #  undef  cpu_is_omap343x
+#  undef cpu_is_ti816x
 #  define cpu_is_omap34xx()		is_omap34xx()
 #  define cpu_is_omap343x()		is_omap343x()
+#  define cpu_is_ti816x()		is_ti816x()
 # endif
 #else
 # if defined(CONFIG_ARCH_OMAP2)
@@ -205,6 +216,10 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  undef  cpu_is_omap343x
 #  define cpu_is_omap343x()		1
 # endif
+# if defined(CONFIG_SOC_OMAPTI816X)
+#  undef cpu_is_ti816x
+#  define cpu_is_ti816x()		1
+# endif
 #endif
 
 /*
@@ -389,6 +404,10 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 8))
 #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 8))
 
+#define TI816X_CLASS		0x81600034
+#define TI8168_REV_ES1_0	TI816X_CLASS
+#define TI8168_REV_ES1_1	(TI816X_CLASS | (OMAP_REVBITS_01 << 8))
+
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	OMAP443X_CLASS
 #define OMAP4430_REV_ES2_0	0x44301044
@@ -419,6 +438,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3630ES1_1           (1 << 9)
 #define CHIP_IS_OMAP3630ES1_2           (1 << 10)
 #define CHIP_IS_OMAP4430ES2		(1 << 11)
+#define CHIP_IS_TI816X			(1 << 12)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
@@ -455,6 +475,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
+#define OMAP3_HAS_SDRC			BIT(7)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -469,5 +490,6 @@ OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
+OMAP3_HAS_FEATURE(sdrc, SDRC)
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index d5b26ad..e87efe1 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -286,5 +286,6 @@
 #include <plat/omap24xx.h>
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
+#include <plat/ti816x.h>
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
-- 
1.7.3.5

