From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 57/59] omap: namespace cleanup to arch/arm/plat-omap/include/mach/system.h
Date: Wed, 12 Nov 2008 00:57:16 +0200
Message-ID: <1226444238-14614-58-git-send-email-me@felipebalbi.com>
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
 <1226444238-14614-45-git-send-email-me@felipebalbi.com>
 <1226444238-14614-46-git-send-email-me@felipebalbi.com>
 <1226444238-14614-47-git-send-email-me@felipebalbi.com>
 <1226444238-14614-48-git-send-email-me@felipebalbi.com>
 <1226444238-14614-49-git-send-email-me@felipebalbi.com>
 <1226444238-14614-50-git-send-email-me@felipebalbi.com>
 <1226444238-14614-51-git-send-email-me@felipebalbi.com>
 <1226444238-14614-52-git-send-email-me@felipebalbi.com>
 <1226444238-14614-53-git-send-email-me@felipebalbi.com>
 <1226444238-14614-54-git-send-email-me@felipebalbi.com>
 <1226444238-14614-55-git-send-email-me@felipebalbi.com>
 <1226444238-14614-56-git-send-email-me@felipebalbi.com>
 <1226444238-14614-57-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43325 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbYKKXQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:16:06 -0500
In-Reply-To: <1226444238-14614-57-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/system.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index e9b9563..f975d6f 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -27,15 +27,15 @@ static inline void omap1_arch_reset(char mode)
 	 * "Global Software Reset Affects Traffic Controller Frequency".
 	 */
 	if (cpu_is_omap5912()) {
-		omap_writew(omap_readw(DPLL_CTL) & ~(1 << 4),
+		__raw_writew(__raw_readw(DPLL_CTL) & ~(1 << 4),
 				 DPLL_CTL);
-		omap_writew(0x8, ARM_RSTCT1);
+		__raw_writew(0x8, ARM_RSTCT1);
 	}
 
 	if (machine_is_voiceblue())
 		voiceblue_reset();
 	else
-		omap_writew(1, ARM_RSTCT1);
+		__raw_writew(1, ARM_RSTCT1);
 }
 
 static inline void arch_reset(char mode)
-- 
1.6.0.2.307.gc427

