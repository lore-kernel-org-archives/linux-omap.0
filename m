From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV3 2/2] Set MPU and IVA bypass clock dividers in DVFS
Date: Thu,  1 Apr 2010 18:32:19 +0800
Message-ID: <1270117939-10730-3-git-send-email-vishwanath.bs@ti.com>
References: <>
 <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
 <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40189 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab0DAEy7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 00:54:59 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o314stjW005409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 23:54:58 -0500
In-Reply-To: <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

Whenever VDD1 OPP is changed, MPU and Bypass clock dividers should be
adjusted such that MPU/IVA is never overclocked when DPLL1/DPLL2 is in
bypass mode

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..068021c
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -154,6 +154,7 @@ static struct device vdd2_dev;
 static int vdd1_lock;
 static int vdd2_lock;
 static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
+static  struct clk *dpll1_fck, *dpll2_fck;
 static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
@@ -228,6 +229,8 @@ void init_opp(struct shared_resource *resp)
 		ret = freq_to_opp(&opp_id, OPP_MPU, dpll1_clk->rate);
 		BUG_ON(ret); /* TBD Cleanup handling */
 		curr_vdd1_opp = opp_id;
+		dpll1_fck = clk_get(NULL, "dpll1_fck");
+		dpll2_fck = clk_get(NULL, "dpll2_fck");
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		vdd2_resp = resp;
 		dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
@@ -276,9 +279,9 @@ static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
 
 static int program_opp_freq(int res, int target_level, int current_level)
 {
-	int ret = 0, l3_div;
+	int ret = 0, l3_div, mpu_div, iva2_div;
 	int *curr_opp;
-	unsigned long mpu_freq, dsp_freq, l3_freq;
+	unsigned long mpu_freq, dsp_freq, l3_freq, max_core_clk;
 #ifndef CONFIG_CPU_FREQ
 	unsigned long mpu_cur_freq;
 #endif
@@ -299,6 +302,17 @@ static int program_opp_freq(int res, int target_level, int current_level)
 
 	lock_scratchpad_sem();
 	if (res == VDD1_OPP) {
+		/* adjust bypass clock diviers */
+		max_core_clk = ULONG_MAX;
+		opp_find_freq_floor(OPP_L3, &max_core_clk);
+		l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+				OMAP3430_CLKSEL_L3_MASK;
+		max_core_clk *= l3_div;
+		mpu_div = 1 << (max_core_clk / mpu_freq);
+		iva2_div = 1 << (max_core_clk / dsp_freq);
+		clk_set_rate(dpll1_fck, max_core_clk/mpu_div);
+		clk_set_rate(dpll2_fck, max_core_clk/iva2_div);
+
 		curr_opp = &curr_vdd1_opp;
 		clk_set_rate(dpll1_clk, mpu_freq);
 		clk_set_rate(dpll2_clk, dsp_freq);
-- 
1.5.4.3

