From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/86] [ARM] omap: rearrange clock.h structure order
Date: Thu, 12 Mar 2009 11:27:19 -0700
Message-ID: <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbZCLS3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:35 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:33 -0700 (PDT)
In-Reply-To: <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

... to eliminate unnecessary padding.  We have rather a lot of these
structures, so eliminating unnecessary padding results in a saving of
1488 bytes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/include/mach/clock.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 547619f..6c24835 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -25,8 +25,8 @@ struct clkops {
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
 struct clksel_rate {
-	u8			div;
 	u32			val;
+	u8			div;
 	u8			flags;
 };
 
@@ -39,23 +39,23 @@ struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
+	unsigned int		rate_tolerance;
+	unsigned long		last_rounded_rate;
 	u16			last_rounded_m;
 	u8			last_rounded_n;
-	unsigned long		last_rounded_rate;
-	unsigned int		rate_tolerance;
-	u16			max_multiplier;
 	u8			max_divider;
 	u32			max_tolerance;
+	u16			max_multiplier;
 #  if defined(CONFIG_ARCH_OMAP3)
 	u8			modes;
 	void __iomem		*control_reg;
+	void __iomem		*autoidle_reg;
+	void __iomem		*idlest_reg;
 	u32			enable_mask;
+	u32			autoidle_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-	void __iomem		*autoidle_reg;
-	u32			autoidle_mask;
-	void __iomem		*idlest_reg;
 	u8			idlest_bit;
 #  endif
 };
@@ -71,12 +71,12 @@ struct clk {
 	unsigned long		rate;
 	__u32			flags;
 	void __iomem		*enable_reg;
-	__u8			enable_bit;
-	__s8			usecount;
 	void			(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
 	long			(*round_rate)(struct clk *, unsigned long);
 	void			(*init)(struct clk *);
+	__u8			enable_bit;
+	__s8			usecount;
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	u8			fixed_div;
 	void __iomem		*clksel_reg;
-- 
1.6.1.2

