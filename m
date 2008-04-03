From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] USB: MUSB: Be sure that we enable musb->clock
Date: Thu, 3 Apr 2008 06:56:01 -0500
Message-ID: <0c65e3d506e8fd8a7579091f73c3b4fb@felipebalbi.com>
References: <1207222710-10120-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35972 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbYDCL4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 07:56:04 -0400
In-Reply-To: <1207222710-10120-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com



On Thu,  3 Apr 2008 14:38:30 +0300, Felipe Balbi <felipe.balbi@nokia.com>
wrote:

The following is better as I'm also disabling the clock on suspend to
conserve power.

>From 5a4151f6fae01b82007c1205ff89daa9328276cb Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Thu, 3 Apr 2008 14:35:33 +0300
Subject: [PATCH 1/1] USB: MUSB: Be sure that we enable musb->clock

If CONFIG_OMAP_RESET_CLOCKS is enabled, musb->clock would
be disabled because nobody was enabling it.

Be sure that omap2430.c enables musb->clock to avoid problems
later.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 8041dde..2a4247c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -246,6 +246,13 @@ int __init musb_platform_init(struct musb *musb)
 
 int musb_platform_suspend(struct musb *musb)
 {
+	unsigned long	flags;
+
+	if (!musb->clock)
+		return 0;
+
+	spin_lock_irqsave(&musb->lock, flags);
+
 	/* in any role */
 	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
 	OTG_SYSCONFIG_REG &= FORCESTDBY;	/* enable force standby */
@@ -257,20 +264,41 @@ int musb_platform_suspend(struct musb *musb)
 	if (musb->xceiv.set_suspend)
 		musb->xceiv.set_suspend(&musb->xceiv, 1);
 
+	if (musb->set_clock)
+		musb->set_clock(musb->clock, 0);
+	else
+		clk_disable(musb->clock);
+
+	spin_unlock_irqrestore(&musb->lock, flags);
+
 	return 0;
 }
 
 int musb_platform_resume(struct musb *musb)
 {
+	unsigned long	flags;
+
+	if (!musb->clock)
+		return 0;
+
+	spin_lock_irqsave(&musb->lock, flags);
+
 	if (musb->xceiv.set_suspend)
 		musb->xceiv.set_suspend(&musb->xceiv, 0);
 
+	if (musb->set_clock)
+		musb->set_clock(musb->clock, 1);
+	else
+		clk_enable(musb->clock);
+
 	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
 	OTG_SYSCONFIG_REG |= SMARTSTDBY;	/* enable smart standby */
 	OTG_SYSCONFIG_REG &= ~AUTOIDLE;		/* disable auto idle */
 	OTG_SYSCONFIG_REG |= SMARTIDLE;		/* enable smart idle */
 	OTG_SYSCONFIG_REG |= AUTOIDLE;		/* enable auto idle */
 
+	spin_unlock_irqrestore(&musb->lock, flags);
+
 	return 0;
 }
 
-- 
1.5.5.rc2.25.g5fbd



-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

