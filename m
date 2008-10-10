From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fix compiler warnings in smartreflex.c
Date: Fri, 10 Oct 2008 19:21:02 +0530
Message-ID: <1223646662-22521-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48106 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742AbYJJNvM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 09:51:12 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9ADp4jo022830
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 08:51:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fix these compiler warnings:
smartreflex.c:126: warning: initialization makes integer from pointer without a cast
smartreflex.c:134: warning: initialization makes integer from pointer without a cast

Refreshed after updates from Felipe.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e54c0fb..33f604d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -49,8 +49,8 @@ struct omap_sr {
 	u32 		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
 	u32		opp5_nvalue;
 	u32		senp_mod, senn_mod;
-	u32		srbase_addr;
-	u32		vpbase_addr;
+	void __iomem	*srbase_addr;
+	void __iomem	*vpbase_addr;
 };
 
 /* Custom clocks to enable SR specific enable/disable functions. */
@@ -60,15 +60,15 @@ struct sr_custom_clk {
 	struct omap_sr 	*sr;
 };
 
-#define SR_REGADDR(offs)     (__force void __iomem *)(sr->srbase_addr + offset)
+#define SR_REGADDR(offs)	(sr->srbase_addr + offset)
 
-static inline void sr_write_reg(struct omap_sr *sr, int offset, u32 value)
+static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
 	__raw_writel(value, SR_REGADDR(offset));
 }
 
-static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
-								u32 value)
+static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
+					u32 value)
 {
 	u32 reg_val;
 
@@ -79,7 +79,7 @@ static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
 	__raw_writel(reg_val, SR_REGADDR(offset));
 }
 
-static inline u32 sr_read_reg(struct omap_sr *sr, int offset)
+static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
 {
 	return __raw_readl(SR_REGADDR(offset));
 }
-- 
1.5.6

