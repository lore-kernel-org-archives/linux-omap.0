From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: hwmod: remove OMAP_CHIP*
Date: Sun, 4 Sep 2011 20:43:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57763 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1IECnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 22:43:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


At Tony's request, remove the OMAP_CHIP* flags from the hwmod data, and
replace it instead with chip family, variant, and ES level-specific lists
of hwmods to register.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |   37 ------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |   45 -------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  172 +++++++++++++-------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   82 ------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 6 files changed, 88 insertions(+), 253 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..d7138070 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1954,9 +1954,6 @@ int __init omap_hwmod_register(struct omap_hwmod **ohs)
 
 	i = 0;
 	do {
-		if (!omap_chip_is(ohs[i]->omap_chip))
-			continue;
-
 		r = _register(ohs[i]);
 		WARN(r, "omap_hwmod: %s: _register returned %d\n", ohs[i]->name,
 		     r);
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a015c69..b6ea69a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -100,7 +100,6 @@ static struct omap_hwmod omap2420_l3_main_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l3_main_masters),
 	.slaves		= omap2420_l3_main_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_main_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -206,7 +205,6 @@ static struct omap_hwmod omap2420_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_core_masters),
 	.slaves		= omap2420_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -227,7 +225,6 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2420_l4_wkup_masters),
 	.slaves		= omap2420_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -243,7 +240,6 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
 	.main_clk	= "mpu_ck",
 	.masters	= omap2420_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_mpu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /*
@@ -271,7 +267,6 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.class		= &iva_hwmod_class,
 	.masters	= omap2420_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_iva_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer1 */
@@ -317,7 +312,6 @@ static struct omap_hwmod omap2420_timer1_hwmod = {
 	.slaves		= omap2420_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer1_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer2 */
@@ -354,7 +348,6 @@ static struct omap_hwmod omap2420_timer2_hwmod = {
 	.slaves		= omap2420_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer2_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer3 */
@@ -391,7 +384,6 @@ static struct omap_hwmod omap2420_timer3_hwmod = {
 	.slaves		= omap2420_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer3_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer4 */
@@ -428,7 +420,6 @@ static struct omap_hwmod omap2420_timer4_hwmod = {
 	.slaves		= omap2420_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer4_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer5 */
@@ -465,7 +456,6 @@ static struct omap_hwmod omap2420_timer5_hwmod = {
 	.slaves		= omap2420_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer5_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 
@@ -503,7 +493,6 @@ static struct omap_hwmod omap2420_timer6_hwmod = {
 	.slaves		= omap2420_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer6_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer7 */
@@ -540,7 +529,6 @@ static struct omap_hwmod omap2420_timer7_hwmod = {
 	.slaves		= omap2420_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer7_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer8 */
@@ -577,7 +565,6 @@ static struct omap_hwmod omap2420_timer8_hwmod = {
 	.slaves		= omap2420_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer8_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer9 */
@@ -614,7 +601,6 @@ static struct omap_hwmod omap2420_timer9_hwmod = {
 	.slaves		= omap2420_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer9_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer10 */
@@ -651,7 +637,6 @@ static struct omap_hwmod omap2420_timer10_hwmod = {
 	.slaves		= omap2420_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer10_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer11 */
@@ -688,7 +673,6 @@ static struct omap_hwmod omap2420_timer11_hwmod = {
 	.slaves		= omap2420_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer11_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* timer12 */
@@ -725,7 +709,6 @@ static struct omap_hwmod omap2420_timer12_hwmod = {
 	.slaves		= omap2420_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_timer12_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
 /* l4_wkup -> wd_timer2 */
@@ -766,7 +749,6 @@ static struct omap_hwmod omap2420_wd_timer2_hwmod = {
 	},
 	.slaves		= omap2420_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* UART1 */
@@ -792,7 +774,6 @@ static struct omap_hwmod omap2420_uart1_hwmod = {
 	.slaves		= omap2420_uart1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_uart1_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* UART2 */
@@ -818,7 +799,6 @@ static struct omap_hwmod omap2420_uart2_hwmod = {
 	.slaves		= omap2420_uart2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_uart2_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* UART3 */
@@ -844,7 +824,6 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
 	.slaves		= omap2420_uart3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_uart3_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* dss */
@@ -898,7 +877,6 @@ static struct omap_hwmod omap2420_dss_core_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_slaves),
 	.masters	= omap2420_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_dss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -938,7 +916,6 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod = {
 	},
 	.slaves		= omap2420_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_dispc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -975,7 +952,6 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 	},
 	.slaves		= omap2420_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1013,7 +989,6 @@ static struct omap_hwmod omap2420_dss_venc_hwmod = {
 	},
 	.slaves		= omap2420_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_venc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1064,7 +1039,6 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_i2c1_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_16BIT_REG,
 };
 
@@ -1092,7 +1066,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_i2c2_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_16BIT_REG,
 };
 
@@ -1197,7 +1170,6 @@ static struct omap_hwmod omap2420_gpio1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio1_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* gpio2 */
@@ -1223,7 +1195,6 @@ static struct omap_hwmod omap2420_gpio2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio2_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* gpio3 */
@@ -1249,7 +1220,6 @@ static struct omap_hwmod omap2420_gpio3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio3_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* gpio4 */
@@ -1275,7 +1245,6 @@ static struct omap_hwmod omap2420_gpio4_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio4_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* dma attributes */
@@ -1322,7 +1291,6 @@ static struct omap_hwmod omap2420_dma_system_hwmod = {
 	.masters	= omap2420_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_dma_system_masters),
 	.dev_attr	= &dma_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1363,7 +1331,6 @@ static struct omap_hwmod omap2420_mailbox_hwmod = {
 	},
 	.slaves		= omap2420_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mailbox_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* mcspi1 */
@@ -1393,7 +1360,6 @@ static struct omap_hwmod omap2420_mcspi1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mcspi1_slaves),
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* mcspi2 */
@@ -1423,7 +1389,6 @@ static struct omap_hwmod omap2420_mcspi2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mcspi2_slaves),
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /*
@@ -1473,7 +1438,6 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 	},
 	.slaves		= omap2420_mcbsp1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mcbsp1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 /* mcbsp2 */
@@ -1514,7 +1478,6 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	},
 	.slaves		= omap2420_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mcbsp2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 408193d..56de8d6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -110,7 +110,6 @@ static struct omap_hwmod omap2430_l3_main_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l3_main_masters),
 	.slaves		= omap2430_l3_main_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_main_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -250,7 +249,6 @@ static struct omap_hwmod omap2430_l4_core_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_core_masters),
 	.slaves		= omap2430_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -301,7 +299,6 @@ static struct omap_hwmod omap2430_l4_wkup_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap2430_l4_wkup_masters),
 	.slaves		= omap2430_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -317,7 +314,6 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 	.main_clk	= "mpu_ck",
 	.masters	= omap2430_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_mpu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /*
@@ -345,7 +341,6 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.class		= &iva_hwmod_class,
 	.masters	= omap2430_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_iva_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer1 */
@@ -391,7 +386,6 @@ static struct omap_hwmod omap2430_timer1_hwmod = {
 	.slaves		= omap2430_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer1_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer2 */
@@ -428,7 +422,6 @@ static struct omap_hwmod omap2430_timer2_hwmod = {
 	.slaves		= omap2430_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer2_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer3 */
@@ -465,7 +458,6 @@ static struct omap_hwmod omap2430_timer3_hwmod = {
 	.slaves		= omap2430_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer3_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer4 */
@@ -502,7 +494,6 @@ static struct omap_hwmod omap2430_timer4_hwmod = {
 	.slaves		= omap2430_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer4_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer5 */
@@ -539,7 +530,6 @@ static struct omap_hwmod omap2430_timer5_hwmod = {
 	.slaves		= omap2430_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer5_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer6 */
@@ -576,7 +566,6 @@ static struct omap_hwmod omap2430_timer6_hwmod = {
 	.slaves		= omap2430_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer6_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer7 */
@@ -613,7 +602,6 @@ static struct omap_hwmod omap2430_timer7_hwmod = {
 	.slaves		= omap2430_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer7_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer8 */
@@ -650,7 +638,6 @@ static struct omap_hwmod omap2430_timer8_hwmod = {
 	.slaves		= omap2430_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer8_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer9 */
@@ -687,7 +674,6 @@ static struct omap_hwmod omap2430_timer9_hwmod = {
 	.slaves		= omap2430_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer9_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer10 */
@@ -724,7 +710,6 @@ static struct omap_hwmod omap2430_timer10_hwmod = {
 	.slaves		= omap2430_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer10_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer11 */
@@ -761,7 +746,6 @@ static struct omap_hwmod omap2430_timer11_hwmod = {
 	.slaves		= omap2430_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer11_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* timer12 */
@@ -798,7 +782,6 @@ static struct omap_hwmod omap2430_timer12_hwmod = {
 	.slaves		= omap2430_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_timer12_slaves),
 	.class		= &omap2xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /* l4_wkup -> wd_timer2 */
@@ -839,7 +822,6 @@ static struct omap_hwmod omap2430_wd_timer2_hwmod = {
 	},
 	.slaves		= omap2430_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* UART1 */
@@ -865,7 +847,6 @@ static struct omap_hwmod omap2430_uart1_hwmod = {
 	.slaves		= omap2430_uart1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_uart1_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* UART2 */
@@ -891,7 +872,6 @@ static struct omap_hwmod omap2430_uart2_hwmod = {
 	.slaves		= omap2430_uart2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_uart2_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* UART3 */
@@ -917,7 +897,6 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
 	.slaves		= omap2430_uart3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_uart3_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* dss */
@@ -965,7 +944,6 @@ static struct omap_hwmod omap2430_dss_core_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_slaves),
 	.masters	= omap2430_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_dss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -999,7 +977,6 @@ static struct omap_hwmod omap2430_dss_dispc_hwmod = {
 	},
 	.slaves		= omap2430_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_dispc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1030,7 +1007,6 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 	},
 	.slaves		= omap2430_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1062,7 +1038,6 @@ static struct omap_hwmod omap2430_dss_venc_hwmod = {
 	},
 	.slaves		= omap2430_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_venc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1123,7 +1098,6 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c1_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* I2C2 */
@@ -1151,7 +1125,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c2_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* l4_wkup -> gpio1 */
@@ -1273,7 +1246,6 @@ static struct omap_hwmod omap2430_gpio1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio1_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* gpio2 */
@@ -1299,7 +1271,6 @@ static struct omap_hwmod omap2430_gpio2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio2_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* gpio3 */
@@ -1325,7 +1296,6 @@ static struct omap_hwmod omap2430_gpio3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio3_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* gpio4 */
@@ -1351,7 +1321,6 @@ static struct omap_hwmod omap2430_gpio4_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio4_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* gpio5 */
@@ -1382,7 +1351,6 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio5_slaves),
 	.class		= &omap2xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* dma attributes */
@@ -1429,7 +1397,6 @@ static struct omap_hwmod omap2430_dma_system_hwmod = {
 	.masters	= omap2430_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_dma_system_masters),
 	.dev_attr	= &dma_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1469,7 +1436,6 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 	},
 	.slaves		= omap2430_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mailbox_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcspi1 */
@@ -1499,7 +1465,6 @@ static struct omap_hwmod omap2430_mcspi1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi1_slaves),
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcspi2 */
@@ -1529,7 +1494,6 @@ static struct omap_hwmod omap2430_mcspi2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi2_slaves),
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcspi3 */
@@ -1572,7 +1536,6 @@ static struct omap_hwmod omap2430_mcspi3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi3_slaves),
 	.class		= &omap2xxx_mcspi_class,
 	.dev_attr	= &omap_mcspi3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /*
@@ -1628,7 +1591,6 @@ static struct omap_hwmod omap2430_usbhsotg_hwmod = {
 	 */
 	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
 				| HWMOD_SWSUP_MSTANDBY,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
 /*
@@ -1689,7 +1651,6 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 	},
 	.slaves		= omap2430_mcbsp1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcbsp1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcbsp2 */
@@ -1731,7 +1692,6 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 	},
 	.slaves		= omap2430_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcbsp2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcbsp3 */
@@ -1783,7 +1743,6 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 	},
 	.slaves		= omap2430_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcbsp3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcbsp4 */
@@ -1841,7 +1800,6 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 	},
 	.slaves		= omap2430_mcbsp4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcbsp4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* mcbsp5 */
@@ -1899,7 +1857,6 @@ static struct omap_hwmod omap2430_mcbsp5_hwmod = {
 	},
 	.slaves		= omap2430_mcbsp5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mcbsp5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* MMC/SD/SDIO common */
@@ -1966,7 +1923,6 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.slaves		= omap2430_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
 	.class		= &omap2430_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* MMC/SD/SDIO2 */
@@ -2010,7 +1966,6 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.slaves		= omap2430_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc2_slaves),
 	.class		= &omap2430_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..59b501c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -156,7 +156,6 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
 	.slaves		= omap3xxx_l3_main_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_main_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -459,7 +458,6 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 	.class		= &l4_hwmod_class,
 	.slaves		= omap3xxx_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -474,7 +472,6 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.class		= &l4_hwmod_class,
 	.slaves		= omap3xxx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -489,7 +486,6 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.class		= &l4_hwmod_class,
 	.slaves		= omap3xxx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -505,7 +501,6 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.main_clk	= "arm_fck",
 	.masters	= omap3xxx_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_mpu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /*
@@ -533,7 +528,6 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.class		= &iva_hwmod_class,
 	.masters	= omap3xxx_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer class */
@@ -613,7 +607,6 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.slaves		= omap3xxx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer1_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer2 */
@@ -659,7 +652,6 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 	.slaves		= omap3xxx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer2_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer3 */
@@ -705,7 +697,6 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 	.slaves		= omap3xxx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer3_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer4 */
@@ -751,7 +742,6 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 	.slaves		= omap3xxx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer4_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer5 */
@@ -797,7 +787,6 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	.slaves		= omap3xxx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer5_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer6 */
@@ -843,7 +832,6 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	.slaves		= omap3xxx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer6_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer7 */
@@ -889,7 +877,6 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	.slaves		= omap3xxx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer7_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer8 */
@@ -935,7 +922,6 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	.slaves		= omap3xxx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer8_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer9 */
@@ -981,7 +967,6 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	.slaves		= omap3xxx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer9_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer10 */
@@ -1018,7 +1003,6 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	.slaves		= omap3xxx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer10_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer11 */
@@ -1055,7 +1039,6 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.slaves		= omap3xxx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer11_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* timer12*/
@@ -1105,7 +1088,6 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	.slaves		= omap3xxx_timer12_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer12_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* l4_wkup -> wd_timer2 */
@@ -1182,7 +1164,6 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 	},
 	.slaves		= omap3xxx_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	/*
 	 * XXX: Use software supervised mode, HW supervised smartidle seems to
 	 * block CORE power domain idle transitions. Maybe a HW bug in wdt2?
@@ -1213,7 +1194,6 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.slaves		= omap3xxx_uart1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart1_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* UART2 */
@@ -1239,7 +1219,6 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.slaves		= omap3xxx_uart2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart2_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* UART3 */
@@ -1265,7 +1244,6 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.slaves		= omap3xxx_uart3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart3_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* UART4 */
@@ -1302,7 +1280,6 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 	.slaves		= omap3xxx_uart4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart4_slaves),
 	.class		= &omap2_uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
 static struct omap_hwmod_class i2c_class = {
@@ -1390,7 +1367,6 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3430es1_dss_slaves),
 	.masters	= omap3xxx_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_dss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1415,8 +1391,6 @@ static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_slaves),
 	.masters	= omap3xxx_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_dss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 |
-				CHIP_IS_OMAP3630ES1 | CHIP_GE_OMAP3630ES1_1),
 };
 
 /* l4_core -> dss_dispc */
@@ -1454,9 +1428,6 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	},
 	.slaves		= omap3xxx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-				CHIP_GE_OMAP3430ES2 | CHIP_IS_OMAP3630ES1 |
-				CHIP_GE_OMAP3630ES1_1),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1518,9 +1489,6 @@ static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	},
 	.slaves		= omap3xxx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-				CHIP_GE_OMAP3430ES2 | CHIP_IS_OMAP3630ES1 |
-				CHIP_GE_OMAP3630ES1_1),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1558,9 +1526,6 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 	},
 	.slaves		= omap3xxx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-				CHIP_GE_OMAP3430ES2 | CHIP_IS_OMAP3630ES1 |
-				CHIP_GE_OMAP3630ES1_1),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1599,9 +1564,6 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 	},
 	.slaves		= omap3xxx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-				CHIP_GE_OMAP3430ES2 | CHIP_IS_OMAP3630ES1 |
-				CHIP_GE_OMAP3630ES1_1),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -1637,7 +1599,6 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c1_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* I2C2 */
@@ -1672,7 +1633,6 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c2_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* I2C3 */
@@ -1718,7 +1678,6 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c3_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* l4_wkup -> gpio1 */
@@ -1880,7 +1839,6 @@ static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio1_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* gpio2 */
@@ -1912,7 +1870,6 @@ static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio2_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* gpio3 */
@@ -1944,7 +1901,6 @@ static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio3_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* gpio4 */
@@ -1976,7 +1932,6 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio4_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* gpio5 */
@@ -2013,7 +1968,6 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio5_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* gpio6 */
@@ -2050,7 +2004,6 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio6_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* dma_system -> L3 */
@@ -2134,7 +2087,6 @@ static struct omap_hwmod omap3xxx_dma_system_hwmod = {
 	.masters	= omap3xxx_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_dma_system_masters),
 	.dev_attr	= &dma_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -2207,7 +2159,6 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcbsp2 */
@@ -2264,7 +2215,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.slaves		= omap3xxx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_slaves),
 	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcbsp3 */
@@ -2321,7 +2271,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.slaves		= omap3xxx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_slaves),
 	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcbsp4 */
@@ -2379,7 +2328,6 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcbsp5 */
@@ -2437,7 +2385,6 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 /* 'mcbsp sidetone' class */
 
@@ -2498,7 +2445,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp2_sidetone_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sidetone_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcbsp3_sidetone */
@@ -2547,7 +2493,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp3_sidetone_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sidetone_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 
@@ -2609,9 +2554,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
-					CHIP_IS_OMAP3430ES3_0 |
-					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2631,7 +2573,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
 /* SR2 */
@@ -2655,9 +2596,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
-					CHIP_IS_OMAP3430ES3_0 |
-					CHIP_IS_OMAP3430ES3_1),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2677,7 +2615,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
 /*
@@ -2745,7 +2682,6 @@ static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 	},
 	.slaves		= omap3xxx_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mailbox_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* l4 core -> mcspi1 interface */
@@ -2843,7 +2779,6 @@ static struct omap_hwmod omap34xx_mcspi1 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi1_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcspi2 */
@@ -2873,7 +2808,6 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi2_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* mcspi3 */
@@ -2916,7 +2850,6 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi3_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* SPI4 */
@@ -2957,7 +2890,6 @@ static struct omap_hwmod omap34xx_mcspi4 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi4_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi4_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /*
@@ -3014,7 +2946,6 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 	 */
 	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
 				| HWMOD_SWSUP_MSTANDBY,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
 /* usb_otg_hs */
@@ -3042,7 +2973,6 @@ static struct omap_hwmod am35xx_usbhsotg_hwmod = {
 	.slaves		= am35xx_usbhsotg_slaves,
 	.slaves_cnt	= ARRAY_SIZE(am35xx_usbhsotg_slaves),
 	.class		= &am35xx_usbotg_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1)
 };
 
 /* MMC/SD/SDIO common */
@@ -3108,7 +3038,6 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 	.slaves		= omap3xxx_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
 	.class		= &omap34xx_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* MMC/SD/SDIO2 */
@@ -3151,7 +3080,6 @@ static struct omap_hwmod omap3xxx_mmc2_hwmod = {
 	.slaves		= omap3xxx_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc2_slaves),
 	.class		= &omap34xx_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 /* MMC/SD/SDIO3 */
@@ -3193,7 +3121,6 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.slaves		= omap3xxx_mmc3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc3_slaves),
 	.class		= &omap34xx_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
@@ -3224,10 +3151,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_uart1_hwmod,
 	&omap3xxx_uart2_hwmod,
 	&omap3xxx_uart3_hwmod,
-	&omap3xxx_uart4_hwmod,
 	/* dss class */
-	&omap3430es1_dss_core_hwmod,
-	&omap3xxx_dss_core_hwmod,
 	&omap3xxx_dss_dispc_hwmod,
 	&omap3xxx_dss_dsi1_hwmod,
 	&omap3xxx_dss_rfbi_hwmod,
@@ -3239,9 +3163,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c3_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
-	&omap36xx_sr1_hwmod,
-	&omap36xx_sr2_hwmod,
-
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
@@ -3272,16 +3193,99 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap34xx_mcspi3,
 	&omap34xx_mcspi4,
 
-	/* usbotg class */
+	NULL,
+};
+
+/* 3430ES1-only hwmods */
+static __initdata struct omap_hwmod *omap3430es1_hwmods[] = {
+	&omap3430es1_dss_core_hwmod,
+	NULL
+};
+
+/* 3430ES2+-only hwmods */
+static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
+	&omap3xxx_dss_core_hwmod,
 	&omap3xxx_usbhsotg_hwmod,
+	NULL
+};
 
-	/* usbotg for am35x */
-	&am35xx_usbhsotg_hwmod,
+/* 34xx-only hwmods (all ES revisions) */
+static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
+	&omap34xx_sr1_hwmod,
+	&omap34xx_sr2_hwmod,
+	NULL
+};
 
-	NULL,
+/* 36xx-only hwmods (all ES revisions) */
+static __initdata struct omap_hwmod *omap36xx_hwmods[] = {
+	&omap3xxx_uart4_hwmod,
+	&omap3xxx_dss_core_hwmod,
+	&omap36xx_sr1_hwmod,
+	&omap36xx_sr2_hwmod,
+	&omap3xxx_usbhsotg_hwmod,
+	NULL
+};
+
+static __initdata struct omap_hwmod *am35xx_hwmods[] = {
+	&omap3xxx_dss_core_hwmod, /* XXX ??? */
+	&am35xx_usbhsotg_hwmod,
+	NULL
 };
 
 int __init omap3xxx_hwmod_init(void)
 {
-	return omap_hwmod_register(omap3xxx_hwmods);
+	int r;
+	struct omap_hwmod **h = NULL;
+
+	/* Register hwmods common to all OMAP3 */
+	r = omap_hwmod_register(omap3xxx_hwmods);
+	if (!r)
+		return r;
+
+	/*
+	 * Register hwmods common to individual OMAP3 families, all
+	 * silicon revisions (e.g., 34xx, or AM3505/3517, or 36xx)
+	 * All possible revisions should be included in this conditional.
+	 */
+	if (omap_rev() == OMAP3430_REV_ES1_0 ||
+	    omap_rev() == OMAP3430_REV_ES2_0 ||
+	    omap_rev() == OMAP3430_REV_ES2_1 ||
+	    omap_rev() == OMAP3430_REV_ES3_0 ||
+	    omap_rev() == OMAP3430_REV_ES3_1 ||
+	    omap_rev() == OMAP3430_REV_ES3_1_2) {
+		h = omap34xx_hwmods;
+	} else if (omap_rev() & OMAP3505_REV(0)) {
+		h = am35xx_hwmods;
+	} else if (omap_rev() == OMAP3630_REV_ES1_0 ||
+		   omap_rev() == OMAP3630_REV_ES1_1 ||
+		   omap_rev() == OMAP3630_REV_ES1_2) {
+		h = omap36xx_hwmods;
+	} else {
+		WARN(1, "OMAP3 hwmod family init: unknown chip type\n");
+		return -EINVAL;
+	};
+
+	r = omap_hwmod_register(h);
+	if (!r)
+		return r;
+
+	/*
+	 * Register hwmods specific to certain ES levels of a
+	 * particular family of silicon (e.g., 34xx ES1.0)
+	 */
+	h = NULL;
+	if (omap_rev() == OMAP3430_REV_ES1_0) {
+		h = omap3430es1_hwmods;
+	} else if (omap_rev() == OMAP3430_REV_ES2_0 ||
+		   omap_rev() == OMAP3430_REV_ES2_1 ||
+		   omap_rev() == OMAP3430_REV_ES3_0 ||
+		   omap_rev() == OMAP3430_REV_ES3_1 ||
+		   omap_rev() == OMAP3430_REV_ES3_1_2) {
+		h = omap3430es2plus_hwmods;
+	};
+
+	if (h)
+		r = omap_hwmod_register(h);
+
+	return r;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..caaf409 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -133,7 +133,6 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.slaves		= omap44xx_dmm_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmm_slaves),
 	.mpu_irqs	= omap44xx_dmm_irqs,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -189,7 +188,6 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
 	},
 	.slaves		= omap44xx_emif_fw_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_emif_fw_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -236,7 +234,6 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	},
 	.slaves		= omap44xx_l3_instr_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_instr_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* l3_main_1 */
@@ -336,7 +333,6 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	},
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* l3_main_2 */
@@ -438,7 +434,6 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	},
 	.slaves		= omap44xx_l3_main_2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* l3_main_3 */
@@ -496,7 +491,6 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 	},
 	.slaves		= omap44xx_l3_main_3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -559,7 +553,6 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	},
 	.slaves		= omap44xx_l4_abe_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_abe_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* l4_cfg */
@@ -588,7 +581,6 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	},
 	.slaves		= omap44xx_l4_cfg_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_cfg_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* l4_per */
@@ -617,7 +609,6 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	},
 	.slaves		= omap44xx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_per_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* l4_wkup */
@@ -646,7 +637,6 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 	},
 	.slaves		= omap44xx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -677,7 +667,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
 	.clkdm_name	= "mpuss_clkdm",
 	.slaves		= omap44xx_mpu_private_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mpu_private_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -828,7 +817,6 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_aess_slaves),
 	.masters	= omap44xx_aess_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_aess_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -856,7 +844,6 @@ static struct omap_hwmod omap44xx_bandgap_hwmod = {
 	},
 	.opt_clks	= bandgap_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(bandgap_opt_clks),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -917,7 +904,6 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	},
 	.slaves		= omap44xx_counter_32k_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_counter_32k_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1005,7 +991,6 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
 	.masters	= omap44xx_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1098,7 +1083,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	},
 	.slaves		= omap44xx_dmic_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1164,7 +1148,6 @@ static struct omap_hwmod omap44xx_dsp_c0_hwmod = {
 			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct omap_hwmod omap44xx_dsp_hwmod = {
@@ -1187,7 +1170,6 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dsp_slaves),
 	.masters	= omap44xx_dsp_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dsp_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1278,7 +1260,6 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_slaves),
 	.masters	= omap44xx_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1381,7 +1362,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1480,7 +1460,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
 	.slaves		= omap44xx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* dss_dsi2 */
@@ -1558,7 +1537,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi2_opt_clks),
 	.slaves		= omap44xx_dss_dsi2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1656,7 +1634,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
 	.slaves		= omap44xx_dss_hdmi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1748,7 +1725,6 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap44xx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1817,7 +1793,6 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	},
 	.slaves		= omap44xx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_venc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -1901,7 +1876,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* gpio2 */
@@ -1957,7 +1931,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* gpio3 */
@@ -2013,7 +1986,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* gpio4 */
@@ -2069,7 +2041,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* gpio5 */
@@ -2125,7 +2096,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* gpio6 */
@@ -2181,7 +2151,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2261,7 +2230,6 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_hsi_slaves),
 	.masters	= omap44xx_hsi_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_hsi_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2345,7 +2313,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* i2c2 */
@@ -2402,7 +2369,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* i2c3 */
@@ -2459,7 +2425,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* i2c4 */
@@ -2516,7 +2481,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
 	.dev_attr	= &i2c_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2577,7 +2541,6 @@ static struct omap_hwmod omap44xx_ipu_c0_hwmod = {
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* Pseudo hwmod for reset control purpose only */
@@ -2593,7 +2556,6 @@ static struct omap_hwmod omap44xx_ipu_c1_hwmod = {
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct omap_hwmod omap44xx_ipu_hwmod = {
@@ -2616,7 +2578,6 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_ipu_slaves),
 	.masters	= omap44xx_ipu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_ipu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2706,7 +2667,6 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_iss_slaves),
 	.masters	= omap44xx_iss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_iss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2781,7 +2741,6 @@ static struct omap_hwmod omap44xx_iva_seq0_hwmod = {
 			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* Pseudo hwmod for reset control purpose only */
@@ -2797,7 +2756,6 @@ static struct omap_hwmod omap44xx_iva_seq1_hwmod = {
 			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct omap_hwmod omap44xx_iva_hwmod = {
@@ -2820,7 +2778,6 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_iva_slaves),
 	.masters	= omap44xx_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_iva_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2890,7 +2847,6 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	},
 	.slaves		= omap44xx_kbd_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_kbd_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -2956,7 +2912,6 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	},
 	.slaves		= omap44xx_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -3051,7 +3006,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mcbsp2 */
@@ -3127,7 +3081,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mcbsp3 */
@@ -3203,7 +3156,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mcbsp4 */
@@ -3258,7 +3210,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -3353,7 +3304,6 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	},
 	.slaves		= omap44xx_mcpdm_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcpdm_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -3442,7 +3392,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.dev_attr	= &mcspi1_dev_attr,
 	.slaves		= omap44xx_mcspi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mcspi2 */
@@ -3505,7 +3454,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.dev_attr	= &mcspi2_dev_attr,
 	.slaves		= omap44xx_mcspi2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mcspi3 */
@@ -3568,7 +3516,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.dev_attr	= &mcspi3_dev_attr,
 	.slaves		= omap44xx_mcspi3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mcspi4 */
@@ -3629,7 +3576,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.dev_attr	= &mcspi4_dev_attr,
 	.slaves		= omap44xx_mcspi4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -3718,7 +3664,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
 	.masters	= omap44xx_mmc1_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc1_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc2 */
@@ -3779,7 +3724,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc2_slaves),
 	.masters	= omap44xx_mmc2_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc2_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc3 */
@@ -3834,7 +3778,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	},
 	.slaves		= omap44xx_mmc3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc4 */
@@ -3890,7 +3833,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	},
 	.slaves		= omap44xx_mmc4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* mmc5 */
@@ -3945,7 +3887,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	},
 	.slaves		= omap44xx_mmc5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -3987,7 +3928,6 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	},
 	.masters	= omap44xx_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mpu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -4063,7 +4003,6 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* smartreflex_iva */
@@ -4112,7 +4051,6 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* smartreflex_mpu */
@@ -4161,7 +4099,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -4224,7 +4161,6 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	},
 	.slaves		= omap44xx_spinlock_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_spinlock_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -4310,7 +4246,6 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	},
 	.slaves		= omap44xx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer2 */
@@ -4358,7 +4293,6 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	},
 	.slaves		= omap44xx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer3 */
@@ -4406,7 +4340,6 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	},
 	.slaves		= omap44xx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer4 */
@@ -4454,7 +4387,6 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	},
 	.slaves		= omap44xx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer5 */
@@ -4521,7 +4453,6 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	},
 	.slaves		= omap44xx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer6 */
@@ -4589,7 +4520,6 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	},
 	.slaves		= omap44xx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer6_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer7 */
@@ -4656,7 +4586,6 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	},
 	.slaves		= omap44xx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer7_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer8 */
@@ -4723,7 +4652,6 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	},
 	.slaves		= omap44xx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer8_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer9 */
@@ -4771,7 +4699,6 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	},
 	.slaves		= omap44xx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer9_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer10 */
@@ -4819,7 +4746,6 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	},
 	.slaves		= omap44xx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer10_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* timer11 */
@@ -4867,7 +4793,6 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	},
 	.slaves		= omap44xx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer11_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -4944,7 +4869,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	},
 	.slaves		= omap44xx_uart1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* uart2 */
@@ -4999,7 +4923,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	},
 	.slaves		= omap44xx_uart2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* uart3 */
@@ -5055,7 +4978,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	},
 	.slaves		= omap44xx_uart3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* uart4 */
@@ -5110,7 +5032,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	},
 	.slaves		= omap44xx_uart4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -5195,7 +5116,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
 	.masters	= omap44xx_usb_otg_hs_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /*
@@ -5266,7 +5186,6 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	},
 	.slaves		= omap44xx_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* wd_timer3 */
@@ -5333,7 +5252,6 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	},
 	.slaves		= omap44xx_wd_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0e329ca..9115aed 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -496,7 +496,6 @@ struct omap_hwmod_class {
  * @_state: internal-use hwmod state
  * @_postsetup_state: internal-use state to leave the hwmod in after _setup()
  * @flags: hwmod flags (documented below)
- * @omap_chip: OMAP chips this hwmod is present on
  * @_lock: spinlock serializing operations on this hwmod
  * @node: list node for hwmod list (internal use)
  *
@@ -545,7 +544,6 @@ struct omap_hwmod {
 	u8				_int_flags;
 	u8				_state;
 	u8				_postsetup_state;
-	const struct omap_chip_id	omap_chip;
 };
 
 int omap_hwmod_register(struct omap_hwmod **ohs);
-- 
1.7.5.4

