From: Charulatha V <charu@ti.com>
Subject: [PATCH:v4 10/13] OMAP: GPIO: Add gpio dev_attr and correct clks in OMAP4 hwmod struct
Date: Tue, 22 Jun 2010 20:31:53 +0530
Message-ID: <1277218916-15213-11-git-send-email-charu@ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
 <1277218916-15213-2-git-send-email-charu@ti.com>
 <1277218916-15213-3-git-send-email-charu@ti.com>
 <1277218916-15213-4-git-send-email-charu@ti.com>
 <1277218916-15213-5-git-send-email-charu@ti.com>
 <1277218916-15213-6-git-send-email-charu@ti.com>
 <1277218916-15213-7-git-send-email-charu@ti.com>
 <1277218916-15213-8-git-send-email-charu@ti.com>
 <1277218916-15213-9-git-send-email-charu@ti.com>
 <1277218916-15213-10-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33379 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758684Ab0FVPBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 11:01:31 -0400
In-Reply-To: <1277218916-15213-10-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com, Charulatha V <charu@ti.com>

This patch adds gpio_dev_attr to OMAP4 gpio hwmod structure. This patch
also corrects the gpio .main_clk and .clk fields in gpio hwmod structures.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   31 +++++++++++++++++----------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 20f5f8c..003d7b2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1272,6 +1273,11 @@ static struct omap_hwmod omap44xx_fdif_hwmod = {
  * general purpose io module
  */
 
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.gpio_bank_width = 32,
+	.dbck_flag = true,
+};
+
 static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
@@ -1285,6 +1291,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
 	.name = "gpio",
 	.sysc = &omap44xx_gpio_sysc,
+	.rev = 2,
 };
 
 /* gpio1 */
@@ -1305,7 +1312,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_gpio1_hwmod,
-	.clk		= "l4_wkup_clk_mux_ck",
+	.clk		= "gpio1_ick",
 	.addr		= omap44xx_gpio1_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1325,7 +1332,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
-	.main_clk	= "gpio1_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
@@ -1333,6 +1339,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	},
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio1_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1356,7 +1363,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio2_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio2_ick",
 	.addr		= omap44xx_gpio2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio2_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1376,7 +1383,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
-	.main_clk	= "gpio2_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
@@ -1384,6 +1390,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	},
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio2_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1407,7 +1414,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio3_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio3_ick",
 	.addr		= omap44xx_gpio3_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio3_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1427,7 +1434,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
-	.main_clk	= "gpio3_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
@@ -1435,6 +1441,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	},
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio3_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1458,7 +1465,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio4_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio4_ick",
 	.addr		= omap44xx_gpio4_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio4_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1478,7 +1485,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
-	.main_clk	= "gpio4_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
@@ -1486,6 +1492,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	},
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio4_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1509,7 +1516,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio5_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio5_ick",
 	.addr		= omap44xx_gpio5_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio5_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1529,7 +1536,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
-	.main_clk	= "gpio5_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
@@ -1537,6 +1543,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	},
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio5_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1560,7 +1567,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio6_hwmod,
-	.clk		= "l4_div_ck",
+	.clk		= "gpio6_ick",
 	.addr		= omap44xx_gpio6_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio6_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1580,7 +1587,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.mpu_irqs	= omap44xx_gpio6_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
-	.main_clk	= "gpio6_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
@@ -1588,6 +1594,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	},
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt = ARRAY_SIZE(gpio6_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.6.3.3

