From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 16/27] cbus: tahvo: usb: drop unused variable
Date: Thu, 13 Oct 2011 11:34:51 +0300
Message-ID: <1318494902-13093-16-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50064 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1JMIfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:39 -0400
Received: by mail-bw0-f45.google.com with SMTP id t2so1237595bka.4
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:38 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo-usb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 10619a8..e078440 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -116,7 +116,6 @@ static struct platform_device *tahvo_otg_dev;
 
 static irqreturn_t omap_otg_irq(int irq, void *arg)
 {
-	struct tahvo_usb *tu = arg;
 	u16 otg_irq;
 
 	otg_irq = omap_readw(OTG_IRQ_SRC);
-- 
1.7.6.396.ge0613

