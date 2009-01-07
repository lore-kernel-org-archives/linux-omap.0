From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3] usb: musb: fix null pointer check in musb_platform_init()
Date: Wed,  7 Jan 2009 16:44:20 +0530
Message-ID: <1231326860-22727-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40373 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbZAGLOe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2009 06:14:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes kernel panic when musb is selected for OMAP35x EVM but twl4030 is not
selected as in this case otg_get_transceiver() returns null.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/omap2430.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3f99536..6ddc986 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -232,6 +232,8 @@ int __init musb_platform_init(struct musb *musb)
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
+	if (!x)
+		return -ENODEV;
 
 	musb->xceiv = *x;
 	musb_platform_resume(musb);
-- 
1.5.6

