From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 1/3] OMAP3:WDT:Register IVA,SECURE, make clks accessible
Date: Mon,  8 Jun 2009 16:08:11 -0500
Message-ID: <1244495293-17244-2-git-send-email-ubh@ti.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbZFHVCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:16 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58L2DMi002334
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2009 16:02:18 -0500
In-Reply-To: <1244495293-17244-1-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

Enabling registration of IVA and SECURE WDT devices. Making
ick and fck for IVA and SECURE WDTs accessible.

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   12 +++---
 arch/arm/plat-omap/devices.c    |   79 +++++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ba05aa4..fe43d73 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -212,11 +212,11 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
-	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
+	CLK("omap_wdt.2", "fck",	&wdt2_fck,	CK_343X),
 	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
 	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
-	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
+	CLK("omap_wdt.2", "ick",	&wdt2_ick,	CK_343X),
+	CLK("omap_wdt.1", "ick",	&wdt1_ick,	CK_343X),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
@@ -238,14 +238,14 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
 	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
 	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
+	CLK("omap_wdt.3", "fck",	&wdt3_fck,	CK_343X),
 	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
 	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
 	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
 	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
 	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
 	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
+	CLK("omap_wdt.3", "ick",	&wdt3_ick,	CK_343X),
 	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
@@ -272,7 +272,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
-	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
+	CLK("omap_wdt.1", "fck",	&wdt1_fck,	CK_343X),
 };
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 87fb7ff..2a1b806 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -288,36 +288,85 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-static struct resource wdt_resources[] = {
+#define	OMAP34XX_WDT1_BASE	0x4830c000
+#define	OMAP34XX_WDT2_BASE	0x48314000
+#define	OMAP34XX_WDT3_BASE	0x49030000
+#define	OMAP2430_WDT_BASE	0x49016000
+#define	OMAP2420_WDT_BASE	0x48022000
+#define	OMAP16XX_WDT_BASE	0xfffeb000
+
+static struct resource wdt1_resources[] = {
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
+static struct resource wdt2_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct resource wdt3_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+/* SECURE WDT */
+static struct platform_device omap_wdt1_device = {
+	.name = "omap_wdt",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(wdt1_resources),
+	.resource = wdt1_resources,
+};
+
+/* MPU WDT */
+static struct platform_device omap_wdt2_device = {
+	.name = "omap_wdt",
+	.id = 2,
+	.num_resources = ARRAY_SIZE(wdt2_resources),
+	.resource = wdt2_resources,
+};
+
+/* IVA WDT */
+static struct platform_device omap_wdt3_device = {
+	.name = "omap_wdt",
+	.id = 3,
+	.num_resources = ARRAY_SIZE(wdt3_resources),
+	.resource = wdt3_resources,
 };
 
 static void omap_init_wdt(void)
 {
 	if (cpu_is_omap16xx())
-		wdt_resources[0].start = 0xfffeb000;
+		wdt2_resources[0].start = OMAP16XX_WDT_BASE;
 	else if (cpu_is_omap2420())
-		wdt_resources[0].start = 0x48022000; /* WDT2 */
+		wdt2_resources[0].start = OMAP2420_WDT_BASE;
 	else if (cpu_is_omap2430())
-		wdt_resources[0].start = 0x49016000; /* WDT2 */
-	else if (cpu_is_omap343x())
-		wdt_resources[0].start = 0x48314000; /* WDT2 */
+		wdt2_resources[0].start = OMAP2430_WDT_BASE;
+	else if (cpu_is_omap343x()) {
+		wdt1_resources[0].start = OMAP34XX_WDT1_BASE;
+		wdt1_resources[0].end = wdt1_resources[0].start + 0x4f;
+		wdt2_resources[0].start = OMAP34XX_WDT2_BASE;
+		wdt3_resources[0].start = OMAP34XX_WDT3_BASE;
+		wdt3_resources[0].end = wdt3_resources[0].start + 0x4f;
+	}
 	else
 		return;
 
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
+	wdt2_resources[0].end = wdt2_resources[0].start + 0x4f;
 
-	(void) platform_device_register(&omap_wdt_device);
-}
+	/* MPU WDT present across omap family */
+	(void) platform_device_register(&omap_wdt2_device);
+
+	if (cpu_is_omap34xx()) {
+		(void) platform_device_register(&omap_wdt3_device);
+		if (omap_type() == OMAP2_DEVICE_TYPE_SEC
+			|| omap_type() == OMAP2_DEVICE_TYPE_EMU)
+			(void) platform_device_register(&omap_wdt1_device);
+		}
+	}
 #else
 static inline void omap_init_wdt(void) {}
 #endif
-- 
1.5.4.3

