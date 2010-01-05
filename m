From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] OMAP2 clock: dynamically allocate CPUFreq frequency table
Date: Mon, 04 Jan 2010 19:42:07 -0700
Message-ID: <20100105024206.16275.58063.stgit@localhost.localdomain>
References: <20100105024113.16275.96273.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52032 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab0AECsk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 21:48:40 -0500
In-Reply-To: <20100105024113.16275.96273.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Dynamically allocate the CPUFreq frequency table on OMAP2xxx chips.
This fixes some compilation problems, since the kernel may not know
what chip it is running on until boot-time.  This also reduces the size
of the CPUFreq frequency table.

Problem reported by Felipe Balbi <felipe.balbi@nokia.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/clock2xxx.c |   50 ++++++++++++++++++++++++++++++++-------
 1 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 2f3c3ba..5c21afe 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -449,14 +449,16 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 #ifdef CONFIG_CPU_FREQ
 /*
  * Walk PRCM rate table and fillout cpufreq freq_table
+ * XXX This should be replaced by an OPP layer in the near future
  */
-static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
+static struct cpufreq_frequency_table *freq_table;
 
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
-	struct prcm_config *prcm;
-	long rate;
+	const struct prcm_config *prcm;
+	long sys_ck_rate;
 	int i = 0;
+	int tbl_sz = 0;
 
 	sys_ck_rate = clk_get_rate(sclk);
 
@@ -470,21 +472,51 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 		if (prcm->dpll_speed == prcm->xtal_speed)
 			continue;
 
+		tbl_sz++;
+	}
+
+	/*
+	 * XXX Ensure that we're doing what CPUFreq expects for this error
+	 * case and the following one
+	 */
+	if (tbl_sz == 0) {
+		pr_warning("%s: no matching entries in rate_table\n",
+			   __func__);
+		goto ocict_exit;
+	}
+
+	/* Include the CPUFREQ_TABLE_END terminator entry */
+	tbl_sz++;
+
+	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) * tbl_sz,
+			     GFP_KERNEL);
+	if (!freq_table) {
+		pr_err("%s: could not kzalloc frequency table\n", __func__);
+		goto ocict_exit;
+	}
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck_rate)
+			continue;
+
+		/* don't put bypass rates in table */
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			continue;
+
 		freq_table[i].index = i;
 		freq_table[i].frequency = prcm->mpu_speed / 1000;
 		i++;
 	}
 
-	if (i == 0) {
-		printk(KERN_WARNING "%s: failed to initialize frequency "
-		       "table\n", __func__);
-		return;
-	}
-
 	freq_table[i].index = i;
 	freq_table[i].frequency = CPUFREQ_TABLE_END;
 
 	*table = &freq_table[0];
+
+ocict_exit:
+	return;
 }
 #endif
 


