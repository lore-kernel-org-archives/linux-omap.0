From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 5/6] OMAP4: hwmod: Add remaining hwmod support for OMAP4430 ES1.0
Date: Wed, 12 May 2010 17:54:40 +0200
Message-ID: <1273679681-27549-6-git-send-email-b-cousson@ti.com>
References: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48499 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab0ELPy7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 11:54:59 -0400
In-Reply-To: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Some IPs are still excluded for the moment because they do not
need an explicit SW control through HWMOD.
If you think that some of the following IPs should be exported
do not hesitate to ask.

  bandgap
  c2c
  c2c_target_fw
  ctrl_module_core
  ctrl_module_wkup
  debugss
  efuse_ctrl_cust
  efuse_ctrl_std
  hdq1w
  mcasp
  mpu_c0
  mpu_c1
  ocmc_ram
  ocp2scp_usb_phy
  ocp_wp_noc
  pad_ctrl_module_core
  pad_ctrl_module_wkup
  prcm_mpu
  scrm
  usim

TODO:
- Create header file with all the physical address mapping
  in order to have a unique place to store this information
  and thus improve the readability.
- Add dual mapping address space when applicable (ABE, DSS...)
- Add ES2.0 specific data
- Add reset lines information per IP
- Take some (long) vacation

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1917 +++++++++++++++++++++++++++-
 1 files changed, 1891 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index b6776e6..20f5f8c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -32,8 +32,18 @@
 #define OMAP44XX_IRQ_GIC_START	32
 
 /* Backward references (IPs with Bus Master capability) */
+static struct omap_hwmod omap44xx_aess_hwmod;
+static struct omap_hwmod omap44xx_dma_system_hwmod;
 static struct omap_hwmod omap44xx_dmm_hwmod;
+static struct omap_hwmod omap44xx_dsp_hwmod;
+static struct omap_hwmod omap44xx_dss_hwmod;
 static struct omap_hwmod omap44xx_emif_fw_hwmod;
+static struct omap_hwmod omap44xx_fdif_hwmod;
+static struct omap_hwmod omap44xx_gpu_hwmod;
+static struct omap_hwmod omap44xx_hsi_hwmod;
+static struct omap_hwmod omap44xx_ipu_hwmod;
+static struct omap_hwmod omap44xx_iss_hwmod;
+static struct omap_hwmod omap44xx_iva_hwmod;
 static struct omap_hwmod omap44xx_l3_instr_hwmod;
 static struct omap_hwmod omap44xx_l3_main_1_hwmod;
 static struct omap_hwmod omap44xx_l3_main_2_hwmod;
@@ -45,6 +55,10 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod;
 static struct omap_hwmod omap44xx_mmc1_hwmod;
 static struct omap_hwmod omap44xx_mmc2_hwmod;
 static struct omap_hwmod omap44xx_mpu_hwmod;
+static struct omap_hwmod omap44xx_sl2if_hwmod;
+static struct omap_hwmod omap44xx_usb_host_fs_hwmod;
+static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
 
 /*
  * Interconnects hwmod structures
@@ -136,9 +150,18 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_3__l3_instr = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* iva -> l3_instr */
+static struct omap_hwmod_ocp_if omap44xx_iva__l3_instr = {
+	.master		= &omap44xx_iva_hwmod,
+	.slave		= &omap44xx_l3_instr_hwmod,
+	.clk		= "dpll_iva_m5_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_instr slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_instr_slaves[] = {
 	&omap44xx_l3_main_3__l3_instr,
+	&omap44xx_iva__l3_instr,
 };
 
 static struct omap_hwmod_class omap44xx_l3_instr_hwmod_class = {
@@ -194,6 +217,22 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* dss -> l3_main_1 */
+static struct omap_hwmod_ocp_if omap44xx_dss__l3_main_1 = {
+	.master		= &omap44xx_dss_hwmod,
+	.slave		= &omap44xx_l3_main_1_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp -> l3_main_1 */
+static struct omap_hwmod_ocp_if omap44xx_dsp__l3_main_1 = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_l3_main_1_hwmod,
+	.clk		= "dpll_iva_m4_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
 	&omap44xx_mmc2__l3_main_1,
@@ -201,6 +240,8 @@ static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
 	&omap44xx_l3_main_2__l3_main_1,
 	&omap44xx_l4_cfg__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
+	&omap44xx_dss__l3_main_1,
+	&omap44xx_dsp__l3_main_1,
 };
 
 static struct omap_hwmod_class omap44xx_l3_main_1_hwmod_class = {
@@ -224,6 +265,86 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* fdif -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 = {
+	.master		= &omap44xx_fdif_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "fdif_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iva -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_iva__l3_main_2 = {
+	.master		= &omap44xx_iva_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "dpll_iva_m5_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_otg_hs -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs__l3_main_2 = {
+	.master		= &omap44xx_usb_otg_hs_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iss -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_iss__l3_main_2 = {
+	.master		= &omap44xx_iss_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "ducati_clk_mux_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_host_fs -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 = {
+	.master		= &omap44xx_usb_host_fs_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* hsi -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 = {
+	.master		= &omap44xx_hsi_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
+	.master		= &omap44xx_dma_system_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_host_hs -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 = {
+	.master		= &omap44xx_usb_host_hs_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ipu -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_ipu__l3_main_2 = {
+	.master		= &omap44xx_ipu_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "ducati_clk_mux_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpu -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_gpu__l3_main_2 = {
+	.master		= &omap44xx_gpu_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -235,6 +356,16 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 /* l3_main_2 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
 	&omap44xx_l3_main_1__l3_main_2,
+	&omap44xx_fdif__l3_main_2,
+	&omap44xx_iva__l3_main_2,
+	&omap44xx_usb_otg_hs__l3_main_2,
+	&omap44xx_iss__l3_main_2,
+	&omap44xx_usb_host_fs__l3_main_2,
+	&omap44xx_hsi__l3_main_2,
+	&omap44xx_dma_system__l3_main_2,
+	&omap44xx_usb_host_hs__l3_main_2,
+	&omap44xx_ipu__l3_main_2,
+	&omap44xx_gpu__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
 };
 
@@ -311,10 +442,28 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l4_abe = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* aess -> l4_abe */
+static struct omap_hwmod_ocp_if omap44xx_aess__l4_abe = {
+	.master		= &omap44xx_aess_hwmod,
+	.slave		= &omap44xx_l4_abe_hwmod,
+	.clk		= "aess_fclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp -> l4_abe */
+static struct omap_hwmod_ocp_if omap44xx_dsp__l4_abe = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_l4_abe_hwmod,
+	.clk		= "dpll_iva_m4_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_abe slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l4_abe_slaves[] = {
 	&omap44xx_l3_main_1__l4_abe,
 	&omap44xx_mpu__l4_abe,
+	&omap44xx_aess__l4_abe,
+	&omap44xx_dsp__l4_abe,
 };
 
 static struct omap_hwmod_class omap44xx_l4_abe_hwmod_class = {
@@ -415,28 +564,15 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  aess
  *  bandgap
  *  c2c
  *  c2c_target_fw
  *  ctrl_module_core
  *  ctrl_module_wkup
  *  debugss
- *  dma_system
- *  dmic
- *  dsp
- *  dss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
- *  elm
- *  fdif
- *  gpu
  *  hdq1w
- *  hsi
- *  ipu
- *  iss
- *  iva
- *  mailbox
  *  mcasp
  *  mpu_c0
  *  mpu_c1
@@ -447,23 +583,94 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
  *  pad_ctrl_module_wkup
  *  prcm_mpu
  *  scrm
- *  sl2if
- *  slimbus1
- *  slimbus2
- *  smartreflex_core
- *  smartreflex_iva
- *  smartreflex_mpu
- *  spinlock
- *  usb_host_fs
- *  usb_host_hs
- *  usb_otg_hs
- *  usb_tll_hs
  *  usim
- *  wd_timer2
- *  wd_timer3
  */
 
 /*
+ * 'aess' class
+ * audio engine sub system
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_aess_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			   SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_aess_hwmod_class = {
+	.name = "aess",
+	.sysc = &omap44xx_aess_sysc,
+};
+
+/* aess */
+static struct omap_hwmod_irq_info omap44xx_aess_irqs[] = {
+	{ .irq = 99 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_aess_sdma_chs[] = {
+	{ .name = "fifo0", .dma_ch = 100 },
+	{ .name = "fifo1", .dma_ch = 101 },
+	{ .name = "fifo2", .dma_ch = 102 },
+	{ .name = "fifo3", .dma_ch = 103 },
+	{ .name = "fifo4", .dma_ch = 104 },
+	{ .name = "fifo5", .dma_ch = 105 },
+	{ .name = "fifo6", .dma_ch = 106 },
+	{ .name = "fifo7", .dma_ch = 107 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
+	{
+		.pa_start	= 0x490f1000,
+		.pa_end		= 0x490f11ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* aess master ports */
+static struct omap_hwmod_ocp_if *omap44xx_aess_masters[] = {
+	&omap44xx_aess__l4_abe,
+};
+
+/* l4_abe -> aess */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_aess_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_aess_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_aess_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* aess slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_aess_slaves[] = {
+	&omap44xx_l4_abe__aess,
+};
+
+static struct omap_hwmod omap44xx_aess_hwmod = {
+	.name		= "aess",
+	.class		= &omap44xx_aess_hwmod_class,
+	.mpu_irqs	= omap44xx_aess_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_aess_irqs),
+	.sdma_chs	= omap44xx_aess_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(omap44xx_aess_sdma_chs),
+	.main_clk	= "aess_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_AESS_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_aess_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_aess_slaves),
+	.masters	= omap44xx_aess_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_aess_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
  */
@@ -521,6 +728,367 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 };
 
 /*
+ * 'dma' class
+ * dma controller for data exchange between memory to memory (i.e. internal or
+ * external memory) and gp peripherals to memory or memory to gp peripherals
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x002c,
+	.syss_offs	= 0x0028,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
+	.name = "dma",
+	.sysc = &omap44xx_dma_sysc,
+};
+
+/* dma_system */
+static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
+	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
+	{
+		.pa_start	= 0x4a056000,
+		.pa_end		= 0x4a0560ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* dma_system master ports */
+static struct omap_hwmod_ocp_if *omap44xx_dma_system_masters[] = {
+	&omap44xx_dma_system__l3_main_2,
+};
+
+/* l4_cfg -> dma_system */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_dma_system_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_dma_system_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dma_system_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dma_system slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dma_system_slaves[] = {
+	&omap44xx_l4_cfg__dma_system,
+};
+
+static struct omap_hwmod omap44xx_dma_system_hwmod = {
+	.name		= "dma_system",
+	.class		= &omap44xx_dma_hwmod_class,
+	.mpu_irqs	= omap44xx_dma_system_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dma_system_irqs),
+	.main_clk	= "l3_div_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dma_system_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
+	.masters	= omap44xx_dma_system_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'dmic' class
+ * digital microphone controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dmic_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_SOFTRESET | SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
+	.name = "dmic",
+	.sysc = &omap44xx_dmic_sysc,
+};
+
+/* dmic */
+static struct omap_hwmod omap44xx_dmic_hwmod;
+static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
+	{ .irq = 114 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_dmic_sdma_chs[] = {
+	{ .dma_ch = 66 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
+	{
+		.pa_start	= 0x4902e000,
+		.pa_end		= 0x4902e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dmic slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dmic_slaves[] = {
+	&omap44xx_l4_abe__dmic,
+};
+
+static struct omap_hwmod omap44xx_dmic_hwmod = {
+	.name		= "dmic",
+	.class		= &omap44xx_dmic_hwmod_class,
+	.mpu_irqs	= omap44xx_dmic_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmic_irqs),
+	.sdma_chs	= omap44xx_dmic_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_chs),
+	.main_clk	= "dmic_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dmic_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'dsp' class
+ * dsp sub-system
+ */
+
+static struct omap_hwmod_class omap44xx_dsp_hwmod_class = {
+	.name = "dsp",
+};
+
+/* dsp */
+static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
+	{ .irq = 28 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* dsp -> iva */
+static struct omap_hwmod_ocp_if omap44xx_dsp__iva = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_iva_hwmod,
+	.clk		= "dpll_iva_m5_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_dsp__sl2if = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_sl2if_hwmod,
+	.clk		= "dpll_iva_m5_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp master ports */
+static struct omap_hwmod_ocp_if *omap44xx_dsp_masters[] = {
+	&omap44xx_dsp__l3_main_1,
+	&omap44xx_dsp__l4_abe,
+	&omap44xx_dsp__iva,
+	&omap44xx_dsp__sl2if,
+};
+
+/* l4_cfg -> dsp */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_dsp_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dsp_slaves[] = {
+	&omap44xx_l4_cfg__dsp,
+};
+
+static struct omap_hwmod omap44xx_dsp_hwmod = {
+	.name		= "dsp",
+	.class		= &omap44xx_dsp_hwmod_class,
+	.mpu_irqs	= omap44xx_dsp_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dsp_irqs),
+	.main_clk	= "dsp_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_TESLA_TESLA_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dsp_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dsp_slaves),
+	.masters	= omap44xx_dsp_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_dsp_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'dss' class
+ * display sub-system
+ */
+
+static struct omap_hwmod_class omap44xx_dss_hwmod_class = {
+	.name = "dss",
+};
+
+/* dss */
+static struct omap_hwmod_irq_info omap44xx_dss_irqs[] = {
+	{ .name = "dispc", .irq = 25 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dsi1", .irq = 53 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dsi2", .irq = 84 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "hdmi", .irq = 101 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_sdma_chs[] = {
+	{ .name = "dispc", .dma_ch = 5 },
+	{ .name = "dsi1", .dma_ch = 74 },
+	{ .name = "dsi2", .dma_ch = 83 },
+	{ .name = "hdmi", .dma_ch = 75 },
+	{ .name = "rfbi", .dma_ch = 13 },
+};
+
+/* dss master ports */
+static struct omap_hwmod_ocp_if *omap44xx_dss_masters[] = {
+	&omap44xx_dss__l3_main_1,
+};
+
+/* l4_per -> dss */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__dss = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_dss_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_2 -> dss */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_dss_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dss slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
+	&omap44xx_l4_per__dss,
+	&omap44xx_l3_main_2__dss,
+};
+
+static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "extalt_clkin_ck" },
+	{ .role = "dssclk", .clk = "dpll_per_m5_ck" },
+	{ .role = "sys_clk", .clk = "syc_clk_div_ck" },
+	{ .role = "48mhz_clk", .clk = "func_48mc_fclk" },
+};
+
+static struct omap_hwmod omap44xx_dss_hwmod = {
+	.name		= "dss",
+	.class		= &omap44xx_dss_hwmod_class,
+	.mpu_irqs	= omap44xx_dss_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_irqs),
+	.sdma_chs	= omap44xx_dss_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(omap44xx_dss_sdma_chs),
+	.main_clk	= "dss_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
+		},
+	},
+	.opt_clks	= dss_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
+	.slaves		= omap44xx_dss_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_slaves),
+	.masters	= omap44xx_dss_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_dss_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'elm' class
+ * bch error location module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_elm_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_elm_hwmod_class = {
+	.name = "elm",
+	.sysc = &omap44xx_elm_sysc,
+};
+
+/* elm */
+static struct omap_hwmod omap44xx_elm_hwmod;
+static struct omap_hwmod_irq_info omap44xx_elm_irqs[] = {
+	{ .irq = 4 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_elm_addrs[] = {
+	{
+		.pa_start	= 0x48078000,
+		.pa_end		= 0x48078fff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> elm */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_elm_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_elm_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_elm_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* elm slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_elm_slaves[] = {
+	&omap44xx_l4_per__elm,
+};
+
+static struct omap_hwmod omap44xx_elm_hwmod = {
+	.name		= "elm",
+	.class		= &omap44xx_elm_hwmod_class,
+	.mpu_irqs	= omap44xx_elm_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_elm_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_ELM_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_elm_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_elm_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'emif' class
  * external memory interface no1
  */
@@ -629,6 +1197,77 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 };
 
 /*
+ * 'fdif' class
+ * face detection hw accelerator module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_MIDLEMODE | SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_fdif_hwmod_class = {
+	.name = "fdif",
+	.sysc = &omap44xx_fdif_sysc,
+};
+
+/* fdif */
+static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] = {
+	{ .irq = 69 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] = {
+	{
+		.pa_start	= 0x4a10a000,
+		.pa_end		= 0x4a10a1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* fdif master ports */
+static struct omap_hwmod_ocp_if *omap44xx_fdif_masters[] = {
+	&omap44xx_fdif__l3_main_2,
+};
+
+/* l4_cfg -> fdif */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_fdif_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_fdif_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_fdif_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* fdif slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_fdif_slaves[] = {
+	&omap44xx_l4_cfg__fdif,
+};
+
+static struct omap_hwmod omap44xx_fdif_hwmod = {
+	.name		= "fdif",
+	.class		= &omap44xx_fdif_hwmod_class,
+	.mpu_irqs	= omap44xx_fdif_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_fdif_irqs),
+	.main_clk	= "fdif_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_CAM_FDIF_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_fdif_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_fdif_slaves),
+	.masters	= omap44xx_fdif_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_fdif_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'gpio' class
  * general purpose io module
  */
@@ -1027,6 +1666,130 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 };
 
 /*
+ * 'gpu' class
+ * 2d/3d graphics accelerator
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpu_sysc = {
+	.rev_offs	= 0xfe00,
+	.sysc_offs	= 0xfe10,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
+			   SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_gpu_hwmod_class = {
+	.name = "gpu",
+	.sysc = &omap44xx_gpu_sysc,
+};
+
+/* gpu */
+static struct omap_hwmod_irq_info omap44xx_gpu_irqs[] = {
+	{ .irq = 21 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpu_addrs[] = {
+	{
+		.pa_start	= 0x56000000,
+		.pa_end		= 0x5600ffff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* gpu master ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpu_masters[] = {
+	&omap44xx_gpu__l3_main_2,
+};
+
+/* l3_main_2 -> gpu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpu = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_gpu_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_gpu_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpu_slaves[] = {
+	&omap44xx_l3_main_2__gpu,
+};
+
+static struct omap_hwmod omap44xx_gpu_hwmod = {
+	.name		= "gpu",
+	.class		= &omap44xx_gpu_hwmod_class,
+	.mpu_irqs	= omap44xx_gpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpu_irqs),
+	.main_clk	= "gpu_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_GFX_GFX_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_gpu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpu_slaves),
+	.masters	= omap44xx_gpu_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_gpu_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'hsi' class
+ * mipi high-speed synchronous serial interface (multichannel and full-duplex
+ * serial if)
+ */
+
+static struct omap_hwmod_class omap44xx_hsi_hwmod_class = {
+	.name = "hsi",
+};
+
+/* hsi */
+static struct omap_hwmod_irq_info omap44xx_hsi_irqs[] = {
+	{ .name = "mpu_dma", .irq = 71 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "mpu_p1", .irq = 67 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "mpu_p2", .irq = 68 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* hsi master ports */
+static struct omap_hwmod_ocp_if *omap44xx_hsi_masters[] = {
+	&omap44xx_hsi__l3_main_2,
+};
+
+/* l4_cfg -> hsi */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__hsi = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_hsi_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* hsi slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_hsi_slaves[] = {
+	&omap44xx_l4_cfg__hsi,
+};
+
+static struct omap_hwmod omap44xx_hsi_hwmod = {
+	.name		= "hsi",
+	.class		= &omap44xx_hsi_hwmod_class,
+	.mpu_irqs	= omap44xx_hsi_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_hsi_irqs),
+	.main_clk	= "hsi_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_HSI_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_hsi_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_hsi_slaves),
+	.masters	= omap44xx_hsi_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_hsi_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'i2c' class
  * multimaster high-speed i2c controller
  */
@@ -1255,6 +2018,184 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 };
 
 /*
+ * 'ipu' class
+ * imaging processor unit
+ */
+
+static struct omap_hwmod_class omap44xx_ipu_hwmod_class = {
+	.name = "ipu",
+};
+
+/* ipu */
+static struct omap_hwmod_irq_info omap44xx_ipu_irqs[] = {
+	{ .irq = 100 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* ipu master ports */
+static struct omap_hwmod_ocp_if *omap44xx_ipu_masters[] = {
+	&omap44xx_ipu__l3_main_2,
+};
+
+/* l3_main_2 -> ipu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ipu = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_ipu_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ipu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_ipu_slaves[] = {
+	&omap44xx_l3_main_2__ipu,
+};
+
+static struct omap_hwmod omap44xx_ipu_hwmod = {
+	.name		= "ipu",
+	.class		= &omap44xx_ipu_hwmod_class,
+	.mpu_irqs	= omap44xx_ipu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_ipu_irqs),
+	.main_clk	= "ipu_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_ipu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_ipu_slaves),
+	.masters	= omap44xx_ipu_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_ipu_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'iss' class
+ * external images sensor pixel data processor
+ */
+
+static struct omap_hwmod_class omap44xx_iss_hwmod_class = {
+	.name = "iss",
+};
+
+/* iss */
+static struct omap_hwmod_irq_info omap44xx_iss_irqs[] = {
+	{ .irq = 24 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_iss_sdma_chs[] = {
+	{ .name = "1", .dma_ch = 8 },
+	{ .name = "2", .dma_ch = 9 },
+	{ .name = "3", .dma_ch = 11 },
+	{ .name = "4", .dma_ch = 12 },
+};
+
+/* iss master ports */
+static struct omap_hwmod_ocp_if *omap44xx_iss_masters[] = {
+	&omap44xx_iss__l3_main_2,
+};
+
+/* l3_main_2 -> iss */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iss = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_iss_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iss slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_iss_slaves[] = {
+	&omap44xx_l3_main_2__iss,
+};
+
+static struct omap_hwmod_opt_clk iss_opt_clks[] = {
+	{ .role = "ctrlclk", .clk = "func_96m_fclk" },
+};
+
+static struct omap_hwmod omap44xx_iss_hwmod = {
+	.name		= "iss",
+	.class		= &omap44xx_iss_hwmod_class,
+	.mpu_irqs	= omap44xx_iss_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_iss_irqs),
+	.sdma_chs	= omap44xx_iss_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(omap44xx_iss_sdma_chs),
+	.main_clk	= "iss_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_CAM_ISS_CLKCTRL,
+		},
+	},
+	.opt_clks	= iss_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(iss_opt_clks),
+	.slaves		= omap44xx_iss_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_iss_slaves),
+	.masters	= omap44xx_iss_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_iss_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'iva' class
+ * multi-standard video encoder/decoder hardware accelerator
+ */
+
+static struct omap_hwmod_class omap44xx_iva_hwmod_class = {
+	.name = "iva",
+};
+
+/* iva */
+static struct omap_hwmod_irq_info omap44xx_iva_irqs[] = {
+	{ .name = "mailbox_0", .irq = 107 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "sync_0", .irq = 104 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "sync_1", .irq = 103 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* iva -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_iva__sl2if = {
+	.master		= &omap44xx_iva_hwmod,
+	.slave		= &omap44xx_sl2if_hwmod,
+	.clk		= "dpll_iva_m5_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iva master ports */
+static struct omap_hwmod_ocp_if *omap44xx_iva_masters[] = {
+	&omap44xx_iva__sl2if,
+	&omap44xx_iva__l3_main_2,
+	&omap44xx_iva__l3_instr,
+};
+
+/* l3_main_2 -> iva */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iva = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_iva_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* iva slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_iva_slaves[] = {
+	&omap44xx_l3_main_2__iva,
+	&omap44xx_dsp__iva,
+};
+
+static struct omap_hwmod omap44xx_iva_hwmod = {
+	.name		= "iva",
+	.class		= &omap44xx_iva_hwmod_class,
+	.mpu_irqs	= omap44xx_iva_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_iva_irqs),
+	.main_clk	= "iva_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_iva_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_iva_slaves),
+	.masters	= omap44xx_iva_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_iva_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'kbd' class
  * keyboard controller
  */
@@ -1321,6 +2262,70 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 };
 
 /*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors
+ * useusing a queued mailbox-interrupt mechanism.
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mailbox_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap44xx_mailbox_sysc,
+};
+
+/* mailbox */
+static struct omap_hwmod omap44xx_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
+	{ .irq = 26 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x4a0f4000,
+		.pa_end		= 0x4a0f41ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> mailbox */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_mailbox_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mailbox_slaves[] = {
+	&omap44xx_l4_cfg__mailbox,
+};
+
+static struct omap_hwmod omap44xx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap44xx_mailbox_hwmod_class,
+	.mpu_irqs	= omap44xx_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'mcbsp' class
  * multi channel buffered serial port controller
  */
@@ -2192,6 +3197,417 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
+ * 'sl2if' class
+ * shared level 2 memory interface
+ */
+
+static struct omap_hwmod_class omap44xx_sl2if_hwmod_class = {
+	.name = "sl2if",
+};
+
+/* sl2if */
+/* l3_main_2 -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_sl2if_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* sl2if slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_sl2if_slaves[] = {
+	&omap44xx_l3_main_2__sl2if,
+	&omap44xx_iva__sl2if,
+	&omap44xx_dsp__sl2if,
+};
+
+static struct omap_hwmod omap44xx_sl2if_hwmod = {
+	.name		= "sl2if",
+	.class		= &omap44xx_sl2if_hwmod_class,
+	.main_clk	= "sl2if_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_IVAHD_SL2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_sl2if_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_sl2if_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'slimbus' class
+ * bidirectional, multi-drop, multi-channel two-line serial interface between
+ * the device and external components
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_slimbus_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_slimbus_hwmod_class = {
+	.name = "slimbus",
+	.sysc = &omap44xx_slimbus_sysc,
+};
+
+/* slimbus1 */
+static struct omap_hwmod omap44xx_slimbus1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_slimbus1_irqs[] = {
+	{ .irq = 97 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus1_sdma_chs[] = {
+	{ .name = "rx0", .dma_ch = 88 },
+	{ .name = "rx1", .dma_ch = 89 },
+	{ .name = "rx2", .dma_ch = 90 },
+	{ .name = "rx3", .dma_ch = 91 },
+	{ .name = "tx0", .dma_ch = 84 },
+	{ .name = "tx1", .dma_ch = 85 },
+	{ .name = "tx2", .dma_ch = 86 },
+	{ .name = "tx3", .dma_ch = 87 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] = {
+	{
+		.pa_start	= 0x4902c000,
+		.pa_end		= 0x4902c0ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> slimbus1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_slimbus1_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_slimbus1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_slimbus1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* slimbus1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_slimbus1_slaves[] = {
+	&omap44xx_l4_abe__slimbus1,
+};
+
+static struct omap_hwmod_opt_clk slimbus1_opt_clks[] = {
+	{ .role = "slimbus_clk_11_11", .clk = "slimbus_clk" },
+	{ .role = "fclk0", .clk = "abe_24m_fclk" },
+	{ .role = "fclk1", .clk = "func_24m_clk" },
+	{ .role = "fclk2", .clk = "pad_clks_ck" },
+};
+
+static struct omap_hwmod omap44xx_slimbus1_hwmod = {
+	.name		= "slimbus1",
+	.class		= &omap44xx_slimbus_hwmod_class,
+	.mpu_irqs	= omap44xx_slimbus1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_slimbus1_irqs),
+	.sdma_chs	= omap44xx_slimbus1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(omap44xx_slimbus1_sdma_chs),
+	.main_clk	= "slimbus1_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
+		},
+	},
+	.opt_clks	= slimbus1_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(slimbus1_opt_clks),
+	.slaves		= omap44xx_slimbus1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_slimbus1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* slimbus2 */
+static struct omap_hwmod omap44xx_slimbus2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_slimbus2_irqs[] = {
+	{ .irq = 98 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus2_sdma_chs[] = {
+	{ .name = "rx0", .dma_ch = 96 },
+	{ .name = "rx1", .dma_ch = 97 },
+	{ .name = "rx2", .dma_ch = 98 },
+	{ .name = "rx3", .dma_ch = 99 },
+	{ .name = "tx0", .dma_ch = 92 },
+	{ .name = "tx1", .dma_ch = 93 },
+	{ .name = "tx2", .dma_ch = 94 },
+	{ .name = "tx3", .dma_ch = 95 },
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] = {
+	{
+		.pa_start	= 0x48076000,
+		.pa_end		= 0x480760ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> slimbus2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_slimbus2_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_slimbus2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_slimbus2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* slimbus2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_slimbus2_slaves[] = {
+	&omap44xx_l4_per__slimbus2,
+};
+
+static struct omap_hwmod_opt_clk slimbus2_opt_clks[] = {
+	{ .role = "perabe24m_gfclk", .clk = "per_abe_24m_fclk" },
+	{ .role = "slimbus_clk", .clk = "pad_slimbus_core_clks_ck" },
+	{ .role = "per24mc_gfclk", .clk = "func_24mc_fclk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus2_hwmod = {
+	.name		= "slimbus2",
+	.class		= &omap44xx_slimbus_hwmod_class,
+	.mpu_irqs	= omap44xx_slimbus2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_slimbus2_irqs),
+	.sdma_chs	= omap44xx_slimbus2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(omap44xx_slimbus2_sdma_chs),
+	.main_clk	= "slimbus2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
+		},
+	},
+	.opt_clks	= slimbus2_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(slimbus2_opt_clks),
+	.slaves		= omap44xx_slimbus2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_slimbus2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'smartreflex' class
+ * smartreflex module (monitor silicon performance and outputs a measure of
+ * performance error)
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
+	.sidle_shift	= 24,
+	.enwkup_shift	= 26,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
+	.sysc_offs	= 0x0038,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
+};
+
+static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
+	.name = "smartreflex",
+	.sysc = &omap44xx_smartreflex_sysc,
+};
+
+/* smartreflex_core */
+static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
+static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
+	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
+	{
+		.pa_start	= 0x4a0dd000,
+		.pa_end		= 0x4a0dd03f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> smartreflex_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_smartreflex_core_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_smartreflex_core_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* smartreflex_core slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
+	&omap44xx_l4_cfg__smartreflex_core,
+};
+
+static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
+	.name		= "smartreflex_core",
+	.class		= &omap44xx_smartreflex_hwmod_class,
+	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_irqs),
+	.main_clk	= "smartreflex_core_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_smartreflex_core_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* smartreflex_iva */
+static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
+static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
+	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
+	{
+		.pa_start	= 0x4a0db000,
+		.pa_end		= 0x4a0db03f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> smartreflex_iva */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_smartreflex_iva_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_smartreflex_iva_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* smartreflex_iva slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
+	&omap44xx_l4_cfg__smartreflex_iva,
+};
+
+static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
+	.name		= "smartreflex_iva",
+	.class		= &omap44xx_smartreflex_hwmod_class,
+	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_irqs),
+	.main_clk	= "smartreflex_iva_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_smartreflex_iva_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* smartreflex_mpu */
+static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
+static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
+	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] = {
+	{
+		.pa_start	= 0x4a0d9000,
+		.pa_end		= 0x4a0d903f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> smartreflex_mpu */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_smartreflex_mpu_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_smartreflex_mpu_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* smartreflex_mpu slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
+	&omap44xx_l4_cfg__smartreflex_mpu,
+};
+
+static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
+	.name		= "smartreflex_mpu",
+	.class		= &omap44xx_smartreflex_hwmod_class,
+	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_irqs),
+	.main_clk	= "smartreflex_mpu_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_smartreflex_mpu_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'spinlock' class
+ * spinlock provides hardware assistance for synchronizing the processes
+ * running on multiple processors
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_spinlock_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE | SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_spinlock_hwmod_class = {
+	.name = "spinlock",
+	.sysc = &omap44xx_spinlock_sysc,
+};
+
+/* spinlock */
+static struct omap_hwmod omap44xx_spinlock_hwmod;
+static struct omap_hwmod_addr_space omap44xx_spinlock_addrs[] = {
+	{
+		.pa_start	= 0x4a0f6000,
+		.pa_end		= 0x4a0f6fff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> spinlock */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__spinlock = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_spinlock_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_spinlock_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_spinlock_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* spinlock slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_spinlock_slaves[] = {
+	&omap44xx_l4_cfg__spinlock,
+};
+
+static struct omap_hwmod omap44xx_spinlock_hwmod = {
+	.name		= "spinlock",
+	.class		= &omap44xx_spinlock_hwmod_class,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4CFG_HW_SEM_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_spinlock_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_spinlock_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'timer' class
  * general purpose timer module with accurate 1ms tick
  * This class contain several variants: ['timer_1ms', 'timer']
@@ -2951,6 +4367,407 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'usb_host_fs' class
+ * full-speed usb host controller
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs = {
+	.midle_shift	= 4,
+	.sidle_shift	= 2,
+	.srst_shift	= 1,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_usb_host_fs_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0210,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_MIDLEMODE | SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type_usb_host_fs,
+};
+
+static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class = {
+	.name = "usb_host_fs",
+	.sysc = &omap44xx_usb_host_fs_sysc,
+};
+
+/* usb_host_fs */
+static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] = {
+	{ .name = "std", .irq = 89 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "smi", .irq = 90 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] = {
+	{
+		.pa_start	= 0x4a0a9000,
+		.pa_end		= 0x4a0a93ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* usb_host_fs master ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_host_fs_masters[] = {
+	&omap44xx_usb_host_fs__l3_main_2,
+};
+
+/* l4_cfg -> usb_host_fs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_usb_host_fs_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_usb_host_fs_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_usb_host_fs_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_host_fs slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_host_fs_slaves[] = {
+	&omap44xx_l4_cfg__usb_host_fs,
+};
+
+static struct omap_hwmod omap44xx_usb_host_fs_hwmod = {
+	.name		= "usb_host_fs",
+	.class		= &omap44xx_usb_host_fs_hwmod_class,
+	.mpu_irqs	= omap44xx_usb_host_fs_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_host_fs_irqs),
+	.main_clk	= "usb_host_fs_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_usb_host_fs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_host_fs_slaves),
+	.masters	= omap44xx_usb_host_fs_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_host_fs_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'usb_host_hs' class
+ * high-speed multi-port usb host controller
+ */
+
+static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class = {
+	.name = "usb_host_hs",
+};
+
+/* usb_host_hs */
+static struct omap_hwmod_irq_info omap44xx_usb_host_hs_irqs[] = {
+	{ .name = "ehci", .irq = 77 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "ohci", .irq = 76 + OMAP44XX_IRQ_GIC_START },
+};
+
+/* usb_host_hs master ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_masters[] = {
+	&omap44xx_usb_host_hs__l3_main_2,
+};
+
+/* l4_cfg -> usb_host_hs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_usb_host_hs_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_host_hs slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_host_hs_slaves[] = {
+	&omap44xx_l4_cfg__usb_host_hs,
+};
+
+static struct omap_hwmod_opt_clk usb_host_hs_opt_clks[] = {
+	{ .role = "hsic60m_p2_clk", .clk = "init_60m_fclk" },
+	{ .role = "utmi_p2_clk", .clk = "utmi_p2_gfclk_ck" },
+	{ .role = "utmi_p1_clk", .clk = "utmi_p1_gfclk_ck" },
+	{ .role = "hsic60m_p1_clk", .clk = "init_60m_fclk" },
+	{ .role = "hsic480m_p1_clk", .clk = "dpll_usb_m2_ck" },
+	{ .role = "utmi_p3_clk", .clk = "init_60m_fclk" },
+	{ .role = "hsic480m_p2_clk", .clk = "dpll_usb_m2_ck" },
+	{ .role = "func48mclk", .clk = "func_48mc_fclk" },
+};
+
+static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
+	.name		= "usb_host_hs",
+	.class		= &omap44xx_usb_host_hs_hwmod_class,
+	.mpu_irqs	= omap44xx_usb_host_hs_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_host_hs_irqs),
+	.main_clk	= "usb_host_hs_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+		},
+	},
+	.opt_clks	= usb_host_hs_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(usb_host_hs_opt_clks),
+	.slaves		= omap44xx_usb_host_hs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_host_hs_slaves),
+	.masters	= omap44xx_usb_host_hs_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_host_hs_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'usb_otg_hs' class
+ * high-speed on-the-go universal serial bus (usb_otg_hs) controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
+	.sysc_flags	= SYSS_MISSING,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+};
+
+static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
+	.name = "usb_otg_hs",
+	.sysc = &omap44xx_usb_otg_hs_sysc,
+};
+
+/* usb_otg_hs */
+static struct omap_hwmod_irq_info omap44xx_usb_otg_hs_irqs[] = {
+	{ .name = "dma", .irq = 93 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "mc", .irq = 92 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
+	{
+		.pa_start	= 0x4a0ab000,
+		.pa_end		= 0x4a0ab003,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* usb_otg_hs master ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_masters[] = {
+	&omap44xx_usb_otg_hs__l3_main_2,
+};
+
+/* l4_cfg -> usb_otg_hs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_otg_hs = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_usb_otg_hs_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_usb_otg_hs_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_otg_hs slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_slaves[] = {
+	&omap44xx_l4_cfg__usb_otg_hs,
+};
+
+static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
+	{ .role = "xclk", .clk = "otg_60m_gfclk_ck" },
+};
+
+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
+	.name		= "usb_otg_hs",
+	.class		= &omap44xx_usb_otg_hs_hwmod_class,
+	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_irqs),
+	.main_clk	= "usb_otg_hs_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+		},
+	},
+	.opt_clks	= usb_otg_hs_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(usb_otg_hs_opt_clks),
+	.slaves		= omap44xx_usb_otg_hs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
+	.masters	= omap44xx_usb_otg_hs_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'usb_tll_hs' class
+ * usb_tll_hs module is the adapter on the usb_host_hs ports
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_usb_tll_hs_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_usb_tll_hs_hwmod_class = {
+	.name = "usb_tll_hs",
+	.sysc = &omap44xx_usb_tll_hs_sysc,
+};
+
+/* usb_tll_hs */
+static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
+static struct omap_hwmod_irq_info omap44xx_usb_tll_hs_irqs[] = {
+	{ .irq = 78 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_usb_tll_hs_addrs[] = {
+	{
+		.pa_start	= 0x4a062000,
+		.pa_end		= 0x4a0627ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> usb_tll_hs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_usb_tll_hs_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_usb_tll_hs_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_usb_tll_hs_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* usb_tll_hs slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_usb_tll_hs_slaves[] = {
+	&omap44xx_l4_cfg__usb_tll_hs,
+};
+
+static struct omap_hwmod_opt_clk usb_tll_hs_opt_clks[] = {
+	{ .role = "usb_ch1_clk", .clk = "init_60m_fclk" },
+	{ .role = "usb_ch0_clk", .clk = "init_60m_fclk" },
+	{ .role = "usb_ch2_clk", .clk = "init_60m_fclk" },
+};
+
+static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
+	.name		= "usb_tll_hs",
+	.class		= &omap44xx_usb_tll_hs_hwmod_class,
+	.mpu_irqs	= omap44xx_usb_tll_hs_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_tll_hs_irqs),
+	.main_clk	= "usb_tll_hs_ick",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
+		},
+	},
+	.opt_clks	= usb_tll_hs_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(usb_tll_hs_opt_clks),
+	.slaves		= omap44xx_usb_tll_hs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_tll_hs_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
+ * 'wd_timer' class
+ * 32-bit watchdog upward counter that generates a pulse on the reset pin on
+ * overflow condition
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap44xx_wd_timer_sysc,
+};
+
+/* wd_timer2 */
+static struct omap_hwmod omap44xx_wd_timer2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
+	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x4a314000,
+		.pa_end		= 0x4a31407f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> wd_timer2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_wd_timer2_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_wd_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* wd_timer2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_wd_timer2_slaves[] = {
+	&omap44xx_l4_wkup__wd_timer2,
+};
+
+static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap44xx_wd_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_wd_timer2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_irqs),
+	.main_clk	= "wd_timer2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* wd_timer3 */
+static struct omap_hwmod omap44xx_wd_timer3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] = {
+	{ .irq = 36 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
+	{
+		.pa_start	= 0x49030000,
+		.pa_end		= 0x4903007f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> wd_timer3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_wd_timer3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_wd_timer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* wd_timer3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_wd_timer3_slaves[] = {
+	&omap44xx_l4_abe__wd_timer3,
+};
+
+static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
+	.name		= "wd_timer3",
+	.class		= &omap44xx_wd_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_wd_timer3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_irqs),
+	.main_clk	= "wd_timer3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_WDT3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_wd_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -2967,11 +4784,25 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_per_hwmod,
 	&omap44xx_l4_wkup_hwmod,
 
+	/* aess class */
+/*	&omap44xx_aess_hwmod, */
 	/* counter class */
 	&omap44xx_counter_32k_hwmod,
+	/* dma class */
+/*	&omap44xx_dma_system_hwmod, */
+	/* dmic class */
+/*	&omap44xx_dmic_hwmod, */
+	/* dsp class */
+/*	&omap44xx_dsp_hwmod, */
+	/* dss class */
+/*	&omap44xx_dss_hwmod, */
+	/* elm class */
+/*	&omap44xx_elm_hwmod, */
 	/* emif class */
 	&omap44xx_emif1_hwmod,
 	&omap44xx_emif2_hwmod,
+	/* fdif class */
+/*	&omap44xx_fdif_hwmod, */
 	/* gpio class */
 	&omap44xx_gpio1_hwmod,
 	&omap44xx_gpio2_hwmod,
@@ -2981,13 +4812,25 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_gpio6_hwmod,
 	/* gpmc class */
 	&omap44xx_gpmc_hwmod,
+	/* gpu class */
+/*	&omap44xx_gpu_hwmod, */
+	/* hsi class */
+/*	&omap44xx_hsi_hwmod, */
 	/* i2c class */
 	&omap44xx_i2c1_hwmod,
 	&omap44xx_i2c2_hwmod,
 	&omap44xx_i2c3_hwmod,
 	&omap44xx_i2c4_hwmod,
+	/* ipu class */
+/*	&omap44xx_ipu_hwmod, */
+	/* iss class */
+/*	&omap44xx_iss_hwmod, */
+	/* iva class */
+/*	&omap44xx_iva_hwmod, */
 	/* kbd class */
 	&omap44xx_kbd_hwmod,
+	/* mailbox class */
+/*	&omap44xx_mailbox_hwmod, */
 	/* mcbsp class */
 	&omap44xx_mcbsp1_hwmod,
 	&omap44xx_mcbsp2_hwmod,
@@ -3008,6 +4851,17 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_mmc5_hwmod,
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
+	/* sl2if class */
+/*	&omap44xx_sl2if_hwmod, */
+	/* slimbus class */
+/*	&omap44xx_slimbus1_hwmod, */
+/*	&omap44xx_slimbus2_hwmod, */
+	/* smartreflex class */
+/*	&omap44xx_smartreflex_core_hwmod, */
+/*	&omap44xx_smartreflex_iva_hwmod, */
+/*	&omap44xx_smartreflex_mpu_hwmod, */
+	/* spinlock class */
+/*	&omap44xx_spinlock_hwmod, */
 	/* timer class */
 	&omap44xx_timer1_hwmod,
 	&omap44xx_timer2_hwmod,
@@ -3025,6 +4879,17 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_uart2_hwmod,
 	&omap44xx_uart3_hwmod,
 	&omap44xx_uart4_hwmod,
+	/* usb_host_fs class */
+/*	&omap44xx_usb_host_fs_hwmod, */
+	/* usb_host_hs class */
+/*	&omap44xx_usb_host_hs_hwmod, */
+	/* usb_otg_hs class */
+/*	&omap44xx_usb_otg_hs_hwmod, */
+	/* usb_tll_hs class */
+/*	&omap44xx_usb_tll_hs_hwmod, */
+	/* wd_timer class */
+/*	&omap44xx_wd_timer2_hwmod, */
+/*	&omap44xx_wd_timer3_hwmod, */
 	NULL,
 };
 
-- 
1.6.1.3

