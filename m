From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/3] ARM: OMAP2+: McBSP: Correct CLKR/FSR clock source mux configuration
Date: Thu,  8 Mar 2012 11:22:15 +0200
Message-ID: <1331198537-13469-2-git-send-email-peter.ujfalusi@ti.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:60459 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756100Ab2CHJWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 04:22:31 -0500
Received: by lbbgg13 with SMTP id gg13so114227lbb.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 01:22:28 -0800 (PST)
In-Reply-To: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On OMAP2/3 McBSP1 port has 6 pin setup, while on OMAP4 the port is McBSP4.
Implement the CLKR/FSR clock mux selection for OMAP4, and make sure that
we add the correct callback for the correct port across supported OMAP
versions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/mcbsp.c |   46 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 49ff5b8..ecc039e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -34,7 +34,7 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
-/* McBSP internal signal muxing function */
+/* McBSP1 internal signal muxing function for OMAP2/3 */
 static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
 				   const char *src)
 {
@@ -65,6 +65,42 @@ static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
 	return 0;
 }
 
+/* McBSP4 internal signal muxing function for OMAP4 */
+#define OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX	(1 << 31)
+#define OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX	(1 << 30)
+static int omap4_mcbsp4_mux_rx_clk(struct device *dev, const char *signal,
+				   const char *src)
+{
+	u32 v;
+
+	/*
+	 * In CONTROL_MCBSPLP register only bit 30 (CLKR mux), and bit 31 (FSR
+	 * mux) is used */
+	v = omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP);
+
+	if (!strcmp(signal, "clkr")) {
+		if (!strcmp(src, "clkr"))
+			v &= ~OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX;
+		else if (!strcmp(src, "clkx"))
+			v |= OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX;
+		else
+			return -EINVAL;
+	} else if (!strcmp(signal, "fsr")) {
+		if (!strcmp(src, "fsr"))
+			v &= ~OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX;
+		else if (!strcmp(src, "fsx"))
+			v |= OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX;
+		else
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	omap4_ctrl_pad_writel(v, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP);
+
+	return 0;
+}
+
 /* McBSP CLKS source switching function */
 static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
 				   const char *src)
@@ -146,9 +182,15 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		pdata->has_ccr = true;
 	}
 	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
-	if (id == 1)
+
+	/* On OMAP2/3 the McBSP1 port has 6 pin configuration */
+	if (id == 1 && oh->class->rev < MCBSP_CONFIG_TYPE4)
 		pdata->mux_signal = omap2_mcbsp1_mux_rx_clk;
 
+	/* On OMAP4 the McBSP4 port has 6 pin configuration */
+	if (id == 4 && oh->class->rev == MCBSP_CONFIG_TYPE4)
+		pdata->mux_signal = omap4_mcbsp4_mux_rx_clk;
+
 	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
 		if (id == 2)
 			/* The FIFO has 1024 + 256 locations */
-- 
1.7.8.5

