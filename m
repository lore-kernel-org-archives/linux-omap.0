From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/13] OMAPDSS: DSI: flush posted write in send_bta
Date: Thu, 24 Nov 2011 15:29:30 +0200
Message-ID: <1322141381-5395-3-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56054 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755542Ab1KXN36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:29:58 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Flush posted write after setting the bit to send the BTA to ensure the
BTA is sent right away, as the code in dsi_vc_send_bta_sync() waits for
an interrupt caused indirectly by sending the BTA.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1331f92..4b1c074 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2913,6 +2913,9 @@ static int dsi_vc_send_bta(struct platform_device *dsidev, int channel)
 
 	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 6, 6); /* BTA_EN */
 
+	/* flush posted write */
+	dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
+
 	return 0;
 }
 
-- 
1.7.4.1

