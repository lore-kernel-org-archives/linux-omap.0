From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 10/28] clk: ti: omap2: transition to usage of ti_clk_get
Date: Thu, 14 Apr 2016 14:07:59 +0300
Message-ID: <1460632097-25727-11-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Cleanup any unnecessary DT_CLK() alias entries from OMAP2 clock file.
Also, use ti_clk_get where necessary.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clk-2xxx.c |  151 ++-------------------------------------------
 1 file changed, 4 insertions(+), 147 deletions(-)

diff --git a/drivers/clk/ti/clk-2xxx.c b/drivers/clk/ti/clk-2xxx.c
index 657c4fe..0b9d7fa 100644
--- a/drivers/clk/ti/clk-2xxx.c
+++ b/drivers/clk/ti/clk-2xxx.c
@@ -22,126 +22,22 @@
 #include "clock.h"
 
 static struct ti_dt_clk omap2xxx_clks[] = {
-	DT_CLK(NULL, "func_32k_ck", "func_32k_ck"),
-	DT_CLK(NULL, "secure_32k_ck", "secure_32k_ck"),
-	DT_CLK(NULL, "virt_12m_ck", "virt_12m_ck"),
-	DT_CLK(NULL, "virt_13m_ck", "virt_13m_ck"),
-	DT_CLK(NULL, "virt_19200000_ck", "virt_19200000_ck"),
-	DT_CLK(NULL, "virt_26m_ck", "virt_26m_ck"),
-	DT_CLK(NULL, "aplls_clkin_ck", "aplls_clkin_ck"),
-	DT_CLK(NULL, "aplls_clkin_x2_ck", "aplls_clkin_x2_ck"),
-	DT_CLK(NULL, "osc_ck", "osc_ck"),
-	DT_CLK(NULL, "sys_ck", "sys_ck"),
-	DT_CLK(NULL, "alt_ck", "alt_ck"),
-	DT_CLK(NULL, "mcbsp_clks", "mcbsp_clks"),
-	DT_CLK(NULL, "dpll_ck", "dpll_ck"),
-	DT_CLK(NULL, "apll96_ck", "apll96_ck"),
-	DT_CLK(NULL, "apll54_ck", "apll54_ck"),
-	DT_CLK(NULL, "func_54m_ck", "func_54m_ck"),
-	DT_CLK(NULL, "core_ck", "core_ck"),
-	DT_CLK(NULL, "func_96m_ck", "func_96m_ck"),
-	DT_CLK(NULL, "func_48m_ck", "func_48m_ck"),
-	DT_CLK(NULL, "func_12m_ck", "func_12m_ck"),
-	DT_CLK(NULL, "sys_clkout_src", "sys_clkout_src"),
-	DT_CLK(NULL, "sys_clkout", "sys_clkout"),
-	DT_CLK(NULL, "emul_ck", "emul_ck"),
-	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
-	DT_CLK(NULL, "dsp_fck", "dsp_fck"),
-	DT_CLK(NULL, "gfx_3d_fck", "gfx_3d_fck"),
-	DT_CLK(NULL, "gfx_2d_fck", "gfx_2d_fck"),
-	DT_CLK(NULL, "gfx_ick", "gfx_ick"),
 	DT_CLK("omapdss_dss", "ick", "dss_ick"),
-	DT_CLK(NULL, "dss_ick", "dss_ick"),
-	DT_CLK(NULL, "dss1_fck", "dss1_fck"),
-	DT_CLK(NULL, "dss2_fck", "dss2_fck"),
-	DT_CLK(NULL, "dss_54m_fck", "dss_54m_fck"),
-	DT_CLK(NULL, "core_l3_ck", "core_l3_ck"),
 	DT_CLK(NULL, "ssi_fck", "ssi_ssr_sst_fck"),
-	DT_CLK(NULL, "usb_l4_ick", "usb_l4_ick"),
-	DT_CLK(NULL, "l4_ck", "l4_ck"),
-	DT_CLK(NULL, "ssi_l4_ick", "ssi_l4_ick"),
-	DT_CLK(NULL, "gpt1_ick", "gpt1_ick"),
-	DT_CLK(NULL, "gpt1_fck", "gpt1_fck"),
-	DT_CLK(NULL, "gpt2_ick", "gpt2_ick"),
-	DT_CLK(NULL, "gpt2_fck", "gpt2_fck"),
-	DT_CLK(NULL, "gpt3_ick", "gpt3_ick"),
-	DT_CLK(NULL, "gpt3_fck", "gpt3_fck"),
-	DT_CLK(NULL, "gpt4_ick", "gpt4_ick"),
-	DT_CLK(NULL, "gpt4_fck", "gpt4_fck"),
-	DT_CLK(NULL, "gpt5_ick", "gpt5_ick"),
-	DT_CLK(NULL, "gpt5_fck", "gpt5_fck"),
-	DT_CLK(NULL, "gpt6_ick", "gpt6_ick"),
-	DT_CLK(NULL, "gpt6_fck", "gpt6_fck"),
-	DT_CLK(NULL, "gpt7_ick", "gpt7_ick"),
-	DT_CLK(NULL, "gpt7_fck", "gpt7_fck"),
-	DT_CLK(NULL, "gpt8_ick", "gpt8_ick"),
-	DT_CLK(NULL, "gpt8_fck", "gpt8_fck"),
-	DT_CLK(NULL, "gpt9_ick", "gpt9_ick"),
-	DT_CLK(NULL, "gpt9_fck", "gpt9_fck"),
-	DT_CLK(NULL, "gpt10_ick", "gpt10_ick"),
-	DT_CLK(NULL, "gpt10_fck", "gpt10_fck"),
-	DT_CLK(NULL, "gpt11_ick", "gpt11_ick"),
-	DT_CLK(NULL, "gpt11_fck", "gpt11_fck"),
-	DT_CLK(NULL, "gpt12_ick", "gpt12_ick"),
-	DT_CLK(NULL, "gpt12_fck", "gpt12_fck"),
 	DT_CLK("omap-mcbsp.1", "ick", "mcbsp1_ick"),
-	DT_CLK(NULL, "mcbsp1_ick", "mcbsp1_ick"),
-	DT_CLK(NULL, "mcbsp1_fck", "mcbsp1_fck"),
 	DT_CLK("omap-mcbsp.2", "ick", "mcbsp2_ick"),
-	DT_CLK(NULL, "mcbsp2_ick", "mcbsp2_ick"),
-	DT_CLK(NULL, "mcbsp2_fck", "mcbsp2_fck"),
 	DT_CLK("omap2_mcspi.1", "ick", "mcspi1_ick"),
-	DT_CLK(NULL, "mcspi1_ick", "mcspi1_ick"),
-	DT_CLK(NULL, "mcspi1_fck", "mcspi1_fck"),
 	DT_CLK("omap2_mcspi.2", "ick", "mcspi2_ick"),
-	DT_CLK(NULL, "mcspi2_ick", "mcspi2_ick"),
-	DT_CLK(NULL, "mcspi2_fck", "mcspi2_fck"),
-	DT_CLK(NULL, "uart1_ick", "uart1_ick"),
-	DT_CLK(NULL, "uart1_fck", "uart1_fck"),
-	DT_CLK(NULL, "uart2_ick", "uart2_ick"),
-	DT_CLK(NULL, "uart2_fck", "uart2_fck"),
-	DT_CLK(NULL, "uart3_ick", "uart3_ick"),
-	DT_CLK(NULL, "uart3_fck", "uart3_fck"),
-	DT_CLK(NULL, "gpios_ick", "gpios_ick"),
-	DT_CLK(NULL, "gpios_fck", "gpios_fck"),
 	DT_CLK("omap_wdt", "ick", "mpu_wdt_ick"),
-	DT_CLK(NULL, "mpu_wdt_ick", "mpu_wdt_ick"),
-	DT_CLK(NULL, "mpu_wdt_fck", "mpu_wdt_fck"),
-	DT_CLK(NULL, "sync_32k_ick", "sync_32k_ick"),
-	DT_CLK(NULL, "wdt1_ick", "wdt1_ick"),
-	DT_CLK(NULL, "omapctrl_ick", "omapctrl_ick"),
 	DT_CLK("omap24xxcam", "fck", "cam_fck"),
-	DT_CLK(NULL, "cam_fck", "cam_fck"),
 	DT_CLK("omap24xxcam", "ick", "cam_ick"),
-	DT_CLK(NULL, "cam_ick", "cam_ick"),
-	DT_CLK(NULL, "mailboxes_ick", "mailboxes_ick"),
-	DT_CLK(NULL, "wdt4_ick", "wdt4_ick"),
-	DT_CLK(NULL, "wdt4_fck", "wdt4_fck"),
-	DT_CLK(NULL, "mspro_ick", "mspro_ick"),
-	DT_CLK(NULL, "mspro_fck", "mspro_fck"),
-	DT_CLK(NULL, "fac_ick", "fac_ick"),
-	DT_CLK(NULL, "fac_fck", "fac_fck"),
 	DT_CLK("omap_hdq.0", "ick", "hdq_ick"),
-	DT_CLK(NULL, "hdq_ick", "hdq_ick"),
 	DT_CLK("omap_hdq.0", "fck", "hdq_fck"),
-	DT_CLK(NULL, "hdq_fck", "hdq_fck"),
 	DT_CLK("omap_i2c.1", "ick", "i2c1_ick"),
-	DT_CLK(NULL, "i2c1_ick", "i2c1_ick"),
 	DT_CLK("omap_i2c.2", "ick", "i2c2_ick"),
-	DT_CLK(NULL, "i2c2_ick", "i2c2_ick"),
-	DT_CLK(NULL, "gpmc_fck", "gpmc_fck"),
-	DT_CLK(NULL, "sdma_fck", "sdma_fck"),
-	DT_CLK(NULL, "sdma_ick", "sdma_ick"),
-	DT_CLK(NULL, "sdrc_ick", "sdrc_ick"),
-	DT_CLK(NULL, "des_ick", "des_ick"),
 	DT_CLK("omap-sham", "ick", "sha_ick"),
-	DT_CLK(NULL, "sha_ick", "sha_ick"),
 	DT_CLK("omap_rng", "ick", "rng_ick"),
-	DT_CLK(NULL, "rng_ick", "rng_ick"),
 	DT_CLK("omap-aes", "ick", "aes_ick"),
-	DT_CLK(NULL, "aes_ick", "aes_ick"),
-	DT_CLK(NULL, "pka_ick", "pka_ick"),
-	DT_CLK(NULL, "usb_fck", "usb_fck"),
 	DT_CLK(NULL, "timer_32k_ck", "func_32k_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_ck"),
 	DT_CLK(NULL, "timer_ext_ck", "alt_ck"),
@@ -149,62 +45,23 @@ static struct ti_dt_clk omap2xxx_clks[] = {
 };
 
 static struct ti_dt_clk omap2420_clks[] = {
-	DT_CLK(NULL, "sys_clkout2_src", "sys_clkout2_src"),
-	DT_CLK(NULL, "sys_clkout2", "sys_clkout2"),
-	DT_CLK(NULL, "dsp_ick", "dsp_ick"),
-	DT_CLK(NULL, "iva1_ifck", "iva1_ifck"),
-	DT_CLK(NULL, "iva1_mpu_int_ifck", "iva1_mpu_int_ifck"),
-	DT_CLK(NULL, "wdt3_ick", "wdt3_ick"),
-	DT_CLK(NULL, "wdt3_fck", "wdt3_fck"),
 	DT_CLK("mmci-omap.0", "ick", "mmc_ick"),
-	DT_CLK(NULL, "mmc_ick", "mmc_ick"),
 	DT_CLK("mmci-omap.0", "fck", "mmc_fck"),
-	DT_CLK(NULL, "mmc_fck", "mmc_fck"),
-	DT_CLK(NULL, "eac_ick", "eac_ick"),
-	DT_CLK(NULL, "eac_fck", "eac_fck"),
-	DT_CLK(NULL, "i2c1_fck", "i2c1_fck"),
-	DT_CLK(NULL, "i2c2_fck", "i2c2_fck"),
-	DT_CLK(NULL, "vlynq_ick", "vlynq_ick"),
-	DT_CLK(NULL, "vlynq_fck", "vlynq_fck"),
 	DT_CLK("musb-hdrc", "fck", "osc_ck"),
 	{ .node_name = NULL },
 };
 
 static struct ti_dt_clk omap2430_clks[] = {
 	DT_CLK("twl", "fck", "osc_ck"),
-	DT_CLK(NULL, "iva2_1_ick", "iva2_1_ick"),
-	DT_CLK(NULL, "mdm_ick", "mdm_ick"),
-	DT_CLK(NULL, "mdm_osc_ck", "mdm_osc_ck"),
 	DT_CLK("omap-mcbsp.3", "ick", "mcbsp3_ick"),
-	DT_CLK(NULL, "mcbsp3_ick", "mcbsp3_ick"),
-	DT_CLK(NULL, "mcbsp3_fck", "mcbsp3_fck"),
 	DT_CLK("omap-mcbsp.4", "ick", "mcbsp4_ick"),
-	DT_CLK(NULL, "mcbsp4_ick", "mcbsp4_ick"),
-	DT_CLK(NULL, "mcbsp4_fck", "mcbsp4_fck"),
 	DT_CLK("omap-mcbsp.5", "ick", "mcbsp5_ick"),
-	DT_CLK(NULL, "mcbsp5_ick", "mcbsp5_ick"),
-	DT_CLK(NULL, "mcbsp5_fck", "mcbsp5_fck"),
 	DT_CLK("omap2_mcspi.3", "ick", "mcspi3_ick"),
-	DT_CLK(NULL, "mcspi3_ick", "mcspi3_ick"),
-	DT_CLK(NULL, "mcspi3_fck", "mcspi3_fck"),
-	DT_CLK(NULL, "icr_ick", "icr_ick"),
-	DT_CLK(NULL, "i2chs1_fck", "i2chs1_fck"),
-	DT_CLK(NULL, "i2chs2_fck", "i2chs2_fck"),
 	DT_CLK("musb-omap2430", "ick", "usbhs_ick"),
-	DT_CLK(NULL, "usbhs_ick", "usbhs_ick"),
 	DT_CLK("omap_hsmmc.0", "ick", "mmchs1_ick"),
-	DT_CLK(NULL, "mmchs1_ick", "mmchs1_ick"),
-	DT_CLK(NULL, "mmchs1_fck", "mmchs1_fck"),
 	DT_CLK("omap_hsmmc.1", "ick", "mmchs2_ick"),
-	DT_CLK(NULL, "mmchs2_ick", "mmchs2_ick"),
-	DT_CLK(NULL, "mmchs2_fck", "mmchs2_fck"),
-	DT_CLK(NULL, "gpio5_ick", "gpio5_ick"),
-	DT_CLK(NULL, "gpio5_fck", "gpio5_fck"),
-	DT_CLK(NULL, "mdm_intc_ick", "mdm_intc_ick"),
 	DT_CLK("omap_hsmmc.0", "mmchsdb_fck", "mmchsdb1_fck"),
-	DT_CLK(NULL, "mmchsdb1_fck", "mmchsdb1_fck"),
 	DT_CLK("omap_hsmmc.1", "mmchsdb_fck", "mmchsdb2_fck"),
-	DT_CLK(NULL, "mmchsdb2_fck", "mmchsdb2_fck"),
 	{ .node_name = NULL },
 };
 
@@ -239,10 +96,10 @@ static int __init omap2xxx_dt_clk_init(int soc_type)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(clk_get_sys(NULL, "sys_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "sys_ck")) / 100000) % 10,
-		(clk_get_rate(clk_get_sys(NULL, "dpll_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "mpu_ck")) / 1000000));
+		(clk_get_rate(ti_clk_get("sys_ck")) / 1000000),
+		(clk_get_rate(ti_clk_get("sys_ck")) / 100000) % 10,
+		(clk_get_rate(ti_clk_get("dpll_ck")) / 1000000),
+		(clk_get_rate(ti_clk_get("mpu_ck")) / 1000000));
 
 	return 0;
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
