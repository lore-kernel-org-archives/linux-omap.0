From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 44/59] omap: namespace cleanup to drivers/usb/musb/omap2430.c
Date: Wed, 12 Nov 2008 00:57:03 +0200
Message-ID: <1226444238-14614-45-git-send-email-me@felipebalbi.com>
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
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
 <1226444238-14614-44-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56714 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYKKXFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:53 -0500
In-Reply-To: <1226444238-14614-44-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index be4e779..4e18035 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -225,7 +225,7 @@ int __init musb_platform_init(struct musb *musb)
 	musb->xceiv = *x;
 	musb_platform_resume(musb);
 
-	l = omap_readl(OTG_SYSCONFIG);
+	l = __raw_readl(OTG_SYSCONFIG);
 	l &= ~ENABLEWAKEUP;	/* disable wakeup */
 	l &= ~NOSTDBY;		/* remove possible nostdby */
 	l |= SMARTSTDBY;	/* enable smart standby */
@@ -233,17 +233,17 @@ int __init musb_platform_init(struct musb *musb)
 	l &= ~NOIDLE;		/* remove possible noidle */
 	l |= SMARTIDLE;		/* enable smart idle */
 	l |= AUTOIDLE;		/* enable auto idle */
-	omap_writel(l, OTG_SYSCONFIG);
+	__raw_writel(l, OTG_SYSCONFIG);
 
-	l = omap_readl(OTG_INTERFSEL);
+	l = __raw_readl(OTG_INTERFSEL);
 	l |= ULPI_12PIN;
-	omap_writel(l, OTG_INTERFSEL);
+	__raw_writel(l, OTG_INTERFSEL);
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
-			omap_readl(OTG_REVISION), omap_readl(OTG_SYSCONFIG),
-			omap_readl(OTG_SYSSTATUS), omap_readl(OTG_INTERFSEL),
-			omap_readl(OTG_SIMENABLE));
+			__raw_readl(OTG_REVISION), omap_readl(OTG_SYSCONFIG),
+			__raw_readl(OTG_SYSSTATUS), omap_readl(OTG_INTERFSEL),
+			__raw_readl(OTG_SIMENABLE));
 
 	omap_vbus_power(musb, musb->board_mode == MUSB_HOST, 1);
 
@@ -266,13 +266,13 @@ int musb_platform_suspend(struct musb *musb)
 		return 0;
 
 	/* in any role */
-	l = omap_readl(OTG_FORCESTDBY);
+	l = __raw_readl(OTG_FORCESTDBY);
 	l |= ENABLEFORCE;	/* enable MSTANDBY */
-	omap_writel(l, OTG_FORCESTDBY);
+	__raw_writel(l, OTG_FORCESTDBY);
 
-	l = omap_readl(OTG_SYSCONFIG);
+	l = __raw_readl(OTG_SYSCONFIG);
 	l |= ENABLEWAKEUP;	/* enable wakeup */
-	omap_writel(l, OTG_SYSCONFIG);
+	__raw_writel(l, OTG_SYSCONFIG);
 
 	if (musb->xceiv.set_suspend)
 		musb->xceiv.set_suspend(&musb->xceiv, 1);
@@ -300,13 +300,13 @@ static int musb_platform_resume(struct musb *musb)
 	else
 		clk_enable(musb->clock);
 
-	l = omap_readl(OTG_SYSCONFIG);
+	l = __raw_readl(OTG_SYSCONFIG);
 	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	omap_writel(l, OTG_SYSCONFIG);
+	__raw_writel(l, OTG_SYSCONFIG);
 
-	l = omap_readl(OTG_FORCESTDBY);
+	l = __raw_readl(OTG_FORCESTDBY);
 	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
-	omap_writel(l, OTG_FORCESTDBY);
+	__raw_writel(l, OTG_FORCESTDBY);
 
 	return 0;
 }
-- 
1.6.0.2.307.gc427

