From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 14/59] omap: namespace cleanup to arch/arm/mach-omap1/mux.c
Date: Wed, 12 Nov 2008 00:56:33 +0200
Message-ID: <1226444238-14614-15-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40117 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbYKKXBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:37 -0500
In-Reply-To: <1226444238-14614-14-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/mux.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 062c905..1e9558b 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -333,7 +333,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 		unsigned	tmp1, tmp2;
 
 		spin_lock_irqsave(&mux_spin_lock, flags);
-		reg_orig = omap_readl(cfg->mux_reg);
+		reg_orig = __raw_readl(cfg->mux_reg);
 
 		/* The mux registers always seem to be 3 bits long */
 		mask = (0x7 << cfg->mask_offset);
@@ -346,7 +346,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 		if (tmp1 != tmp2)
 			warn = 1;
 
-		omap_writel(reg, cfg->mux_reg);
+		__raw_writel(reg, cfg->mux_reg);
 		spin_unlock_irqrestore(&mux_spin_lock, flags);
 	}
 
@@ -354,7 +354,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 	if (!cpu_is_omap15xx()) {
 		if (cfg->pu_pd_reg && cfg->pull_val) {
 			spin_lock_irqsave(&mux_spin_lock, flags);
-			pu_pd_orig = omap_readl(cfg->pu_pd_reg);
+			pu_pd_orig = __raw_readl(cfg->pu_pd_reg);
 			mask = 1 << cfg->pull_bit;
 
 			if (cfg->pu_pd_val) {
@@ -368,7 +368,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 				/* Use pull down */
 				pu_pd = pu_pd_orig & ~mask;
 			}
-			omap_writel(pu_pd, cfg->pu_pd_reg);
+			__raw_writel(pu_pd, cfg->pu_pd_reg);
 			spin_unlock_irqrestore(&mux_spin_lock, flags);
 		}
 	}
@@ -376,7 +376,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 	/* Check for an associated pull down register */
 	if (cfg->pull_reg) {
 		spin_lock_irqsave(&mux_spin_lock, flags);
-		pull_orig = omap_readl(cfg->pull_reg);
+		pull_orig = __raw_readl(cfg->pull_reg);
 		mask = 1 << cfg->pull_bit;
 
 		if (cfg->pull_val) {
@@ -391,7 +391,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 			pull = pull_orig | mask;
 		}
 
-		omap_writel(pull, cfg->pull_reg);
+		__raw_writel(pull, cfg->pull_reg);
 		spin_unlock_irqrestore(&mux_spin_lock, flags);
 	}
 
-- 
1.6.0.2.307.gc427

