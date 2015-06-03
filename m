From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] ARM: OMAP2+: Prepare dm81xx hwmod code for adding minimal dm814x support
Date: Wed,  3 Jun 2015 09:23:15 -0700
Message-ID: <1433348601-8966-7-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:13340 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757790AbbFCQXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:53 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Paul Walmsley <paul@pwsan.com>

Let's change the defines so we can share the hwmod code better between
dm816x and dm814x, and let's add the dm814x specific defines. And let's
rename the shared ones to start with dm81xx. No functional changes.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 406 +++++++++++++++--------------
 1 file changed, 213 insertions(+), 193 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index cab1eb6..67a3d50 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -32,21 +32,59 @@
  */
 
 /*
- * The alwon .clkctrl_offs field is offset from the CM_ALWON, that's
- * TRM 18.7.17 CM_ALWON device register values minus 0x1400.
+ * Common alwon .clkctrl_offs from dm814x TRM "Table 2-278. CM_ALWON REGISTERS"
+ * also dm816x TRM 18.7.17 CM_ALWON device register values minus 0x1400.
  */
+#define DM81XX_CM_ALWON_MCASP0_CLKCTRL		0x140
+#define DM81XX_CM_ALWON_MCASP1_CLKCTRL		0x144
+#define DM81XX_CM_ALWON_MCASP2_CLKCTRL		0x148
+#define DM81XX_CM_ALWON_MCBSP_CLKCTRL		0x14c
+#define DM81XX_CM_ALWON_UART_0_CLKCTRL		0x150
+#define DM81XX_CM_ALWON_UART_1_CLKCTRL		0x154
+#define DM81XX_CM_ALWON_UART_2_CLKCTRL		0x158
+#define DM81XX_CM_ALWON_GPIO_0_CLKCTRL		0x15c
+#define DM81XX_CM_ALWON_GPIO_1_CLKCTRL		0x160
+#define DM81XX_CM_ALWON_I2C_0_CLKCTRL		0x164
+#define DM81XX_CM_ALWON_I2C_1_CLKCTRL		0x168
+#define DM81XX_CM_ALWON_WDTIMER_CLKCTRL		0x18c
+#define DM81XX_CM_ALWON_SPI_CLKCTRL		0x190
+#define DM81XX_CM_ALWON_MAILBOX_CLKCTRL		0x194
+#define DM81XX_CM_ALWON_SPINBOX_CLKCTRL		0x198
+#define DM81XX_CM_ALWON_MMUDATA_CLKCTRL		0x19c
+#define DM81XX_CM_ALWON_MMUCFG_CLKCTRL		0x1a8
+#define DM81XX_CM_ALWON_CONTROL_CLKCTRL		0x1c4
+#define DM81XX_CM_ALWON_GPMC_CLKCTRL		0x1d0
+#define DM81XX_CM_ALWON_ETHERNET_0_CLKCTRL	0x1d4
+#define DM81XX_CM_ALWON_L3_CLKCTRL		0x1e4
+#define DM81XX_CM_ALWON_L4HS_CLKCTRL		0x1e8
+#define DM81XX_CM_ALWON_L4LS_CLKCTRL		0x1ec
+#define DM81XX_CM_ALWON_RTC_CLKCTRL		0x1f0
+#define DM81XX_CM_ALWON_TPCC_CLKCTRL		0x1f4
+#define DM81XX_CM_ALWON_TPTC0_CLKCTRL		0x1f8
+#define DM81XX_CM_ALWON_TPTC1_CLKCTRL		0x1fc
+#define DM81XX_CM_ALWON_TPTC2_CLKCTRL		0x200
+#define DM81XX_CM_ALWON_TPTC3_CLKCTRL		0x204
+
+/* Registers specific to dm814x */
+#define DM814X_CM_ALWON_MCASP_3_4_5_CLKCTRL	0x16c
+#define DM814X_CM_ALWON_ATL_CLKCTRL		0x170
+#define DM814X_CM_ALWON_MLB_CLKCTRL		0x174
+#define DM814X_CM_ALWON_PATA_CLKCTRL		0x178
+#define DM814X_CM_ALWON_UART_3_CLKCTRL		0x180
+#define DM814X_CM_ALWON_UART_4_CLKCTRL		0x184
+#define DM814X_CM_ALWON_UART_5_CLKCTRL		0x188
+#define DM814X_CM_ALWON_OCM_0_CLKCTRL		0x1b4
+#define DM814X_CM_ALWON_VCP_CLKCTRL		0x1b8
+#define DM814X_CM_ALWON_MPU_CLKCTRL		0x1dc
+#define DM814X_CM_ALWON_DEBUGSS_CLKCTRL		0x1e0
+#define DM814X_CM_ALWON_DCAN_0_1_CLKCTRL	0x218
+#define DM814X_CM_ALWON_MMCHS_0_CLKCTRL		0x21c
+#define DM814X_CM_ALWON_MMCHS_1_CLKCTRL		0x220
+#define DM814X_CM_ALWON_MMCHS_2_CLKCTRL		0x224
+#define DM814X_CM_ALWON_CUST_EFUSE_CLKCTRL	0x228
+
+/* Registers specific to dm816x */
 #define DM816X_DM_ALWON_BASE		0x1400
-#define DM816X_CM_ALWON_MCASP0_CLKCTRL	(0x1540 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_MCASP1_CLKCTRL	(0x1544 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_MCASP2_CLKCTRL	(0x1548 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_MCBSP_CLKCTRL	(0x154c - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_UART_0_CLKCTRL	(0x1550 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_UART_1_CLKCTRL	(0x1554 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_UART_2_CLKCTRL	(0x1558 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_GPIO_0_CLKCTRL	(0x155c - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_GPIO_1_CLKCTRL	(0x1560 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_I2C_0_CLKCTRL	(0x1564 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_I2C_1_CLKCTRL	(0x1568 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_TIMER_1_CLKCTRL	(0x1570 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_TIMER_2_CLKCTRL	(0x1574 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_TIMER_3_CLKCTRL	(0x1578 - DM816X_DM_ALWON_BASE)
@@ -54,29 +92,11 @@
 #define DM816X_CM_ALWON_TIMER_5_CLKCTRL	(0x1580 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_TIMER_6_CLKCTRL	(0x1584 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_TIMER_7_CLKCTRL	(0x1588 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_WDTIMER_CLKCTRL	(0x158c - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_SPI_CLKCTRL	(0x1590 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_MAILBOX_CLKCTRL	(0x1594 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_SPINBOX_CLKCTRL	(0x1598 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_MMUDATA_CLKCTRL	(0x159c - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_MMUCFG_CLKCTRL	(0x15a8 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_SDIO_CLKCTRL	(0x15b0 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_OCMC_0_CLKCTRL	(0x15b4 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_OCMC_1_CLKCTRL	(0x15b8 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_CONTRL_CLKCTRL	(0x15c4 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_GPMC_CLKCTRL	(0x15d0 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_ETHERNET_0_CLKCTRL (0x15d4 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_ETHERNET_1_CLKCTRL (0x15d8 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_MPU_CLKCTRL	(0x15dc - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_L3_CLKCTRL	(0x15e4 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_L4HS_CLKCTRL	(0x15e8 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_L4LS_CLKCTRL	(0x15ec - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_RTC_CLKCTRL	(0x15f0 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_TPCC_CLKCTRL	(0x15f4 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_TPTC0_CLKCTRL	(0x15f8 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_TPTC1_CLKCTRL	(0x15fc - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_TPTC2_CLKCTRL	(0x1600 - DM816X_DM_ALWON_BASE)
-#define DM816X_CM_ALWON_TPTC3_CLKCTRL	(0x1604 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_SR_0_CLKCTRL	(0x1608 - DM816X_DM_ALWON_BASE)
 #define DM816X_CM_ALWON_SR_1_CLKCTRL	(0x160c - DM816X_DM_ALWON_BASE)
 
@@ -88,28 +108,28 @@
 #define DM816X_CM_DEFAULT_USB_CLKCTRL	(0x558 - DM816X_CM_DEFAULT_OFFSET)
 
 /* L3 Interconnect entries clocked at 125, 250 and 500MHz */
-static struct omap_hwmod dm816x_alwon_l3_slow_hwmod = {
+static struct omap_hwmod dm81xx_alwon_l3_slow_hwmod = {
 	.name		= "alwon_l3_slow",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.class		= &l3_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-static struct omap_hwmod dm816x_default_l3_slow_hwmod = {
+static struct omap_hwmod dm81xx_default_l3_slow_hwmod = {
 	.name		= "default_l3_slow",
 	.clkdm_name	= "default_l3_slow_clkdm",
 	.class		= &l3_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-static struct omap_hwmod dm816x_alwon_l3_med_hwmod = {
+static struct omap_hwmod dm81xx_alwon_l3_med_hwmod = {
 	.name		= "l3_med",
 	.clkdm_name	= "alwon_l3_med_clkdm",
 	.class		= &l3_hwmod_class,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-static struct omap_hwmod dm816x_alwon_l3_fast_hwmod = {
+static struct omap_hwmod dm81xx_alwon_l3_fast_hwmod = {
 	.name		= "l3_fast",
 	.clkdm_name	= "alwon_l3_fast_clkdm",
 	.class		= &l3_hwmod_class,
@@ -120,7 +140,7 @@ static struct omap_hwmod dm816x_alwon_l3_fast_hwmod = {
  * L4 standard peripherals, see TRM table 1-12 for devices using this.
  * See TRM table 1-73 for devices using the 125MHz SYSCLK6 clock.
  */
-static struct omap_hwmod dm816x_l4_ls_hwmod = {
+static struct omap_hwmod dm81xx_l4_ls_hwmod = {
 	.name		= "l4_ls",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.class		= &l4_hwmod_class,
@@ -131,23 +151,23 @@ static struct omap_hwmod dm816x_l4_ls_hwmod = {
  * table 1-13. On dm816x, only EMAC, MDIO and SATA use this. See also TRM
  * table 1-73 for devices using 250MHz SYSCLK5 clock.
  */
-static struct omap_hwmod dm816x_l4_hs_hwmod = {
+static struct omap_hwmod dm81xx_l4_hs_hwmod = {
 	.name		= "l4_hs",
 	.clkdm_name	= "alwon_l3_med_clkdm",
 	.class		= &l4_hwmod_class,
 };
 
 /* L3 slow -> L4 ls peripheral interface running at 125MHz */
-static struct omap_hwmod_ocp_if dm816x_alwon_l3_slow__l4_ls = {
-	.master	= &dm816x_alwon_l3_slow_hwmod,
-	.slave	= &dm816x_l4_ls_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__l4_ls = {
+	.master	= &dm81xx_alwon_l3_slow_hwmod,
+	.slave	= &dm81xx_l4_ls_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
 /* L3 med -> L4 fast peripheral interface running at 250MHz */
-static struct omap_hwmod_ocp_if dm816x_alwon_l3_slow__l4_hs = {
-	.master	= &dm816x_alwon_l3_med_hwmod,
-	.slave	= &dm816x_l4_hs_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__l4_hs = {
+	.master	= &dm81xx_alwon_l3_med_hwmod,
+	.slave	= &dm81xx_l4_hs_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
@@ -168,14 +188,14 @@ static struct omap_hwmod dm816x_mpu_hwmod = {
 
 static struct omap_hwmod_ocp_if dm816x_mpu__alwon_l3_slow = {
 	.master		= &dm816x_mpu_hwmod,
-	.slave		= &dm816x_alwon_l3_slow_hwmod,
+	.slave		= &dm81xx_alwon_l3_slow_hwmod,
 	.user		= OCP_USER_MPU,
 };
 
 /* L3 med peripheral interface running at 250MHz */
 static struct omap_hwmod_ocp_if dm816x_mpu__alwon_l3_med = {
 	.master	= &dm816x_mpu_hwmod,
-	.slave	= &dm816x_alwon_l3_med_hwmod,
+	.slave	= &dm81xx_alwon_l3_med_hwmod,
 	.user	= OCP_USER_MPU,
 };
 
@@ -197,13 +217,13 @@ static struct omap_hwmod_class uart_class = {
 	.sysc = &uart_sysc,
 };
 
-static struct omap_hwmod dm816x_uart1_hwmod = {
+static struct omap_hwmod dm81xx_uart1_hwmod = {
 	.name		= "uart1",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_UART_0_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_UART_0_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -211,20 +231,20 @@ static struct omap_hwmod dm816x_uart1_hwmod = {
 	.flags		= DEBUG_TI81XXUART1_FLAGS,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__uart1 = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_uart1_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__uart1 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_uart1_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod dm816x_uart2_hwmod = {
+static struct omap_hwmod dm81xx_uart2_hwmod = {
 	.name		= "uart2",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_UART_1_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_UART_1_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -232,20 +252,20 @@ static struct omap_hwmod dm816x_uart2_hwmod = {
 	.flags		= DEBUG_TI81XXUART2_FLAGS,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__uart2 = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_uart2_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__uart2 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_uart2_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod dm816x_uart3_hwmod = {
+static struct omap_hwmod dm81xx_uart3_hwmod = {
 	.name		= "uart3",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_UART_2_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_UART_2_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -253,9 +273,9 @@ static struct omap_hwmod dm816x_uart3_hwmod = {
 	.flags		= DEBUG_TI81XXUART3_FLAGS,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__uart3 = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_uart3_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__uart3 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_uart3_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
@@ -276,23 +296,23 @@ static struct omap_hwmod_class wd_timer_class = {
 	.reset		= &omap2_wd_timer_reset,
 };
 
-static struct omap_hwmod dm816x_wd_timer_hwmod = {
+static struct omap_hwmod dm81xx_wd_timer_hwmod = {
 	.name		= "wd_timer",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk18_ck",
 	.flags		= HWMOD_NO_IDLEST,
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_WDTIMER_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_WDTIMER_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
 	.class		= &wd_timer_class,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__wd_timer1 = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_wd_timer_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__wd_timer1 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_wd_timer_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
@@ -320,27 +340,27 @@ static struct omap_hwmod dm81xx_i2c1_hwmod = {
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_I2C_0_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_I2C_0_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
 	.class		= &i2c_class,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__i2c1 = {
-	.master		= &dm816x_l4_ls_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__i2c1 = {
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_i2c1_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod dm816x_i2c2_hwmod = {
+static struct omap_hwmod dm81xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_I2C_1_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_I2C_1_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -358,9 +378,9 @@ static struct omap_hwmod_class_sysconfig dm81xx_elm_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__i2c2 = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_i2c2_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__i2c2 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_i2c2_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
@@ -378,7 +398,7 @@ static struct omap_hwmod dm81xx_elm_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__elm = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_elm_hwmod,
 	.user		= OCP_USER_MPU,
 };
@@ -417,7 +437,7 @@ static struct omap_hwmod dm81xx_gpio1_hwmod = {
 	.main_clk	= "sysclk6_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_GPIO_0_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_GPIO_0_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -427,7 +447,7 @@ static struct omap_hwmod dm81xx_gpio1_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio1 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_gpio1_hwmod,
 	.user		= OCP_USER_MPU,
 };
@@ -443,7 +463,7 @@ static struct omap_hwmod dm81xx_gpio2_hwmod = {
 	.main_clk	= "sysclk6_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_GPIO_1_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_GPIO_1_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -453,7 +473,7 @@ static struct omap_hwmod dm81xx_gpio2_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm81xx_l4_ls__gpio2 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm81xx_gpio2_hwmod,
 	.user		= OCP_USER_MPU,
 };
@@ -480,14 +500,14 @@ static struct omap_hwmod dm81xx_gpmc_hwmod = {
 	.main_clk	= "sysclk6_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_GPMC_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_GPMC_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
 };
 
 struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__gpmc = {
-	.master		= &dm816x_alwon_l3_slow_hwmod,
+	.master		= &dm81xx_alwon_l3_slow_hwmod,
 	.slave		= &dm81xx_gpmc_hwmod,
 	.user		= OCP_USER_MPU,
 };
@@ -520,7 +540,7 @@ static struct omap_hwmod dm81xx_usbss_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm81xx_default_l3_slow__usbss = {
-	.master		= &dm816x_default_l3_slow_hwmod,
+	.master		= &dm81xx_default_l3_slow_hwmod,
 	.slave		= &dm81xx_usbss_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -560,7 +580,7 @@ static struct omap_hwmod dm816x_timer1_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer1 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer1_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -581,7 +601,7 @@ static struct omap_hwmod dm816x_timer2_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer2 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer2_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -602,7 +622,7 @@ static struct omap_hwmod dm816x_timer3_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer3 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer3_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -623,7 +643,7 @@ static struct omap_hwmod dm816x_timer4_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer4 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer4_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -644,7 +664,7 @@ static struct omap_hwmod dm816x_timer5_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer5 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer5_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -665,7 +685,7 @@ static struct omap_hwmod dm816x_timer6_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer6 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer6_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -686,7 +706,7 @@ static struct omap_hwmod dm816x_timer7_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__timer7 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_timer7_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -715,21 +735,21 @@ static struct omap_hwmod dm816x_emac0_hwmod = {
 	.class		= &dm816x_emac_hwmod_class,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_hs__emac0 = {
-	.master		= &dm816x_l4_hs_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_hs__emac0 = {
+	.master		= &dm81xx_l4_hs_hwmod,
 	.slave		= &dm816x_emac0_hwmod,
 	.clk		= "sysclk5_ck",
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_class dm816x_mdio_hwmod_class = {
+static struct omap_hwmod_class dm81xx_mdio_hwmod_class = {
 	.name		= "davinci_mdio",
 	.sysc		= &dm816x_emac_sysc,
 };
 
-struct omap_hwmod dm816x_emac0_mdio_hwmod = {
+struct omap_hwmod dm81xx_emac0_mdio_hwmod = {
 	.name		= "davinci_mdio",
-	.class		= &dm816x_mdio_hwmod_class,
+	.class		= &dm81xx_mdio_hwmod_class,
 	.clkdm_name	= "alwon_ethernet_clkdm",
 	.main_clk	= "sysclk24_ck",
 	.flags		= HWMOD_NO_IDLEST,
@@ -739,15 +759,15 @@ struct omap_hwmod dm816x_emac0_mdio_hwmod = {
 	 */
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_ETHERNET_0_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_ETHERNET_0_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_emac0__mdio = {
-	.master		= &dm816x_l4_hs_hwmod,
-	.slave		= &dm816x_emac0_mdio_hwmod,
+struct omap_hwmod_ocp_if dm81xx_emac0__mdio = {
+	.master		= &dm81xx_l4_hs_hwmod,
+	.slave		= &dm81xx_emac0_mdio_hwmod,
 	.user		= OCP_USER_MPU,
 };
 
@@ -766,7 +786,7 @@ static struct omap_hwmod dm816x_emac1_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_hs__emac1 = {
-	.master		= &dm816x_l4_hs_hwmod,
+	.master		= &dm81xx_l4_hs_hwmod,
 	.slave		= &dm816x_emac1_hwmod,
 	.clk		= "sysclk5_ck",
 	.user		= OCP_USER_MPU,
@@ -813,7 +833,7 @@ static struct omap_hwmod dm816x_mmc1_hwmod = {
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__mmc1 = {
-	.master		= &dm816x_l4_ls_hwmod,
+	.master		= &dm81xx_l4_ls_hwmod,
 	.slave		= &dm816x_mmc1_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
@@ -841,13 +861,13 @@ static struct omap2_mcspi_dev_attr dm816x_mcspi1_dev_attr = {
 	.num_chipselect = 4,
 };
 
-static struct omap_hwmod dm816x_mcspi1_hwmod = {
+static struct omap_hwmod dm81xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_SPI_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_SPI_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
@@ -855,14 +875,14 @@ static struct omap_hwmod dm816x_mcspi1_hwmod = {
 	.dev_attr	= &dm816x_mcspi1_dev_attr,
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__mcspi1 = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_mcspi1_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__mcspi1 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_mcspi1_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_class_sysconfig dm816x_mailbox_sysc = {
+static struct omap_hwmod_class_sysconfig dm81xx_mailbox_sysc = {
 	.rev_offs	= 0x000,
 	.sysc_offs	= 0x010,
 	.syss_offs	= 0x014,
@@ -872,55 +892,55 @@ static struct omap_hwmod_class_sysconfig dm816x_mailbox_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class dm816x_mailbox_hwmod_class = {
+static struct omap_hwmod_class dm81xx_mailbox_hwmod_class = {
 	.name = "mailbox",
-	.sysc = &dm816x_mailbox_sysc,
+	.sysc = &dm81xx_mailbox_sysc,
 };
 
-static struct omap_hwmod dm816x_mailbox_hwmod = {
+static struct omap_hwmod dm81xx_mailbox_hwmod = {
 	.name		= "mailbox",
 	.clkdm_name	= "alwon_l3s_clkdm",
-	.class		= &dm816x_mailbox_hwmod_class,
+	.class		= &dm81xx_mailbox_hwmod_class,
 	.main_clk	= "sysclk6_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_ALWON_MAILBOX_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_ALWON_MAILBOX_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-static struct omap_hwmod_ocp_if dm816x_l4_ls__mailbox = {
-	.master		= &dm816x_l4_ls_hwmod,
-	.slave		= &dm816x_mailbox_hwmod,
+static struct omap_hwmod_ocp_if dm81xx_l4_ls__mailbox = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm81xx_mailbox_hwmod,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_class dm816x_tpcc_hwmod_class = {
+static struct omap_hwmod_class dm81xx_tpcc_hwmod_class = {
 	.name		= "tpcc",
 };
 
-struct omap_hwmod dm816x_tpcc_hwmod = {
+struct omap_hwmod dm81xx_tpcc_hwmod = {
 	.name		= "tpcc",
-	.class		= &dm816x_tpcc_hwmod_class,
+	.class		= &dm81xx_tpcc_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= DM816X_CM_ALWON_TPCC_CLKCTRL,
+			.clkctrl_offs	= DM81XX_CM_ALWON_TPCC_CLKCTRL,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tpcc = {
-	.master		= &dm816x_alwon_l3_fast_hwmod,
-	.slave		= &dm816x_tpcc_hwmod,
+struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tpcc = {
+	.master		= &dm81xx_alwon_l3_fast_hwmod,
+	.slave		= &dm81xx_tpcc_hwmod,
 	.clk		= "sysclk4_ck",
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm816x_tptc0_addr_space[] = {
+static struct omap_hwmod_addr_space dm81xx_tptc0_addr_space[] = {
 	{
 		.pa_start	= 0x49800000,
 		.pa_end		= 0x49800000 + SZ_8K - 1,
@@ -929,40 +949,40 @@ static struct omap_hwmod_addr_space dm816x_tptc0_addr_space[] = {
 	{ },
 };
 
-static struct omap_hwmod_class dm816x_tptc0_hwmod_class = {
+static struct omap_hwmod_class dm81xx_tptc0_hwmod_class = {
 	.name		= "tptc0",
 };
 
-struct omap_hwmod dm816x_tptc0_hwmod = {
+struct omap_hwmod dm81xx_tptc0_hwmod = {
 	.name		= "tptc0",
-	.class		= &dm816x_tptc0_hwmod_class,
+	.class		= &dm81xx_tptc0_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= DM816X_CM_ALWON_TPTC0_CLKCTRL,
+			.clkctrl_offs	= DM81XX_CM_ALWON_TPTC0_CLKCTRL,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc0 = {
-	.master		= &dm816x_alwon_l3_fast_hwmod,
-	.slave		= &dm816x_tptc0_hwmod,
+struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc0 = {
+	.master		= &dm81xx_alwon_l3_fast_hwmod,
+	.slave		= &dm81xx_tptc0_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc0_addr_space,
+	.addr		= dm81xx_tptc0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc0__alwon_l3_fast = {
-	.master		= &dm816x_tptc0_hwmod,
-	.slave		= &dm816x_alwon_l3_fast_hwmod,
+struct omap_hwmod_ocp_if dm81xx_tptc0__alwon_l3_fast = {
+	.master		= &dm81xx_tptc0_hwmod,
+	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc0_addr_space,
+	.addr		= dm81xx_tptc0_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm816x_tptc1_addr_space[] = {
+static struct omap_hwmod_addr_space dm81xx_tptc1_addr_space[] = {
 	{
 		.pa_start	= 0x49900000,
 		.pa_end		= 0x49900000 + SZ_8K - 1,
@@ -971,40 +991,40 @@ static struct omap_hwmod_addr_space dm816x_tptc1_addr_space[] = {
 	{ },
 };
 
-static struct omap_hwmod_class dm816x_tptc1_hwmod_class = {
+static struct omap_hwmod_class dm81xx_tptc1_hwmod_class = {
 	.name		= "tptc1",
 };
 
-struct omap_hwmod dm816x_tptc1_hwmod = {
+struct omap_hwmod dm81xx_tptc1_hwmod = {
 	.name		= "tptc1",
-	.class		= &dm816x_tptc1_hwmod_class,
+	.class		= &dm81xx_tptc1_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= DM816X_CM_ALWON_TPTC1_CLKCTRL,
+			.clkctrl_offs	= DM81XX_CM_ALWON_TPTC1_CLKCTRL,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc1 = {
-	.master		= &dm816x_alwon_l3_fast_hwmod,
-	.slave		= &dm816x_tptc1_hwmod,
+struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc1 = {
+	.master		= &dm81xx_alwon_l3_fast_hwmod,
+	.slave		= &dm81xx_tptc1_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc1_addr_space,
+	.addr		= dm81xx_tptc1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc1__alwon_l3_fast = {
-	.master		= &dm816x_tptc1_hwmod,
-	.slave		= &dm816x_alwon_l3_fast_hwmod,
+struct omap_hwmod_ocp_if dm81xx_tptc1__alwon_l3_fast = {
+	.master		= &dm81xx_tptc1_hwmod,
+	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc1_addr_space,
+	.addr		= dm81xx_tptc1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm816x_tptc2_addr_space[] = {
+static struct omap_hwmod_addr_space dm81xx_tptc2_addr_space[] = {
 	{
 		.pa_start	= 0x49a00000,
 		.pa_end		= 0x49a00000 + SZ_8K - 1,
@@ -1013,40 +1033,40 @@ static struct omap_hwmod_addr_space dm816x_tptc2_addr_space[] = {
 	{ },
 };
 
-static struct omap_hwmod_class dm816x_tptc2_hwmod_class = {
+static struct omap_hwmod_class dm81xx_tptc2_hwmod_class = {
 	.name		= "tptc2",
 };
 
-struct omap_hwmod dm816x_tptc2_hwmod = {
+struct omap_hwmod dm81xx_tptc2_hwmod = {
 	.name		= "tptc2",
-	.class		= &dm816x_tptc2_hwmod_class,
+	.class		= &dm81xx_tptc2_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= DM816X_CM_ALWON_TPTC2_CLKCTRL,
+			.clkctrl_offs	= DM81XX_CM_ALWON_TPTC2_CLKCTRL,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc2 = {
-	.master		= &dm816x_alwon_l3_fast_hwmod,
-	.slave		= &dm816x_tptc2_hwmod,
+struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc2 = {
+	.master		= &dm81xx_alwon_l3_fast_hwmod,
+	.slave		= &dm81xx_tptc2_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc2_addr_space,
+	.addr		= dm81xx_tptc2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc2__alwon_l3_fast = {
-	.master		= &dm816x_tptc2_hwmod,
-	.slave		= &dm816x_alwon_l3_fast_hwmod,
+struct omap_hwmod_ocp_if dm81xx_tptc2__alwon_l3_fast = {
+	.master		= &dm81xx_tptc2_hwmod,
+	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc2_addr_space,
+	.addr		= dm81xx_tptc2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space dm816x_tptc3_addr_space[] = {
+static struct omap_hwmod_addr_space dm81xx_tptc3_addr_space[] = {
 	{
 		.pa_start	= 0x49b00000,
 		.pa_end		= 0x49b00000 + SZ_8K - 1,
@@ -1055,50 +1075,50 @@ static struct omap_hwmod_addr_space dm816x_tptc3_addr_space[] = {
 	{ },
 };
 
-static struct omap_hwmod_class dm816x_tptc3_hwmod_class = {
+static struct omap_hwmod_class dm81xx_tptc3_hwmod_class = {
 	.name		= "tptc3",
 };
 
-struct omap_hwmod dm816x_tptc3_hwmod = {
+struct omap_hwmod dm81xx_tptc3_hwmod = {
 	.name		= "tptc3",
-	.class		= &dm816x_tptc3_hwmod_class,
+	.class		= &dm81xx_tptc3_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.main_clk	= "sysclk4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= DM816X_CM_ALWON_TPTC3_CLKCTRL,
+			.clkctrl_offs	= DM81XX_CM_ALWON_TPTC3_CLKCTRL,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
 
-struct omap_hwmod_ocp_if dm816x_alwon_l3_fast__tptc3 = {
-	.master		= &dm816x_alwon_l3_fast_hwmod,
-	.slave		= &dm816x_tptc3_hwmod,
+struct omap_hwmod_ocp_if dm81xx_alwon_l3_fast__tptc3 = {
+	.master		= &dm81xx_alwon_l3_fast_hwmod,
+	.slave		= &dm81xx_tptc3_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc3_addr_space,
+	.addr		= dm81xx_tptc3_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if dm816x_tptc3__alwon_l3_fast = {
-	.master		= &dm816x_tptc3_hwmod,
-	.slave		= &dm816x_alwon_l3_fast_hwmod,
+struct omap_hwmod_ocp_if dm81xx_tptc3__alwon_l3_fast = {
+	.master		= &dm81xx_tptc3_hwmod,
+	.slave		= &dm81xx_alwon_l3_fast_hwmod,
 	.clk		= "sysclk4_ck",
-	.addr		= dm816x_tptc3_addr_space,
+	.addr		= dm81xx_tptc3_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm816x_mpu__alwon_l3_slow,
 	&dm816x_mpu__alwon_l3_med,
-	&dm816x_alwon_l3_slow__l4_ls,
-	&dm816x_alwon_l3_slow__l4_hs,
-	&dm816x_l4_ls__uart1,
-	&dm816x_l4_ls__uart2,
-	&dm816x_l4_ls__uart3,
-	&dm816x_l4_ls__wd_timer1,
-	&dm816x_l4_ls__i2c1,
-	&dm816x_l4_ls__i2c2,
+	&dm81xx_alwon_l3_slow__l4_ls,
+	&dm81xx_alwon_l3_slow__l4_hs,
+	&dm81xx_l4_ls__uart1,
+	&dm81xx_l4_ls__uart2,
+	&dm81xx_l4_ls__uart3,
+	&dm81xx_l4_ls__wd_timer1,
+	&dm81xx_l4_ls__i2c1,
+	&dm81xx_l4_ls__i2c2,
 	&dm81xx_l4_ls__gpio1,
 	&dm81xx_l4_ls__gpio2,
 	&dm81xx_l4_ls__elm,
@@ -1110,20 +1130,20 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm816x_l4_ls__timer5,
 	&dm816x_l4_ls__timer6,
 	&dm816x_l4_ls__timer7,
-	&dm816x_l4_ls__mcspi1,
-	&dm816x_l4_ls__mailbox,
-	&dm816x_l4_hs__emac0,
-	&dm816x_emac0__mdio,
+	&dm81xx_l4_ls__mcspi1,
+	&dm81xx_l4_ls__mailbox,
+	&dm81xx_l4_hs__emac0,
+	&dm81xx_emac0__mdio,
 	&dm816x_l4_hs__emac1,
-	&dm816x_alwon_l3_fast__tpcc,
-	&dm816x_alwon_l3_fast__tptc0,
-	&dm816x_alwon_l3_fast__tptc1,
-	&dm816x_alwon_l3_fast__tptc2,
-	&dm816x_alwon_l3_fast__tptc3,
-	&dm816x_tptc0__alwon_l3_fast,
-	&dm816x_tptc1__alwon_l3_fast,
-	&dm816x_tptc2__alwon_l3_fast,
-	&dm816x_tptc3__alwon_l3_fast,
+	&dm81xx_alwon_l3_fast__tpcc,
+	&dm81xx_alwon_l3_fast__tptc0,
+	&dm81xx_alwon_l3_fast__tptc1,
+	&dm81xx_alwon_l3_fast__tptc2,
+	&dm81xx_alwon_l3_fast__tptc3,
+	&dm81xx_tptc0__alwon_l3_fast,
+	&dm81xx_tptc1__alwon_l3_fast,
+	&dm81xx_tptc2__alwon_l3_fast,
+	&dm81xx_tptc3__alwon_l3_fast,
 	&dm81xx_alwon_l3_slow__gpmc,
 	&dm81xx_default_l3_slow__usbss,
 	NULL,
-- 
2.1.4

