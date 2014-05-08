From: Archit Taneja <archit@ti.com>
Subject: [RFC 1/6] omapdss: remove check for simpler port/endpoint binding
Date: Thu, 8 May 2014 14:45:12 +0530
Message-ID: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58727 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbaEHJQZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 05:16:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The support for simpler port/endpoint binding was removed in the merged version
of omapdss DT. But dss_init_ports still tries to get to an endpoint even if no
port exists. Remove this as this doesn't work.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d55266c..31ef262 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -784,12 +784,8 @@ static int __init dss_init_ports(struct platform_device *pdev)
 		return 0;
 
 	port = omapdss_of_get_next_port(parent, NULL);
-	if (!port) {
-#ifdef CONFIG_OMAP2_DSS_DPI
-		dpi_init_port(pdev, parent);
-#endif
+	if (!port)
 		return 0;
-	}
 
 	do {
 		u32 reg;
-- 
1.8.3.2

