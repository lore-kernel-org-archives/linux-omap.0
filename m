From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 26/27] clk: ti: dm816: add clkctrl clock data
Date: Mon, 30 Oct 2017 15:04:44 +0200
Message-ID: <1509368685-29112-27-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Add data for dm816 clkctrl clocks, and register it within the clkctrl
driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-816x.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/ti/clkctrl.c  |  3 +++
 drivers/clk/ti/clock.h    |  1 +
 3 files changed, 49 insertions(+)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index ac9c94a..7d215cd 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -13,9 +13,54 @@
 #include <linux/list.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/ti.h>
+#include <dt-bindings/clock/dm816.h>
 
 #include "clock.h"
 
+static const struct omap_clkctrl_reg_data dm816_default_clkctrl_regs[] __initconst = {
+	{ DM816_USB_OTG_HS_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ 0 },
+};
+
+static const struct omap_clkctrl_reg_data dm816_alwon_clkctrl_regs[] __initconst = {
+	{ DM816_UART1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_UART2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_UART3_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_GPIO1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM816_GPIO2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM816_I2C1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_I2C2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_TIMER1_CLKCTRL, NULL, CLKF_SW_SUP, "timer1_fck" },
+	{ DM816_TIMER2_CLKCTRL, NULL, CLKF_SW_SUP, "timer2_fck" },
+	{ DM816_TIMER3_CLKCTRL, NULL, CLKF_SW_SUP, "timer3_fck" },
+	{ DM816_TIMER4_CLKCTRL, NULL, CLKF_SW_SUP, "timer4_fck" },
+	{ DM816_TIMER5_CLKCTRL, NULL, CLKF_SW_SUP, "timer5_fck" },
+	{ DM816_TIMER6_CLKCTRL, NULL, CLKF_SW_SUP, "timer6_fck" },
+	{ DM816_TIMER7_CLKCTRL, NULL, CLKF_SW_SUP, "timer7_fck" },
+	{ DM816_WD_TIMER_CLKCTRL, NULL, CLKF_SW_SUP | CLKF_NO_IDLEST, "sysclk18_ck" },
+	{ DM816_MCSPI1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_MAILBOX_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM816_SPINBOX_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM816_MMC1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk10_ck" },
+	{ DM816_GPMC_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk6_ck" },
+	{ DM816_DAVINCI_MDIO_CLKCTRL, NULL, CLKF_SW_SUP | CLKF_NO_IDLEST, "sysclk24_ck" },
+	{ DM816_EMAC1_CLKCTRL, NULL, CLKF_SW_SUP | CLKF_NO_IDLEST, "sysclk24_ck" },
+	{ DM816_MPU_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk2_ck" },
+	{ DM816_RTC_CLKCTRL, NULL, CLKF_SW_SUP | CLKF_NO_IDLEST, "sysclk18_ck" },
+	{ DM816_TPCC_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM816_TPTC0_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM816_TPTC1_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM816_TPTC2_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ DM816_TPTC3_CLKCTRL, NULL, CLKF_SW_SUP, "sysclk4_ck" },
+	{ 0 },
+};
+
+const struct omap_clkctrl_data dm816_clkctrl_data[] __initconst = {
+	{ 0x48180500, dm816_default_clkctrl_regs },
+	{ 0x48181400, dm816_alwon_clkctrl_regs },
+	{ 0 },
+};
+
 static struct ti_dt_clk dm816x_clks[] = {
 	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index a531a89..75aa4de 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -456,6 +456,9 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 #ifdef CONFIG_SOC_TI81XX
 	if (of_machine_is_compatible("ti,dm814"))
 		data = dm814_clkctrl_data;
+
+	if (of_machine_is_compatible("ti,dm816"))
+		data = dm816_clkctrl_data;
 #endif
 
 	while (data->addr) {
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 60e6794..c560254 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -236,6 +236,7 @@ struct omap_clkctrl_data {
 extern const struct omap_clkctrl_data am3_clkctrl_data[];
 extern const struct omap_clkctrl_data am4_clkctrl_data[];
 extern const struct omap_clkctrl_data dm814_clkctrl_data[];
+extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
 #define CLKF_SW_SUP	BIT(0)
 #define CLKF_HW_SUP	BIT(1)
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
