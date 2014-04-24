From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/23] OMAPDSS: DSI: Add OMAP5 DSI module IDs
Date: Thu, 24 Apr 2014 13:17:12 +0300
Message-ID: <1398334639-14172-17-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58147 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391AbaDXKTT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:19 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add OMAP5 DSI module ID support to the OMAP DSI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 57f120896b43..a888d28fd055 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -5733,9 +5733,16 @@ static const struct dsi_module_id_data dsi_of_data_omap4[] = {
 	{ },
 };
 
+static const struct dsi_module_id_data dsi_of_data_omap5[] = {
+	{ .address = 0x58004000, .id = 0, },
+	{ .address = 0x58009000, .id = 1, },
+	{ },
+};
+
 static const struct of_device_id dsi_of_match[] = {
 	{ .compatible = "ti,omap3-dsi", .data = dsi_of_data_omap3, },
 	{ .compatible = "ti,omap4-dsi", .data = dsi_of_data_omap4, },
+	{ .compatible = "ti,omap5-dsi", .data = dsi_of_data_omap5, },
 	{},
 };
 
-- 
1.9.1

