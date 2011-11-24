From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/13] OMAPDSS: DSI: flush posted write when entering ULPS
Date: Thu, 24 Nov 2011 15:29:29 +0200
Message-ID: <1322141381-5395-2-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58117 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755040Ab1KXN3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:29:55 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Flush posted write between writing the ULPS enable bits and waiting for
the interrupt.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5abf8e7..1331f92 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3561,6 +3561,9 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (1 << 0) | (1 << 1) | (1 << 2),
 		7, 5);
 
+	/* flush posted write and wait for SCP interface to finish the write */
+	dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG2);
+
 	if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(1000)) == 0) {
 		DSSERR("ULPS enable timeout\n");
@@ -3575,6 +3578,9 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (0 << 0) | (0 << 1) | (0 << 2),
 		7, 5);
 
+	/* flush posted write and wait for SCP interface to finish the write */
+	dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG2);
+
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ULPS);
 
 	dsi_if_enable(dsidev, false);
-- 
1.7.4.1

