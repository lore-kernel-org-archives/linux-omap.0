From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/5] OMAP4: mcbsp: Callback function for McBSP4 CLKR/FSR mux selection
Date: Thu, 22 Dec 2011 19:31:46 +0200
Message-ID: <1324575106-17172-6-git-send-email-peter.ujfalusi@ti.com>
References: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49162 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157Ab1LVRcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:32:03 -0500
Received: by lami14 with SMTP id i14so3288493lam.6
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:32:01 -0800 (PST)
In-Reply-To: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On OMAP4 McBSP4 has 6 pin mode. The configuration of the CLKR/FSR
source can be done via the CONTROL_MCBSPLP register which only
has two valid bits (30: CLKR mux, 31: FSR mux).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 269765c..d5fbe9a 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -70,6 +70,46 @@ static int omap2_mcbsp1_mux_rx_clk(struct device *dev, const char *signal,
 	return 0;
 }
 
+#define OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_FSX	(1 << 31)
+#define OMAP4_CONTROL_MCBSPLP_ALBCTRLRX_CLKX	(1 << 30)
+static int omap4_mcbsp4_mux_rx_clk(struct device *dev, const char *signal,
+				   const char *src)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	u32 v;
+
+	/* Only McBSP4 have 6 pin configuration (CLKR/FSR source selectable) */
+	if (mcbsp->id != 3)
+		return -EINVAL;
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
 static int omap2_mcbsp_reparent_clk(struct device *dev, struct clk *clk,
 				    char *fck_src_name)
 {
@@ -209,6 +249,8 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 
 	if (oh->class->rev == MCBSP_CONFIG_TYPE4)
 		pdata->set_clk_src = omap4_mcbsp_set_clk_src;
+		if (id == 4)
+			pdata->mux_signal = omap4_mcbsp4_mux_rx_clk;
 	else {
 		pdata->set_clk_src = omap2_mcbsp_set_clk_src;
 		if (id == 1)
-- 
1.7.8.1

