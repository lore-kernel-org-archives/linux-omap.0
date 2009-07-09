From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 1/2] watchdog:OMAP3:Register IVA and SECURE WDT, make clks ac
Date: Thu,  9 Jul 2009 13:04:22 -0500
Message-ID: <1247162663-27541-2-git-send-email-ubh@ti.com>
References: <1247162663-27541-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58844 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbZGIR62 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jul 2009 13:58:28 -0400
In-Reply-To: <1247162663-27541-1-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wim@iguana.be
Cc: linux-omap@vger.kernel.org, Ulrik Bech Hald <ubh@ti.com>

Enabling registration of IVA and SECURE WDT devices. Making
ick and fck for IVA and SECURE WDTs accessible.

Tested on Zoom1 OMAP3 platform

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap1/clock.c     |    6 +-
 arch/arm/mach-omap2/clock24xx.c |    4 +-
 arch/arm/mach-omap2/clock34xx.c |   12 +++---
 arch/arm/plat-omap/devices.c    |   91 ++++++++++++++++++++++++++++++++-------
 4 files changed, 86 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 436eed2..c0b5849 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -85,9 +85,9 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap_wdt",	"ick",		&armper_ck.clk,	CK_16XX),
-	CLK("omap_wdt", "ick",		&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap_wdt.2", "fck",	&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap_wdt.2", "ick",	&armper_ck.clk,	CK_16XX),
+	CLK("omap_wdt.2", "ick",	&dummy_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
 	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
 	/* CK_GEN2 clocks */
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 44de027..4fe3def 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -165,8 +165,8 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X | CK_242X),
-	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X | CK_242X),
-	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X | CK_242X),
+	CLK("omap_wdt.2", "ick",	&mpu_wdt_ick,	CK_243X | CK_242X),
+	CLK("omap_wdt.2", "fck",	&mpu_wdt_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 045da92..aaea62c 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -215,11 +215,11 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
-	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
+	CLK("omap_wdt.1", "fck",	&wdt2_fck,	CK_343X),
 	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
 	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
-	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
+	CLK("omap_wdt.1", "ick",	&wdt2_ick,	CK_343X),
+	CLK("omap_wdt.0", "ick",	&wdt1_ick,	CK_343X),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
@@ -241,14 +241,14 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
 	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
 	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
+	CLK("omap_wdt.2", "fck",	&wdt3_fck,	CK_343X),
 	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
 	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
 	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
 	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
 	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
 	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
+	CLK("omap_wdt.2", "ick",	&wdt3_ick,	CK_343X),
 	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
@@ -275,7 +275,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
-	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
+	CLK("omap_wdt.0", "fck",	&wdt1_fck,	CK_343X),
 };
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index a64b692..6abef3f 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -288,42 +288,101 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-static struct resource wdt_resources[] = {
+#define	OMAP44XX_WDT2_BASE	0x4a314000
+#define	OMAP34XX_WDT1_BASE	0x4830c000
+#define	OMAP34XX_WDT2_BASE	0x48314000
+#define	OMAP34XX_WDT3_BASE	0x49030000
+#define	OMAP2430_WDT_BASE	0x49016000
+#define	OMAP2420_WDT_BASE	0x48022000
+#define	OMAP16XX_WDT_BASE	0xfffeb000
+
+static struct resource secure_wdt_resources[] = {
 	{
-		.flags		= IORESOURCE_MEM,
+		.flags = IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device omap_wdt_device = {
-	.name	   = "omap_wdt",
-	.id	     = -1,
-	.num_resources	= ARRAY_SIZE(wdt_resources),
-	.resource	= wdt_resources,
+static struct resource mpu_wdt_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct resource iva2_wdt_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_secure_wdt_device = {
+	.name = "omap_wdt",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(secure_wdt_resources),
+	.resource = secure_wdt_resources,
+	.dev = {
+		.platform_data = "watchdog_secure",
+	},
+};
+
+static struct platform_device omap_mpu_wdt_device = {
+	.name = "omap_wdt",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(mpu_wdt_resources),
+	.resource = mpu_wdt_resources,
+	.dev = {
+		.platform_data = "watchdog",
+	},
+};
+
+static struct platform_device omap_iva2_wdt_device = {
+	.name = "omap_wdt",
+	.id = 2,
+	.num_resources = ARRAY_SIZE(iva2_wdt_resources),
+	.resource = iva2_wdt_resources,
+	.dev = {
+		.platform_data = "watchdog_iva2",
+	},
 };
 
 static void omap_init_wdt(void)
 {
 	if (cpu_is_omap16xx())
-		wdt_resources[0].start = 0xfffeb000;
+		mpu_wdt_resources[0].start = OMAP16XX_WDT_BASE;
 	else if (cpu_is_omap2420())
-		wdt_resources[0].start = 0x48022000; /* WDT2 */
+		mpu_wdt_resources[0].start = OMAP2420_WDT_BASE;
 	else if (cpu_is_omap2430())
-		wdt_resources[0].start = 0x49016000; /* WDT2 */
-	else if (cpu_is_omap343x())
-		wdt_resources[0].start = 0x48314000; /* WDT2 */
-	else if (cpu_is_omap44xx())
-		wdt_resources[0].start = 0x4a314000;
+		mpu_wdt_resources[0].start = OMAP2430_WDT_BASE;
+	else if (cpu_is_omap343x()) {
+		secure_wdt_resources[0].start = OMAP34XX_WDT1_BASE;
+		secure_wdt_resources[0].end = secure_wdt_resources[0].start
+			+ 0x4f;
+		mpu_wdt_resources[0].start = OMAP34XX_WDT2_BASE;
+		iva2_wdt_resources[0].start = OMAP34XX_WDT3_BASE;
+		iva2_wdt_resources[0].end = iva2_wdt_resources[0].start + 0x4f;
+	} else if (cpu_is_omap44xx())
+		mpu_wdt_resources[0].start = OMAP44XX_WDT2_BASE;
 	else
 		return;
 
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
+	mpu_wdt_resources[0].end = mpu_wdt_resources[0].start + 0x4f;
+
+	/* MPU WDT present across omap family */
+	(void) platform_device_register(&omap_mpu_wdt_device);
 
-	(void) platform_device_register(&omap_wdt_device);
+	if (cpu_is_omap34xx()) {
+		(void) platform_device_register(&omap_iva2_wdt_device);
+		if (omap_type() == OMAP2_DEVICE_TYPE_SEC
+			|| omap_type() == OMAP2_DEVICE_TYPE_EMU)
+			(void)
+			platform_device_register(&omap_secure_wdt_device);
+	}
 }
+
 #else
 static inline void omap_init_wdt(void) {}
 #endif
 
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
-- 
1.5.4.3

