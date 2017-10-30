From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 24/27] clk: ti: dm814: add clkctrl clock data
Date: Mon, 30 Oct 2017 15:04:42 +0200
Message-ID: <1509368685-29112-25-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Add data for dm814 clkctrl clocks, and register it within the clkctrl
driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-814x.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/clk/ti/clkctrl.c  |  4 ++++
 drivers/clk/ti/clock.h    |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
index 7dab941..f688fdd 100644
--- a/drivers/clk/ti/clk-814x.c
+++ b/drivers/clk/ti/clk-814x.c
@@ -9,9 +9,46 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
 #include <linux/of_platform.h>
+#include <dt-bindings/clock/dm814.h>
 
 #include "clock.h"
 
+static const struct omap_clkctrl_reg_data dm814_default_clkctrl_regs[] __initconst = {
+	{ DM814_USB_OTG_HS_CLKCTRL, NULL, CLKF_SW_SUP, "pll260dcoclkldo" },
+	{ 0 },
+};
+
+static const struct omap_clkctrl_reg_data dm814_alwon_clkctrl_regs[] __initconst = {
+	{ DM814_UART1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM814_UART2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM814_UART3_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM814_GPIO1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM814_GPIO2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM814_I2C1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM814_I2C2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM814_WD_TIMER_CLKCTRL, NULL, CLKF_SW_SUP | CLKF_NO_IDLEST, "sysclk18_ck" },
+	{ DM814_MCSPI1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM814_GPMC_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM814_CPGMAC0_CLKCTRL, NULL, CLKF_SW_SUP, "cpsw_125mhz_gclk" },
+	{ DM814_MPU_CLKCTRL, NULL, CLKF_SW_SUP, "mpu_ck" },
+	{ DM814_RTC_CLKCTRL, NULL, CLKF_SW_SUP | CLKF_NO_IDLEST, "sysclk18_ck" },
+	{ DM814_TPCC_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM814_TPTC0_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM814_TPTC1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM814_TPTC2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM814_TPTC3_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM814_MMC1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk8_ck" },
+	{ DM814_MMC2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk8_ck" },
+	{ DM814_MMC3_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk8_ck" },
+	{ 0 },
+};
+
+const struct omap_clkctrl_data dm814_clkctrl_data[] __initconst = {
+	{ 0x48180500, dm814_default_clkctrl_regs },
+	{ 0x48181400, dm814_alwon_clkctrl_regs },
+	{ 0 },
+};
+
 static struct ti_dt_clk dm814_clks[] = {
 	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
 	{ .node_name = NULL },
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 74d1320..a531a89 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -453,6 +453,10 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	if (of_machine_is_compatible("ti,am4372"))
 		data = am4_clkctrl_data;
 #endif
+#ifdef CONFIG_SOC_TI81XX
+	if (of_machine_is_compatible("ti,dm814"))
+		data = dm814_clkctrl_data;
+#endif
 
 	while (data->addr) {
 		if (addr == data->addr)
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index a42bbb8..60e6794 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -235,6 +235,7 @@ struct omap_clkctrl_data {
 extern const struct omap_clkctrl_data dra7_clkctrl_data[];
 extern const struct omap_clkctrl_data am3_clkctrl_data[];
 extern const struct omap_clkctrl_data am4_clkctrl_data[];
+extern const struct omap_clkctrl_data dm814_clkctrl_data[];
 
 #define CLKF_SW_SUP	BIT(0)
 #define CLKF_HW_SUP	BIT(1)
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
