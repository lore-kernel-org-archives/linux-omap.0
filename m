From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 (v2) 05/11] MUSB: OMAP: make musb_platform_suspend() 'static'
Date: Thu, 25 Mar 2010 13:25:22 +0200
Message-ID: <1269516328-28267-6-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48808 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab0CYL0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:26:35 -0400
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

This function is only called inside omap2430.c...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 218df2c..2633049 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -276,7 +276,7 @@ void musb_platform_restore_context(struct musb *musb,
 }
 #endif
 
-int musb_platform_suspend(struct musb *musb)
+static int musb_platform_suspend(struct musb *musb)
 {
 	u32 l;
 
-- 
1.7.0.rc0.33.g7c3932

