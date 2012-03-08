From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/15] ARM: OMAP4: hwmod data: add some interconnect-related
 IP blocks
Date: Thu, 08 Mar 2012 03:51:33 -0700
Message-ID: <20120308105133.14753.52890.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47066 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab2CHKxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:37 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the SL2 interface IP block and interconnect data.  The SL2 is relat=
ed
to the IVA-HD subsystem.

Add IP block and interconnect data for the C2C ("Chip-to-chip")
interconnect.  This can provide a direct system interconnect link to
other devices stacked on the OMAP package.

Add the ELM IP block and interconnect data.  The ELM can be used
to locate errors in NAND flash connected to the GPMC.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  224 ++++++++++++++++++=
++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1=20
 2 files changed, 221 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 3be64f5..8d3a7c1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -50,6 +50,27 @@
  */
=20
 /*
+ * 'c2c_target_fw' class
+ * instance(s): c2c_target_fw
+ */
+static struct omap_hwmod_class omap44xx_c2c_target_fw_hwmod_class =3D =
{
+	.name	=3D "c2c_target_fw",
+};
+
+/* c2c_target_fw */
+static struct omap_hwmod omap44xx_c2c_target_fw_hwmod =3D {
+	.name		=3D "c2c_target_fw",
+	.class		=3D &omap44xx_c2c_target_fw_hwmod_class,
+	.clkdm_name	=3D "d2d_clkdm",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_D2D_SAD2D_FW_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_D2D_SAD2D_FW_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'dmm' class
  * instance(s): dmm
  */
@@ -248,8 +269,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  c2c
- *  c2c_target_fw
  *  cm_core
  *  cm_core_aon
  *  ctrl_module_core
@@ -259,7 +278,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
- *  elm
  *  mpu_c0
  *  mpu_c1
  *  ocmc_ram
@@ -268,7 +286,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  prcm_mpu
  *  prm
  *  scrm
- *  sl2if
  *  usb_host_fs
  *  usb_host_hs
  *  usb_phy_cm
@@ -331,6 +348,41 @@ static struct omap_hwmod omap44xx_aess_hwmod =3D {
 };
=20
 /*
+ * 'c2c' class
+ * chip 2 chip interface used to plug the ape soc (omap) with an exter=
nal modem
+ * soc
+ */
+
+static struct omap_hwmod_class omap44xx_c2c_hwmod_class =3D {
+	.name	=3D "c2c",
+};
+
+/* c2c */
+static struct omap_hwmod_irq_info omap44xx_c2c_irqs[] =3D {
+	{ .irq =3D 88 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_c2c_sdma_reqs[] =3D {
+	{ .dma_req =3D 68 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_c2c_hwmod =3D {
+	.name		=3D "c2c",
+	.class		=3D &omap44xx_c2c_hwmod_class,
+	.clkdm_name	=3D "d2d_clkdm",
+	.mpu_irqs	=3D omap44xx_c2c_irqs,
+	.sdma_reqs	=3D omap44xx_c2c_sdma_reqs,
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_D2D_SAD2D_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_D2D_SAD2D_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz =
clock
  */
@@ -806,6 +858,46 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod =3D=
 {
 };
=20
 /*
+ * 'elm' class
+ * bch error location module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_elm_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0010,
+	.syss_offs	=3D 0x0014,
+	.sysc_flags	=3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_elm_hwmod_class =3D {
+	.name	=3D "elm",
+	.sysc	=3D &omap44xx_elm_sysc,
+};
+
+/* elm */
+static struct omap_hwmod_irq_info omap44xx_elm_irqs[] =3D {
+	{ .irq =3D 4 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_elm_hwmod =3D {
+	.name		=3D "elm",
+	.class		=3D &omap44xx_elm_hwmod_class,
+	.clkdm_name	=3D "l4_per_clkdm",
+	.mpu_irqs	=3D omap44xx_elm_irqs,
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L4PER_ELM_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'emif' class
  * external memory interface no1
  */
@@ -2268,6 +2360,29 @@ static struct omap_hwmod omap44xx_mpu_hwmod =3D =
{
 };
=20
 /*
+ * 'sl2if' class
+ * shared level 2 memory interface
+ */
+
+static struct omap_hwmod_class omap44xx_sl2if_hwmod_class =3D {
+	.name	=3D "sl2if",
+};
+
+/* sl2if */
+static struct omap_hwmod omap44xx_sl2if_hwmod =3D {
+	.name		=3D "sl2if",
+	.class		=3D &omap44xx_sl2if_hwmod_class,
+	.clkdm_name	=3D "ivahd_clkdm",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_IVAHD_SL2_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_IVAHD_SL2_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'slimbus' class
  * bidirectional, multi-drop, multi-channel two-line serial interface =
between
  * the device and external components
@@ -3181,6 +3296,32 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmo=
d =3D {
  * interfaces
  */
=20
+static struct omap_hwmod_addr_space omap44xx_c2c_target_fw_addrs[] =3D=
 {
+	{
+		.pa_start	=3D 0x4a204000,
+		.pa_end		=3D 0x4a2040ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* c2c -> c2c_target_fw */
+static struct omap_hwmod_ocp_if omap44xx_c2c__c2c_target_fw =3D {
+	.master		=3D &omap44xx_c2c_hwmod,
+	.slave		=3D &omap44xx_c2c_target_fw_hwmod,
+	.clk		=3D "div_core_ck",
+	.addr		=3D omap44xx_c2c_target_fw_addrs,
+	.user		=3D OCP_USER_MPU,
+};
+
+/* l4_cfg -> c2c_target_fw */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__c2c_target_fw =3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_c2c_target_fw_hwmod,
+	.clk		=3D "l4_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> dmm */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm =3D {
 	.master		=3D &omap44xx_l3_main_1_hwmod,
@@ -3207,6 +3348,14 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__dm=
m =3D {
 	.user		=3D OCP_USER_MPU,
 };
=20
+/* c2c -> emif_fw */
+static struct omap_hwmod_ocp_if omap44xx_c2c__emif_fw =3D {
+	.master		=3D &omap44xx_c2c_hwmod,
+	.slave		=3D &omap44xx_emif_fw_hwmod,
+	.clk		=3D "div_core_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dmm -> emif_fw */
 static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw =3D {
 	.master		=3D &omap44xx_dmm_hwmod,
@@ -3315,6 +3464,14 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3=
_main_1 =3D {
 	.user		=3D OCP_USER_MPU,
 };
=20
+/* c2c_target_fw -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_c2c_target_fw__l3_main_2 =3D =
{
+	.master		=3D &omap44xx_c2c_target_fw_hwmod,
+	.slave		=3D &omap44xx_l3_main_2_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dma_system -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 =3D {
 	.master		=3D &omap44xx_dma_system_hwmod,
@@ -3547,6 +3704,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe_=
_aess_dma =3D {
 	.user		=3D OCP_USER_SDMA,
 };
=20
+/* l3_main_2 -> c2c */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__c2c =3D {
+	.master		=3D &omap44xx_l3_main_2_hwmod,
+	.slave		=3D &omap44xx_c2c_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_counter_32k_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4a304000,
@@ -3629,6 +3794,14 @@ static struct omap_hwmod_ocp_if omap44xx_dsp__iv=
a =3D {
 	.user		=3D OCP_USER_DSP,
 };
=20
+/* dsp -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_dsp__sl2if =3D {
+	.master		=3D &omap44xx_dsp_hwmod,
+	.slave		=3D &omap44xx_sl2if_hwmod,
+	.clk		=3D "dpll_iva_m5x2_ck",
+	.user		=3D OCP_USER_DSP,
+};
+
 /* l4_cfg -> dsp */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
@@ -3889,6 +4062,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_dss_venc =3D {
 	.user		=3D OCP_USER_MPU,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_elm_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48078000,
+		.pa_end		=3D 0x48078fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> elm */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__elm =3D {
+	.master		=3D &omap44xx_l4_per_hwmod,
+	.slave		=3D &omap44xx_elm_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_elm_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_emif1_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4c000000,
@@ -4221,6 +4412,14 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main=
_2__iss =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* iva -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_iva__sl2if =3D {
+	.master		=3D &omap44xx_iva_hwmod,
+	.slave		=3D &omap44xx_sl2if_hwmod,
+	.clk		=3D "dpll_iva_m5x2_ck",
+	.user		=3D OCP_USER_IVA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_iva_addrs[] =3D {
 	{
 		.pa_start	=3D 0x5a000000,
@@ -4641,6 +4840,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_mmc5 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* l3_main_2 -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if =3D {
+	.master		=3D &omap44xx_l3_main_2_hwmod,
+	.slave		=3D &omap44xx_sl2if_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4012c000,
@@ -5230,8 +5437,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe_=
_wd_timer3_dma =3D {
 };
=20
 static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata =3D=
 {
+	&omap44xx_c2c__c2c_target_fw,
+	&omap44xx_l4_cfg__c2c_target_fw,
 	&omap44xx_l3_main_1__dmm,
 	&omap44xx_mpu__dmm,
+	&omap44xx_c2c__emif_fw,
 	&omap44xx_dmm__emif_fw,
 	&omap44xx_l4_cfg__emif_fw,
 	&omap44xx_iva__l3_instr,
@@ -5243,6 +5453,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_mmc1__l3_main_1,
 	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
+	&omap44xx_c2c_target_fw__l3_main_2,
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
 	&omap44xx_gpu__l3_main_2,
@@ -5267,11 +5478,13 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod=
_ocp_ifs[] __initdata =3D {
 	&omap44xx_mpu__mpu_private,
 	&omap44xx_l4_abe__aess,
 	&omap44xx_l4_abe__aess_dma,
+	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,
 	&omap44xx_dsp__iva,
+	&omap44xx_dsp__sl2if,
 	&omap44xx_l4_cfg__dsp,
 	&omap44xx_l3_main_2__dss,
 	&omap44xx_l4_per__dss,
@@ -5287,6 +5500,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
+	&omap44xx_l4_per__elm,
 	&omap44xx_emif_fw__emif1,
 	&omap44xx_emif_fw__emif2,
 	&omap44xx_l4_cfg__fdif,
@@ -5306,6 +5520,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__i2c4,
 	&omap44xx_l3_main_2__ipu,
 	&omap44xx_l3_main_2__iss,
+	&omap44xx_iva__sl2if,
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
@@ -5329,6 +5544,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
 	&omap44xx_l4_per__slimbus2,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 8c39f70..965d8ab 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -214,6 +214,7 @@ struct omap_hwmod_addr_space {
 #define OCP_USER_MPU			(1 << 0)
 #define OCP_USER_SDMA			(1 << 1)
 #define OCP_USER_DSP			(1 << 2)
+#define OCP_USER_IVA			(1 << 3)
=20
 /* omap_hwmod_ocp_if.flags bits */
 #define OCPIF_SWSUP_IDLE		(1 << 0)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
