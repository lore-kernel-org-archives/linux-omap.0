From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 23/59] omap: namespace cleanup to arch/arm/plat-omap/ocpi.c
Date: Wed, 12 Nov 2008 00:56:42 +0200
Message-ID: <1226444238-14614-24-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40046 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYKKXBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:15 -0500
In-Reply-To: <1226444238-14614-23-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/ocpi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/ocpi.c b/arch/arm/plat-omap/ocpi.c
index ebe0c73..b0578d3 100644
--- a/arch/arm/plat-omap/ocpi.c
+++ b/arch/arm/plat-omap/ocpi.c
@@ -62,14 +62,14 @@ int ocpi_enable(void)
 		return -ENODEV;
 
 	/* Enable access for OHCI in OCPI */
-	val = omap_readl(OCPI_PROT);
+	val = __raw_readl(OCPI_PROT);
 	val &= ~0xff;
 	//val &= (1 << 0);	/* Allow access only to EMIFS */
-	omap_writel(val, OCPI_PROT);
+	__raw_writel(val, OCPI_PROT);
 
-	val = omap_readl(OCPI_SEC);
+	val = __raw_readl(OCPI_SEC);
 	val &= ~0xff;
-	omap_writel(val, OCPI_SEC);
+	__raw_writel(val, OCPI_SEC);
 
 	return 0;
 }
-- 
1.6.0.2.307.gc427

