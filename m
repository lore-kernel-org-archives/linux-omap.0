From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/4] OMAP2: clock: fix misc. OMAP24xx compile issues
Date: Thu, 28 Jan 2010 09:17:15 -0800
Message-ID: <1264699036-5491-4-git-send-email-khilman@deeprootsystems.com>
References: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54167 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319Ab0A1RRY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:17:24 -0500
Received: by mail-pw0-f42.google.com with SMTP id 21so625474pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:17:24 -0800 (PST)
In-Reply-To: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- Convert use of non-existant cpu_is_omap2xxx() to cpu_is_omap24xx()
- Change prefix of OMAP2 CPUfreq init/exit functions from
  omap2xxx_ to omap2_ as used in clock.c
- fix 'possible use of uninitialized variable' warning in
  omap2xxx_clk_init()

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    8 ++++----
 arch/arm/mach-omap2/clock2xxx_data.c         |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 7174d09..3b1eac4 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -177,14 +177,14 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
  */
 static struct cpufreq_frequency_table *freq_table;
 
-void omap2xxx_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	const struct prcm_config *prcm;
 	long sys_ck_rate;
 	int i = 0;
 	int tbl_sz = 0;
 
-	if (!cpu_is_omap2xxx())
+	if (!cpu_is_omap24xx())
 		return;
 
 	sys_ck_rate = clk_get_rate(sclk);
@@ -243,9 +243,9 @@ void omap2xxx_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 	*table = &freq_table[0];
 }
 
-void omap2xxx_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
+void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 {
-	if (!cpu_is_omap2xxx())
+	if (!cpu_is_omap24xx())
 		return;
 
 	kfree(freq_table);
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 52c7a6c..cd9156d 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -2243,7 +2243,7 @@ int __init omap2xxx_clk_init(void)
 	const struct prcm_config *prcm;
 	struct omap_clk *c;
 	u32 clkrate;
-	u16 cpu_clkflg;
+	u16 cpu_clkflg = 0;
 
 	if (cpu_is_omap242x()) {
 		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
-- 
1.6.6

