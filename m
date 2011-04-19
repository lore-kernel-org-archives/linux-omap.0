From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/19] OMAP: DSS2: DSI: ensure VDDS_DSI is disabled on exit
Date: Tue, 19 Apr 2011 12:22:16 +0300
Message-ID: <1303204942-25450-14-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52092 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754436Ab1DSJW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:59 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The panel drivers can leave the VDDS_DSI regulator enabled, even when
the panel is disabled, to ensure that the DSI pins are powered.

This patch ensures that VDDS_DSI is disabled on DSI module unload.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f1e14ca..9c5715a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4090,6 +4090,11 @@ err1:
 static void dsi_exit(void)
 {
 	if (dsi.vdds_dsi_reg != NULL) {
+		if (dsi.vdds_dsi_enabled) {
+			regulator_disable(dsi.vdds_dsi_reg);
+			dsi.vdds_dsi_enabled = false;
+		}
+
 		regulator_put(dsi.vdds_dsi_reg);
 		dsi.vdds_dsi_reg = NULL;
 	}
-- 
1.7.1

