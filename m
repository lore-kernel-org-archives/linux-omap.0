From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v4 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only for omap2,3
Date: Tue, 22 Jun 2010 17:27:07 +0530
Message-ID: <1277207827-15833-4-git-send-email-svadivu@ti.com>
References: <1277207827-15833-1-git-send-email-svadivu@ti.com>
 <1277207827-15833-2-git-send-email-svadivu@ti.com>
 <1277207827-15833-3-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60557 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756174Ab0FVL5U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 07:57:20 -0400
In-Reply-To: <1277207827-15833-3-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Force def_vrfb to 0 for non omap2, omap3 devices

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..0f79db8 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2128,6 +2128,16 @@ static int omapfb_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
+	*	 available for OMAP2 and OMAP3
+	*/
+	if (def_vrfb && (!cpu_is_omap24xx()) && (!cpu_is_omap34xx())) {
+		def_vrfb = 0;
+		dev_warn(&pdev->dev, "VRFB is not in this device,"
+				"using DMA for rotation\n");
+	}
+
+
 	mutex_init(&fbdev->mtx);
 
 	fbdev->dev = &pdev->dev;
-- 
1.6.3.3

