From: Raphael Assenat <raph@8d.com>
Subject: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 17 Jul 2012 10:01:40 -0400
Message-ID: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:53797 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827Ab2GQOBl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 10:01:41 -0400
Received: from raph.usine.8d.com ([192.168.142.55] helo=renkinjitsu.usine.8d.com)
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Sr8LM-0001WK-Fw
	for linux-omap@vger.kernel.org; Tue, 17 Jul 2012 10:01:40 -0400
Received: from raph by renkinjitsu.usine.8d.com with local (Exim 4.72)
	(envelope-from <raph@8d.com>)
	id 1Sr8LM-00067s-BK
	for linux-omap@vger.kernel.org; Tue, 17 Jul 2012 10:01:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.

Signed-off-by: Raphael Assenat <raph@8d.com>

--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -486,6 +486,80 @@ static struct panel_config generic_dpi_panels[] = {
 					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
 		.name			= "primeview_pd104slf",
 	},
+
+	/* ChiMei G121S1-L01 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 600,
+
+			.pixel_clock	= 39700,
+
+			.hfp		= 128,
+			.hsw		= 1,
+			.hbp		= 128,
+
+			.vfp		= 28,
+			.vsw		= 1,
+			.vbp		= 28
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "chimei_g121s1-l01",
+	},
+
+	/* ChiMei G121S1-L02 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 600,
+
+			.pixel_clock	= 40000,
+
+			.hfp		= 1,
+			.hsw		= 256,
+			.hbp		= 1,
+
+			.vfp		= 1,
+			.vsw		= 28,
+			.vbp		= 1
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "chimei_g121s1-l02",
+	},
+
+
+	/* ChiMei G121X1-L01 */
+	{
+		{
+			.x_res		= 1024,
+			.y_res		= 768,
+
+			.pixel_clock	= 64900,
+
+			.hfp		= 160,
+			.hsw		= 1,
+			.hbp		= 160,
+
+			.vfp		= 38,
+			.vsw		= 1,
+			.vbp		= 38
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "chimei_g121x1-l01",
+	},
+
 };
 
 struct panel_drv_data {
