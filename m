From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH resend 13/13] omap: mcbsp: Start generalize signal muxing functions
Date: Mon, 26 Sep 2011 10:45:49 +0300
Message-ID: <1317023150-6730-14-git-send-email-jarkko.nikula@bitmer.com>
References: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:58511 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab1IZILq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 04:11:46 -0400
In-Reply-To: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

This generalizes the omap2_mcbsp1_mux_clkr_src and omap2_mcbsp1_mux_fsr_src
implementation between generic McBSP and OMAP2 specific McBSP code. These
functions are used to select source for CLKR and FSR signals on OMAP2+.

Start generalizing the code by implementing an optional mux_signal function
pointer in platform data that will implement the actual muxing and which is
called now from omap2_mcbsp1_mux_clkr_src and omap2_mcbsp1_mux_fsr_src.
These functions are to be removed later and cleanup the API so that
mux_signal gets its arguments directly from client code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap2/mcbsp.c             |   43 +++++++++++++++++-------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    1 +
 arch/arm/plat-omap/mcbsp.c              |   36 ++++++++++++++++++++------
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 3dd4c47..5063f25 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -34,33 +34,36 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
-/* McBSP internal signal muxing functions */
-
-void omap2_mcbsp1_mux_clkr_src(u8 mux)
+/* McBSP internal signal muxing function */
+static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
+				   const char *src)
 {
 	u32 v;
 
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	if (mux == CLKR_SRC_CLKR)
-		v &= ~OMAP2_MCBSP1_CLKR_MASK;
-	else if (mux == CLKR_SRC_CLKX)
-		v |= OMAP2_MCBSP1_CLKR_MASK;
-	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-}
-EXPORT_SYMBOL(omap2_mcbsp1_mux_clkr_src);
 
-void omap2_mcbsp1_mux_fsr_src(u8 mux)
-{
-	u32 v;
+	if (!strcmp(signal, "clkr")) {
+		if (!strcmp(src, "clkr"))
+			v &= ~OMAP2_MCBSP1_CLKR_MASK;
+		else if (!strcmp(src, "clkx"))
+			v |= OMAP2_MCBSP1_CLKR_MASK;
+		else
+			return -EINVAL;
+	} else if (!strcmp(signal, "fsr")) {
+		if (!strcmp(src, "fsr"))
+			v &= ~OMAP2_MCBSP1_FSR_MASK;
+		else if (!strcmp(src, "fsx"))
+			v |= OMAP2_MCBSP1_FSR_MASK;
+		else
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
 
-	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	if (mux == FSR_SRC_FSR)
-		v &= ~OMAP2_MCBSP1_FSR_MASK;
-	else if (mux == FSR_SRC_FSX)
-		v |= OMAP2_MCBSP1_FSR_MASK;
 	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+
+	return 0;
 }
-EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
 
 /* McBSP CLKS source switching function */
 static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
@@ -181,6 +184,8 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		return PTR_ERR(pdev);
 	}
 	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
+	if (id == 1)
+		pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
 	omap_mcbsp_count++;
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index c8ebfc9..8fa74e2 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -309,6 +309,7 @@ struct omap_mcbsp_platform_data {
 	bool has_ccr; /* Transceiver has configuration control registers */
 	int (*enable_st_clock)(unsigned int, bool);
 	int (*set_clk_src)(struct device *dev, struct clk *clk, const char *src);
+	int (*mux_signal)(struct device *dev, const char *signal, const char *src);
 };
 
 struct omap_mcbsp_st_data {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 38b67d9..4b15cd7 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -922,21 +922,41 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 }
 EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
-#ifndef CONFIG_ARCH_OMAP2PLUS
 void omap2_mcbsp1_mux_clkr_src(u8 mux)
 {
-	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
-	     __func__);
-	return;
+	struct omap_mcbsp *mcbsp;
+	const char *src;
+
+	if (mux == CLKR_SRC_CLKR)
+		src = "clkr";
+	else if (mux == CLKR_SRC_CLKX)
+		src = "clkx";
+	else
+		return;
+
+	mcbsp = id_to_mcbsp_ptr(0);
+	if (mcbsp->pdata->mux_signal)
+		mcbsp->pdata->mux_signal(mcbsp->dev, "clkr", src);
 }
+EXPORT_SYMBOL(omap2_mcbsp1_mux_clkr_src);
 
 void omap2_mcbsp1_mux_fsr_src(u8 mux)
 {
-	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
-	     __func__);
-	return;
+	struct omap_mcbsp *mcbsp;
+	const char *src;
+
+	if (mux == FSR_SRC_FSR)
+		src = "fsr";
+	else if (mux == FSR_SRC_FSX)
+		src = "fsx";
+	else
+		return;
+
+	mcbsp = id_to_mcbsp_ptr(0);
+	if (mcbsp->pdata->mux_signal)
+		mcbsp->pdata->mux_signal(mcbsp->dev, "fsr", src);
 }
-#endif
+EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
 
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
-- 
1.7.6.3

