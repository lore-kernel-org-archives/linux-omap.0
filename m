From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Set correct off mode polarity
Date: Mon, 21 Jul 2008 19:17:20 +0300
Message-ID: <1216657043-5941-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1216657043-5941-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20983 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYGUQSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 12:18:09 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6LGI5al021295
	for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2008 19:18:07 +0300
In-Reply-To: <1216657043-5941-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6bb25cf..b0bc1b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -46,6 +46,8 @@
 
 #define MAX_DPLL_WAIT_TRIES		1000000
 
+#define OFFMODE_POL 			(1<<3)
+
 struct vdd_prcm_config *curr_vdd1_prcm_set;
 struct vdd_prcm_config *curr_vdd2_prcm_set;
 static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
@@ -684,6 +686,9 @@ int __init omap2_clk_init(void)
 	}
 #endif
 
+	prm_clear_mod_reg_bits(OFFMODE_POL, OMAP3430_GR_MOD,
+				OMAP3_PRM_POLCTRL_OFFSET);
+
 	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
@@ -797,7 +802,6 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 	}
 
-
 	if (clk == &virt_vdd1_prcm_set) {
 		curr_mpu_speed = curr_vdd1_prcm_set->speed;
 		clk_set_rate(dpll1_clk, prcm_vdd->speed);
-- 
1.5.3.4

