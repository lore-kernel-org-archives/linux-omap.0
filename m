From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: sparse: add missing static declaration
Date: Sat, 11 Jul 2015 20:29:15 +0530
Message-ID: <21cca39eea23dfac76e6752fa2b2b62a4b1e15ad.1436622578.git.nsekhar@ti.com>
References: <cover.1436622578.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1436622578.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Add missing static declaration for file local variables.
This fixes sparse warnings of type:

arch/arm/mach-omap2/omap_hwmod_81xx_data.c:491:26: warning: symbol 'dm81xx_alwon_l3_slow__gpmc' was not declared. Should it be static?

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 34 +++++++++++-----------
 arch/arm/mach-omap2/pdata-quirks.c                 |  6 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 79f49d904a06..65024af169d3 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -105,7 +105,7 @@ static void dummy_cpu_resume(void)
 static void dummy_scu_prepare(unsigned int cpu_id, unsigned int cpu_state)
 {}
 
-struct cpu_pm_ops omap_pm_ops = {
+static struct cpu_pm_ops omap_pm_ops = {
 	.finish_suspend		= default_finish_suspend,
 	.resume			= dummy_cpu_resume,
 	.scu_prepare		= dummy_scu_prepare,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 6dcfd03ced8f..36bcd2e75422 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -20,7 +20,7 @@
 #include "prm-regbits-24xx.h"
 #include "wd_timer.h"
 
-struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[] = {
+static struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .dma_req = -1, },
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 215d5efa0dba..e97a894b5f88 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -480,7 +480,7 @@ static struct omap_hwmod am43xx_dss_core_hwmod = {
 
 /* dispc */
 
-struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
+static struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
 	.manager_count		= 1,
 	.has_framedonetv_irq	= 0
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index c92413769144..280789a04ff9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -488,7 +488,7 @@ static struct omap_hwmod dm81xx_gpmc_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__gpmc = {
+static struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__gpmc = {
 	.master		= &dm816x_alwon_l3_slow_hwmod,
 	.slave		= &dm81xx_gpmc_hwmod,
 	.user		= OCP_USER_MPU,
@@ -729,7 +729,7 @@ static struct omap_hwmod_class dm816x_mdio_hwmod_class = {
 	.sysc		= &dm816x_emac_sysc,
 };
 
-struct omap_hwmod dm816x_emac0_mdio_hwmod = {
+static struct omap_hwmod dm816x_emac0_mdio_hwmod = {
 	.name		= "davinci_mdio",
 	.class		= &dm816x_mdio_hwmod_class,
 	.clkdm_name	= "alwon_ethernet_clkdm",
@@ -747,7 +747,7 @@ struct omap_hwmod dm816x_emac0_mdio_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_emac0__mdio = {
+static struct omap_hwmod_ocp_if dm816x_emac0__mdio = {
 	.master		= &dm816x_l4_hs_hwmod,
 	.slave		= &dm816x_emac0_mdio_hwmod,
 	.user		= OCP_USER_MPU,
@@ -902,7 +902,7 @@ static struct omap_hwmod_class dm816x_tpcc_hwmod_class = {
 	.name		= "tpcc",
 };
 
-struct omap_hwmod dm816x_tpcc_hwmod = {
+static struct omap_hwmod dm816x_tpcc_hwmod = {
 	.name		= "tpcc",
 	.class		= &dm816x_tpcc_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -915,7 +915,7 @@ struct omap_hwmod dm816x_tpcc_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tpcc = {
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tpcc = {
 	.master		= &dm816x_alwon_l3_fast_hwmod,
 	.slave		= &dm816x_tpcc_hwmod,
 	.clk		= "sysclk4_ck",
@@ -935,7 +935,7 @@ static struct omap_hwmod_class dm816x_tptc0_hwmod_class = {
 	.name		= "tptc0",
 };
 
-struct omap_hwmod dm816x_tptc0_hwmod = {
+static struct omap_hwmod dm816x_tptc0_hwmod = {
 	.name		= "tptc0",
 	.class		= &dm816x_tptc0_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -948,7 +948,7 @@ struct omap_hwmod dm816x_tptc0_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc0 = {
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc0 = {
 	.master		= &dm816x_alwon_l3_fast_hwmod,
 	.slave		= &dm816x_tptc0_hwmod,
 	.clk		= "sysclk4_ck",
@@ -956,7 +956,7 @@ struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc0 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc0__alwon_l3_fast = {
+static struct omap_hwmod_ocp_if dm816x_tptc0__alwon_l3_fast = {
 	.master		= &dm816x_tptc0_hwmod,
 	.slave		= &dm816x_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
@@ -977,7 +977,7 @@ static struct omap_hwmod_class dm816x_tptc1_hwmod_class = {
 	.name		= "tptc1",
 };
 
-struct omap_hwmod dm816x_tptc1_hwmod = {
+static struct omap_hwmod dm816x_tptc1_hwmod = {
 	.name		= "tptc1",
 	.class		= &dm816x_tptc1_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -990,7 +990,7 @@ struct omap_hwmod dm816x_tptc1_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc1 = {
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc1 = {
 	.master		= &dm816x_alwon_l3_fast_hwmod,
 	.slave		= &dm816x_tptc1_hwmod,
 	.clk		= "sysclk4_ck",
@@ -998,7 +998,7 @@ struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc1 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc1__alwon_l3_fast = {
+static struct omap_hwmod_ocp_if dm816x_tptc1__alwon_l3_fast = {
 	.master		= &dm816x_tptc1_hwmod,
 	.slave		= &dm816x_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
@@ -1019,7 +1019,7 @@ static struct omap_hwmod_class dm816x_tptc2_hwmod_class = {
 	.name		= "tptc2",
 };
 
-struct omap_hwmod dm816x_tptc2_hwmod = {
+static struct omap_hwmod dm816x_tptc2_hwmod = {
 	.name		= "tptc2",
 	.class		= &dm816x_tptc2_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -1032,7 +1032,7 @@ struct omap_hwmod dm816x_tptc2_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc2 = {
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc2 = {
 	.master		= &dm816x_alwon_l3_fast_hwmod,
 	.slave		= &dm816x_tptc2_hwmod,
 	.clk		= "sysclk4_ck",
@@ -1040,7 +1040,7 @@ struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc2 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc2__alwon_l3_fast = {
+static struct omap_hwmod_ocp_if dm816x_tptc2__alwon_l3_fast = {
 	.master		= &dm816x_tptc2_hwmod,
 	.slave		= &dm816x_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
@@ -1061,7 +1061,7 @@ static struct omap_hwmod_class dm816x_tptc3_hwmod_class = {
 	.name		= "tptc3",
 };
 
-struct omap_hwmod dm816x_tptc3_hwmod = {
+static struct omap_hwmod dm816x_tptc3_hwmod = {
 	.name		= "tptc3",
 	.class		= &dm816x_tptc3_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
@@ -1074,7 +1074,7 @@ struct omap_hwmod dm816x_tptc3_hwmod = {
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc3 = {
+static struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc3 = {
 	.master		= &dm816x_alwon_l3_fast_hwmod,
 	.slave		= &dm816x_tptc3_hwmod,
 	.clk		= "sysclk4_ck",
@@ -1082,7 +1082,7 @@ struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc3 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc3__alwon_l3_fast = {
+static struct omap_hwmod_ocp_if dm816x_tptc3__alwon_l3_fast = {
 	.master		= &dm816x_tptc3_hwmod,
 	.slave		= &dm816x_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 821171cf6b7d..1a352f561113 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -31,7 +31,7 @@ struct pdata_init {
 	void (*fn)(void);
 };
 
-struct of_dev_auxdata omap_auxdata_lookup[];
+static struct of_dev_auxdata omap_auxdata_lookup[];
 static struct twl4030_gpio_platform_data twl_gpio_auxdata;
 
 #ifdef CONFIG_MACH_NOKIA_N8X0
@@ -128,7 +128,7 @@ static void __init omap3_sbc_t3530_legacy_init(void)
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 }
 
-struct ti_st_plat_data wilink_pdata = {
+static struct ti_st_plat_data wilink_pdata = {
 	.nshutdown_gpio = 137,
 	.dev_name = "/dev/ttyO1",
 	.flow_cntrl = 1,
@@ -323,7 +323,7 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 	{ /* sentinel */ },
 };
 
-struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
 	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
-- 
2.4.4.408.g16da57c
