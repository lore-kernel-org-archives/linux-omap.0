From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/13] OMAP clock: compress clock flags down to a u8
Date: Thu, 11 Feb 2010 11:17:03 -0700
Message-ID: <20100211181701.795.87996.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35527 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab0BKSUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:54 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

There are now only eight OMAP clock flags, so renumber the flags to
fit in a u8 and shrink the size of struct clk.flags from a u32 to a
u8.  The intention is to save memory.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/clock.h |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 5dac307..7dc1ae7 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -126,7 +126,6 @@ struct clk {
 	struct list_head	children;
 	struct list_head	sibling;	/* node for children */
 	unsigned long		rate;
-	__u32			flags;
 	void __iomem		*enable_reg;
 	unsigned long		(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
@@ -135,6 +134,7 @@ struct clk {
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			fixed_div;
+	u8			flags;
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 		defined(CONFIG_ARCH_OMAP4)
 	void __iomem		*clksel_reg;
@@ -189,20 +189,14 @@ extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
 extern const struct clkops clkops_null;
 
 /* Clock flags */
-/* bit 0 is free */
-#define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
-/* bits 2-4 are free */
-#define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
-/* bit 6 is free */
-#define CLOCK_IDLE_CONTROL	(1 << 7)
-#define CLOCK_NO_IDLE_PARENT	(1 << 8)
-#define DELAYED_APP		(1 << 9)	/* Delay application of clock */
-/* bit 10 is currently free */
-#define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 12)	/* 0 enables, 1 disables */
-/* bit 13 is currently free */
-#define ALWAYS_ENABLED		(1 << 14)
-/* bits 15-31 are currently free */
+#define RATE_FIXED		(1 << 0)	/* Fixed clock rate */
+#define ENABLE_REG_32BIT	(1 << 1)	/* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 2)
+#define CLOCK_NO_IDLE_PARENT	(1 << 3)
+#define DELAYED_APP		(1 << 4)	/* Delay application of clock */
+#define ENABLE_ON_INIT		(1 << 5)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 6)	/* 0 enables, 1 disables */
+#define ALWAYS_ENABLED		(1 << 7)
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)


