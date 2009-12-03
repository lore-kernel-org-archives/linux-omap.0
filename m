From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/8] OMAP1/2/3 clock: remove paranoid checks in preparation
	for clock{, 2xxx, 3xxx}_data.c
Date: Thu, 03 Dec 2009 03:07:02 -0700
Message-ID: <20091203100658.1203.42063.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZLCKLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:11:47 -0500
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Some parts of the clock code took advantage of the fact that the statically
allocated clock tree was in clock{,24xx,34xx}.c's local namespace to do some
extra argument checks.  These are overzealous and are more difficult to
maintain when the clock tree is in a separate namespace, so, remove them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c     |    6 ------
 arch/arm/mach-omap2/clock24xx.c |    6 ------
 arch/arm/mach-omap2/clock34xx.c |   18 ------------------
 3 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 42cbe20..e006493 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -376,9 +376,6 @@ static int omap1_select_table_rate(struct clk * clk, unsigned long rate)
 	/* Find the highest supported frequency <= rate and switch to it */
 	struct mpu_rate * ptr;
 
-	if (clk != &virtual_ck_mpu)
-		return -EINVAL;
-
 	for (ptr = rate_table; ptr->rate; ptr++) {
 		if (ptr->xtal != ck_ref.rate)
 			continue;
@@ -465,9 +462,6 @@ static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate)
 	struct mpu_rate * ptr;
 	long  highest_rate;
 
-	if (clk != &virtual_ck_mpu)
-		return -EINVAL;
-
 	highest_rate = -EINVAL;
 
 	for (ptr = rate_table; ptr->rate; ptr++) {
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 845b478..8ecd175 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -512,9 +512,6 @@ static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 	struct prcm_config *ptr;
 	long highest_rate;
 
-	if (clk != &virt_prcm_set)
-		return -EINVAL;
-
 	highest_rate = -EINVAL;
 
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
@@ -540,9 +537,6 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	unsigned long found_speed = 0;
 	unsigned long flags;
 
-	if (clk != &virt_prcm_set)
-		return -EINVAL;
-
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2878733..a4b903d 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -520,9 +520,6 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 	u8 ai;
 	int r;
 
-	if (clk == &dpll3_ck)
-		return -EINVAL;
-
 	pr_debug("clock: locking DPLL %s\n", clk->name);
 
 	ai = omap3_dpll_autoidle_read(clk);
@@ -557,9 +554,6 @@ static int _omap3_noncore_dpll_bypass(struct clk *clk)
 	int r;
 	u8 ai;
 
-	if (clk == &dpll3_ck)
-		return -EINVAL;
-
 	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS)))
 		return -EINVAL;
 
@@ -593,9 +587,6 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 {
 	u8 ai;
 
-	if (clk == &dpll3_ck)
-		return -EINVAL;
-
 	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
 		return -EINVAL;
 
@@ -632,9 +623,6 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	int r;
 	struct dpll_data *dd;
 
-	if (clk == &dpll3_ck)
-		return -EINVAL;
-
 	dd = clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
@@ -669,9 +657,6 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
  */
 static void omap3_noncore_dpll_disable(struct clk *clk)
 {
-	if (clk == &dpll3_ck)
-		return;
-
 	_omap3_noncore_dpll_stop(clk);
 }
 
@@ -844,9 +829,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (!clk || !rate)
 		return -EINVAL;
 
-	if (clk != &dpll3_m2_ck)
-		return -EINVAL;
-
 	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
 	if (validrate != rate)
 		return -EINVAL;


