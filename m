From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/12] OMAPDSS: DSI: workaround for HSDiv problem
Date: Tue, 30 Oct 2012 18:10:03 +0200
Message-ID: <1351613409-21186-7-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952Ab2J3QKa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 12:10:30 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

It looks like on many OMAP versions powers for both HSClk and HSDiv to
be enabled to have a functional HSDiv.

This patch fixes the issue by forcing both powers on.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d0e35da..26d1a78 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1741,6 +1741,12 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 
 	DSSDBG("PLL init\n");
 
+	/*
+	 * It seems that on many OMAPs we need to enable both to have a
+	 * functional HSDivider.
+	 */
+	enable_hsclk = enable_hsdiv = true;
+
 	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
-- 
1.7.10.4

