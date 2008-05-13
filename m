From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC PATCH 3/5] USB: MUSB: Do not turn vbus on immediately
Date: Tue, 13 May 2008 15:29:54 +0300
Message-ID: <1210681796-1984-4-git-send-email-felipe.balbi@nokia.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35651 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbYEMMdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:33:36 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCXPJn031177
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 07:33:34 -0500
In-Reply-To: <1210681796-1984-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Felipe Balbi <felipe.balbi@nokia.com>

From: ext Felipe Balbi <felipe.balbi@nokia.com>

Wait for user interaction to turn vbus on.
On end user products, this behavior could be
masked under some application with permission to
write to /sys/devices/platform/musb_hdrc/session.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/tusb6010.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 9f92cef..14220d9 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -675,11 +675,6 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 		musb->xceiv.default_a = default_a;
 		musb->xceiv.state = default_a ? OTG_STATE_A_IDLE
 			: OTG_STATE_B_IDLE;
-		tusb_source_power(musb, default_a);
-
-		/* Don't allow idling immediately */
-		if (default_a)
-			idle_timeout = jiffies + (HZ * 3);
 	}
 
 	/* VBUS state change */
-- 
1.5.5.1.125.gc697a

