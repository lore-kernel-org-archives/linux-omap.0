From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/15] OMAPDSS: Add support for MFLAG
Date: Thu, 26 Feb 2015 14:49:06 +0200
Message-ID: <1424954949-12801-12-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37399 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbbBZMts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 07:49:48 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP5 has support for MFLAG feature, which allows DSS to dynamically
increase the priority of DISPC's DMA traffic. At the moment we don't
have support for it.

It was noticed that on DRA7 with high bandwidth use cases we see FIFO
underflows. Implementing MFLAG support removed those underflows.
Interestingly, on OMAP5 uEVM no such overflows were seen.

This patch adds a simple MFLAG implementation, where we use a fixed
MFLAG threshold value based on the FIFO size. The thresholds are set to
4/8 of fifo size for low threshold, and 5/8 of fifo size for high
threshold.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 6296a3e5124f..6b056d0ce187 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1305,6 +1305,53 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 }
 EXPORT_SYMBOL(dispc_ovl_compute_fifo_thresholds);
 
+static void dispc_ovl_set_mflag(enum omap_plane plane, bool enable)
+{
+	int bit;
+
+	if (plane == OMAP_DSS_GFX)
+		bit = 14;
+	else
+		bit = 23;
+
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, bit, bit);
+}
+
+static void dispc_ovl_set_mflag_threshold(enum omap_plane plane,
+	int low, int high)
+{
+	dispc_write_reg(DISPC_OVL_MFLAG_THRESHOLD(plane),
+		FLD_VAL(high, 31, 16) |	FLD_VAL(low, 15, 0));
+}
+
+static void dispc_init_mflag(void)
+{
+	int i;
+
+	dispc_write_reg(DISPC_GLOBAL_MFLAG_ATTRIBUTE,
+		(2 << 0) |	/* MFLAG_CTRL = enable */
+		(0 << 2));	/* MFLAG_START = disable */
+
+	for (i = 0; i < dss_feat_get_num_ovls(); ++i) {
+		u32 size = dispc_ovl_get_fifo_size(i);
+		u32 unit = dss_feat_get_buffer_size_unit();
+		u32 low, high;
+
+		dispc_ovl_set_mflag(i, true);
+
+		/*
+		 * Simulation team suggests below thesholds:
+		 * HT = fifosize * 5 / 8;
+		 * LT = fifosize * 4 / 8;
+		 */
+
+		low = size * 4 / 8 / unit;
+		high = size * 5 / 8 / unit;
+
+		dispc_ovl_set_mflag_threshold(i, low, high);
+	}
+}
+
 static void dispc_ovl_set_fir(enum omap_plane plane,
 				int hinc, int vinc,
 				enum omap_color_component color_comp)
@@ -3630,6 +3677,9 @@ static void _omap_dispc_initial_config(void)
 
 	if (dispc.feat->mstandby_workaround)
 		REG_FLD_MOD(DISPC_MSTANDBY_CTRL, 1, 0, 0);
+
+	if (dss_has_feature(FEAT_MFLAG))
+		dispc_init_mflag();
 }
 
 static const struct dispc_features omap24xx_dispc_feats __initconst = {
-- 
2.3.0

