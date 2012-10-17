From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 5/5] OMAPFB: use omap_vrfb_supported()
Date: Wed, 17 Oct 2012 13:18:22 +0300
Message-ID: <1350469102-24888-6-git-send-email-tomi.valkeinen@ti.com>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56024 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022Ab2JQKSl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 06:18:41 -0400
In-Reply-To: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Replace cpu_is_*() check with omap_vrfb_supported().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 5943b3a..bc225e4 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -31,7 +31,6 @@
 #include <linux/omapfb.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 #include <plat/vram.h>
 #include <video/omapvrfb.h>
 
@@ -2396,10 +2395,7 @@ static int __init omapfb_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
-	*	 available for OMAP2 and OMAP3
-	*/
-	if (def_vrfb && !cpu_is_omap24xx() && !cpu_is_omap34xx()) {
+	if (def_vrfb && !omap_vrfb_supported()) {
 		def_vrfb = 0;
 		dev_warn(&pdev->dev, "VRFB is not supported on this hardware, "
 				"ignoring the module parameter vrfb=y\n");
-- 
1.7.9.5

