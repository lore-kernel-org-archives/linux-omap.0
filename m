From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 5/9] ehci: increase timeout to fix ehci failure
Date: Thu,  6 Aug 2009 17:37:36 +0530
Message-ID: <1249560460-16306-5-git-send-email-ajay.gupta@ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51384 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276AbZHFMI7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 08:08:59 -0400
In-Reply-To: <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Sometime during TLL reset and waiting loop for TLL reset timeouts and thus
ehci init fails. Fixing this by increasing timeout value.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 55e5259..c7631f5 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -244,7 +244,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
  */
 static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	unsigned reg = 0;
 	int ret = 0;
 
-- 
1.6.2.4

