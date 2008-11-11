From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 30/59] omap: namespace cleanup to drivers/i2c/chips/twl4030-usb.c
Date: Wed, 12 Nov 2008 00:56:49 +0200
Message-ID: <1226444238-14614-31-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56531 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYKKXEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:04:43 -0500
In-Reply-To: <1226444238-14614-30-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index f967353..b6c7893 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -594,7 +594,7 @@ static int twl4030_set_peripheral(struct otg_transceiver *x,
 	twl = xceiv_to_twl(x);
 
 	if (!gadget) {
-		omap_writew(0, OTG_IRQ_EN);
+		__raw_writew(0, OTG_IRQ_EN);
 		twl4030_phy_suspend(twl, 1);
 		twl->otg.gadget = NULL;
 
@@ -604,10 +604,10 @@ static int twl4030_set_peripheral(struct otg_transceiver *x,
 	twl->otg.gadget = gadget;
 	twl4030_phy_resume(twl);
 
-	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
+	l = __raw_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
 	l |= OTG_ID;
-	omap_writel(l, OTG_CTRL);
+	__raw_writel(l, OTG_CTRL);
 
 	twl->otg.state = OTG_STATE_B_IDLE;
 
@@ -624,7 +624,7 @@ static int twl4030_set_host(struct otg_transceiver *x, struct usb_bus *host)
 	twl = xceiv_to_twl(x);
 
 	if (!host) {
-		omap_writew(0, OTG_IRQ_EN);
+		__raw_writew(0, OTG_IRQ_EN);
 		twl4030_phy_suspend(twl, 1);
 		twl->otg.host = NULL;
 
-- 
1.6.0.2.307.gc427

