From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/86] [ARM] omap: remove unnecessary calls to propagate_rate()
Date: Thu, 12 Mar 2009 11:27:23 -0700
Message-ID: <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbZCLS3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:46 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:45 -0700 (PDT)
In-Reply-To: <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

We've always called propagate_rate() in the parent function to
the .set_rate methods, so there's no point having the .set_rate
methods also call this heavy-weight function - it's mere
duplication of what's happening elsewhere.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index ee1b9f2..80a58e9 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -308,7 +308,6 @@ static int omap1_select_table_rate(struct clk * clk, unsigned long rate)
 		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
 
 	ck_dpll1.rate = ptr->pll_rate;
-	propagate_rate(&ck_dpll1);
 	return 0;
 }
 
@@ -333,9 +332,6 @@ static int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate)
 		ret = 0;
 	}
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
-		propagate_rate(clk);
-
 	return ret;
 }
 
@@ -442,8 +438,6 @@ static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
 	omap_writel(l, MOD_CONF_CTRL_1);
 
 	clk->rate = p_rate / (div + 1);
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
 
 	return 0;
 }
@@ -787,7 +781,6 @@ int __init omap1_clk_init(void)
 			}
 		}
 	}
-	propagate_rate(&ck_dpll1);
 #else
 	/* Find the highest supported frequency and enable it */
 	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
@@ -796,9 +789,9 @@ int __init omap1_clk_init(void)
 		omap_writew(0x2290, DPLL_CTL);
 		omap_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
 		ck_dpll1.rate = 60000000;
-		propagate_rate(&ck_dpll1);
 	}
 #endif
+	propagate_rate(&ck_dpll1);
 	/* Cache rates for clocks connected to ck_ref (not dpll1) */
 	propagate_rate(&ck_ref);
 	printk(KERN_INFO "Clocking rate (xtal/DPLL1/MPU): "
-- 
1.6.1.2

