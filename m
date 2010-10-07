From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v4 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only for omap2,3
Date: Thu,  7 Oct 2010 14:38:55 +0530
Message-ID: <1286442535-28308-4-git-send-email-svadivu@ti.com>
References: <1286442535-28308-1-git-send-email-svadivu@ti.com>
 <1286442535-28308-2-git-send-email-svadivu@ti.com>
 <1286442535-28308-3-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40095 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab0JGJJF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 05:09:05 -0400
In-Reply-To: <1286442535-28308-3-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
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

