From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP1 clock: fix for "BUG: spinlock lockup on CPU#0"
Date: Fri, 15 Jan 2010 18:06:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001151805130.11569@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35690 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab0APBGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 20:06:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com


Commit 52650505fbf3a6ab851c801f54e73e76c55ab8da caused clock initialization
to fail on OMAP1 with "BUG: spinlock lockup on CPU#0" -- this is because
omap1_select_table_rate() and omap1_round_to_table_rate() call clk_get_rate()
with the clockfw spinlock held.  Fix by accessing the rate directly from
the internal clock framework functions.

Thanks to Tony Lindgren <tony@atomide.com> for reporting and testing the fix.

Queued for 2.6.33-rcX fixes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/clock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 2ba9ab9..04f1d29 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -214,8 +214,8 @@ int omap1_select_table_rate(struct clk *clk, unsigned long rate)
 	struct mpu_rate * ptr;
 	unsigned long dpll1_rate, ref_rate;
 
-	dpll1_rate = clk_get_rate(ck_dpll1_p);
-	ref_rate = clk_get_rate(ck_ref_p);
+	dpll1_rate = ck_dpll1_p->rate;
+	ref_rate = ck_ref_p->rate;
 
 	for (ptr = omap1_rate_table; ptr->rate; ptr++) {
 		if (ptr->xtal != ref_rate)
@@ -306,7 +306,7 @@ long omap1_round_to_table_rate(struct clk *clk, unsigned long rate)
 	long highest_rate;
 	unsigned long ref_rate;
 
-	ref_rate = clk_get_rate(ck_ref_p);
+	ref_rate = ck_ref_p->rate;
 
 	highest_rate = -EINVAL;
 
-- 
1.6.6.rc2.5.g49666

