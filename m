From: Charulatha V <charu@ti.com>
Subject: [PATCH 08/13 v5] OMAP: GPIO: Add gpio dev_attr and correct clks in OMAP4 hwmod struct
Date: Fri,  6 Aug 2010 18:04:20 +0530
Message-ID: <1281098065-24177-9-git-send-email-charu@ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
 <1281098065-24177-2-git-send-email-charu@ti.com>
 <1281098065-24177-3-git-send-email-charu@ti.com>
 <1281098065-24177-4-git-send-email-charu@ti.com>
 <1281098065-24177-5-git-send-email-charu@ti.com>
 <1281098065-24177-6-git-send-email-charu@ti.com>
 <1281098065-24177-7-git-send-email-charu@ti.com>
 <1281098065-24177-8-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48634 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934476Ab0HFMbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 08:31:47 -0400
In-Reply-To: <1281098065-24177-8-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>

This patch adds gpio_dev_attr to OMAP4 gpio hwmod structure. This patch
also corrects the gpio .main_clk and .clk fields in gpio hwmod structures.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   40 +++++++++++++++++++--------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 20f5f8c..1b066df 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1272,6 +1273,20 @@ static struct omap_hwmod omap44xx_fdif_hwmod = {
  * general purpose io module
  */
 
+/* gpio_dev_attr common for gpio2-6*/
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = true,
+	.off_mode_support = true,
+};
+
+/* gpio_dev_attr for gpio1*/
+static struct omap_gpio_dev_attr gpio1_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = true,
+	.off_mode_support = false,
+};
+
 static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
@@ -1285,6 +1300,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
 	.name = "gpio",
 	.sysc = &omap44xx_gpio_sysc,
+	.rev = 2,
 };
 
 /* gpio1 */
@@ -1305,7 +1321,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_gpio1_hwmod,
-	.clk		= "l4_wkup_clk_mux_ck",
+	.clk		= "gpio1_ick",
 	.addr		= omap44xx_gpio1_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1325,7 +1341,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
-	.main_clk	= "gpio1_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
@@ -1333,6 +1348,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio1_opt_clks),
+	.dev_attr	= &gpio1_dev_attr,
 	.slaves		= omap44xx_gpio1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1356,7 +1372,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio2_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio2_ick",
 	.addr		= omap44xx_gpio2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio2_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1376,7 +1392,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
-	.main_clk	= "gpio2_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
@@ -1384,6 +1399,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio2_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1407,7 +1423,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio3_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio3_ick",
 	.addr		= omap44xx_gpio3_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio3_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1427,7 +1443,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
-	.main_clk	= "gpio3_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
@@ -1435,6 +1450,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	},
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio3_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1458,7 +1474,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio4_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio4_ick",
 	.addr		= omap44xx_gpio4_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio4_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1478,7 +1494,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
-	.main_clk	= "gpio4_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
@@ -1486,6 +1501,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	},
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio4_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1509,7 +1525,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio5_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio5_ick",
 	.addr		= omap44xx_gpio5_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio5_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1529,7 +1545,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
-	.main_clk	= "gpio5_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
@@ -1537,6 +1552,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	},
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio5_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1560,7 +1576,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio6_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio6_ick",
 	.addr		= omap44xx_gpio6_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio6_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1580,7 +1596,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio6_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
-	.main_clk	= "gpio6_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
@@ -1588,6 +1603,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	},
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio6_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.6.3.3

