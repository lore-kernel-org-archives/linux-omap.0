From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes
Date: Wed, 12 Sep 2012 00:32:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Remove some unnecessary plat/ includes that are interfering with multi-subarch
ARM kernels.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Kevin Hilman <khilman@ti.com>
---

Still awaiting some final testing here.  Rafael, was wondering if you 
would be willing to ack this so we can merge it via the OMAP tree?   
Otherwise the patch can be split into an OMAP part and a CPUFreq part that 
can go in across two merge windows.

 arch/arm/mach-omap2/clock2420_data.c |    1 +
 arch/arm/mach-omap2/clock2430_data.c |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 drivers/cpufreq/omap-cpufreq.c       |   19 +------------------
 5 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index ea8e883..de1b9a4 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1897,6 +1897,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
+	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_242X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index cacabb0..d3ecdf7 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1993,6 +1993,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"timer_32k_ck",  &func_32k_ck,   CK_243X),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
 	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
+	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 83bed9a..ea4690c 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3466,6 +3466,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
 	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
+	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
 };
 
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index d7f55e4..9b31767 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3325,6 +3325,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap_timer.6",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("omap_timer.7",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("omap_timer.8",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index b47034e..2737d08 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -30,13 +30,9 @@
 #include <asm/smp_plat.h>
 #include <asm/cpu.h>
 
-#include <plat/clock.h>
-#include <plat/omap-pm.h>
 #include <plat/common.h>
 #include <plat/omap_device.h>
 
-#include <mach/hardware.h>
-
 /* OPP tolerance in percentage */
 #define	OPP_TOLERANCE	4
 
@@ -53,7 +49,6 @@ static struct lpj_info global_lpj_ref;
 static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
-static char *mpu_clk_name;
 static struct device *mpu_dev;
 static struct regulator *mpu_reg;
 
@@ -207,7 +202,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 
-	mpu_clk = clk_get(NULL, mpu_clk_name);
+	mpu_clk = clk_get(NULL, "cpufreq_ck");
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
@@ -288,18 +283,6 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
-	if (cpu_is_omap24xx())
-		mpu_clk_name = "virt_prcm_set";
-	else if (cpu_is_omap34xx())
-		mpu_clk_name = "dpll1_ck";
-	else if (cpu_is_omap44xx())
-		mpu_clk_name = "dpll_mpu_ck";
-
-	if (!mpu_clk_name) {
-		pr_err("%s: unsupported Silicon?\n", __func__);
-		return -EINVAL;
-	}
-
 	mpu_dev = omap_device_get_by_hwmod_name("mpu");
 	if (!mpu_dev) {
 		pr_warning("%s: unable to get the mpu device\n", __func__);
-- 
1.7.10.4

