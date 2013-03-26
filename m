From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 8/8] OMAPDSS: DISPC: Revert to older DISPC Smart Standby mechanism for OMAP5
Date: Tue, 26 Mar 2013 19:15:25 +0530
Message-ID: <1364305525-28496-9-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
 <1364305525-28496-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934428Ab3CZNqv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:46:51 -0400
In-Reply-To: <1364305525-28496-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, robdclark@gmail.com, andy.gross@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

DISPC on OMAP5 has a more optimised mechanism of asserting Mstandby to achieve
more power savings when DISPC is configured in Smart Standby mode. This
mechanism leads to underflows when multiple DISPC pipes are enabled.

There is a register field which can let us revert to the older mechanism of
asserting Mstandby. Configure this field to prevent underflows.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    7 +++++++
 drivers/video/omap2/dss/dispc.h |    1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ddbf031..b33b016 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -87,6 +87,9 @@ struct dispc_features {
 
 	/* no DISPC_IRQ_FRAMEDONETV on this SoC */
 	bool no_framedone_tv:1;
+
+	/* revert to the OMAP4 mechanism of DISPC Smart Standby operation */
+	bool mstandby_workaround:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -3502,6 +3505,9 @@ static void _omap_dispc_initial_config(void)
 	dispc_configure_burst_sizes();
 
 	dispc_ovl_enable_zorder_planes();
+
+	if (dispc.feat->mstandby_workaround)
+		REG_FLD_MOD(DISPC_MSTANDBY_CTRL, 1, 0, 0);
 }
 
 static const struct dispc_features omap24xx_dispc_feats __initconst = {
@@ -3596,6 +3602,7 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
 	.gfx_fifo_workaround	=	true,
+	.mstandby_workaround	=	true,
 };
 
 static int __init dispc_init_features(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 222363c..de4863d 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -39,6 +39,7 @@
 #define DISPC_GLOBAL_BUFFER		0x0800
 #define DISPC_CONTROL3                  0x0848
 #define DISPC_CONFIG3                   0x084C
+#define DISPC_MSTANDBY_CTRL		0x0858
 
 /* DISPC overlay registers */
 #define DISPC_OVL_BA0(n)		(DISPC_OVL_BASE(n) + \
-- 
1.7.10.4

