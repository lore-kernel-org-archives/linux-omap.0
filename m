From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 6/9] omap3: clk: use pm accessor functions for cpufreq table
Date: Fri, 13 Nov 2009 00:05:19 -0600
Message-ID: <1258092322-30833-7-git-send-email-nm@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
 <1258092322-30833-2-git-send-email-nm@ti.com>
 <1258092322-30833-3-git-send-email-nm@ti.com>
 <1258092322-30833-4-git-send-email-nm@ti.com>
 <1258092322-30833-5-git-send-email-nm@ti.com>
 <1258092322-30833-6-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34864 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbZKMGFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 01:05:22 -0500
In-Reply-To: <1258092322-30833-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

omap2_clk_init_cpufreq_table currently directly accesses the opp
table, making it unscalable to various OMAPs. Instead use the
accessor functions to populate the cpufreq table

Tested on: SDP3430, SDP3630

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: SuiLun Lam <s-lam@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   46 +++++++++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index da5bc1f..daec6ea 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -1042,28 +1042,46 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 #if defined(CONFIG_ARCH_OMAP3)
 
 #ifdef CONFIG_CPU_FREQ
-static struct cpufreq_frequency_table freq_table[MAX_VDD1_OPP+1];
+
+/* Use a dummy table with no entries to start with */
+static struct cpufreq_frequency_table dummy_freq_table = {
+	.frequency = CPUFREQ_TABLE_END,
+};
+static struct cpufreq_frequency_table *freq_table = &dummy_freq_table;
 
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
-	struct omap_opp *prcm;
-	int i = 0;
+	int i;
+	int ret;
+	u8 opp_id;
+	unsigned long freq;
 
 	if (!mpu_opps)
 		return;
-
-	prcm = mpu_opps + MAX_VDD1_OPP;
-	for (; prcm->rate; prcm--) {
-		freq_table[i].index = i;
-		freq_table[i].frequency = prcm->rate / 1000;
-		i++;
+	ret = get_limit_freq(&freq, mpu_opps, true, true);
+	if (ret) {
+		pr_warning("%s: failed to initialize frequency"
+				"table\n", __func__);
+		return;
 	}
+	/* The following should'nt fail */
+	BUG_ON(freq_to_opp(&opp_id, mpu_opps, freq));
 
-	if (i == 0) {
-		printk(KERN_WARNING "%s: failed to initialize frequency \
-								table\n",
-								__func__);
-		return;
+	/* There is a risk of overallocating if the lower/intermediate
+	 * OPPs are disabled, but the amount is not expected to be high
+	 * in comparison to reallocating to exactly available opps
+	 */
+	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
+			(opp_id + 1), GFP_KERNEL);
+
+	/* Populate the first index.. we already found the freq */
+	freq_table[0].index = 0;
+	freq_table[0].frequency =  freq / 1000;
+
+	/* Populate the table highest to lowest */
+	for (i = 1; !get_next_freq(&freq, mpu_opps, false, true, true); i++) {
+		freq_table[i].index = i;
+		freq_table[i].frequency =  freq / 1000;
 	}
 
 	freq_table[i].index = i;
-- 
1.6.3.3

