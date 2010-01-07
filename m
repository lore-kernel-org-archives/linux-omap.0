From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 4/5] OMAP clock/CPUFreq: add clk_exit_cpufreq_table()
Date: Wed, 06 Jan 2010 18:22:22 -0700
Message-ID: <20100107012209.3551.29357.stgit@localhost.localdomain>
References: <20100107011932.3551.75659.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37143 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271Ab0AGBYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 20:24:18 -0500
In-Reply-To: <20100107011932.3551.75659.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

A subsequent patch adds code on OMAP2xxx to dynamically allocate the
CPUFreq frequency table in clk_init_cpufreq_table(), so for it to
avoid a leak, it will need a corresponding function to free the
memory.  This patch adds clk_exit_cpufreq_table() with generic
code to call a chip-specific variant inside the clockfw_lock spinlock via
struct clk_functions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c              |   10 ++++++++++
 arch/arm/plat-omap/cpu-omap.c           |    1 +
 arch/arm/plat-omap/include/plat/clock.h |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index a64d84c..d9f8c84 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -329,6 +329,16 @@ void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 		arch_clock->clk_init_cpufreq_table(table);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
+
+void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if (arch_clock->clk_exit_cpufreq_table)
+		arch_clock->clk_exit_cpufreq_table(table);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+}
 #endif
 
 /*-------------------------------------------------------------------------*/
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index f8ddbdd..6d3d333 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -134,6 +134,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
+	clk_exit_cpufreq_table(&freq_table);
 	clk_put(mpu_clk);
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 309b6d1..94fe2a0 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -119,6 +119,7 @@ struct clk_functions {
 	void		(*clk_disable_unused)(struct clk *clk);
 #ifdef CONFIG_CPU_FREQ
 	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **);
+	void		(*clk_exit_cpufreq_table)(struct cpufreq_frequency_table **);
 #endif
 };
 
@@ -135,6 +136,7 @@ extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
+extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
 
 extern const struct clkops clkops_null;


