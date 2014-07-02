From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/13] ARM: OMAP4+: clock: remove DEFINE_CLK_OMAP_HSDIVIDER macro
Date: Wed, 2 Jul 2014 11:47:36 +0300
Message-ID: <1404290867-6768-3-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55671 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaGBIrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 04:47:55 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

This clock type declaration is no longer used as all omap4+ SoC clock
data has been moved to DT, thus remove it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.h |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 12f54d4..e29f982 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -101,31 +101,6 @@ struct clockdomain;
 	};							\
 	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
 
-#define DEFINE_CLK_OMAP_HSDIVIDER(_name, _parent_name,		\
-				_parent_ptr, _flags,		\
-				_clksel_reg, _clksel_mask)	\
-	static const struct clksel _name##_div[] = {		\
-		{						\
-			.parent = _parent_ptr,			\
-			.rates = div31_1to31_rates		\
-		},						\
-		{ .parent = NULL },				\
-	};							\
-	static struct clk _name;				\
-	static const char *_name##_parent_names[] = {		\
-		_parent_name,					\
-	};							\
-	static struct clk_hw_omap _name##_hw = {		\
-		.hw = {						\
-			.clk = &_name,				\
-		},						\
-		.clksel		= _name##_div,			\
-		.clksel_reg	= _clksel_reg,			\
-		.clksel_mask	= _clksel_mask,			\
-		.ops		= &clkhwops_omap4_dpllmx,	\
-	};							\
-	DEFINE_STRUCT_CLK(_name, _name##_parent_names, omap_hsdivider_ops);
-
 /* struct clksel_rate.flags possibilities */
 #define RATE_IN_242X		(1 << 0)
 #define RATE_IN_243X		(1 << 1)
-- 
1.7.9.5

