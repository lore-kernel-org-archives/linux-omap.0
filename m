From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 08/29] ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
Date: Thu, 14 Jun 2012 18:16:57 +0530
Message-ID: <1339678038-23082-9-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab2FNMsE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:48:04 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Moving to COMMON clk for OMAP would mean we no longer use
internal lookup mechanism like omap_clk_get_by_name().
get rid of all its usage mostly from hwmod and omap_device
code.

Also use IS_ERR_OR_NULL() for error checking.

Moving to clk_get() also means the respective platforms
need the clkdev tables updated with an entry for all clocks
used by hwmod to have clock name same as the alias.

Based on original changes from Mike Turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/clock2430_data.c |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/clock44xx_data.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c     |   12 ++++++------
 arch/arm/plat-omap/omap_device.c     |    6 +++---
 6 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index bace930..7fe2233 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1808,6 +1808,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
 	/* DSS domain clocks */
 	CLK("omapdss_dss",	"ick",		&dss_ick,	CK_242X),
+	CLK(NULL,	"dss_ick",		&dss_ick,	CK_242X),
 	CLK(NULL,	"dss1_fck",		&dss1_fck,	CK_242X),
 	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_242X),
 	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_242X),
@@ -1847,12 +1848,16 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
+	CLK(NULL, 	"mcbsp1_ick",	&mcbsp1_ick,	CK_242X),
 	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_242X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
+	CLK(NULL, 	"mcbsp2_ick",	&mcbsp2_ick,	CK_242X),
 	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck,	CK_242X),
 	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_242X),
+	CLK(NULL, 	"mcspi1_ick",	&mcspi1_ick,	CK_242X),
 	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck,	CK_242X),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_242X),
+	CLK(NULL, 	"mcspi2_ick",	&mcspi2_ick,	CK_242X),
 	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck,	CK_242X),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_242X),
 	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_242X),
@@ -1863,12 +1868,15 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_242X),
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
+	CLK(NULL,	"mpu_wdt_ick",		&mpu_wdt_ick,	CK_242X),
 	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_242X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
 	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
+	CLK(NULL, 	"cam_fck",	&cam_fck,	CK_242X),
 	CLK("omap24xxcam", "ick",	&cam_ick,	CK_242X),
+	CLK(NULL, 	"cam_ick",	&cam_ick,	CK_242X),
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_242X),
 	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_242X),
 	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_242X),
@@ -1877,16 +1885,22 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_242X),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_242X),
 	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
+	CLK(NULL, "mmc_ick",	&mmc_ick,	CK_242X),
 	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
+	CLK(NULL, "mmc_fck",	&mmc_fck,	CK_242X),
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_242X),
 	CLK(NULL,	"fac_fck",	&fac_fck,	CK_242X),
 	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
 	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_242X),
+	CLK(NULL, 	"hdq_ick",	&hdq_ick,	CK_242X),
 	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_242X),
+	CLK(NULL, 	"hdq_fck",	&hdq_fck,	CK_242X),
 	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_242X),
+	CLK(NULL, 	"i2c1_ick",	&i2c1_ick,	CK_242X),
 	CLK(NULL,	"i2c1_fck",	&i2c1_fck,	CK_242X),
 	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_242X),
+	CLK(NULL, 	"i2c2_ick",	&i2c2_ick,	CK_242X),
 	CLK(NULL,	"i2c2_fck",	&i2c2_fck,	CK_242X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_242X),
@@ -1896,8 +1910,11 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
 	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
 	CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
+	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
+	CLK(NULL,	"rng_ick",		&rng_ick,	CK_242X),
 	CLK("omap-aes",	"ick",	&aes_ick,	CK_242X),
+	CLK(NULL,	"aes_ick",	&aes_ick,	CK_242X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 3b4d09a..21e69ab 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1897,6 +1897,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
 	/* DSS domain clocks */
 	CLK("omapdss_dss",	"ick",		&dss_ick,	CK_243X),
+	CLK(NULL,	"dss_ick",		&dss_ick,	CK_243X),
 	CLK(NULL,	"dss1_fck",		&dss1_fck,	CK_243X),
 	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_243X),
 	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_243X),
@@ -1936,20 +1937,28 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
+	CLK(NULL, 	"mcbsp1_ick",	&mcbsp1_ick,	CK_243X),
 	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_243X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
+	CLK(NULL, 	"mcbsp2_ick",	&mcbsp2_ick,	CK_243X),
 	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck,	CK_243X),
 	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_243X),
+	CLK(NULL, 	"mcbsp3_ick",	&mcbsp3_ick,	CK_243X),
 	CLK(NULL,	"mcbsp3_fck",	&mcbsp3_fck,	CK_243X),
 	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_243X),
+	CLK(NULL, 	"mcbsp4_ick",	&mcbsp4_ick,	CK_243X),
 	CLK(NULL,	"mcbsp4_fck",	&mcbsp4_fck,	CK_243X),
 	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_243X),
+	CLK(NULL, 	"mcbsp5_ick",	&mcbsp5_ick,	CK_243X),
 	CLK(NULL,	"mcbsp5_fck",	&mcbsp5_fck,	CK_243X),
 	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X),
+	CLK(NULL, 	"mcspi1_ick",	&mcspi1_ick,	CK_243X),
 	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck,	CK_243X),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X),
+	CLK(NULL, 	"mcspi2_ick",	&mcspi2_ick,	CK_243X),
 	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck,	CK_243X),
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_243X),
+	CLK(NULL, 	"mcspi3_ick",	&mcspi3_ick,	CK_243X),
 	CLK(NULL,	"mcspi3_fck",	&mcspi3_fck,	CK_243X),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X),
 	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X),
@@ -1960,13 +1969,16 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X),
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
+	CLK(NULL,	"mpu_wdt_ick",	&mpu_wdt_ick,	CK_243X),
 	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_243X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
 	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X),
+	CLK(NULL, 	"cam_fck",	&cam_fck,	CK_243X),
 	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X),
+	CLK(NULL, 	"cam_ick",	&cam_ick,	CK_243X),
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X),
 	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X),
 	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X),
@@ -1975,10 +1987,14 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X),
 	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X),
+	CLK(NULL, 	"hdq_ick",	&hdq_ick,	CK_243X),
 	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X),
+	CLK(NULL, 	"hdq_fck",	&hdq_fck,	CK_243X),
 	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_243X),
+	CLK(NULL, 	"i2c1_ick",	&i2c1_ick,	CK_243X),
 	CLK(NULL,	"i2chs1_fck",	&i2chs1_fck,	CK_243X),
 	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_243X),
+	CLK(NULL, 	"i2c2_ick",	&i2c2_ick,	CK_243X),
 	CLK(NULL,	"i2chs2_fck",	&i2chs2_fck,	CK_243X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X),
@@ -1991,15 +2007,20 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X),
 	CLK("musb-omap2430",	"ick",	&usbhs_ick,	CK_243X),
+	CLK(NULL,	"usbhs_ick",	&usbhs_ick,	CK_243X),
 	CLK("omap_hsmmc.0", "ick",	&mmchs1_ick,	CK_243X),
+	CLK(NULL, 	"mmchs1_ick",	&mmchs1_ick,	CK_243X),
 	CLK(NULL,	"mmchs1_fck",	&mmchs1_fck,	CK_243X),
 	CLK("omap_hsmmc.1", "ick",	&mmchs2_ick,	CK_243X),
+	CLK(NULL, 	"mmchs2_ick",	&mmchs2_ick,	CK_243X),
 	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck,	CK_243X),
 	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
 	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
 	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
+	CLK(NULL,	 "mmchsdb1_fck",	&mmchsdb1_fck,	CK_243X),
 	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck,	CK_243X),
+	CLK(NULL,	 "mmchsdb2_fck",	&mmchsdb2_fck,	CK_243X),
 	CLK("omap_timer.1",	"32k_ck",  &func_32k_ck,   CK_243X),
 	CLK("omap_timer.2",	"32k_ck",  &func_32k_ck,   CK_243X),
 	CLK("omap_timer.3",	"32k_ck",  &func_32k_ck,   CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4e1a3b0..4c826e0 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3260,6 +3260,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_3XXX),
 	CLK(NULL,	"omap_192m_alwon_fck", &omap_192m_alwon_fck, CK_36XX),
 	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_3XXX),
+	CLK(NULL,	"omap_96m_alwon_fck_3630", &omap_96m_alwon_fck_3630, CK_3XXX),
 	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_3XXX),
 	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_3XXX),
 	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_3XXX),
@@ -3329,6 +3330,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
 	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_3XXX),
 	CLK("omap_hdq.0",	"fck",	&hdq_fck,	CK_3XXX),
+	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_3XXX),
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
@@ -3336,6 +3338,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_3XXX),
 	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
 	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
+	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
+	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_3XXX),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_3XXX),
 	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_34XX | CK_36XX),
@@ -3344,27 +3348,40 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("usbhs_omap",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"mmchs3_ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
 	CLK("omap-aes",	"ick",	&aes2_ick,	CK_34XX | CK_36XX),
 	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
 	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick,	CK_3XXX),
 	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick,	CK_3XXX),
+	CLK(NULL,	"mmchs2_ick",	&mmchs2_ick,	CK_3XXX),
+	CLK(NULL,	"mmchs1_ick",	&mmchs1_ick,	CK_3XXX),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_34XX | CK_36XX),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_3XXX),
+	CLK(NULL, 	"hdq_ick",	&hdq_ick,	CK_3XXX),
 	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_3XXX),
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_3XXX),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_3XXX),
 	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_3XXX),
+	CLK(NULL, 	"mcspi4_ick",	&mcspi4_ick,	CK_3XXX),
+	CLK(NULL, 	"mcspi3_ick",	&mcspi3_ick,	CK_3XXX),
+	CLK(NULL, 	"mcspi2_ick",	&mcspi2_ick,	CK_3XXX),
+	CLK(NULL, 	"mcspi1_ick",	&mcspi1_ick,	CK_3XXX),
 	CLK("omap_i2c.3", "ick",	&i2c3_ick,	CK_3XXX),
 	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_3XXX),
 	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_3XXX),
+	CLK(NULL, 	"i2c3_ick",	&i2c3_ick,	CK_3XXX),
+	CLK(NULL, 	"i2c2_ick",	&i2c2_ick,	CK_3XXX),
+	CLK(NULL, 	"i2c1_ick",	&i2c1_ick,	CK_3XXX),
 	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_3XXX),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_3XXX),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_3XXX),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_3XXX),
 	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_3XXX),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_3XXX),
+	CLK(NULL, 	"mcbsp5_ick",	&mcbsp5_ick,	CK_3XXX),
+	CLK(NULL, 	"mcbsp1_ick",	&mcbsp1_ick,	CK_3XXX),
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_34XX | CK_36XX),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_3XXX),
@@ -3383,7 +3400,9 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"dss_96m_fck",	&dss_96m_fck,	CK_3XXX),
 	CLK(NULL,	"dss2_alwon_fck",	&dss2_alwon_fck, CK_3XXX),
 	CLK("omapdss_dss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK(NULL,	"dss_ick",		&dss_ick_3430es1,	CK_3430ES1),
 	CLK("omapdss_dss",	"ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"dss_ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_34XX | CK_36XX),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_34XX | CK_36XX),
@@ -3408,6 +3427,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2PLUS | CK_36XX),
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
+	CLK(NULL,	"wdt2_ick",	&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
@@ -3456,6 +3476,9 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_3XXX),
 	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_3XXX),
 	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_3XXX),
+	CLK(NULL, 	"mcbsp4_ick",	&mcbsp2_ick,	CK_3XXX),
+	CLK(NULL, 	"mcbsp3_ick",	&mcbsp3_ick,	CK_3XXX),
+	CLK(NULL, 	"mcbsp2_ick",	&mcbsp4_ick,	CK_3XXX),
 	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck,	CK_3XXX),
 	CLK(NULL,	"mcbsp3_fck",	&mcbsp3_fck,	CK_3XXX),
 	CLK(NULL,	"mcbsp4_fck",	&mcbsp4_fck,	CK_3XXX),
@@ -3479,6 +3502,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
 	CLK("musb-am35x",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
+	CLK(NULL,	"hsotgusb_ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
 	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2172f66..51eea69 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3223,6 +3223,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dss_tv_clk",			&dss_tv_clk,	CK_443X),
 	CLK(NULL,	"dss_48mhz_clk",		&dss_48mhz_clk,	CK_443X),
 	CLK(NULL,	"dss_dss_clk",			&dss_dss_clk,	CK_443X),
+	CLK(NULL,	"dss_fck",			&dss_fck,	CK_443X),
 	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
@@ -3279,6 +3280,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
 	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
+	CLK(NULL,	"rng_ick",			&rng_ick,	CK_443X),
 	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
 	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
 	CLK(NULL,	"sl2if_ick",			&sl2if_ick,	CK_443X),
@@ -3295,20 +3297,32 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
 	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
+	CLK(NULL,	"timer1_fck",			&timer1_fck,	CK_443X),
 	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
+	CLK(NULL,	"timer10_fck",			&timer10_fck,	CK_443X),
 	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
+	CLK(NULL,	"timer11_fck",			&timer11_fck,	CK_443X),
 	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
+	CLK(NULL,	"timer2_fck",			&timer2_fck,	CK_443X),
 	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
+	CLK(NULL,	"timer3_fck",			&timer3_fck,	CK_443X),
 	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
+	CLK(NULL,	"timer4_fck",			&timer4_fck,	CK_443X),
 	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
+	CLK(NULL,	"timer5_fck",			&timer5_fck,	CK_443X),
 	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
+	CLK(NULL,	"timer6_fck",			&timer6_fck,	CK_443X),
 	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
+	CLK(NULL,	"timer7_fck",			&timer7_fck,	CK_443X),
 	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
+	CLK(NULL,	"timer8_fck",			&timer8_fck,	CK_443X),
 	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
+	CLK(NULL,	"timer9_fck",			&timer9_fck,	CK_443X),
 	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
 	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
+	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK("usbhs_omap",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
@@ -3320,14 +3334,17 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
+	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
 	CLK("usbhs_omap",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
 	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_443X),
+	CLK(NULL,	"usb_otg_hs_ick",		&usb_otg_hs_ick,	CK_443X),
 	CLK("musb-omap2430",	"ick",				&usb_otg_hs_ick,	CK_443X),
 	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
+	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
 	CLK("usbhs_omap",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
 	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
 	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b46ae17..3f3ae15 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -602,8 +602,8 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	if (!oh->main_clk)
 		return 0;
 
-	oh->_clk = omap_clk_get_by_name(oh->main_clk);
-	if (!oh->_clk) {
+	oh->_clk = clk_get(NULL, oh->main_clk);
+	if (IS_ERR_OR_NULL(oh->_clk)) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
 		return -EINVAL;
@@ -638,8 +638,8 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 		if (!os->clk)
 			continue;
 
-		c = omap_clk_get_by_name(os->clk);
-		if (!c) {
+		c = clk_get(NULL, os->clk);
+		if (IS_ERR_OR_NULL(c)) {
 			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				   oh->name, os->clk);
 			ret = -EINVAL;
@@ -665,8 +665,8 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 	int ret = 0;
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
-		c = omap_clk_get_by_name(oc->clk);
-		if (!c) {
+		c = clk_get(NULL, oc->clk);
+		if (IS_ERR_OR_NULL(c)) {
 			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				   oh->name, oc->clk);
 			ret = -EINVAL;
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..af822d5 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -266,10 +266,10 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		return;
 	}
 
-	r = omap_clk_get_by_name(clk_name);
-	if (IS_ERR(r)) {
+	r = clk_get(NULL, clk_name);
+	if (IS_ERR_OR_NULL(r)) {
 		dev_err(&od->pdev->dev,
-			"omap_clk_get_by_name for %s failed\n", clk_name);
+			"clk_get for %s failed\n", clk_name);
 		return;
 	}
 
-- 
1.7.1

