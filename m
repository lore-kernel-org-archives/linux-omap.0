From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v6 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only for omap2,3
Date: Fri,  8 Oct 2010 12:14:33 +0530
Message-ID: <1286520273-4892-4-git-send-email-svadivu@ti.com>
References: <1286520273-4892-1-git-send-email-svadivu@ti.com>
 <1286520273-4892-2-git-send-email-svadivu@ti.com>
 <1286520273-4892-3-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43125 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab0JHGoo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 02:44:44 -0400
In-Reply-To: <1286520273-4892-3-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

VRFB is supported only on OMAP2 and OMAP3 platforms. If VRFB rotation is 
not supported by the hardware and the user requests VRFB rotation, 
print a warning and ignore the request from the user.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index bddfca6..fcd9038 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2198,6 +2198,16 @@ static int omapfb_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
+	*	 available for OMAP2 and OMAP3
+	*/
+	if (def_vrfb && !cpu_is_omap24xx() && !cpu_is_omap34xx()) {
+		def_vrfb = 0;
+		dev_warn(&pdev->dev, "VRFB is not supported in this hardware,"
+				"ignoring the module parameter vrfb=y\n");
+	}
+
+
 	mutex_init(&fbdev->mtx);
 
 	fbdev->dev = &pdev->dev;
-- 
1.6.3.3

