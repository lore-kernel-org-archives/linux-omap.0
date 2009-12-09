From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 07/10 V4] omap3: clk: use pm accessor functions for cpufreq table
Date: Wed,  9 Dec 2009 00:17:12 -0600
Message-ID: <1260339435-20294-8-git-send-email-nm@ti.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com>
 <1260339435-20294-2-git-send-email-nm@ti.com>
 <1260339435-20294-3-git-send-email-nm@ti.com>
 <1260339435-20294-4-git-send-email-nm@ti.com>
 <1260339435-20294-5-git-send-email-nm@ti.com>
 <1260339435-20294-6-git-send-email-nm@ti.com>
 <1260339435-20294-7-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755683AbZLIGRY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 01:17:24 -0500
In-Reply-To: <1260339435-20294-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

omap2_clk_init_cpufreq_table currently directly accesses the opp
table, making it unscalable to various OMAPs. Instead use the
accessor functions to populate the cpufreq table.

includes fixes from comment:
http://marc.info/?l=linux-omap&m=126027057909254&w=2

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tero Kristo <Tero.Kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   40 ++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 5150939..6c4a609 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -1042,30 +1042,44 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 #if defined(CONFIG_ARCH_OMAP3)
 
 #ifdef CONFIG_CPU_FREQ
-static struct cpufreq_frequency_table freq_table[MAX_VDD1_OPP+1];
+
+static struct cpufreq_frequency_table *freq_table;
 
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
-	struct omap_opp *prcm;
 	int i = 0;
+	int opp_num;
+	struct omap_opp *opp = mpu_opps;
+	unsigned long freq = ULONG_MAX;
 
-	if (!mpu_opps)
+	if (!mpu_opps) {
+		pr_warning("%s: failed to initialize frequency"
+				"table\n", __func__);
+		return;
+	}
+	opp_num = opp_get_opp_count(mpu_opps);
+	if (opp_num < 0) {
+		pr_err("%s: no opp table?\n", __func__);
 		return;
-
-	prcm = mpu_opps + MAX_VDD1_OPP;
-	for (; prcm->rate; prcm--) {
-		freq_table[i].index = i;
-		freq_table[i].frequency = prcm->rate / 1000;
-		i++;
 	}
 
-	if (i == 0) {
-		printk(KERN_WARNING "%s: failed to initialize frequency \
-								table\n",
-								__func__);
+	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
+			(opp_num + 1), GFP_ATOMIC);
+	if (!freq_table) {
+		pr_warning("%s: failed to allocate frequency"
+				"table\n", __func__);
 		return;
 	}
 
+	while (!IS_ERR(opp = opp_find_freq_approx(opp, &freq,
+					OPP_SEARCH_LOW))) {
+		freq_table[i].index = i;
+		freq_table[i].frequency = freq / 1000;
+		i++;
+		/* set the next benchmark to search */
+		freq--;
+	}
+
 	freq_table[i].index = i;
 	freq_table[i].frequency = CPUFREQ_TABLE_END;
 
-- 
1.6.3.3

