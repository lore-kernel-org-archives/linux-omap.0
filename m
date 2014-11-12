From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/22] OMAPDSS: DSI: wait for hsdiv clocks when enabling PLL
Date: Wed, 12 Nov 2014 13:52:03 +0200
Message-ID: <1415793144-11723-2-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53594 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbaKLLwq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:46 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment we have two functions to wait for the HSDIV clocks to get
active, dsi_wait_pll_hsdiv_dispc_active and
dsi_wait_pll_hsdiv_dsi_active. Instead of such inconvenient functions,
let's just make sure that the hsdiv clocks are active after the pll has
been enabled.

This patch adds code to dsi_pll_set_clock_div() to wait until HSDIV
clocks are active.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 0793bc67a275..fe8196b17a5e 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1514,6 +1514,20 @@ static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
 	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkin4ddr / cinfo->regm_dsi;
 }
 
+static int dsi_wait_hsdiv_ack(struct platform_device *dsidev, u32 hsdiv_ack_mask)
+{
+	int t = 100;
+
+	while (t-- > 0) {
+		u32 v = dsi_read_reg(dsidev, DSI_PLL_STATUS);
+		v &= hsdiv_ack_mask;
+		if (v == hsdiv_ack_mask)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo)
 {
@@ -1646,6 +1660,13 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	l = FLD_MOD(l, 0, 20, 20);	/* DSI_HSDIVBYPASS */
 	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION2, l);
 
+	r = dsi_wait_hsdiv_ack(dsidev, BIT(7) | BIT(8));
+	if (r) {
+		DSSERR("failed to enable HSDIV clocks: %d\n", r);
+		goto err;
+	}
+
+
 	DSSDBG("PLL config done\n");
 err:
 	return r;
-- 
2.1.3

