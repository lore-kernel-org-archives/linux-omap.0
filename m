From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
Date: Fri, 7 Sep 2012 20:25:02 +0300
Message-ID: <20120907172500.GB9208@arwen.pp.htv.fi>
References: <504A11E4.6000406@ti.com>
 <20120907170621.GZ1303@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5550337259419512770=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120907170621.GZ1303@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Felipe Balbi <balbi@ti.com>, santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============5550337259419512770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 07, 2012 at 10:06:22AM -0700, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [120907 08:26]:
> > Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> > (ARM: OMAP: omap_device: Fix up resource names when booted with devicet=
re),
> > we can now specify reg and interrupts using standard device tree
> > attributes.
> >=20
> > Update the OMAP4 dtsi file with missing reg and interrupts attributes.
> >=20
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > Hi Tony,
> >=20
> > This is the first step toward reduction of the hwmod data inside mach-o=
map2.
> > OMAP2/3/4 data still need to be there for legacy boards, but it will al=
low
> > OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwm=
od.
>=20
> That's good to hear, that should cut down the data by some hundreds of li=
nes :)

more than you think, I guess :-)

commit ed674f12d10f8ebb52758d122ed196a8f0ddabc6
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Sep 7 20:21:36 2012 +0300

    DO NOT APPLY
   =20
    $ sed -i '/omap_hwmod_addr_space/,/};/d' arch/arm/mach-omap2/omap_hwmod=
_44xx_data.c
    $ sed -i '/omap_hwmod_irq_info/,/};/d' arch/arm/mach-omap2/omap_hwmod_4=
4xx_data.c
    $ sed -i '/.mpu_irqs.*$/d' arch/arm/mach-omap2/omap_hwmod_44xx_data.c
    $ sed -i '/.addr.*$/d' arch/arm/mach-omap2/omap_hwmod_44xx_data.c
   =20
    NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 242aee4..9c63898 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -79,16 +79,11 @@ static struct omap_hwmod_class omap44xx_dmm_hwmod_class=
 =3D {
 };
=20
 /* dmm */
-static struct omap_hwmod_irq_info omap44xx_dmm_irqs[] =3D {
-	{ .irq =3D 113 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_dmm_hwmod =3D {
 	.name		=3D "dmm",
 	.class		=3D &omap44xx_dmm_hwmod_class,
 	.clkdm_name	=3D "l3_emif_clkdm",
-	.mpu_irqs	=3D omap44xx_dmm_irqs,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
@@ -141,17 +136,11 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod =3D {
 };
=20
 /* l3_main_1 */
-static struct omap_hwmod_irq_info omap44xx_l3_main_1_irqs[] =3D {
-	{ .name =3D "dbg_err", .irq =3D 9 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "app_err", .irq =3D 10 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_l3_main_1_hwmod =3D {
 	.name		=3D "l3_main_1",
 	.class		=3D &omap44xx_l3_hwmod_class,
 	.clkdm_name	=3D "l3_1_clkdm",
-	.mpu_irqs	=3D omap44xx_l3_main_1_irqs,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
@@ -315,10 +304,6 @@ static struct omap_hwmod_class omap44xx_aess_hwmod_cla=
ss =3D {
 };
=20
 /* aess */
-static struct omap_hwmod_irq_info omap44xx_aess_irqs[] =3D {
-	{ .irq =3D 99 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_aess_sdma_reqs[] =3D {
 	{ .name =3D "fifo0", .dma_req =3D 100 + OMAP44XX_DMA_REQ_START },
@@ -336,7 +321,6 @@ static struct omap_hwmod omap44xx_aess_hwmod =3D {
 	.name		=3D "aess",
 	.class		=3D &omap44xx_aess_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_aess_irqs,
 	.sdma_reqs	=3D omap44xx_aess_sdma_reqs,
 	.main_clk	=3D "aess_fck",
 	.prcm =3D {
@@ -359,10 +343,6 @@ static struct omap_hwmod_class omap44xx_c2c_hwmod_clas=
s =3D {
 };
=20
 /* c2c */
-static struct omap_hwmod_irq_info omap44xx_c2c_irqs[] =3D {
-	{ .irq =3D 88 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_c2c_sdma_reqs[] =3D {
 	{ .dma_req =3D 68 + OMAP44XX_DMA_REQ_START },
@@ -373,7 +353,6 @@ static struct omap_hwmod omap44xx_c2c_hwmod =3D {
 	.name		=3D "c2c",
 	.class		=3D &omap44xx_c2c_hwmod_class,
 	.clkdm_name	=3D "d2d_clkdm",
-	.mpu_irqs	=3D omap44xx_c2c_irqs,
 	.sdma_reqs	=3D omap44xx_c2c_sdma_reqs,
 	.prcm =3D {
 		.omap4 =3D {
@@ -437,16 +416,11 @@ static struct omap_hwmod_class omap44xx_ctrl_module_h=
wmod_class =3D {
 };
=20
 /* ctrl_module_core */
-static struct omap_hwmod_irq_info omap44xx_ctrl_module_core_irqs[] =3D {
-	{ .irq =3D 8 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_ctrl_module_core_hwmod =3D {
 	.name		=3D "ctrl_module_core",
 	.class		=3D &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	=3D "l4_cfg_clkdm",
-	.mpu_irqs	=3D omap44xx_ctrl_module_core_irqs,
 };
=20
 /* ctrl_module_pad_core */
@@ -525,19 +499,11 @@ static struct omap_dma_dev_attr dma_dev_attr =3D {
 };
=20
 /* dma_system */
-static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] =3D {
-	{ .name =3D "0", .irq =3D 12 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "1", .irq =3D 13 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "2", .irq =3D 14 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "3", .irq =3D 15 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_dma_system_hwmod =3D {
 	.name		=3D "dma_system",
 	.class		=3D &omap44xx_dma_hwmod_class,
 	.clkdm_name	=3D "l3_dma_clkdm",
-	.mpu_irqs	=3D omap44xx_dma_system_irqs,
 	.main_clk	=3D "l3_div_ck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -569,10 +535,6 @@ static struct omap_hwmod_class omap44xx_dmic_hwmod_cla=
ss =3D {
 };
=20
 /* dmic */
-static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] =3D {
-	{ .irq =3D 114 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] =3D {
 	{ .dma_req =3D 66 + OMAP44XX_DMA_REQ_START },
@@ -583,7 +545,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod =3D {
 	.name		=3D "dmic",
 	.class		=3D &omap44xx_dmic_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_dmic_irqs,
 	.sdma_reqs	=3D omap44xx_dmic_sdma_reqs,
 	.main_clk	=3D "dmic_fck",
 	.prcm =3D {
@@ -605,10 +566,6 @@ static struct omap_hwmod_class omap44xx_dsp_hwmod_clas=
s =3D {
 };
=20
 /* dsp */
-static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] =3D {
-	{ .irq =3D 28 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_rst_info omap44xx_dsp_resets[] =3D {
 	{ .name =3D "dsp", .rst_shift =3D 0 },
@@ -619,7 +576,6 @@ static struct omap_hwmod omap44xx_dsp_hwmod =3D {
 	.name		=3D "dsp",
 	.class		=3D &omap44xx_dsp_hwmod_class,
 	.clkdm_name	=3D "tesla_clkdm",
-	.mpu_irqs	=3D omap44xx_dsp_irqs,
 	.rst_lines	=3D omap44xx_dsp_resets,
 	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_dsp_resets),
 	.main_clk	=3D "dsp_fck",
@@ -697,10 +653,6 @@ static struct omap_hwmod_class omap44xx_dispc_hwmod_cl=
ass =3D {
 };
=20
 /* dss_dispc */
-static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] =3D {
-	{ .irq =3D 25 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] =3D {
 	{ .dma_req =3D 5 + OMAP44XX_DMA_REQ_START },
@@ -716,7 +668,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod =3D {
 	.name		=3D "dss_dispc",
 	.class		=3D &omap44xx_dispc_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
-	.mpu_irqs	=3D omap44xx_dss_dispc_irqs,
 	.sdma_reqs	=3D omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
@@ -750,10 +701,6 @@ static struct omap_hwmod_class omap44xx_dsi_hwmod_clas=
s =3D {
 };
=20
 /* dss_dsi1 */
-static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] =3D {
-	{ .irq =3D 53 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] =3D {
 	{ .dma_req =3D 74 + OMAP44XX_DMA_REQ_START },
@@ -768,7 +715,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod =3D {
 	.name		=3D "dss_dsi1",
 	.class		=3D &omap44xx_dsi_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
-	.mpu_irqs	=3D omap44xx_dss_dsi1_irqs,
 	.sdma_reqs	=3D omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
@@ -782,10 +728,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod =3D {
 };
=20
 /* dss_dsi2 */
-static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] =3D {
-	{ .irq =3D 84 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] =3D {
 	{ .dma_req =3D 83 + OMAP44XX_DMA_REQ_START },
@@ -800,7 +742,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod =3D {
 	.name		=3D "dss_dsi2",
 	.class		=3D &omap44xx_dsi_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
-	.mpu_irqs	=3D omap44xx_dss_dsi2_irqs,
 	.sdma_reqs	=3D omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
@@ -834,10 +775,6 @@ static struct omap_hwmod_class omap44xx_hdmi_hwmod_cla=
ss =3D {
 };
=20
 /* dss_hdmi */
-static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] =3D {
-	{ .irq =3D 101 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] =3D {
 	{ .dma_req =3D 75 + OMAP44XX_DMA_REQ_START },
@@ -857,7 +794,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod =3D {
 	 * set idle mode by software.
 	 */
 	.flags		=3D HWMOD_SWSUP_SIDLE,
-	.mpu_irqs	=3D omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	=3D omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	=3D "dss_48mhz_clk",
 	.prcm =3D {
@@ -961,16 +897,11 @@ static struct omap_hwmod_class omap44xx_elm_hwmod_cla=
ss =3D {
 };
=20
 /* elm */
-static struct omap_hwmod_irq_info omap44xx_elm_irqs[] =3D {
-	{ .irq =3D 4 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_elm_hwmod =3D {
 	.name		=3D "elm",
 	.class		=3D &omap44xx_elm_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_elm_irqs,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET,
@@ -994,17 +925,12 @@ static struct omap_hwmod_class omap44xx_emif_hwmod_cl=
ass =3D {
 };
=20
 /* emif1 */
-static struct omap_hwmod_irq_info omap44xx_emif1_irqs[] =3D {
-	{ .irq =3D 110 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_emif1_hwmod =3D {
 	.name		=3D "emif1",
 	.class		=3D &omap44xx_emif_hwmod_class,
 	.clkdm_name	=3D "l3_emif_clkdm",
 	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	=3D omap44xx_emif1_irqs,
 	.main_clk	=3D "ddrphy_ck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1016,17 +942,12 @@ static struct omap_hwmod omap44xx_emif1_hwmod =3D {
 };
=20
 /* emif2 */
-static struct omap_hwmod_irq_info omap44xx_emif2_irqs[] =3D {
-	{ .irq =3D 111 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_emif2_hwmod =3D {
 	.name		=3D "emif2",
 	.class		=3D &omap44xx_emif_hwmod_class,
 	.clkdm_name	=3D "l3_emif_clkdm",
 	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	=3D omap44xx_emif2_irqs,
 	.main_clk	=3D "ddrphy_ck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1067,16 +988,11 @@ static struct omap_hwmod_class omap44xx_fdif_hwmod_c=
lass =3D {
 };
=20
 /* fdif */
-static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] =3D {
-	{ .irq =3D 69 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_fdif_hwmod =3D {
 	.name		=3D "fdif",
 	.class		=3D &omap44xx_fdif_hwmod_class,
 	.clkdm_name	=3D "iss_clkdm",
-	.mpu_irqs	=3D omap44xx_fdif_irqs,
 	.main_clk	=3D "fdif_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1117,10 +1033,6 @@ static struct omap_gpio_dev_attr gpio_dev_attr =3D {
 };
=20
 /* gpio1 */
-static struct omap_hwmod_irq_info omap44xx_gpio1_irqs[] =3D {
-	{ .irq =3D 29 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] =3D {
 	{ .role =3D "dbclk", .clk =3D "gpio1_dbclk" },
@@ -1130,7 +1042,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod =3D {
 	.name		=3D "gpio1",
 	.class		=3D &omap44xx_gpio_hwmod_class,
 	.clkdm_name	=3D "l4_wkup_clkdm",
-	.mpu_irqs	=3D omap44xx_gpio1_irqs,
 	.main_clk	=3D "gpio1_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1145,10 +1056,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod =3D {
 };
=20
 /* gpio2 */
-static struct omap_hwmod_irq_info omap44xx_gpio2_irqs[] =3D {
-	{ .irq =3D 30 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk gpio2_opt_clks[] =3D {
 	{ .role =3D "dbclk", .clk =3D "gpio2_dbclk" },
@@ -1159,7 +1066,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod =3D {
 	.class		=3D &omap44xx_gpio_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap44xx_gpio2_irqs,
 	.main_clk	=3D "gpio2_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1174,10 +1080,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod =3D {
 };
=20
 /* gpio3 */
-static struct omap_hwmod_irq_info omap44xx_gpio3_irqs[] =3D {
-	{ .irq =3D 31 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk gpio3_opt_clks[] =3D {
 	{ .role =3D "dbclk", .clk =3D "gpio3_dbclk" },
@@ -1188,7 +1090,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod =3D {
 	.class		=3D &omap44xx_gpio_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap44xx_gpio3_irqs,
 	.main_clk	=3D "gpio3_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1203,10 +1104,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod =3D {
 };
=20
 /* gpio4 */
-static struct omap_hwmod_irq_info omap44xx_gpio4_irqs[] =3D {
-	{ .irq =3D 32 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk gpio4_opt_clks[] =3D {
 	{ .role =3D "dbclk", .clk =3D "gpio4_dbclk" },
@@ -1217,7 +1114,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod =3D {
 	.class		=3D &omap44xx_gpio_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap44xx_gpio4_irqs,
 	.main_clk	=3D "gpio4_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1232,10 +1128,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod =3D {
 };
=20
 /* gpio5 */
-static struct omap_hwmod_irq_info omap44xx_gpio5_irqs[] =3D {
-	{ .irq =3D 33 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] =3D {
 	{ .role =3D "dbclk", .clk =3D "gpio5_dbclk" },
@@ -1246,7 +1138,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod =3D {
 	.class		=3D &omap44xx_gpio_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap44xx_gpio5_irqs,
 	.main_clk	=3D "gpio5_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1261,10 +1152,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod =3D {
 };
=20
 /* gpio6 */
-static struct omap_hwmod_irq_info omap44xx_gpio6_irqs[] =3D {
-	{ .irq =3D 34 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk gpio6_opt_clks[] =3D {
 	{ .role =3D "dbclk", .clk =3D "gpio6_dbclk" },
@@ -1275,7 +1162,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod =3D {
 	.class		=3D &omap44xx_gpio_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	=3D omap44xx_gpio6_irqs,
 	.main_clk	=3D "gpio6_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1310,10 +1196,6 @@ static struct omap_hwmod_class omap44xx_gpmc_hwmod_c=
lass =3D {
 };
=20
 /* gpmc */
-static struct omap_hwmod_irq_info omap44xx_gpmc_irqs[] =3D {
-	{ .irq =3D 20 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_gpmc_sdma_reqs[] =3D {
 	{ .dma_req =3D 3 + OMAP44XX_DMA_REQ_START },
@@ -1325,7 +1207,6 @@ static struct omap_hwmod omap44xx_gpmc_hwmod =3D {
 	.class		=3D &omap44xx_gpmc_hwmod_class,
 	.clkdm_name	=3D "l3_2_clkdm",
 	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	=3D omap44xx_gpmc_irqs,
 	.sdma_reqs	=3D omap44xx_gpmc_sdma_reqs,
 	.prcm =3D {
 		.omap4 =3D {
@@ -1357,16 +1238,11 @@ static struct omap_hwmod_class omap44xx_gpu_hwmod_c=
lass =3D {
 };
=20
 /* gpu */
-static struct omap_hwmod_irq_info omap44xx_gpu_irqs[] =3D {
-	{ .irq =3D 21 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_gpu_hwmod =3D {
 	.name		=3D "gpu",
 	.class		=3D &omap44xx_gpu_hwmod_class,
 	.clkdm_name	=3D "l3_gfx_clkdm",
-	.mpu_irqs	=3D omap44xx_gpu_irqs,
 	.main_clk	=3D "gpu_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1397,17 +1273,12 @@ static struct omap_hwmod_class omap44xx_hdq1w_hwmod=
_class =3D {
 };
=20
 /* hdq1w */
-static struct omap_hwmod_irq_info omap44xx_hdq1w_irqs[] =3D {
-	{ .irq =3D 58 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_hdq1w_hwmod =3D {
 	.name		=3D "hdq1w",
 	.class		=3D &omap44xx_hdq1w_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_INIT_NO_RESET, /* XXX temporary */
-	.mpu_irqs	=3D omap44xx_hdq1w_irqs,
 	.main_clk	=3D "hdq1w_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1443,18 +1314,11 @@ static struct omap_hwmod_class omap44xx_hsi_hwmod_c=
lass =3D {
 };
=20
 /* hsi */
-static struct omap_hwmod_irq_info omap44xx_hsi_irqs[] =3D {
-	{ .name =3D "mpu_p1", .irq =3D 67 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "mpu_p2", .irq =3D 68 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "mpu_dma", .irq =3D 71 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_hsi_hwmod =3D {
 	.name		=3D "hsi",
 	.class		=3D &omap44xx_hsi_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
-	.mpu_irqs	=3D omap44xx_hsi_irqs,
 	.main_clk	=3D "hsi_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1495,10 +1359,6 @@ static struct omap_i2c_dev_attr i2c_dev_attr =3D {
 };
=20
 /* i2c1 */
-static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] =3D {
-	{ .irq =3D 56 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_i2c1_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 26 + OMAP44XX_DMA_REQ_START },
@@ -1511,7 +1371,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod =3D {
 	.class		=3D &omap44xx_i2c_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	=3D omap44xx_i2c1_irqs,
 	.sdma_reqs	=3D omap44xx_i2c1_sdma_reqs,
 	.main_clk	=3D "i2c1_fck",
 	.prcm =3D {
@@ -1525,10 +1384,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod =3D {
 };
=20
 /* i2c2 */
-static struct omap_hwmod_irq_info omap44xx_i2c2_irqs[] =3D {
-	{ .irq =3D 57 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_i2c2_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 28 + OMAP44XX_DMA_REQ_START },
@@ -1541,7 +1396,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod =3D {
 	.class		=3D &omap44xx_i2c_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	=3D omap44xx_i2c2_irqs,
 	.sdma_reqs	=3D omap44xx_i2c2_sdma_reqs,
 	.main_clk	=3D "i2c2_fck",
 	.prcm =3D {
@@ -1555,10 +1409,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod =3D {
 };
=20
 /* i2c3 */
-static struct omap_hwmod_irq_info omap44xx_i2c3_irqs[] =3D {
-	{ .irq =3D 61 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_i2c3_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 24 + OMAP44XX_DMA_REQ_START },
@@ -1571,7 +1421,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod =3D {
 	.class		=3D &omap44xx_i2c_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	=3D omap44xx_i2c3_irqs,
 	.sdma_reqs	=3D omap44xx_i2c3_sdma_reqs,
 	.main_clk	=3D "i2c3_fck",
 	.prcm =3D {
@@ -1585,10 +1434,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod =3D {
 };
=20
 /* i2c4 */
-static struct omap_hwmod_irq_info omap44xx_i2c4_irqs[] =3D {
-	{ .irq =3D 62 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_i2c4_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 123 + OMAP44XX_DMA_REQ_START },
@@ -1601,7 +1446,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod =3D {
 	.class		=3D &omap44xx_i2c_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	=3D omap44xx_i2c4_irqs,
 	.sdma_reqs	=3D omap44xx_i2c4_sdma_reqs,
 	.main_clk	=3D "i2c4_fck",
 	.prcm =3D {
@@ -1624,10 +1468,6 @@ static struct omap_hwmod_class omap44xx_ipu_hwmod_cl=
ass =3D {
 };
=20
 /* ipu */
-static struct omap_hwmod_irq_info omap44xx_ipu_irqs[] =3D {
-	{ .irq =3D 100 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_rst_info omap44xx_ipu_resets[] =3D {
 	{ .name =3D "cpu0", .rst_shift =3D 0 },
@@ -1639,7 +1479,6 @@ static struct omap_hwmod omap44xx_ipu_hwmod =3D {
 	.name		=3D "ipu",
 	.class		=3D &omap44xx_ipu_hwmod_class,
 	.clkdm_name	=3D "ducati_clkdm",
-	.mpu_irqs	=3D omap44xx_ipu_irqs,
 	.rst_lines	=3D omap44xx_ipu_resets,
 	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_ipu_resets),
 	.main_clk	=3D "ipu_fck",
@@ -1684,10 +1523,6 @@ static struct omap_hwmod_class omap44xx_iss_hwmod_cl=
ass =3D {
 };
=20
 /* iss */
-static struct omap_hwmod_irq_info omap44xx_iss_irqs[] =3D {
-	{ .irq =3D 24 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_iss_sdma_reqs[] =3D {
 	{ .name =3D "1", .dma_req =3D 8 + OMAP44XX_DMA_REQ_START },
@@ -1705,7 +1540,6 @@ static struct omap_hwmod omap44xx_iss_hwmod =3D {
 	.name		=3D "iss",
 	.class		=3D &omap44xx_iss_hwmod_class,
 	.clkdm_name	=3D "iss_clkdm",
-	.mpu_irqs	=3D omap44xx_iss_irqs,
 	.sdma_reqs	=3D omap44xx_iss_sdma_reqs,
 	.main_clk	=3D "iss_fck",
 	.prcm =3D {
@@ -1729,12 +1563,6 @@ static struct omap_hwmod_class omap44xx_iva_hwmod_cl=
ass =3D {
 };
=20
 /* iva */
-static struct omap_hwmod_irq_info omap44xx_iva_irqs[] =3D {
-	{ .name =3D "sync_1", .irq =3D 103 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "sync_0", .irq =3D 104 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "mailbox_0", .irq =3D 107 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_rst_info omap44xx_iva_resets[] =3D {
 	{ .name =3D "seq0", .rst_shift =3D 0 },
@@ -1746,7 +1574,6 @@ static struct omap_hwmod omap44xx_iva_hwmod =3D {
 	.name		=3D "iva",
 	.class		=3D &omap44xx_iva_hwmod_class,
 	.clkdm_name	=3D "ivahd_clkdm",
-	.mpu_irqs	=3D omap44xx_iva_irqs,
 	.rst_lines	=3D omap44xx_iva_resets,
 	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_iva_resets),
 	.main_clk	=3D "iva_fck",
@@ -1783,16 +1610,11 @@ static struct omap_hwmod_class omap44xx_kbd_hwmod_c=
lass =3D {
 };
=20
 /* kbd */
-static struct omap_hwmod_irq_info omap44xx_kbd_irqs[] =3D {
-	{ .irq =3D 120 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_kbd_hwmod =3D {
 	.name		=3D "kbd",
 	.class		=3D &omap44xx_kbd_hwmod_class,
 	.clkdm_name	=3D "l4_wkup_clkdm",
-	.mpu_irqs	=3D omap44xx_kbd_irqs,
 	.main_clk	=3D "kbd_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -1824,16 +1646,11 @@ static struct omap_hwmod_class omap44xx_mailbox_hwm=
od_class =3D {
 };
=20
 /* mailbox */
-static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] =3D {
-	{ .irq =3D 26 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_mailbox_hwmod =3D {
 	.name		=3D "mailbox",
 	.class		=3D &omap44xx_mailbox_hwmod_class,
 	.clkdm_name	=3D "l4_cfg_clkdm",
-	.mpu_irqs	=3D omap44xx_mailbox_irqs,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
@@ -1866,11 +1683,6 @@ static struct omap_hwmod_class omap44xx_mcasp_hwmod_=
class =3D {
 };
=20
 /* mcasp */
-static struct omap_hwmod_irq_info omap44xx_mcasp_irqs[] =3D {
-	{ .name =3D "arevt", .irq =3D 108 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "axevt", .irq =3D 109 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcasp_sdma_reqs[] =3D {
 	{ .name =3D "axevt", .dma_req =3D 7 + OMAP44XX_DMA_REQ_START },
@@ -1882,7 +1694,6 @@ static struct omap_hwmod omap44xx_mcasp_hwmod =3D {
 	.name		=3D "mcasp",
 	.class		=3D &omap44xx_mcasp_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_mcasp_irqs,
 	.sdma_reqs	=3D omap44xx_mcasp_sdma_reqs,
 	.main_clk	=3D "mcasp_fck",
 	.prcm =3D {
@@ -1914,10 +1725,6 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod_=
class =3D {
 };
=20
 /* mcbsp1 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] =3D {
-	{ .name =3D "common", .irq =3D 17 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 32 + OMAP44XX_DMA_REQ_START },
@@ -1934,7 +1741,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod =3D {
 	.name		=3D "mcbsp1",
 	.class		=3D &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_mcbsp1_irqs,
 	.sdma_reqs	=3D omap44xx_mcbsp1_sdma_reqs,
 	.main_clk	=3D "mcbsp1_fck",
 	.prcm =3D {
@@ -1949,10 +1755,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod =3D {
 };
=20
 /* mcbsp2 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] =3D {
-	{ .name =3D "common", .irq =3D 22 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 16 + OMAP44XX_DMA_REQ_START },
@@ -1969,7 +1771,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod =3D {
 	.name		=3D "mcbsp2",
 	.class		=3D &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_mcbsp2_irqs,
 	.sdma_reqs	=3D omap44xx_mcbsp2_sdma_reqs,
 	.main_clk	=3D "mcbsp2_fck",
 	.prcm =3D {
@@ -1984,10 +1785,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod =3D {
 };
=20
 /* mcbsp3 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] =3D {
-	{ .name =3D "common", .irq =3D 23 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 18 + OMAP44XX_DMA_REQ_START },
@@ -2004,7 +1801,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod =3D {
 	.name		=3D "mcbsp3",
 	.class		=3D &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_mcbsp3_irqs,
 	.sdma_reqs	=3D omap44xx_mcbsp3_sdma_reqs,
 	.main_clk	=3D "mcbsp3_fck",
 	.prcm =3D {
@@ -2019,10 +1815,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod =3D {
 };
=20
 /* mcbsp4 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] =3D {
-	{ .name =3D "common", .irq =3D 16 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 30 + OMAP44XX_DMA_REQ_START },
@@ -2039,7 +1831,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod =3D {
 	.name		=3D "mcbsp4",
 	.class		=3D &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mcbsp4_irqs,
 	.sdma_reqs	=3D omap44xx_mcbsp4_sdma_reqs,
 	.main_clk	=3D "mcbsp4_fck",
 	.prcm =3D {
@@ -2075,10 +1866,6 @@ static struct omap_hwmod_class omap44xx_mcpdm_hwmod_=
class =3D {
 };
=20
 /* mcpdm */
-static struct omap_hwmod_irq_info omap44xx_mcpdm_irqs[] =3D {
-	{ .irq =3D 112 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcpdm_sdma_reqs[] =3D {
 	{ .name =3D "up_link", .dma_req =3D 64 + OMAP44XX_DMA_REQ_START },
@@ -2090,7 +1877,6 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =3D {
 	.name		=3D "mcpdm",
 	.class		=3D &omap44xx_mcpdm_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_mcpdm_irqs,
 	.sdma_reqs	=3D omap44xx_mcpdm_sdma_reqs,
 	.main_clk	=3D "mcpdm_fck",
 	.prcm =3D {
@@ -2125,10 +1911,6 @@ static struct omap_hwmod_class omap44xx_mcspi_hwmod_=
class =3D {
 };
=20
 /* mcspi1 */
-static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] =3D {
-	{ .irq =3D 65 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] =3D {
 	{ .name =3D "tx0", .dma_req =3D 34 + OMAP44XX_DMA_REQ_START },
@@ -2151,7 +1933,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod =3D {
 	.name		=3D "mcspi1",
 	.class		=3D &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mcspi1_irqs,
 	.sdma_reqs	=3D omap44xx_mcspi1_sdma_reqs,
 	.main_clk	=3D "mcspi1_fck",
 	.prcm =3D {
@@ -2165,10 +1946,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod =3D {
 };
=20
 /* mcspi2 */
-static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] =3D {
-	{ .irq =3D 66 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] =3D {
 	{ .name =3D "tx0", .dma_req =3D 42 + OMAP44XX_DMA_REQ_START },
@@ -2187,7 +1964,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod =3D {
 	.name		=3D "mcspi2",
 	.class		=3D &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mcspi2_irqs,
 	.sdma_reqs	=3D omap44xx_mcspi2_sdma_reqs,
 	.main_clk	=3D "mcspi2_fck",
 	.prcm =3D {
@@ -2201,10 +1977,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod =3D {
 };
=20
 /* mcspi3 */
-static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] =3D {
-	{ .irq =3D 91 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] =3D {
 	{ .name =3D "tx0", .dma_req =3D 14 + OMAP44XX_DMA_REQ_START },
@@ -2223,7 +1995,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod =3D {
 	.name		=3D "mcspi3",
 	.class		=3D &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mcspi3_irqs,
 	.sdma_reqs	=3D omap44xx_mcspi3_sdma_reqs,
 	.main_clk	=3D "mcspi3_fck",
 	.prcm =3D {
@@ -2237,10 +2008,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod =3D {
 };
=20
 /* mcspi4 */
-static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] =3D {
-	{ .irq =3D 48 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] =3D {
 	{ .name =3D "tx0", .dma_req =3D 69 + OMAP44XX_DMA_REQ_START },
@@ -2257,7 +2024,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod =3D {
 	.name		=3D "mcspi4",
 	.class		=3D &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mcspi4_irqs,
 	.sdma_reqs	=3D omap44xx_mcspi4_sdma_reqs,
 	.main_clk	=3D "mcspi4_fck",
 	.prcm =3D {
@@ -2293,10 +2059,6 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_cl=
ass =3D {
 };
=20
 /* mmc1 */
-static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] =3D {
-	{ .irq =3D 83 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 60 + OMAP44XX_DMA_REQ_START },
@@ -2313,7 +2075,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod =3D {
 	.name		=3D "mmc1",
 	.class		=3D &omap44xx_mmc_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
-	.mpu_irqs	=3D omap44xx_mmc1_irqs,
 	.sdma_reqs	=3D omap44xx_mmc1_sdma_reqs,
 	.main_clk	=3D "mmc1_fck",
 	.prcm =3D {
@@ -2327,10 +2088,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod =3D {
 };
=20
 /* mmc2 */
-static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] =3D {
-	{ .irq =3D 86 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 46 + OMAP44XX_DMA_REQ_START },
@@ -2342,7 +2099,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod =3D {
 	.name		=3D "mmc2",
 	.class		=3D &omap44xx_mmc_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
-	.mpu_irqs	=3D omap44xx_mmc2_irqs,
 	.sdma_reqs	=3D omap44xx_mmc2_sdma_reqs,
 	.main_clk	=3D "mmc2_fck",
 	.prcm =3D {
@@ -2355,10 +2111,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod =3D {
 };
=20
 /* mmc3 */
-static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] =3D {
-	{ .irq =3D 94 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 76 + OMAP44XX_DMA_REQ_START },
@@ -2370,7 +2122,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod =3D {
 	.name		=3D "mmc3",
 	.class		=3D &omap44xx_mmc_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mmc3_irqs,
 	.sdma_reqs	=3D omap44xx_mmc3_sdma_reqs,
 	.main_clk	=3D "mmc3_fck",
 	.prcm =3D {
@@ -2383,10 +2134,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod =3D {
 };
=20
 /* mmc4 */
-static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] =3D {
-	{ .irq =3D 96 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 56 + OMAP44XX_DMA_REQ_START },
@@ -2398,7 +2145,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod =3D {
 	.name		=3D "mmc4",
 	.class		=3D &omap44xx_mmc_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mmc4_irqs,
 	.sdma_reqs	=3D omap44xx_mmc4_sdma_reqs,
 	.main_clk	=3D "mmc4_fck",
 	.prcm =3D {
@@ -2411,10 +2157,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod =3D {
 };
=20
 /* mmc5 */
-static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] =3D {
-	{ .irq =3D 59 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 58 + OMAP44XX_DMA_REQ_START },
@@ -2426,7 +2168,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod =3D {
 	.name		=3D "mmc5",
 	.class		=3D &omap44xx_mmc_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_mmc5_irqs,
 	.sdma_reqs	=3D omap44xx_mmc5_sdma_reqs,
 	.main_clk	=3D "mmc5_fck",
 	.prcm =3D {
@@ -2448,19 +2189,12 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_c=
lass =3D {
 };
=20
 /* mpu */
-static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] =3D {
-	{ .name =3D "pl310", .irq =3D 0 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_mpu_hwmod =3D {
 	.name		=3D "mpu",
 	.class		=3D &omap44xx_mpu_hwmod_class,
 	.clkdm_name	=3D "mpuss_clkdm",
 	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	=3D omap44xx_mpu_irqs,
 	.main_clk	=3D "dpll_mpu_m2_ck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2552,10 +2286,6 @@ static struct omap_hwmod omap44xx_cm_core_hwmod =3D {
 };
=20
 /* prm */
-static struct omap_hwmod_irq_info omap44xx_prm_irqs[] =3D {
-	{ .irq =3D 11 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_rst_info omap44xx_prm_resets[] =3D {
 	{ .name =3D "rst_global_warm_sw", .rst_shift =3D 0 },
@@ -2565,7 +2295,6 @@ static struct omap_hwmod_rst_info omap44xx_prm_resets=
[] =3D {
 static struct omap_hwmod omap44xx_prm_hwmod =3D {
 	.name		=3D "prm",
 	.class		=3D &omap44xx_prcm_hwmod_class,
-	.mpu_irqs	=3D omap44xx_prm_irqs,
 	.rst_lines	=3D omap44xx_prm_resets,
 	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_prm_resets),
 };
@@ -2631,10 +2360,6 @@ static struct omap_hwmod_class omap44xx_slimbus_hwmo=
d_class =3D {
 };
=20
 /* slimbus1 */
-static struct omap_hwmod_irq_info omap44xx_slimbus1_irqs[] =3D {
-	{ .irq =3D 97 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_slimbus1_sdma_reqs[] =3D {
 	{ .name =3D "tx0", .dma_req =3D 84 + OMAP44XX_DMA_REQ_START },
@@ -2659,7 +2384,6 @@ static struct omap_hwmod omap44xx_slimbus1_hwmod =3D {
 	.name		=3D "slimbus1",
 	.class		=3D &omap44xx_slimbus_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_slimbus1_irqs,
 	.sdma_reqs	=3D omap44xx_slimbus1_sdma_reqs,
 	.prcm =3D {
 		.omap4 =3D {
@@ -2673,10 +2397,6 @@ static struct omap_hwmod omap44xx_slimbus1_hwmod =3D=
 {
 };
=20
 /* slimbus2 */
-static struct omap_hwmod_irq_info omap44xx_slimbus2_irqs[] =3D {
-	{ .irq =3D 98 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_slimbus2_sdma_reqs[] =3D {
 	{ .name =3D "tx0", .dma_req =3D 92 + OMAP44XX_DMA_REQ_START },
@@ -2700,7 +2420,6 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod =3D {
 	.name		=3D "slimbus2",
 	.class		=3D &omap44xx_slimbus_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_slimbus2_irqs,
 	.sdma_reqs	=3D omap44xx_slimbus2_sdma_reqs,
 	.prcm =3D {
 		.omap4 =3D {
@@ -2744,16 +2463,11 @@ static struct omap_smartreflex_dev_attr smartreflex=
_core_dev_attr =3D {
 	.sensor_voltdm_name   =3D "core",
 };
=20
-static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] =3D {
-	{ .irq =3D 19 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_smartreflex_core_hwmod =3D {
 	.name		=3D "smartreflex_core",
 	.class		=3D &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	=3D "l4_ao_clkdm",
-	.mpu_irqs	=3D omap44xx_smartreflex_core_irqs,
=20
 	.main_clk	=3D "smartreflex_core_fck",
 	.prcm =3D {
@@ -2771,16 +2485,11 @@ static struct omap_smartreflex_dev_attr smartreflex=
_iva_dev_attr =3D {
 	.sensor_voltdm_name	=3D "iva",
 };
=20
-static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] =3D {
-	{ .irq =3D 102 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_smartreflex_iva_hwmod =3D {
 	.name		=3D "smartreflex_iva",
 	.class		=3D &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	=3D "l4_ao_clkdm",
-	.mpu_irqs	=3D omap44xx_smartreflex_iva_irqs,
 	.main_clk	=3D "smartreflex_iva_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2797,16 +2506,11 @@ static struct omap_smartreflex_dev_attr smartreflex=
_mpu_dev_attr =3D {
 	.sensor_voltdm_name	=3D "mpu",
 };
=20
-static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] =3D {
-	{ .irq =3D 18 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod =3D {
 	.name		=3D "smartreflex_mpu",
 	.class		=3D &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	=3D "l4_ao_clkdm",
-	.mpu_irqs	=3D omap44xx_smartreflex_mpu_irqs,
 	.main_clk	=3D "smartreflex_mpu_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2903,16 +2607,11 @@ static struct omap_timer_capability_dev_attr capabi=
lity_pwm_dev_attr =3D {
 };
=20
 /* timer1 */
-static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] =3D {
-	{ .irq =3D 37 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer1_hwmod =3D {
 	.name		=3D "timer1",
 	.class		=3D &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	=3D "l4_wkup_clkdm",
-	.mpu_irqs	=3D omap44xx_timer1_irqs,
 	.main_clk	=3D "timer1_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2925,16 +2624,11 @@ static struct omap_hwmod omap44xx_timer1_hwmod =3D {
 };
=20
 /* timer2 */
-static struct omap_hwmod_irq_info omap44xx_timer2_irqs[] =3D {
-	{ .irq =3D 38 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer2_hwmod =3D {
 	.name		=3D "timer2",
 	.class		=3D &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_timer2_irqs,
 	.main_clk	=3D "timer2_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2946,16 +2640,11 @@ static struct omap_hwmod omap44xx_timer2_hwmod =3D {
 };
=20
 /* timer3 */
-static struct omap_hwmod_irq_info omap44xx_timer3_irqs[] =3D {
-	{ .irq =3D 39 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer3_hwmod =3D {
 	.name		=3D "timer3",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_timer3_irqs,
 	.main_clk	=3D "timer3_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2967,16 +2656,11 @@ static struct omap_hwmod omap44xx_timer3_hwmod =3D {
 };
=20
 /* timer4 */
-static struct omap_hwmod_irq_info omap44xx_timer4_irqs[] =3D {
-	{ .irq =3D 40 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer4_hwmod =3D {
 	.name		=3D "timer4",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_timer4_irqs,
 	.main_clk	=3D "timer4_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -2988,16 +2672,11 @@ static struct omap_hwmod omap44xx_timer4_hwmod =3D {
 };
=20
 /* timer5 */
-static struct omap_hwmod_irq_info omap44xx_timer5_irqs[] =3D {
-	{ .irq =3D 41 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer5_hwmod =3D {
 	.name		=3D "timer5",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_timer5_irqs,
 	.main_clk	=3D "timer5_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3009,16 +2688,11 @@ static struct omap_hwmod omap44xx_timer5_hwmod =3D {
 };
=20
 /* timer6 */
-static struct omap_hwmod_irq_info omap44xx_timer6_irqs[] =3D {
-	{ .irq =3D 42 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer6_hwmod =3D {
 	.name		=3D "timer6",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_timer6_irqs,
=20
 	.main_clk	=3D "timer6_fck",
 	.prcm =3D {
@@ -3031,16 +2705,11 @@ static struct omap_hwmod omap44xx_timer6_hwmod =3D {
 };
=20
 /* timer7 */
-static struct omap_hwmod_irq_info omap44xx_timer7_irqs[] =3D {
-	{ .irq =3D 43 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer7_hwmod =3D {
 	.name		=3D "timer7",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_timer7_irqs,
 	.main_clk	=3D "timer7_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3052,16 +2721,11 @@ static struct omap_hwmod omap44xx_timer7_hwmod =3D {
 };
=20
 /* timer8 */
-static struct omap_hwmod_irq_info omap44xx_timer8_irqs[] =3D {
-	{ .irq =3D 44 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer8_hwmod =3D {
 	.name		=3D "timer8",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_timer8_irqs,
 	.main_clk	=3D "timer8_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3074,16 +2738,11 @@ static struct omap_hwmod omap44xx_timer8_hwmod =3D {
 };
=20
 /* timer9 */
-static struct omap_hwmod_irq_info omap44xx_timer9_irqs[] =3D {
-	{ .irq =3D 45 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer9_hwmod =3D {
 	.name		=3D "timer9",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_timer9_irqs,
 	.main_clk	=3D "timer9_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3096,16 +2755,11 @@ static struct omap_hwmod omap44xx_timer9_hwmod =3D {
 };
=20
 /* timer10 */
-static struct omap_hwmod_irq_info omap44xx_timer10_irqs[] =3D {
-	{ .irq =3D 46 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer10_hwmod =3D {
 	.name		=3D "timer10",
 	.class		=3D &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_timer10_irqs,
 	.main_clk	=3D "timer10_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3118,16 +2772,11 @@ static struct omap_hwmod omap44xx_timer10_hwmod =3D=
 {
 };
=20
 /* timer11 */
-static struct omap_hwmod_irq_info omap44xx_timer11_irqs[] =3D {
-	{ .irq =3D 47 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_timer11_hwmod =3D {
 	.name		=3D "timer11",
 	.class		=3D &omap44xx_timer_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_timer11_irqs,
 	.main_clk	=3D "timer11_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3162,10 +2811,6 @@ static struct omap_hwmod_class omap44xx_uart_hwmod_c=
lass =3D {
 };
=20
 /* uart1 */
-static struct omap_hwmod_irq_info omap44xx_uart1_irqs[] =3D {
-	{ .irq =3D 72 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_uart1_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 48 + OMAP44XX_DMA_REQ_START },
@@ -3177,7 +2822,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod =3D {
 	.name		=3D "uart1",
 	.class		=3D &omap44xx_uart_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_uart1_irqs,
 	.sdma_reqs	=3D omap44xx_uart1_sdma_reqs,
 	.main_clk	=3D "uart1_fck",
 	.prcm =3D {
@@ -3190,10 +2834,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod =3D {
 };
=20
 /* uart2 */
-static struct omap_hwmod_irq_info omap44xx_uart2_irqs[] =3D {
-	{ .irq =3D 73 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_uart2_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 50 + OMAP44XX_DMA_REQ_START },
@@ -3205,7 +2845,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod =3D {
 	.name		=3D "uart2",
 	.class		=3D &omap44xx_uart_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_uart2_irqs,
 	.sdma_reqs	=3D omap44xx_uart2_sdma_reqs,
 	.main_clk	=3D "uart2_fck",
 	.prcm =3D {
@@ -3218,10 +2857,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod =3D {
 };
=20
 /* uart3 */
-static struct omap_hwmod_irq_info omap44xx_uart3_irqs[] =3D {
-	{ .irq =3D 74 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_uart3_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 52 + OMAP44XX_DMA_REQ_START },
@@ -3234,7 +2869,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod =3D {
 	.class		=3D &omap44xx_uart_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
 	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	=3D omap44xx_uart3_irqs,
 	.sdma_reqs	=3D omap44xx_uart3_sdma_reqs,
 	.main_clk	=3D "uart3_fck",
 	.prcm =3D {
@@ -3247,10 +2881,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod =3D {
 };
=20
 /* uart4 */
-static struct omap_hwmod_irq_info omap44xx_uart4_irqs[] =3D {
-	{ .irq =3D 70 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_dma_info omap44xx_uart4_sdma_reqs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 54 + OMAP44XX_DMA_REQ_START },
@@ -3262,7 +2892,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod =3D {
 	.name		=3D "uart4",
 	.class		=3D &omap44xx_uart_hwmod_class,
 	.clkdm_name	=3D "l4_per_clkdm",
-	.mpu_irqs	=3D omap44xx_uart4_irqs,
 	.sdma_reqs	=3D omap44xx_uart4_sdma_reqs,
 	.main_clk	=3D "uart4_fck",
 	.prcm =3D {
@@ -3302,17 +2931,11 @@ static struct omap_hwmod_class omap44xx_usb_host_fs=
_hwmod_class =3D {
 };
=20
 /* usb_host_fs */
-static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] =3D {
-	{ .name =3D "std", .irq =3D 89 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "smi", .irq =3D 90 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_usb_host_fs_hwmod =3D {
 	.name		=3D "usb_host_fs",
 	.class		=3D &omap44xx_usb_host_fs_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
-	.mpu_irqs	=3D omap44xx_usb_host_fs_irqs,
 	.main_clk	=3D "usb_host_fs_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3346,11 +2969,6 @@ static struct omap_hwmod_class omap44xx_usb_host_hs_=
hwmod_class =3D {
 };
=20
 /* usb_host_hs */
-static struct omap_hwmod_irq_info omap44xx_usb_host_hs_irqs[] =3D {
-	{ .name =3D "ohci-irq", .irq =3D 76 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "ehci-irq", .irq =3D 77 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_usb_host_hs_hwmod =3D {
 	.name		=3D "usb_host_hs",
@@ -3364,7 +2982,6 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod =
=3D {
 			.modulemode   =3D MODULEMODE_SWCTRL,
 		},
 	},
-	.mpu_irqs	=3D omap44xx_usb_host_hs_irqs,
=20
 	/*
 	 * Errata: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
@@ -3439,11 +3056,6 @@ static struct omap_hwmod_class omap44xx_usb_otg_hs_h=
wmod_class =3D {
 };
=20
 /* usb_otg_hs */
-static struct omap_hwmod_irq_info omap44xx_usb_otg_hs_irqs[] =3D {
-	{ .name =3D "mc", .irq =3D 92 + OMAP44XX_IRQ_GIC_START },
-	{ .name =3D "dma", .irq =3D 93 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] =3D {
 	{ .role =3D "xclk", .clk =3D "usb_otg_hs_xclk" },
@@ -3454,7 +3066,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod =
=3D {
 	.class		=3D &omap44xx_usb_otg_hs_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
 	.flags		=3D HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.mpu_irqs	=3D omap44xx_usb_otg_hs_irqs,
 	.main_clk	=3D "usb_otg_hs_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3488,16 +3099,11 @@ static struct omap_hwmod_class omap44xx_usb_tll_hs_=
hwmod_class =3D {
 	.sysc	=3D &omap44xx_usb_tll_hs_sysc,
 };
=20
-static struct omap_hwmod_irq_info omap44xx_usb_tll_hs_irqs[] =3D {
-	{ .name =3D "tll-irq", .irq =3D 78 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_usb_tll_hs_hwmod =3D {
 	.name		=3D "usb_tll_hs",
 	.class		=3D &omap44xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	=3D "l3_init_clkdm",
-	.mpu_irqs	=3D omap44xx_usb_tll_hs_irqs,
 	.main_clk	=3D "usb_tll_hs_ick",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3533,16 +3139,11 @@ static struct omap_hwmod_class omap44xx_wd_timer_hw=
mod_class =3D {
 };
=20
 /* wd_timer2 */
-static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] =3D {
-	{ .irq =3D 80 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_wd_timer2_hwmod =3D {
 	.name		=3D "wd_timer2",
 	.class		=3D &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	=3D "l4_wkup_clkdm",
-	.mpu_irqs	=3D omap44xx_wd_timer2_irqs,
 	.main_clk	=3D "wd_timer2_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3554,16 +3155,11 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod =
=3D {
 };
=20
 /* wd_timer3 */
-static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] =3D {
-	{ .irq =3D 36 + OMAP44XX_IRQ_GIC_START },
-	{ .irq =3D -1 }
-};
=20
 static struct omap_hwmod omap44xx_wd_timer3_hwmod =3D {
 	.name		=3D "wd_timer3",
 	.class		=3D &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	=3D "abe_clkdm",
-	.mpu_irqs	=3D omap44xx_wd_timer3_irqs,
 	.main_clk	=3D "wd_timer3_fck",
 	.prcm =3D {
 		.omap4 =3D {
@@ -3579,21 +3175,12 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod =
=3D {
  * interfaces
  */
=20
-static struct omap_hwmod_addr_space omap44xx_c2c_target_fw_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a204000,
-		.pa_end		=3D 0x4a2040ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* c2c -> c2c_target_fw */
 static struct omap_hwmod_ocp_if omap44xx_c2c__c2c_target_fw =3D {
 	.master		=3D &omap44xx_c2c_hwmod,
 	.slave		=3D &omap44xx_c2c_target_fw_hwmod,
 	.clk		=3D "div_core_ck",
-	.addr		=3D omap44xx_c2c_target_fw_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
@@ -3613,21 +3200,12 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1_=
_dmm =3D {
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dmm_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4e000000,
-		.pa_end		=3D 0x4e0007ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* mpu -> dmm */
 static struct omap_hwmod_ocp_if omap44xx_mpu__dmm =3D {
 	.master		=3D &omap44xx_mpu_hwmod,
 	.slave		=3D &omap44xx_dmm_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_dmm_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
@@ -3647,21 +3225,12 @@ static struct omap_hwmod_ocp_if omap44xx_dmm__emif_=
fw =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_emif_fw_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a20c000,
-		.pa_end		=3D 0x4a20c0ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> emif_fw */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__emif_fw =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_emif_fw_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_emif_fw_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
@@ -3737,21 +3306,12 @@ static struct omap_hwmod_ocp_if omap44xx_mmc2__l3_m=
ain_1 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_l3_main_1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x44000000,
-		.pa_end		=3D 0x44000fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* mpu -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 =3D {
 	.master		=3D &omap44xx_mpu_hwmod,
 	.slave		=3D &omap44xx_l3_main_1_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_l3_main_1_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
@@ -3827,21 +3387,12 @@ static struct omap_hwmod_ocp_if omap44xx_iva__l3_ma=
in_2 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_l3_main_2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x44800000,
-		.pa_end		=3D 0x44801fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_1 -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 =3D {
 	.master		=3D &omap44xx_l3_main_1_hwmod,
 	.slave		=3D &omap44xx_l3_main_2_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_l3_main_2_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
@@ -3877,21 +3428,12 @@ static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs=
__l3_main_2 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_l3_main_3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x45000000,
-		.pa_end		=3D 0x45000fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_1 -> l3_main_3 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_3 =3D {
 	.master		=3D &omap44xx_l3_main_1_hwmod,
 	.slave		=3D &omap44xx_l3_main_3_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_l3_main_3_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
@@ -3975,57 +3517,30 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_p=
rivate =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_ocp_wp_noc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a102000,
-		.pa_end		=3D 0x4a10207f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> ocp_wp_noc */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_ocp_wp_noc_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_ocp_wp_noc_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_aess_addrs[] =3D {
-	{
-		.pa_start	=3D 0x401f1000,
-		.pa_end		=3D 0x401f13ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> aess */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_aess_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_aess_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x490f1000,
-		.pa_end		=3D 0x490f13ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> aess (dma) */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess_dma =
=3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_aess_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_aess_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
@@ -4037,167 +3552,84 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2=
__c2c =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_counter_32k_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a304000,
-		.pa_end		=3D 0x4a30401f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> counter_32k */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__counter_32k =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_counter_32k_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_counter_32k_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_core_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a002000,
-		.pa_end		=3D 0x4a0027ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> ctrl_module_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_core =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_ctrl_module_core_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_ctrl_module_core_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_core_addrs[] =
=3D {
-	{
-		.pa_start	=3D 0x4a100000,
-		.pa_end		=3D 0x4a1007ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> ctrl_module_pad_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_pad_core =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_ctrl_module_pad_core_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_ctrl_module_pad_core_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_wkup_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a30c000,
-		.pa_end		=3D 0x4a30c7ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> ctrl_module_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_wkup =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_ctrl_module_wkup_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_ctrl_module_wkup_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_wkup_addrs[] =
=3D {
-	{
-		.pa_start	=3D 0x4a31e000,
-		.pa_end		=3D 0x4a31e7ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> ctrl_module_pad_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_pad_wkup =3D=
 {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_ctrl_module_pad_wkup_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_ctrl_module_pad_wkup_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] =3D {
-	{
-		.pa_start	=3D 0x54160000,
-		.pa_end		=3D 0x54167fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_instr -> debugss */
 static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss =3D {
 	.master		=3D &omap44xx_l3_instr_hwmod,
 	.slave		=3D &omap44xx_debugss_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_debugss_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a056000,
-		.pa_end		=3D 0x4a056fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> dma_system */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_dma_system_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dma_system_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x4012e000,
-		.pa_end		=3D 0x4012e07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> dmic */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_dmic_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_dmic_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] =3D {
-	{
-		.name		=3D "dma",
-		.pa_start	=3D 0x4902e000,
-		.pa_end		=3D 0x4902e07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> dmic (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_dmic_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_dmic_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
@@ -4225,579 +3657,291 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__=
dsp =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58000000,
-		.pa_end		=3D 0x5800007f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48040000,
-		.pa_end		=3D 0x4804007f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58001000,
-		.pa_end		=3D 0x58001fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss_dispc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_dispc_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_dispc_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dispc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48041000,
-		.pa_end		=3D 0x48041fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss_dispc */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dispc =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_dispc_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_dispc_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58004000,
-		.pa_end		=3D 0x580041ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_dsi1_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_dsi1_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dsi1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48044000,
-		.pa_end		=3D 0x480441ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi1 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_dsi1_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_dsi1_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58005000,
-		.pa_end		=3D 0x580051ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss_dsi2 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_dsi2_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_dsi2_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_dsi2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48045000,
-		.pa_end		=3D 0x480451ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss_dsi2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_dsi2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_dsi2_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58006000,
-		.pa_end		=3D 0x58006fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss_hdmi */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_hdmi_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_hdmi_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_hdmi_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48046000,
-		.pa_end		=3D 0x48046fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss_hdmi */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_hdmi =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_hdmi_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_hdmi_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58002000,
-		.pa_end		=3D 0x580020ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_rfbi_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_rfbi_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_rfbi_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48042000,
-		.pa_end		=3D 0x480420ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_rfbi =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_rfbi_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_rfbi_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x58003000,
-		.pa_end		=3D 0x580030ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> dss_venc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_dss_venc_hwmod,
 	.clk		=3D "dss_fck",
-	.addr		=3D omap44xx_dss_venc_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_dss_venc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48043000,
-		.pa_end		=3D 0x480430ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> dss_venc */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_dss_venc_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_dss_venc_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_elm_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48078000,
-		.pa_end		=3D 0x48078fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> elm */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__elm =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_elm_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_elm_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_emif1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4c000000,
-		.pa_end		=3D 0x4c0000ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* emif_fw -> emif1 */
 static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif1 =3D {
 	.master		=3D &omap44xx_emif_fw_hwmod,
 	.slave		=3D &omap44xx_emif1_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_emif1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_emif2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4d000000,
-		.pa_end		=3D 0x4d0000ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* emif_fw -> emif2 */
 static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif2 =3D {
 	.master		=3D &omap44xx_emif_fw_hwmod,
 	.slave		=3D &omap44xx_emif2_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_emif2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a10a000,
-		.pa_end		=3D 0x4a10a1ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> fdif */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_fdif_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_fdif_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a310000,
-		.pa_end		=3D 0x4a3101ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> gpio1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_gpio1_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_gpio1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48055000,
-		.pa_end		=3D 0x480551ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> gpio2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_gpio2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_gpio2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48057000,
-		.pa_end		=3D 0x480571ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> gpio3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_gpio3_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_gpio3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48059000,
-		.pa_end		=3D 0x480591ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> gpio4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_gpio4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_gpio4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4805b000,
-		.pa_end		=3D 0x4805b1ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> gpio5 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_gpio5_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_gpio5_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4805d000,
-		.pa_end		=3D 0x4805d1ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> gpio6 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_gpio6_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_gpio6_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpmc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x50000000,
-		.pa_end		=3D 0x500003ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> gpmc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_gpmc_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_gpmc_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_gpu_addrs[] =3D {
-	{
-		.pa_start	=3D 0x56000000,
-		.pa_end		=3D 0x5600ffff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> gpu */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpu =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_gpu_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_gpu_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480b2000,
-		.pa_end		=3D 0x480b201f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> hdq1w */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__hdq1w =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_hdq1w_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_hdq1w_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_hsi_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a058000,
-		.pa_end		=3D 0x4a05bfff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> hsi */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__hsi =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_hsi_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_hsi_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_i2c1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48070000,
-		.pa_end		=3D 0x480700ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> i2c1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c1 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_i2c1_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_i2c1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_i2c2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48072000,
-		.pa_end		=3D 0x480720ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> i2c2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_i2c2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_i2c2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_i2c3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48060000,
-		.pa_end		=3D 0x480600ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> i2c3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c3 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_i2c3_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_i2c3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_i2c4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48350000,
-		.pa_end		=3D 0x483500ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> i2c4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_i2c4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_i2c4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -4809,21 +3953,12 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2_=
_ipu =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_iss_addrs[] =3D {
-	{
-		.pa_start	=3D 0x52000000,
-		.pa_end		=3D 0x520000ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> iss */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iss =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_iss_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_iss_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -4835,423 +3970,210 @@ static struct omap_hwmod_ocp_if omap44xx_iva__sl2=
if =3D {
 	.user		=3D OCP_USER_IVA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_iva_addrs[] =3D {
-	{
-		.pa_start	=3D 0x5a000000,
-		.pa_end		=3D 0x5a07ffff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l3_main_2 -> iva */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iva =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_iva_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_iva_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_kbd_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a31c000,
-		.pa_end		=3D 0x4a31c07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> kbd */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__kbd =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_kbd_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_kbd_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0f4000,
-		.pa_end		=3D 0x4a0f41ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> mailbox */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_mailbox_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mailbox_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcasp_addrs[] =3D {
-	{
-		.pa_start	=3D 0x40128000,
-		.pa_end		=3D 0x401283ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcasp */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcasp_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcasp_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x49028000,
-		.pa_end		=3D 0x490283ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcasp (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcasp_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcasp_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x40122000,
-		.pa_end		=3D 0x401220ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcbsp1_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcbsp1_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp1_dma_addrs[] =3D {
-	{
-		.name		=3D "dma",
-		.pa_start	=3D 0x49022000,
-		.pa_end		=3D 0x490220ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcbsp1 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcbsp1_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcbsp1_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x40124000,
-		.pa_end		=3D 0x401240ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcbsp2_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcbsp2_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp2_dma_addrs[] =3D {
-	{
-		.name		=3D "dma",
-		.pa_start	=3D 0x49024000,
-		.pa_end		=3D 0x490240ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcbsp2 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcbsp2_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcbsp2_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x40126000,
-		.pa_end		=3D 0x401260ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcbsp3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcbsp3_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcbsp3_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp3_dma_addrs[] =3D {
-	{
-		.name		=3D "dma",
-		.pa_start	=3D 0x49026000,
-		.pa_end		=3D 0x490260ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcbsp3 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcbsp3_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcbsp3_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcbsp4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48096000,
-		.pa_end		=3D 0x480960ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mcbsp4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mcbsp4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mcbsp4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcpdm_addrs[] =3D {
-	{
-		.pa_start	=3D 0x40132000,
-		.pa_end		=3D 0x4013207f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcpdm */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcpdm_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcpdm_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcpdm_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x49032000,
-		.pa_end		=3D 0x4903207f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> mcpdm (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_mcpdm_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_mcpdm_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48098000,
-		.pa_end		=3D 0x480981ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mcspi1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi1 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mcspi1_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mcspi1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4809a000,
-		.pa_end		=3D 0x4809a1ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mcspi2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mcspi2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mcspi2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480b8000,
-		.pa_end		=3D 0x480b81ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mcspi3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi3 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mcspi3_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mcspi3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480ba000,
-		.pa_end		=3D 0x480ba1ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mcspi4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mcspi4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mcspi4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mmc1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4809c000,
-		.pa_end		=3D 0x4809c3ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mmc1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc1 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mmc1_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mmc1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mmc2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480b4000,
-		.pa_end		=3D 0x480b43ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mmc2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mmc2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mmc2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mmc3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480ad000,
-		.pa_end		=3D 0x480ad3ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mmc3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc3 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mmc3_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mmc3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mmc4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480d1000,
-		.pa_end		=3D 0x480d13ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mmc4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mmc4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mmc4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mmc5_addrs[] =3D {
-	{
-		.pa_start	=3D 0x480d5000,
-		.pa_end		=3D 0x480d53ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> mmc5 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_mmc5_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mmc5_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -5271,93 +4193,48 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__oc=
p2scp_usb_phy =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_prcm_mpu_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48243000,
-		.pa_end		=3D 0x48243fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* mpu_private -> prcm_mpu */
 static struct omap_hwmod_ocp_if omap44xx_mpu_private__prcm_mpu =3D {
 	.master		=3D &omap44xx_mpu_private_hwmod,
 	.slave		=3D &omap44xx_prcm_mpu_hwmod,
 	.clk		=3D "l3_div_ck",
-	.addr		=3D omap44xx_prcm_mpu_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_cm_core_aon_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a004000,
-		.pa_end		=3D 0x4a004fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> cm_core_aon */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__cm_core_aon =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_cm_core_aon_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_cm_core_aon_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_cm_core_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a008000,
-		.pa_end		=3D 0x4a009fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> cm_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__cm_core =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_cm_core_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_cm_core_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_prm_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a306000,
-		.pa_end		=3D 0x4a307fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> prm */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__prm =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_prm_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_prm_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_scrm_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a30a000,
-		.pa_end		=3D 0x4a30a7ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> scrm */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__scrm =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_scrm_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_scrm_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -5369,609 +4246,300 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_=
2__sl2if =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4012c000,
-		.pa_end		=3D 0x4012c3ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> slimbus1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_slimbus1_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_slimbus1_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_slimbus1_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4902c000,
-		.pa_end		=3D 0x4902c3ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> slimbus1 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_slimbus1_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_slimbus1_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48076000,
-		.pa_end		=3D 0x480763ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> slimbus2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_slimbus2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_slimbus2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0dd000,
-		.pa_end		=3D 0x4a0dd03f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> smartreflex_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_smartreflex_core_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_smartreflex_core_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0db000,
-		.pa_end		=3D 0x4a0db03f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> smartreflex_iva */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_smartreflex_iva_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_smartreflex_iva_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0d9000,
-		.pa_end		=3D 0x4a0d903f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> smartreflex_mpu */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_smartreflex_mpu_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_smartreflex_mpu_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_spinlock_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0f6000,
-		.pa_end		=3D 0x4a0f6fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> spinlock */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__spinlock =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_spinlock_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_spinlock_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a318000,
-		.pa_end		=3D 0x4a31807f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__timer1 =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_timer1_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_timer1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48032000,
-		.pa_end		=3D 0x4803207f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> timer2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_timer2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48034000,
-		.pa_end		=3D 0x4803407f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> timer3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer3 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_timer3_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_timer3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48036000,
-		.pa_end		=3D 0x4803607f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> timer4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_timer4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_timer4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer5_addrs[] =3D {
-	{
-		.pa_start	=3D 0x40138000,
-		.pa_end		=3D 0x4013807f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer5 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer5_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer5_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer5_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x49038000,
-		.pa_end		=3D 0x4903807f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer5 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer5_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer5_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer6_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4013a000,
-		.pa_end		=3D 0x4013a07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer6 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer6_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer6_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer6_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4903a000,
-		.pa_end		=3D 0x4903a07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer6 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer6_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer6_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer7_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4013c000,
-		.pa_end		=3D 0x4013c07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer7 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer7_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer7_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer7_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4903c000,
-		.pa_end		=3D 0x4903c07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer7 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer7_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer7_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer8_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4013e000,
-		.pa_end		=3D 0x4013e07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer8 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer8_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer8_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer8_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4903e000,
-		.pa_end		=3D 0x4903e07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> timer8 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_timer8_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_timer8_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer9_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4803e000,
-		.pa_end		=3D 0x4803e07f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> timer9 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer9 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_timer9_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_timer9_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer10_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48086000,
-		.pa_end		=3D 0x4808607f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> timer10 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer10 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_timer10_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_timer10_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_timer11_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48088000,
-		.pa_end		=3D 0x4808807f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> timer11 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer11 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_timer11_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_timer11_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_uart1_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4806a000,
-		.pa_end		=3D 0x4806a0ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> uart1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart1 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_uart1_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_uart1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4806c000,
-		.pa_end		=3D 0x4806c0ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> uart2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart2 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_uart2_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_uart2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48020000,
-		.pa_end		=3D 0x480200ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> uart3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart3 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_uart3_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_uart3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4806e000,
-		.pa_end		=3D 0x4806e0ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_per -> uart4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 =3D {
 	.master		=3D &omap44xx_l4_per_hwmod,
 	.slave		=3D &omap44xx_uart4_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_uart4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0a9000,
-		.pa_end		=3D 0x4a0a93ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> usb_host_fs */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_cfg__usb_host_f=
s =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_usb_host_fs_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_usb_host_fs_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D {
-	{
-		.name		=3D "uhh",
-		.pa_start	=3D 0x4a064000,
-		.pa_end		=3D 0x4a0647ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{
-		.name		=3D "ohci",
-		.pa_start	=3D 0x4a064800,
-		.pa_end		=3D 0x4a064bff,
-	},
-	{
-		.name		=3D "ehci",
-		.pa_start	=3D 0x4a064c00,
-		.pa_end		=3D 0x4a064fff,
-	},
-	{}
-};
=20
 /* l4_cfg -> usb_host_hs */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_usb_host_hs_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_usb_host_hs_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0ab000,
-		.pa_end		=3D 0x4a0ab003,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_cfg -> usb_otg_hs */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_otg_hs =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_usb_otg_hs_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_usb_otg_hs_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_usb_tll_hs_addrs[] =3D {
-	{
-		.name		=3D "tll",
-		.pa_start	=3D 0x4a062000,
-		.pa_end		=3D 0x4a063fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{}
-};
=20
 /* l4_cfg -> usb_tll_hs */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_usb_tll_hs_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_usb_tll_hs_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a314000,
-		.pa_end		=3D 0x4a31407f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_wkup -> wd_timer2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 =3D {
 	.master		=3D &omap44xx_l4_wkup_hwmod,
 	.slave		=3D &omap44xx_wd_timer2_hwmod,
 	.clk		=3D "l4_wkup_clk_mux_ck",
-	.addr		=3D omap44xx_wd_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x40130000,
-		.pa_end		=3D 0x4013007f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> wd_timer3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_wd_timer3_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_wd_timer3_addrs,
 	.user		=3D OCP_USER_MPU,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] =3D {
-	{
-		.pa_start	=3D 0x49030000,
-		.pa_end		=3D 0x4903007f,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_abe -> wd_timer3 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma =3D {
 	.master		=3D &omap44xx_l4_abe_hwmod,
 	.slave		=3D &omap44xx_wd_timer3_hwmod,
 	.clk		=3D "ocp_abe_iclk",
-	.addr		=3D omap44xx_wd_timer3_dma_addrs,
 	.user		=3D OCP_USER_SDMA,
 };
=20

--=20
balbi

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSi3sAAoJEIaOsuA1yqREsWUP/12OYYaYtVkmI/gPBm5tPb2e
lgxz5SMY1FlmC5JlU1uHm9MHyrzhbWTGz2FHkv/qTf0d0EQq3Ttr77XtwpyPeoaG
QJTzQytFl+OEnLuq5LXnQdSQdS0E+Q5WAxWuKFoXOIseq/OtCXv38vGIyHCMeOVK
AUB7/B51vW8In4qEOdSqnGRqGJCwziIJiH+1o8x4n+AmlLjxmSWLe75I450edLcV
AHNDMudwNZbrgSm4MeNEoZDdWhmP9QXZGMiUH0FvShYFFMrfaZnEAoh2zNDNYH8t
9M1+iUs8/Dwf34YeDtB2cXOR8Su4cEbuo2NAVT2uc0Rxj3efPQP7w9ceafbv2mGK
mvkyQ/UDOd8QeUmrwLfZ1HfBcebVe3LbNQcf16yZV2upJ+Y7tRpWSP5+jZjW8zBk
i/Q003Sp50pbhVjxe+/BFPvIf/Hb60JteeDD2DLhpGedqQ/++jb2czrkhamIzek3
0OtfHJOz++3L9mOA5t6yDR52hzjbE4jamOE5JnJTTALRONJ5FJdn7R1+V7aSTiGJ
qVtmHSh8N8nEp46YgL/+GuEvYg8V84+R62qMQclcep1lN6xhf+GFHWPeCZfHXqAt
irvei4l8SbYkLnj+BxzUxjXmUjOh95zMwANFauvo4ITcFDebVxMspY/A1KHydLBL
++/e+1ZK2xSZDyMkrmgy
=5YHd
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--


--===============5550337259419512770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5550337259419512770==--
