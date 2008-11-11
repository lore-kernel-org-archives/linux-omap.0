From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 18/59] omap: namespace cleanup to arch/arm/mach-omap2/pm24xx.c
Date: Wed, 12 Nov 2008 00:56:37 +0200
Message-ID: <1226444238-14614-19-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40126 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYKKXBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:40 -0500
In-Reply-To: <1226444238-14614-18-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/pm24xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 60ff04f..3632aa1 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -300,12 +300,12 @@ static int omap2_pm_suspend(void)
 	prm_write_mod_reg(wken_wkup & ~OMAP24XX_EN_GPT1, WKUP_MOD, PM_WKEN);
 
 	/* Mask GPT1 */
-	mir1 = omap_readl(0x480fe0a4);
-	omap_writel(1 << 5, 0x480fe0ac);
+	mir1 = __raw_readl(0x480fe0a4);
+	__raw_writel(1 << 5, 0x480fe0ac);
 
 	omap2_enter_full_retention();
 
-	omap_writel(mir1, 0x480fe0a4);
+	__raw_writel(mir1, 0x480fe0a4);
 	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	return 0;
-- 
1.6.0.2.307.gc427

