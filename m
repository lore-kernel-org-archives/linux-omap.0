From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 08/11] MUSB: DaVinci: fix musb_platform_init() error cleanup path
Date: Thu, 25 Mar 2010 13:14:30 +0200
Message-ID: <1269515673-27980-9-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36527 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab0CYLPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:15:42 -0400
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

This function forgets to call clk_disable() iff reading the USB module version
register returns 0.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/davinci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index a883f9d..4b0f5be 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -445,6 +445,8 @@ int __init musb_platform_init(struct musb *musb)
 	return 0;
 
 fail:
+	clk_disable(musb->clock);
+
 	usb_nop_xceiv_unregister();
 	return -ENODEV;
 }
-- 
1.7.0.rc0.33.g7c3932

