From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/20] OMAPDSS: DSI: fix DSI channel source initialization
Date: Fri, 8 Mar 2013 13:51:54 +0200
Message-ID: <1362743515-10152-20-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933492Ab3CHLwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:32 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

During the initialization of the DSI protocol registers, we always set
the sources of all DSI channels to L4. However, we don't update the
value in the dsi_data, so we may end up with a different value in the
register and in the dsi_data, leading to DSI problems.

This patch fixes the issue by initializing also the channel source in
the dsi_data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index da8a678..2d95ed9 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2794,6 +2794,7 @@ static int dsi_vc_enable(struct platform_device *dsidev, int channel,
 
 static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r;
 
 	DSSDBG("Initial config of virtual channel %d", channel);
@@ -2818,6 +2819,8 @@ static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 	r = FLD_MOD(r, 4, 23, 21); /* DMA_TX_REQ_NB = no dma */
 
 	dsi_write_reg(dsidev, DSI_VC_CTRL(channel), r);
+
+	dsi->vc[channel].source = DSI_VC_SOURCE_L4;
 }
 
 static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
-- 
1.7.10.4

