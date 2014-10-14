From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Date: Tue, 14 Oct 2014 13:28:54 -0500
Message-ID: <1413311335-25083-2-git-send-email-balbi@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbaJNS33 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 14:29:29 -0400
In-Reply-To: <1413311335-25083-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>, Felipe Balbi <balbi@ti.com>

without MODULE_ALIAS(), omapfb won't get loaded
automatically.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 9cbf1ce..b4b9244 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -2651,6 +2651,7 @@ module_param_named(mirror, def_mirror, bool, 0);
 
 module_platform_driver(omapfb_driver);
 
+MODULE_ALIAS("platform:omapfb");
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
 MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
 MODULE_LICENSE("GPL v2");
-- 
2.1.0.GIT

