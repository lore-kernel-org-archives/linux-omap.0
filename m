From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 28/86] [ARM] omap: mcbsp: convert to use fck/ick clocks directly
Date: Thu, 12 Mar 2009 11:27:38 -0700
Message-ID: <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384AbZCLSa7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:59 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:58 -0700 (PDT)
In-Reply-To: <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Rather than introducing a special 'mcbsp_clk' with code behind it in
mach-omap*/mcbsp.c to handle the SoC specifics, arrange for the mcbsp
driver to be like any other driver.  mcbsp requests its fck and ick
clocks directly, and the SoC specific code deals with selecting the
correct clock.

There is one oddity to deal with - OMAP1 fiddles with the DSP clocks
and DSP reset, so we move this to the two callback functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |    9 +++
 arch/arm/mach-omap1/mcbsp.c             |   52 +++++++++++-------
 arch/arm/mach-omap2/clock24xx.c         |   20 ++++----
 arch/arm/mach-omap2/clock34xx.c         |   20 ++++----
 arch/arm/mach-omap2/mcbsp.c             |   26 ---------
 arch/arm/plat-omap/include/mach/mcbsp.h |    6 +--
 arch/arm/plat-omap/mcbsp.c              |   90 +++++++++++++------------------
 7 files changed, 100 insertions(+), 123 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 61ace02..b62da4c 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -132,6 +132,15 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
 	CLK("i2c_omap.1", "i2c_fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
 	CLK("i2c_omap.1", "i2c_ick",	&i2c_ick,	CK_16XX),
+	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
+	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap-mcbsp.2", "ick",	&armper_ck.clk,	CK_16XX),
+	CLK("omap-mcbsp.2", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap-mcbsp.3", "ick",	&dspper_ck,	CK_16XX),
+	CLK("omap-mcbsp.3", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap-mcbsp.1", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap-mcbsp.2", "fck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap-mcbsp.3", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
 };
 
 static int omap1_clk_enable_generic(struct clk * clk);
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 575ba31..d040c3f 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -28,9 +28,9 @@
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
 
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-const char *clk_names[] = { "dsp_ck", "api_ck", "dspxor_ck" };
-#endif
+static int dsp_use;
+static struct clk *api_clk;
+static struct clk *dsp_clk;
 
 static void omap1_mcbsp_request(unsigned int id)
 {
@@ -39,20 +39,40 @@ static void omap1_mcbsp_request(unsigned int id)
 	 * are DSP public peripherals.
 	 */
 	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
-		omap_dsp_request_mem();
-		/*
-		 * DSP external peripheral reset
-		 * FIXME: This should be moved to dsp code
-		 */
-		__raw_writew(__raw_readw(DSP_RSTCT2) | DPS_RSTCT2_PER_EN |
-				DSP_RSTCT2_WD_PER_EN, DSP_RSTCT2);
+		if (dsp_use++ == 0) {
+			api_clk = clk_get(NULL, "api_clk");
+			dsp_clk = clk_get(NULL, "dsp_clk");
+			if (!IS_ERR(api_clk) && !IS_ERR(dsp_clk)) {
+				clk_enable(api_clk);
+				clk_enable(dsp_clk);
+
+				omap_dsp_request_mem();
+				/*
+				 * DSP external peripheral reset
+				 * FIXME: This should be moved to dsp code
+				 */
+				__raw_writew(__raw_readw(DSP_RSTCT2) | DPS_RSTCT2_PER_EN |
+						DSP_RSTCT2_WD_PER_EN, DSP_RSTCT2);
+			}
+		}
 	}
 }
 
 static void omap1_mcbsp_free(unsigned int id)
 {
-	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
-		omap_dsp_release_mem();
+	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
+		if (--dsp_use == 0) {
+			omap_dsp_release_mem();
+			if (!IS_ERR(api_clk)) {
+				clk_disable(api_clk);
+				clk_put(api_clk);
+			}
+			if (!IS_ERR(dsp_clk)) {
+				clk_disable(dsp_clk);
+				clk_put(dsp_clk);
+			}
+		}
+	}
 }
 
 static struct omap_mcbsp_ops omap1_mcbsp_ops = {
@@ -94,8 +114,6 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP1RX,
 		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 3,
 	},
 	{
 		.phys_base	= OMAP1510_MCBSP2_BASE,
@@ -112,8 +130,6 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP3RX,
 		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 3,
 	},
 };
 #define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
@@ -131,8 +147,6 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP1RX,
 		.tx_irq		= INT_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 3,
 	},
 	{
 		.phys_base	= OMAP1610_MCBSP2_BASE,
@@ -149,8 +163,6 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_McBSP3RX,
 		.tx_irq		= INT_McBSP3TX,
 		.ops		= &omap1_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 3,
 	},
 };
 #define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index ac03803..ea21d55 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -139,16 +139,16 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.1", "mcbsp_ick", &mcbsp1_ick,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.1", "mcbsp_fck", &mcbsp1_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.2", "mcbsp_ick", &mcbsp2_ick,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.2", "mcbsp_fck", &mcbsp2_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.3", "mcbsp_ick", &mcbsp3_ick,	CK_243X),
-	CLK("omap-mcbsp.3", "mcbsp_fck", &mcbsp3_fck,	CK_243X),
-	CLK("omap-mcbsp.4", "mcbsp_ick", &mcbsp4_ick,	CK_243X),
-	CLK("omap-mcbsp.4", "mcbsp_fck", &mcbsp4_fck,	CK_243X),
-	CLK("omap-mcbsp.5", "mcbsp_ick", &mcbsp5_ick,	CK_243X),
-	CLK("omap-mcbsp.5", "mcbsp_fck", &mcbsp5_fck,	CK_243X),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_243X),
+	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_243X),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_243X),
+	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_243X),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_243X),
+	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_243X),
 	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X | CK_242X),
 	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_243X | CK_242X),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d0bfae5..a70aa2e 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -144,8 +144,8 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("i2c_omap.3", "i2c_fck",	&i2c3_fck,	CK_343X),
 	CLK("i2c_omap.2", "i2c_fck",	&i2c2_fck,	CK_343X),
 	CLK("i2c_omap.1", "i2c_fck",	&i2c1_fck,	CK_343X),
-	CLK("omap-mcbsp.5", "mcbsp_fck", &mcbsp5_fck,	CK_343X),
-	CLK("omap-mcbsp.1", "mcbsp_fck", &mcbsp1_fck,	CK_343X),
+	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_343X),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_343X),
 	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
 	CLK("omap2_mcspi.4", "fck",	&mcspi4_fck,	CK_343X),
 	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_343X),
@@ -186,8 +186,8 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_343X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_343X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_343X),
-	CLK("omap-mcbsp.5", "mcbsp_ick", &mcbsp5_ick,	CK_343X),
-	CLK("omap-mcbsp.1", "mcbsp_ick", &mcbsp1_ick,	CK_343X),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_343X),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_343X),
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
@@ -257,12 +257,12 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_343X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_343X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_343X),
-	CLK("omap-mcbsp.2", "mcbsp_ick", &mcbsp2_ick,	CK_343X),
-	CLK("omap-mcbsp.3", "mcbsp_ick", &mcbsp3_ick,	CK_343X),
-	CLK("omap-mcbsp.4", "mcbsp_ick", &mcbsp4_ick,	CK_343X),
-	CLK("omap-mcbsp.2", "mcbsp_fck", &mcbsp2_fck,	CK_343X),
-	CLK("omap-mcbsp.3", "mcbsp_fck", &mcbsp3_fck,	CK_343X),
-	CLK("omap-mcbsp.4", "mcbsp_fck", &mcbsp4_fck,	CK_343X),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_343X),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_343X),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_343X),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_343X),
+	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_343X),
+	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_343X),
 	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_343X),
 	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
 	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index a9e631f..a5c0f04 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -24,8 +24,6 @@
 #include <mach/cpu.h>
 #include <mach/mcbsp.h>
 
-const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
-
 static void omap2_mcbsp2_mux_setup(void)
 {
 	omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
@@ -57,8 +55,6 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -67,8 +63,6 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 };
 #define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
@@ -86,8 +80,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP24XX_MCBSP2_BASE,
@@ -96,8 +88,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP3_BASE,
@@ -106,8 +96,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP4_BASE,
@@ -116,8 +104,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP2430_MCBSP5_BASE,
@@ -126,8 +112,6 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 };
 #define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
@@ -145,8 +129,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -155,8 +137,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -165,8 +145,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -175,8 +153,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -185,8 +161,6 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.clk_names	= clk_names,
-		.num_clks	= 2,
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 113c246..bb154ea 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -344,8 +344,6 @@ struct omap_mcbsp_platform_data {
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-	char const **clk_names;
-	int num_clks;
 };
 
 struct omap_mcbsp {
@@ -377,8 +375,8 @@ struct omap_mcbsp {
 	/* Protect the field .free, while checking if the mcbsp is in use */
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
-	struct clk **clks;
-	int num_clks;
+	struct clk *iclk;
+	struct clk *fclk;
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e5842e3..28b0a82 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -214,7 +214,6 @@ EXPORT_SYMBOL(omap_mcbsp_set_io_type);
 int omap_mcbsp_request(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	int i;
 	int err;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -223,23 +222,23 @@ int omap_mcbsp_request(unsigned int id)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
-		mcbsp->pdata->ops->request(id);
-
-	for (i = 0; i < mcbsp->num_clks; i++)
-		clk_enable(mcbsp->clks[i]);
-
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
 			mcbsp->id);
 		spin_unlock(&mcbsp->lock);
-		return -1;
+		return -EBUSY;
 	}
 
 	mcbsp->free = 0;
 	spin_unlock(&mcbsp->lock);
 
+	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
+		mcbsp->pdata->ops->request(id);
+
+	clk_enable(mcbsp->iclk);
+	clk_enable(mcbsp->fclk);
+
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
@@ -278,7 +277,6 @@ EXPORT_SYMBOL(omap_mcbsp_request);
 void omap_mcbsp_free(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	int i;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -289,8 +287,14 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	for (i = mcbsp->num_clks - 1; i >= 0; i--)
-		clk_disable(mcbsp->clks[i]);
+	clk_disable(mcbsp->fclk);
+	clk_disable(mcbsp->iclk);
+
+	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
+		/* Free IRQs */
+		free_irq(mcbsp->rx_irq, (void *)mcbsp);
+		free_irq(mcbsp->tx_irq, (void *)mcbsp);
+	}
 
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
@@ -302,12 +306,6 @@ void omap_mcbsp_free(unsigned int id)
 
 	mcbsp->free = 1;
 	spin_unlock(&mcbsp->lock);
-
-	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
-		/* Free IRQs */
-		free_irq(mcbsp->rx_irq, (void *)mcbsp);
-		free_irq(mcbsp->tx_irq, (void *)mcbsp);
-	}
 }
 EXPORT_SYMBOL(omap_mcbsp_free);
 
@@ -876,7 +874,6 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
 	struct omap_mcbsp *mcbsp;
 	int id = pdev->id - 1;
-	int i;
 	int ret = 0;
 
 	if (!pdata) {
@@ -899,7 +896,6 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto exit;
 	}
-	mcbsp_ptr[id] = mcbsp;
 
 	spin_lock_init(&mcbsp->lock);
 	mcbsp->id = id + 1;
@@ -921,39 +917,32 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dma_rx_sync = pdata->dma_rx_sync;
 	mcbsp->dma_tx_sync = pdata->dma_tx_sync;
 
-	if (pdata->num_clks) {
-		mcbsp->num_clks = pdata->num_clks;
-		mcbsp->clks = kzalloc(mcbsp->num_clks * sizeof(struct clk *),
-					GFP_KERNEL);
-		if (!mcbsp->clks) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-		for (i = 0; i < mcbsp->num_clks; i++) {
-			mcbsp->clks[i] = clk_get(&pdev->dev, pdata->clk_names[i]);
-			if (IS_ERR(mcbsp->clks[i])) {
-				dev_err(&pdev->dev,
-					"Invalid %s configuration for McBSP%d.\n",
-					pdata->clk_names[i], mcbsp->id);
-				ret = PTR_ERR(mcbsp->clks[i]);
-				goto err_clk;
-			}
-		}
+	mcbsp->iclk = clk_get(&pdev->dev, "ick");
+	if (IS_ERR(mcbsp->iclk)) {
+		ret = PTR_ERR(mcbsp->iclk);
+		dev_err(&pdev->dev, "unable to get ick: %d\n", ret);
+		goto err_iclk;
+	}
 
+	mcbsp->fclk = clk_get(&pdev->dev, "fck");
+	if (IS_ERR(mcbsp->fclk)) {
+		ret = PTR_ERR(mcbsp->fclk);
+		dev_err(&pdev->dev, "unable to get fck: %d\n", ret);
+		goto err_fclk;
 	}
 
 	mcbsp->pdata = pdata;
 	mcbsp->dev = &pdev->dev;
+	mcbsp_ptr[id] = mcbsp;
 	platform_set_drvdata(pdev, mcbsp);
 	return 0;
 
-err_clk:
-	while (i--)
-		clk_put(mcbsp->clks[i]);
-	kfree(mcbsp->clks);
+err_fclk:
+	clk_put(mcbsp->iclk);
+err_iclk:
 	iounmap(mcbsp->io_base);
 err_ioremap:
-	mcbsp->free = 0;
+	kfree(mcbsp);
 exit:
 	return ret;
 }
@@ -961,7 +950,6 @@ exit:
 static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
-	int i;
 
 	platform_set_drvdata(pdev, NULL);
 	if (mcbsp) {
@@ -970,18 +958,15 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 				mcbsp->pdata->ops->free)
 			mcbsp->pdata->ops->free(mcbsp->id);
 
-		for (i = mcbsp->num_clks - 1; i >= 0; i--) {
-			clk_disable(mcbsp->clks[i]);
-			clk_put(mcbsp->clks[i]);
-		}
+		clk_disable(mcbsp->fclk);
+		clk_disable(mcbsp->iclk);
+		clk_put(mcbsp->fclk);
+		clk_put(mcbsp->iclk);
 
 		iounmap(mcbsp->io_base);
 
-		if (mcbsp->num_clks) {
-			kfree(mcbsp->clks);
-			mcbsp->clks = NULL;
-			mcbsp->num_clks = 0;
-		}
+		mcbsp->fclk = NULL;
+		mcbsp->iclk = NULL;
 		mcbsp->free = 0;
 		mcbsp->dev = NULL;
 	}
@@ -1002,4 +987,3 @@ int __init omap_mcbsp_init(void)
 	/* Register the McBSP driver */
 	return platform_driver_register(&omap_mcbsp_driver);
 }
-
-- 
1.6.1.2

