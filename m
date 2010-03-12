From: Roger Quadros <roger.quadros@nokia.com>
Subject: [RFC][PATCH 1/3] OMAP: DSS2: Do regulator stuff in dpi_init_display()
Date: Fri, 12 Mar 2010 17:27:22 +0200
Message-ID: <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20684 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934302Ab0CLP2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:28:10 -0500
In-Reply-To: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

We don't want dpi_init() to fail in any case as it will prevent us
from using DSS2 if we don't have DSI in the system. This is because
dpi_init() is done unconditionally by the DSS2 core.

We will only need to do regulator initialization when DPI is actually
present in the system. So we do regulator init stuff in dpi_init_display()

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 drivers/video/omap2/dss/dpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..bcedafd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -299,11 +299,6 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	return 0;
-}
-
-int dpi_init(struct platform_device *pdev)
-{
 	if (cpu_is_omap34xx()) {
 		dpi.vdds_dsi_reg = dss_get_vdds_dsi();
 		if (IS_ERR(dpi.vdds_dsi_reg)) {
@@ -315,6 +310,11 @@ int dpi_init(struct platform_device *pdev)
 	return 0;
 }
 
+int dpi_init(struct platform_device *pdev)
+{
+	return 0;
+}
+
 void dpi_exit(void)
 {
 }
-- 
1.6.0.4

