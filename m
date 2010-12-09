From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/5] OMAP4: hwmod data: Fix hwmod entries order
Date: Fri, 10 Dec 2010 00:33:31 +0100
Message-ID: <1291937615-18571-2-git-send-email-b-cousson@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47620 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab0LIXeb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 18:34:31 -0500
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>

The original OMAP4 hwmod data files is fully generated from HW
database. But since the file is introduced incrementaly along
with driver that uses the data, it has to be splitted by the driver
owner and then re-merged by the maintainer.
Because of the similarity of the data, git is completely lost
during such merge and thus the data does not look like the original one
at the end.

Re-order properly the structures to stay in sync with original data set.

Add a comment that does contain all the IPs that can have a hwmod, but
do not have it in the file for the moment. It gives a good indication
of the progress.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Charulatha V <charu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1002 +++++++++++++++-------------
 1 files changed, 553 insertions(+), 449 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index d258936..d8ef977 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -168,6 +168,7 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/* l3_main_1 interface data */
 /* l3_main_2 -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -384,6 +385,464 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 };
 
 /*
+ * 'mpu_bus' class
+ * instance(s): mpu_private
+ */
+static struct omap_hwmod_class omap44xx_mpu_bus_hwmod_class = {
+	.name = "mpu_bus",
+};
+
+/* mpu_private interface data */
+/* mpu -> mpu_private */
+static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
+	.master		= &omap44xx_mpu_hwmod,
+	.slave		= &omap44xx_mpu_private_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mpu_private slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mpu_private_slaves[] = {
+	&omap44xx_mpu__mpu_private,
+};
+
+static struct omap_hwmod omap44xx_mpu_private_hwmod = {
+	.name		= "mpu_private",
+	.class		= &omap44xx_mpu_bus_hwmod_class,
+	.slaves		= omap44xx_mpu_private_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mpu_private_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * Modules omap_hwmod structures
+ *
+ * The following IPs are excluded for the moment because:
+ * - They do not need an explicit SW control using omap_hwmod API.
+ * - They still need to be validated with the driver
+ *   properly adapted to omap_hwmod / omap_device
+ *
+ *  aess
+ *  bandgap
+ *  c2c
+ *  c2c_target_fw
+ *  cm_core
+ *  cm_core_aon
+ *  counter_32k
+ *  ctrl_module_core
+ *  ctrl_module_pad_core
+ *  ctrl_module_pad_wkup
+ *  ctrl_module_wkup
+ *  debugss
+ *  dma_system
+ *  dmic
+ *  dsp
+ *  dss
+ *  dss_dispc
+ *  dss_dsi1
+ *  dss_dsi2
+ *  dss_hdmi
+ *  dss_rfbi
+ *  dss_venc
+ *  efuse_ctrl_cust
+ *  efuse_ctrl_std
+ *  elm
+ *  emif1
+ *  emif2
+ *  fdif
+ *  gpmc
+ *  gpu
+ *  hdq1w
+ *  hsi
+ *  ipu
+ *  iss
+ *  iva
+ *  kbd
+ *  mailbox
+ *  mcasp
+ *  mcbsp1
+ *  mcbsp2
+ *  mcbsp3
+ *  mcbsp4
+ *  mcpdm
+ *  mcspi1
+ *  mcspi2
+ *  mcspi3
+ *  mcspi4
+ *  mmc1
+ *  mmc2
+ *  mmc3
+ *  mmc4
+ *  mmc5
+ *  mpu_c0
+ *  mpu_c1
+ *  ocmc_ram
+ *  ocp2scp_usb_phy
+ *  ocp_wp_noc
+ *  prcm
+ *  prcm_mpu
+ *  prm
+ *  scrm
+ *  sl2if
+ *  slimbus1
+ *  slimbus2
+ *  smartreflex_core
+ *  smartreflex_iva
+ *  smartreflex_mpu
+ *  spinlock
+ *  timer1
+ *  timer10
+ *  timer11
+ *  timer2
+ *  timer3
+ *  timer4
+ *  timer5
+ *  timer6
+ *  timer7
+ *  timer8
+ *  timer9
+ *  usb_host_fs
+ *  usb_host_hs
+ *  usb_otg_hs
+ *  usb_phy_cm
+ *  usb_tll_hs
+ *  usim
+ */
+
+/*
+ * 'gpio' class
+ * general purpose io module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0114,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
+	.name = "gpio",
+	.sysc = &omap44xx_gpio_sysc,
+	.rev = 2,
+};
+
+/* gpio dev_attr */
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = true,
+};
+
+/* gpio1 */
+static struct omap_hwmod omap44xx_gpio1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio1_irqs[] = {
+	{ .irq = 29 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
+	{
+		.pa_start	= 0x4a310000,
+		.pa_end		= 0x4a3101ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> gpio1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_gpio1_hwmod,
+	.addr		= omap44xx_gpio1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio1_slaves[] = {
+	&omap44xx_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio1_hwmod = {
+	.name		= "gpio1",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
+	.main_clk	= "gpio1_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio1_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio1_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio2 */
+static struct omap_hwmod omap44xx_gpio2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio2_irqs[] = {
+	{ .irq = 30 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
+	{
+		.pa_start	= 0x48055000,
+		.pa_end		= 0x480551ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio2_hwmod,
+	.addr		= omap44xx_gpio2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio2_slaves[] = {
+	&omap44xx_l4_per__gpio2,
+};
+
+static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio2_hwmod = {
+	.name		= "gpio2",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
+	.main_clk	= "gpio2_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio2_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio2_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio3 */
+static struct omap_hwmod omap44xx_gpio3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio3_irqs[] = {
+	{ .irq = 31 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
+	{
+		.pa_start	= 0x48057000,
+		.pa_end		= 0x480571ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio3_hwmod,
+	.addr		= omap44xx_gpio3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio3_slaves[] = {
+	&omap44xx_l4_per__gpio3,
+};
+
+static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio3_hwmod = {
+	.name		= "gpio3",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
+	.main_clk	= "gpio3_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio3_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio3_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio4 */
+static struct omap_hwmod omap44xx_gpio4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio4_irqs[] = {
+	{ .irq = 32 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
+	{
+		.pa_start	= 0x48059000,
+		.pa_end		= 0x480591ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio4_hwmod,
+	.addr		= omap44xx_gpio4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio4_slaves[] = {
+	&omap44xx_l4_per__gpio4,
+};
+
+static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio4_hwmod = {
+	.name		= "gpio4",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
+	.main_clk	= "gpio4_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio4_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio4_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio5 */
+static struct omap_hwmod omap44xx_gpio5_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio5_irqs[] = {
+	{ .irq = 33 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
+	{
+		.pa_start	= 0x4805b000,
+		.pa_end		= 0x4805b1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio5 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio5_hwmod,
+	.addr		= omap44xx_gpio5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio5 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio5_slaves[] = {
+	&omap44xx_l4_per__gpio5,
+};
+
+static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio5_hwmod = {
+	.name		= "gpio5",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
+	.main_clk	= "gpio5_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio5_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio5_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio6 */
+static struct omap_hwmod omap44xx_gpio6_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio6_irqs[] = {
+	{ .irq = 34 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
+	{
+		.pa_start	= 0x4805d000,
+		.pa_end		= 0x4805d1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio6 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio6_hwmod,
+	.addr		= omap44xx_gpio6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio6_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio6 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio6_slaves[] = {
+	&omap44xx_l4_per__gpio6,
+};
+
+static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio6_hwmod = {
+	.name		= "gpio6",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio6_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
+	.main_clk	= "gpio6_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio6_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio6_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'i2c' class
  * multimaster high-speed i2c controller
  */
@@ -391,9 +850,9 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0090,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -616,36 +1075,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 };
 
 /*
- * 'mpu_bus' class
- * instance(s): mpu_private
- */
-static struct omap_hwmod_class omap44xx_mpu_bus_hwmod_class = {
-	.name = "mpu_bus",
-};
-
-/* mpu_private interface data */
-/* mpu -> mpu_private */
-static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
-	.master		= &omap44xx_mpu_hwmod,
-	.slave		= &omap44xx_mpu_private_hwmod,
-	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* mpu_private slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_mpu_private_slaves[] = {
-	&omap44xx_mpu__mpu_private,
-};
-
-static struct omap_hwmod omap44xx_mpu_private_hwmod = {
-	.name		= "mpu_private",
-	.class		= &omap44xx_mpu_bus_hwmod_class,
-	.slaves		= omap44xx_mpu_private_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_mpu_private_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/*
  * 'mpu' class
  * mpu sub-system
  */
@@ -686,22 +1115,6 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
- * 'wd_timer' class
- * 32-bit watchdog upward counter that generates a pulse on the reset pin on
- * overflow condition
- */
-
-static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
-			   SYSC_HAS_SOFTRESET),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-/*
  * 'uart' class
  * universal asynchronous receiver/transmitter (uart)
  */
@@ -710,31 +1123,12 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 	.rev_offs	= 0x0050,
 	.sysc_offs	= 0x0054,
 	.syss_offs	= 0x0058,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
-	.name = "wd_timer",
-	.sysc = &omap44xx_wd_timer_sysc,
-};
-
-/* wd_timer2 */
-static struct omap_hwmod omap44xx_wd_timer2_hwmod;
-static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
-	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
-	{
-		.pa_start	= 0x4a314000,
-		.pa_end		= 0x4a31407f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
 static struct omap_hwmod_class omap44xx_uart_hwmod_class = {
 	.name = "uart",
 	.sysc = &omap44xx_uart_sysc,
@@ -811,51 +1205,6 @@ static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
 	},
 };
 
-/* l4_wkup -> wd_timer2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
-	.master		= &omap44xx_l4_wkup_hwmod,
-	.slave		= &omap44xx_wd_timer2_hwmod,
-	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_wd_timer2_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* wd_timer2 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_wd_timer2_slaves[] = {
-	&omap44xx_l4_wkup__wd_timer2,
-};
-
-static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
-	.name		= "wd_timer2",
-	.class		= &omap44xx_wd_timer_hwmod_class,
-	.mpu_irqs	= omap44xx_wd_timer2_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_irqs),
-	.main_clk	= "wd_timer2_fck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
-		},
-	},
-	.slaves		= omap44xx_wd_timer2_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/* wd_timer3 */
-static struct omap_hwmod omap44xx_wd_timer3_hwmod;
-static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] = {
-	{ .irq = 36 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
-	{
-		.pa_start	= 0x40130000,
-		.pa_end		= 0x4013007f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
 /* l4_per -> uart2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart2 = {
 	.master		= &omap44xx_l4_per_hwmod,
@@ -908,25 +1257,6 @@ static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] = {
 	},
 };
 
-/* l4_abe -> wd_timer3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_wd_timer3_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_wd_timer3_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_addrs),
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> wd_timer3 (dma) */
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
-	{
-		.pa_start	= 0x49030000,
-		.pa_end		= 0x4903007f,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
 /* l4_per -> uart3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart3 = {
 	.master		= &omap44xx_l4_per_hwmod,
@@ -980,37 +1310,6 @@ static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] = {
 	},
 };
 
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_wd_timer3_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_wd_timer3_dma_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_dma_addrs),
-	.user		= OCP_USER_SDMA,
-};
-
-/* wd_timer3 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_wd_timer3_slaves[] = {
-	&omap44xx_l4_abe__wd_timer3,
-	&omap44xx_l4_abe__wd_timer3_dma,
-};
-
-static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
-	.name		= "wd_timer3",
-	.class		= &omap44xx_wd_timer_hwmod_class,
-	.mpu_irqs	= omap44xx_wd_timer3_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_irqs),
-	.main_clk	= "wd_timer3_fck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM1_ABE_WDT3_CLKCTRL,
-		},
-	},
-	.slaves		= omap44xx_wd_timer3_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
 /* l4_per -> uart4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 = {
 	.master		= &omap44xx_l4_per_hwmod,
@@ -1045,357 +1344,154 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 };
 
 /*
- * 'gpio' class
- * general purpose io module
+ * 'wd_timer' class
+ * 32-bit watchdog upward counter that generates a pulse on the reset pin on
+ * overflow condition
  */
 
-static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
+static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0114,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
-	.name = "gpio",
-	.sysc = &omap44xx_gpio_sysc,
-	.rev = 2,
-};
-
-/* gpio dev_attr */
-static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = true,
+static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap44xx_wd_timer_sysc,
 };
 
-/* gpio1 */
-static struct omap_hwmod omap44xx_gpio1_hwmod;
-static struct omap_hwmod_irq_info omap44xx_gpio1_irqs[] = {
-	{ .irq = 29 + OMAP44XX_IRQ_GIC_START },
+/* wd_timer2 */
+static struct omap_hwmod omap44xx_wd_timer2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
+	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
+static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
 	{
-		.pa_start	= 0x4a310000,
-		.pa_end		= 0x4a3101ff,
+		.pa_start	= 0x4a314000,
+		.pa_end		= 0x4a31407f,
 		.flags		= ADDR_TYPE_RT
 	},
 };
 
-/* l4_wkup -> gpio1 */
-static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
+/* l4_wkup -> wd_timer2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
-	.slave		= &omap44xx_gpio1_hwmod,
-	.addr		= omap44xx_gpio1_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* gpio1 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_gpio1_slaves[] = {
-	&omap44xx_l4_wkup__gpio1,
-};
-
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
-};
-
-static struct omap_hwmod omap44xx_gpio1_hwmod = {
-	.name		= "gpio1",
-	.class		= &omap44xx_gpio_hwmod_class,
-	.mpu_irqs	= omap44xx_gpio1_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
-	.main_clk	= "gpio1_ick",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
-		},
-	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(gpio1_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
-	.slaves		= omap44xx_gpio1_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/* gpio2 */
-static struct omap_hwmod omap44xx_gpio2_hwmod;
-static struct omap_hwmod_irq_info omap44xx_gpio2_irqs[] = {
-	{ .irq = 30 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
-	{
-		.pa_start	= 0x48055000,
-		.pa_end		= 0x480551ff,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_per -> gpio2 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_gpio2_hwmod,
-	.addr		= omap44xx_gpio2_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio2_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* gpio2 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_gpio2_slaves[] = {
-	&omap44xx_l4_per__gpio2,
-};
-
-static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
-};
-
-static struct omap_hwmod omap44xx_gpio2_hwmod = {
-	.name		= "gpio2",
-	.class		= &omap44xx_gpio_hwmod_class,
-	.mpu_irqs	= omap44xx_gpio2_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
-	.main_clk	= "gpio2_ick",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
-		},
-	},
-	.opt_clks	= gpio2_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(gpio2_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
-	.slaves		= omap44xx_gpio2_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/* gpio3 */
-static struct omap_hwmod omap44xx_gpio3_hwmod;
-static struct omap_hwmod_irq_info omap44xx_gpio3_irqs[] = {
-	{ .irq = 31 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
-	{
-		.pa_start	= 0x48057000,
-		.pa_end		= 0x480571ff,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_per -> gpio3 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_gpio3_hwmod,
-	.addr		= omap44xx_gpio3_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio3_addrs),
+	.slave		= &omap44xx_wd_timer2_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_wd_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* gpio3 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_gpio3_slaves[] = {
-	&omap44xx_l4_per__gpio3,
-};
-
-static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+/* wd_timer2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_wd_timer2_slaves[] = {
+	&omap44xx_l4_wkup__wd_timer2,
 };
 
-static struct omap_hwmod omap44xx_gpio3_hwmod = {
-	.name		= "gpio3",
-	.class		= &omap44xx_gpio_hwmod_class,
-	.mpu_irqs	= omap44xx_gpio3_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
-	.main_clk	= "gpio3_ick",
+static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap44xx_wd_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_wd_timer2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_irqs),
+	.main_clk	= "wd_timer2_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
 		},
 	},
-	.opt_clks	= gpio3_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(gpio3_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
-	.slaves		= omap44xx_gpio3_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
+	.slaves		= omap44xx_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-/* gpio4 */
-static struct omap_hwmod omap44xx_gpio4_hwmod;
-static struct omap_hwmod_irq_info omap44xx_gpio4_irqs[] = {
-	{ .irq = 32 + OMAP44XX_IRQ_GIC_START },
+/* wd_timer3 */
+static struct omap_hwmod omap44xx_wd_timer3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] = {
+	{ .irq = 36 + OMAP44XX_IRQ_GIC_START },
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
+static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
 	{
-		.pa_start	= 0x48059000,
-		.pa_end		= 0x480591ff,
+		.pa_start	= 0x40130000,
+		.pa_end		= 0x4013007f,
 		.flags		= ADDR_TYPE_RT
 	},
 };
 
-/* l4_per -> gpio4 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_gpio4_hwmod,
-	.addr		= omap44xx_gpio4_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio4_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* gpio4 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_gpio4_slaves[] = {
-	&omap44xx_l4_per__gpio4,
-};
-
-static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
-};
-
-static struct omap_hwmod omap44xx_gpio4_hwmod = {
-	.name		= "gpio4",
-	.class		= &omap44xx_gpio_hwmod_class,
-	.mpu_irqs	= omap44xx_gpio4_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
-	.main_clk	= "gpio4_ick",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
-		},
-	},
-	.opt_clks	= gpio4_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(gpio4_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
-	.slaves		= omap44xx_gpio4_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
-
-/* gpio5 */
-static struct omap_hwmod omap44xx_gpio5_hwmod;
-static struct omap_hwmod_irq_info omap44xx_gpio5_irqs[] = {
-	{ .irq = 33 + OMAP44XX_IRQ_GIC_START },
+/* l4_abe -> wd_timer3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_wd_timer3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_wd_timer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_addrs),
+	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
+static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
 	{
-		.pa_start	= 0x4805b000,
-		.pa_end		= 0x4805b1ff,
+		.pa_start	= 0x49030000,
+		.pa_end		= 0x4903007f,
 		.flags		= ADDR_TYPE_RT
 	},
 };
 
-/* l4_per -> gpio5 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_gpio5_hwmod,
-	.addr		= omap44xx_gpio5_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio5_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* gpio5 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_gpio5_slaves[] = {
-	&omap44xx_l4_per__gpio5,
+/* l4_abe -> wd_timer3 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_wd_timer3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_wd_timer3_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_dma_addrs),
+	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+/* wd_timer3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_wd_timer3_slaves[] = {
+	&omap44xx_l4_abe__wd_timer3,
+	&omap44xx_l4_abe__wd_timer3_dma,
 };
 
-static struct omap_hwmod omap44xx_gpio5_hwmod = {
-	.name		= "gpio5",
-	.class		= &omap44xx_gpio_hwmod_class,
-	.mpu_irqs	= omap44xx_gpio5_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
-	.main_clk	= "gpio5_ick",
+static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
+	.name		= "wd_timer3",
+	.class		= &omap44xx_wd_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_wd_timer3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_irqs),
+	.main_clk	= "wd_timer3_fck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+			.clkctrl_reg = OMAP4430_CM1_ABE_WDT3_CLKCTRL,
 		},
 	},
-	.opt_clks	= gpio5_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(gpio5_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
-	.slaves		= omap44xx_gpio5_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
+	.slaves		= omap44xx_wd_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-/* gpio6 */
-static struct omap_hwmod omap44xx_gpio6_hwmod;
-static struct omap_hwmod_irq_info omap44xx_gpio6_irqs[] = {
-	{ .irq = 34 + OMAP44XX_IRQ_GIC_START },
-};
-
-static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
-	{
-		.pa_start	= 0x4805d000,
-		.pa_end		= 0x4805d1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-};
-
-/* l4_per -> gpio6 */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_gpio6_hwmod,
-	.addr		= omap44xx_gpio6_addrs,
-	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio6_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* gpio6 slave ports */
-static struct omap_hwmod_ocp_if *omap44xx_gpio6_slaves[] = {
-	&omap44xx_l4_per__gpio6,
-};
-
-static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
-};
-
-static struct omap_hwmod omap44xx_gpio6_hwmod = {
-	.name		= "gpio6",
-	.class		= &omap44xx_gpio_hwmod_class,
-	.mpu_irqs	= omap44xx_gpio6_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
-	.main_clk	= "gpio6_ick",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
-		},
-	},
-	.opt_clks	= gpio6_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(gpio6_opt_clks),
-	.dev_attr	= &gpio_dev_attr,
-	.slaves		= omap44xx_gpio6_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-};
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
+
 	/* emif_fw class */
 	&omap44xx_emif_fw_hwmod,
+
 	/* l3 class */
 	&omap44xx_l3_instr_hwmod,
 	&omap44xx_l3_main_1_hwmod,
 	&omap44xx_l3_main_2_hwmod,
 	&omap44xx_l3_main_3_hwmod,
+
 	/* l4 class */
 	&omap44xx_l4_abe_hwmod,
 	&omap44xx_l4_cfg_hwmod,
 	&omap44xx_l4_per_hwmod,
 	&omap44xx_l4_wkup_hwmod,
-	/* i2c class */
-	&omap44xx_i2c1_hwmod,
-	&omap44xx_i2c2_hwmod,
-	&omap44xx_i2c3_hwmod,
-	&omap44xx_i2c4_hwmod,
+
 	/* mpu_bus class */
 	&omap44xx_mpu_private_hwmod,
 
@@ -1407,17 +1503,25 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_gpio5_hwmod,
 	&omap44xx_gpio6_hwmod,
 
+	/* i2c class */
+	&omap44xx_i2c1_hwmod,
+	&omap44xx_i2c2_hwmod,
+	&omap44xx_i2c3_hwmod,
+	&omap44xx_i2c4_hwmod,
+
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
-	/* wd_timer class */
-	&omap44xx_wd_timer2_hwmod,
-	&omap44xx_wd_timer3_hwmod,
 
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
 	&omap44xx_uart3_hwmod,
 	&omap44xx_uart4_hwmod,
+
+	/* wd_timer class */
+	&omap44xx_wd_timer2_hwmod,
+	&omap44xx_wd_timer3_hwmod,
+
 	NULL,
 };
 
-- 
1.7.0.4

