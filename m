From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC PATCH 1/5] USB: MUSB: Switch to a_idle when micro/mini-a cable is attached
Date: Tue, 13 May 2008 15:29:52 +0300
Message-ID: <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42627 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbYEMMcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:32:09 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCVadZ021346
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:32:06 +0300
In-Reply-To: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Felipe Balbi <felipe.balbi@nokia.com>

From: ext Felipe Balbi <felipe.balbi@nokia.com>

This is mostly cosmetic but can help us in the future
making musb driver not insertion-based.

I mean, whenever we attach micro-/mini-A connector to
musb-based devices, we instantaneously turn vbus on where
we should wait until we need to use the bus.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/tusb6010.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 1f3643b..9f92cef 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -673,6 +673,8 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 			default_a = is_host_enabled(musb);
 		DBG(2, "Default-%c\n", default_a ? 'A' : 'B');
 		musb->xceiv.default_a = default_a;
+		musb->xceiv.state = default_a ? OTG_STATE_A_IDLE
+			: OTG_STATE_B_IDLE;
 		tusb_source_power(musb, default_a);
 
 		/* Don't allow idling immediately */
-- 
1.5.5.1.125.gc697a

