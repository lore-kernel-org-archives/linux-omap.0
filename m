From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 8/8] arm: omap: musb: remove unnecessary return
Date: Mon, 28 Dec 2009 13:09:50 +0200
Message-ID: <1261998590-6639-9-git-send-email-felipe.balbi@nokia.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19161 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZL1LL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 06:11:57 -0500
In-Reply-To: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index e0050c5..ec8869a 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -91,10 +91,8 @@ void __init usb_musb_init(enum musb_mode mode, unsigned power)
 	musb_plat.power = power >> 1;
 	musb_plat.mode = mode;
 
-	if (platform_device_register(&musb_device) < 0) {
+	if (platform_device_register(&musb_device) < 0)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
-		return;
-	}
 }
 
 #else
-- 
1.6.6.rc0

