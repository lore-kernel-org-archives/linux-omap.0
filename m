From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] SmartReflex: fix sparse issues
Date: Thu, 17 Jul 2008 20:52:41 -0600
Message-ID: <20080718025239.20613.30676.stgit@localhost.localdomain>
References: <20080718024832.20613.30050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42275 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYGRDNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 23:13:05 -0400
In-Reply-To: <20080718024832.20613.30050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix sparse issues with smartreflex.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/smartreflex.c |   10 ++++++----
 arch/arm/mach-omap2/smartreflex.h |    3 +++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 0f3a659..f460831 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -60,9 +60,11 @@ struct sr_custom_clk {
 	struct omap_sr 	*sr;
 };
 
+#define SR_REGADDR(offs)     (__force void __iomem *)(sr->srbase_addr + offset)
+
 static inline void sr_write_reg(struct omap_sr *sr, int offset, u32 value)
 {
-	__raw_writel(value, sr->srbase_addr + offset);
+	__raw_writel(value, SR_REGADDR(offset));
 }
 
 static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
@@ -70,16 +72,16 @@ static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
 {
 	u32 reg_val;
 
-	reg_val = __raw_readl(sr->srbase_addr + offset);
+	reg_val = __raw_readl(SR_REGADDR(offset));
 	reg_val &= ~mask;
 	reg_val |= value;
 
-	__raw_writel(reg_val, sr->srbase_addr + offset);
+	__raw_writel(reg_val, SR_REGADDR(offset));
 }
 
 static inline u32 sr_read_reg(struct omap_sr *sr, int offset)
 {
-	return __raw_readl(sr->srbase_addr + offset);
+	return __raw_readl(SR_REGADDR(offset));
 }
 
 /* Custom clock handling functions */
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 9b9904d..be6e6b9 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -248,6 +248,9 @@ extern u32 current_vdd2_opp;
 #ifdef CONFIG_OMAP_SMARTREFLEX
 void enable_smartreflex(int srid);
 void disable_smartreflex(int srid);
+int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
+void sr_start_vddautocomap(int srid, u32 target_opp_no);
+int sr_stop_vddautocomap(int srid);
 #else
 static inline void enable_smartreflex(int srid) {}
 static inline void disable_smartreflex(int srid) {}


