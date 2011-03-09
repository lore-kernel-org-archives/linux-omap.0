From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/6] OMAP: DSS2: DSI: catch DSI errors in send_bta_sync
Date: Wed, 9 Mar 2011 09:21:27 +0200
Message-ID: <1299655288-7121-6-git-send-email-tomi.valkeinen@ti.com>
References: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57395 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab1CIHVr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 02:21:47 -0500
In-Reply-To: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dsi_vc_send_bta_sync() waits for BTA interrupt with a 500ms timeout. If
a DSI error happens, no BTA is received and the timeout triggers. This
could be handled much faster by listening to DSI errors also.

This patch uses the ISR support to notice DSI errors while waiting for
the BTA, thus speeding up the fail-path considerably.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5672e40..ec5b879 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2230,24 +2230,31 @@ int dsi_vc_send_bta_sync(int channel)
 	if (r)
 		goto err0;
 
-	r = dsi_vc_send_bta(channel);
+	r = dsi_register_isr(dsi_completion_handler, &completion,
+			DSI_IRQ_ERROR_MASK);
 	if (r)
 		goto err1;
 
+	r = dsi_vc_send_bta(channel);
+	if (r)
+		goto err2;
+
 	if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(500)) == 0) {
 		DSSERR("Failed to receive BTA\n");
 		r = -EIO;
-		goto err1;
+		goto err2;
 	}
 
 	err = dsi_get_errors();
 	if (err) {
 		DSSERR("Error while sending BTA: %x\n", err);
 		r = -EIO;
-		goto err1;
+		goto err2;
 	}
-
+err2:
+	dsi_unregister_isr(dsi_completion_handler, &completion,
+			DSI_IRQ_ERROR_MASK);
 err1:
 	dsi_unregister_isr_vc(channel, dsi_completion_handler,
 			&completion, DSI_VC_IRQ_BTA);
-- 
1.7.1

