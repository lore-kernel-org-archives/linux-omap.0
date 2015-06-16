From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/7] OMAPDSS: reorder uninit calls
Date: Tue, 16 Jun 2015 13:16:27 +0300
Message-ID: <1434449789-13812-6-git-send-email-tomi.valkeinen@ti.com>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756716AbbFPKRH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 06:17:07 -0400
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We have a list of function pointers to dss submodule uninit functions.
It makes sense to do the uninit in the reverse order to init, but that
is not currently the case.

This patch reorders the uninit calls to be the reverse of init order.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
index 57b6a5296c87..5c64515de818 100644
--- a/drivers/video/fbdev/omap2/dss/core.c
+++ b/drivers/video/fbdev/omap2/dss/core.c
@@ -269,26 +269,26 @@ static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 };
 
 static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_uninit_platform_driver,
+#ifdef CONFIG_OMAP5_DSS_HDMI
+	hdmi5_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DPI
-	dpi_uninit_platform_driver,
+#ifdef CONFIG_OMAP4_DSS_HDMI
+	hdmi4_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_SDI
-	sdi_uninit_platform_driver,
+#ifdef CONFIG_OMAP2_DSS_VENC
+	venc_uninit_platform_driver,
 #endif
 #ifdef CONFIG_OMAP2_DSS_RFBI
 	rfbi_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_VENC
-	venc_uninit_platform_driver,
+#ifdef CONFIG_OMAP2_DSS_SDI
+	sdi_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP4_DSS_HDMI
-	hdmi4_uninit_platform_driver,
+#ifdef CONFIG_OMAP2_DSS_DPI
+	dpi_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP5_DSS_HDMI
-	hdmi5_uninit_platform_driver,
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_uninit_platform_driver,
 #endif
 };
 
-- 
2.1.4

