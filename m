From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Move omap2_init_common_devices out of
 init_early
Date: Wed, 24 Aug 2011 06:32:53 -0700
Message-ID: <20110824133253.GB2963@atomide.com>
References: <20110824115048.2985.24230.stgit@kaulin>
 <20110824115433.2985.98712.stgit@kaulin>
 <4E54EA5E.8010603@ti.com>
 <20110824122049.GA2963@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45326 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751129Ab1HXNc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 09:32:59 -0400
Content-Disposition: inline
In-Reply-To: <20110824122049.GA2963@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Tony Lindgren <tony@atomide.com> [110824 04:48]:
> * Cousson, Benoit <b-cousson@ti.com> [110824 04:38]:
> =20
> > void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc=
_cs0,
> >                                       struct omap_sdrc_params *sdrc=
_cs1)
> > {
> >         if (cpu_is_omap24xx() || omap3_has_sdrc()) {
> >                 omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> >                 _omap2_init_reprogram_sdrc();
> >         }
> > }
> >=20
> > I guess it used to do much more than that in the past.
> >=20
> > Shouldn't we rename it to clarify its purpose?
>=20
> Yeah we might as well rename it to omap_init_sdrc since we're
> patching it. Will post an updated patch.

Here's an updated patch.

=CE=A4ony


=46rom: Tony Lindgren <tony@atomide.com>
Date: Mon, 22 Aug 2011 23:57:23 -0700
Subject: [PATCH] ARM: OMAP: Move omap2_init_common_devices out of init_=
early

There's no need to call omap2_init_common_devices from init_early.

It no longer does anything else except reprogram the memory timings
for some boards, so it's better to do it later so we have a chance
to get console messages if something goes wrong.

Move it to happen after omap_serial_init gets called. And while
patching it anyways, rename it to omap_sdrc_init as suggested by
Benoit Cousson <b-cousson@ti.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/=
board-2430sdp.c
index 2028464..a4f43ee 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -144,7 +144,6 @@ static struct omap_board_config_kernel sdp2430_conf=
ig[] __initdata =3D {
 static void __init omap_2430sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] =3D {
@@ -235,6 +234,7 @@ static void __init omap_2430sdp_init(void)
=20
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	omap2_hsmmc_init(mmc);
 	omap2_usbfs_init(&sdp2430_usb_config);
=20
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/=
board-3430sdp.c
index bd600cf..cc8e148 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -228,7 +228,6 @@ static struct omap_board_config_kernel sdp3430_conf=
ig[] __initdata =3D {
 static void __init omap_3430sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(hyb18m512160af6_sdrc_params, NULL);
 }
=20
 static struct omap2_hsmmc_info mmc[] =3D {
@@ -719,6 +718,7 @@ static void __init omap_3430sdp_init(void)
 		gpio_pendown =3D SDP3430_TS_GPIO_IRQ_SDPV1;
 	omap_ads7846_init(1, gpio_pendown, 310, NULL);
 	board_serial_init();
+	omap_sdrc_init(hyb18m512160af6_sdrc_params, NULL);
 	usb_musb_init(NULL);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/=
board-3630sdp.c
index e4f37b5..96766e9 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -73,8 +73,6 @@ static struct omap_board_config_kernel sdp_config[] _=
_initdata =3D {
 static void __init omap_sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
-				  h8mbx00u0mer0em_sdrc_params);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -207,6 +205,8 @@ static void __init omap_sdp_init(void)
 	omap_board_config =3D sdp_config;
 	omap_board_config_size =3D ARRAY_SIZE(sdp_config);
 	zoom_peripherals_init();
+	omap_sdrc_init(h8mbx00u0mer0em_sdrc_params,
+				  h8mbx00u0mer0em_sdrc_params);
 	zoom_display_init();
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp, NAND_BUSWIDTH_16=
);
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/=
board-4430sdp.c
index c7cef44..bbe3735 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -392,7 +392,6 @@ static struct omap_board_config_kernel sdp4430_conf=
ig[] __initdata =3D {
 static void __init omap_4430sdp_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static struct omap_musb_board_data musb_board_data =3D {
@@ -809,6 +808,7 @@ static void __init omap_4430sdp_init(void)
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	board_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	omap4_sdp4430_wifi_init();
 	omap4_twl6030_hsmmc_init(mmc);
=20
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-om=
ap2/board-am3517crane.c
index 933e935..4701e8c 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -50,7 +50,6 @@ static struct omap_board_mux board_mux[] __initdata =3D=
 {
 static void __init am3517_crane_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static struct usbhs_omap_board_data usbhs_bdata __initdata =3D {
@@ -70,6 +69,7 @@ static void __init am3517_crane_init(void)
=20
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
=20
 	omap_board_config =3D am3517_crane_config;
 	omap_board_config_size =3D ARRAY_SIZE(am3517_crane_config);
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap=
2/board-am3517evm.c
index f3006c3..b5391a1 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -365,7 +365,6 @@ static struct omap_dss_board_info am3517_evm_dss_da=
ta =3D {
 static void __init am3517_evm_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static struct omap_musb_board_data musb_board_data =3D {
@@ -469,6 +468,7 @@ static void __init am3517_evm_init(void)
 	am3517_evm_i2c_init();
 	omap_display_init(&am3517_evm_dss_data);
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
=20
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/=
board-apollon.c
index 7021170..6d88ffa 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -276,7 +276,6 @@ static struct omap_board_config_kernel apollon_conf=
ig[] __initdata =3D {
 static void __init omap_apollon_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static struct gpio apollon_gpio_leds[] __initdata =3D {
@@ -340,6 +339,7 @@ static void __init omap_apollon_init(void)
 	 */
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 }
=20
 static void __init omap_apollon_map_io(void)
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/b=
oard-cm-t35.c
index 3af8aab..0f25496 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -474,8 +474,6 @@ static void __init cm_t35_init_i2c(void)
 static void __init cm_t35_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -610,6 +608,8 @@ static void __init cm_t3x_common_init(void)
 	omap_board_config_size =3D ARRAY_SIZE(cm_t35_config);
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
 	cm_t35_init_i2c();
 	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
 	cm_t35_init_ethernet();
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2=
/board-cm-t3517.c
index 05c72f4..88e1f74 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -254,7 +254,6 @@ static struct omap_board_config_kernel cm_t3517_con=
fig[] __initdata =3D {
 static void __init cm_t3517_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -289,6 +288,7 @@ static void __init cm_t3517_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	omap_board_config =3D cm_t3517_config;
 	omap_board_config_size =3D ARRAY_SIZE(cm_t3517_config);
 	cm_t3517_init_leds();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-oma=
p2/board-devkit8000.c
index b6002ec..631dc58 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -401,8 +401,6 @@ static struct platform_device keys_gpio =3D {
 static void __init devkit8000_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-				  mt46h32m32lf6_sdrc_params);
 }
=20
 static void __init devkit8000_init_irq(void)
@@ -645,6 +643,8 @@ static void __init devkit8000_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
=20
 	omap_dm9000_init();
=20
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/=
board-generic.c
index 54db41a..5223898 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -36,12 +36,12 @@ static struct omap_board_config_kernel generic_conf=
ig[] =3D {
 static void __init omap_generic_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static void __init omap_generic_init(void)
 {
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	omap_board_config =3D generic_config;
 	omap_board_config_size =3D ARRAY_SIZE(generic_config);
 }
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board=
-h4.c
index 45de2b3..84ca5c0 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -293,7 +293,6 @@ static struct omap_board_config_kernel h4_config[] =
__initdata =3D {
 static void __init omap_h4_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static void __init omap_h4_init_irq(void)
@@ -371,6 +370,7 @@ static void __init omap_h4_init(void)
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	h4_init_flash();
 }
=20
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2=
/board-igep0020.c
index 35be778..1b2309f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -494,8 +494,6 @@ static struct platform_device *igep_devices[] __ini=
tdata =3D {
 static void __init igep_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(m65kxxxxam_sdrc_params,
-				  m65kxxxxam_sdrc_params);
 }
=20
 static int igep2_keymap[] =3D {
@@ -650,6 +648,8 @@ static void __init igep_init(void)
 	igep_i2c_init();
 	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));
 	omap_serial_init();
+	omap_sdrc_init(m65kxxxxam_sdrc_params,
+				  m65kxxxxam_sdrc_params);
 	usb_musb_init(NULL);
=20
 	igep_flash_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/boar=
d-ldp.c
index 218764c..c45a0f4 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -196,7 +196,6 @@ static struct omap_board_config_kernel ldp_config[]=
 __initdata =3D {
 static void __init omap_ldp_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static struct twl4030_gpio_platform_data ldp_gpio_data =3D {
@@ -325,6 +324,7 @@ static void __init omap_ldp_init(void)
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	omap_ads7846_init(1, 54, 310, NULL);
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	usb_musb_init(NULL);
 	board_nand_init(ldp_nand_partitions,
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/boa=
rd-n8x0.c
index e11f0c5..2545a4a 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -625,7 +625,6 @@ static void __init n8x0_map_io(void)
 static void __init n8x0_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -689,6 +688,7 @@ static void __init n8x0_init_machine(void)
 		i2c_register_board_info(2, n810_i2c_board_info_2,
 					ARRAY_SIZE(n810_i2c_board_info_2));
 	board_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	gpmc_onenand_init(board_onenand_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-om=
ap2/board-omap3beagle.c
index 3ae16b4..ce3234d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -447,8 +447,6 @@ static struct platform_device keys_gpio =3D {
 static void __init omap3_beagle_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-				  mt46h32m32lf6_sdrc_params);
 }
=20
 static void __init omap3_beagle_init_irq(void)
@@ -534,6 +532,8 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
=20
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	/* REVISIT leave DVI powered down until it's needed ... */
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2=
/board-omap3evm.c
index c452b3f..0735bca 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -523,7 +523,6 @@ static struct omap_board_config_kernel omap3_evm_co=
nfig[] __initdata =3D {
 static void __init omap3_evm_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 }
=20
 static struct usbhs_omap_board_data usbhs_bdata __initdata =3D {
@@ -640,6 +639,7 @@ static void __init omap3_evm_init(void)
 	omap_display_init(&omap3_evm_dss_data);
=20
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params, NULL);
=20
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-oma=
p2/board-omap3logic.c
index 703aeb5..2e0b011 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -185,7 +185,6 @@ static inline void __init board_smsc911x_init(void)
 static void __init omap3logic_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -200,6 +199,7 @@ static void __init omap3logic_init(void)
 	omap3torpedo_fix_pbias_voltage();
 	omap3logic_i2c_init();
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	board_mmc_init();
 	board_smsc911x_init();
=20
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-o=
map2/board-omap3pandora.c
index 080d7bd..0f70566 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -528,8 +528,6 @@ static struct spi_board_info omap3pandora_spi_board=
_info[] __initdata =3D {
 static void __init omap3pandora_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-				  mt46h32m32lf6_sdrc_params);
 }
=20
 static void __init pandora_wl1251_init(void)
@@ -593,6 +591,8 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_display_init(&pandora_dss_data);
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap_ads7846_init(1, OMAP3_PANDORA_TS_GPIO, 0, NULL);
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-o=
map2/board-omap3stalker.c
index 8e10498..04981f9 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -431,7 +431,6 @@ static struct omap_board_config_kernel omap3_stalke=
r_config[] __initdata =3D {
 static void __init omap3_stalker_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params, NULL);
 }
=20
 static void __init omap3_stalker_init_irq(void)
@@ -478,6 +477,7 @@ static void __init omap3_stalker_init(void)
 	omap_display_init(&omap3_stalker_dss_data);
=20
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params, NULL);
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_ads7846_init(1, OMAP3_STALKER_TS_GPIO, 310, NULL);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach=
-omap2/board-omap3touchbook.c
index 852ea04..b3fe7ad 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -329,8 +329,6 @@ static struct omap_board_mux board_mux[] __initdata=
 =3D {
 static void __init omap3_touchbook_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-				  mt46h32m32lf6_sdrc_params);
 }
=20
 static void __init omap3_touchbook_init_irq(void)
@@ -385,6 +383,8 @@ static void __init omap3_touchbook_init(void)
 	platform_add_devices(omap3_touchbook_devices,
 			ARRAY_SIZE(omap3_touchbook_devices));
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
=20
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	/* REVISIT leave DVI powered down until it's needed ... */
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-oma=
p2/board-omap4panda.c
index 9aaa960..b730ca5 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -98,7 +98,6 @@ static struct platform_device *panda_devices[] __init=
data =3D {
 static void __init omap4_panda_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static const struct usbhs_omap_board_data usbhs_bdata __initconst =3D =
{
@@ -569,6 +568,7 @@ static void __init omap4_panda_init(void)
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
 	board_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/bo=
ard-overo.c
index f949a99..c3bd1af 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -481,8 +481,6 @@ static int __init overo_spi_init(void)
 static void __init overo_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-				  mt46h32m32lf6_sdrc_params);
 }
=20
 static const struct usbhs_omap_board_data usbhs_bdata __initconst =3D =
{
@@ -514,6 +512,8 @@ static void __init overo_init(void)
 	overo_i2c_init();
 	omap_display_init(&overo_dss_data);
 	omap_serial_init();
+	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
 	omap_nand_flash_init(0, overo_nand_partitions,
 			     ARRAY_SIZE(overo_nand_partitions));
 	usb_musb_init(NULL);
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/bo=
ard-rm680.c
index 7dfed24..a6f76e1 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -125,11 +125,7 @@ static void __init rm680_peripherals_init(void)
=20
 static void __init rm680_init_early(void)
 {
-	struct omap_sdrc_params *sdrc_params;
-
 	omap2_init_common_infrastructure();
-	sdrc_params =3D nokia_get_sdram_timings();
-	omap2_init_common_devices(sdrc_params, sdrc_params);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -140,8 +136,14 @@ static struct omap_board_mux board_mux[] __initdat=
a =3D {
=20
 static void __init rm680_init(void)
 {
+	struct omap_sdrc_params *sdrc_params;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
+
+	sdrc_params =3D nokia_get_sdram_timings();
+	omap_sdrc_init(sdrc_params, sdrc_params);
+
 	usb_musb_init(NULL);
 	rm680_peripherals_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index 5ea142f..656a8b5 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -104,11 +104,7 @@ static struct omap_board_config_kernel rx51_config=
[] =3D {
=20
 static void __init rx51_init_early(void)
 {
-	struct omap_sdrc_params *sdrc_params;
-
 	omap2_init_common_infrastructure();
-	sdrc_params =3D nokia_get_sdram_timings();
-	omap2_init_common_devices(sdrc_params, sdrc_params);
 }
=20
 extern void __init rx51_peripherals_init(void);
@@ -127,11 +123,17 @@ static struct omap_musb_board_data musb_board_dat=
a =3D {
=20
 static void __init rx51_init(void)
 {
+	struct omap_sdrc_params *sdrc_params;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config =3D rx51_config;
 	omap_board_config_size =3D ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	omap_serial_init();
+
+	sdrc_params =3D nokia_get_sdram_timings();
+	omap_sdrc_init(sdrc_params, sdrc_params);
+
 	usb_musb_init(&musb_board_data);
 	rx51_peripherals_init();
=20
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap=
2/board-ti8168evm.c
index a85d5b0..e249c3d 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -30,12 +30,12 @@ static struct omap_board_config_kernel ti8168_evm_c=
onfig[] __initdata =3D {
 static void __init ti8168_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
 }
=20
 static void __init ti8168_evm_init(void)
 {
 	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
 	omap_board_config =3D ti8168_evm_config;
 	omap_board_config_size =3D ARRAY_SIZE(ti8168_evm_config);
 }
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/boa=
rd-zoom.c
index 8a98c3c..5695264 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -37,12 +37,6 @@
 static void __init omap_zoom_init_early(void)
 {
 	omap2_init_common_infrastructure();
-	if (machine_is_omap_zoom2())
-		omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
-					  mt46h32m32lf6_sdrc_params);
-	else if (machine_is_omap_zoom3())
-		omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
-					  h8mbx00u0mer0em_sdrc_params);
 }
=20
 #ifdef CONFIG_OMAP_MUX
@@ -129,6 +123,14 @@ static void __init omap_zoom_init(void)
 						ZOOM_NAND_CS, NAND_BUSWIDTH_16);
 	zoom_debugboard_init();
 	zoom_peripherals_init();
+
+	if (machine_is_omap_zoom2())
+		omap_sdrc_init(mt46h32m32lf6_sdrc_params,
+					  mt46h32m32lf6_sdrc_params);
+	else if (machine_is_omap_zoom3())
+		omap_sdrc_init(h8mbx00u0mer0em_sdrc_params,
+					  h8mbx00u0mer0em_sdrc_params);
+
 	zoom_display_init();
 }
=20
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2ce1ce6..9258a5c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -376,7 +376,7 @@ void __init omap2_init_common_infrastructure(void)
 	 * omap_hwmod_late_init(), so boards that desire full watchdog
 	 * coverage of kernel initialization can reprogram the
 	 * postsetup_state between the calls to
-	 * omap2_init_common_infra() and omap2_init_common_devices().
+	 * omap2_init_common_infra() and omap_sdrc_init().
 	 *
 	 * XXX ideally we could detect whether the MPU WDT was currently
 	 * enabled here and make this conditional
@@ -400,7 +400,7 @@ void __init omap2_init_common_infrastructure(void)
 		pr_err("Could not init clock framework - unknown SoC\n");
 }
=20
-void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs=
0,
+void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
 {
 	if (cpu_is_omap24xx() || omap3_has_sdrc()) {
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/=
include/plat/io.h
index d72ec85..75311fc 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -300,7 +300,7 @@ static inline void omap44xx_map_common_io(void)
 #endif
=20
 extern void omap2_init_common_infrastructure(void);
-extern void omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs=
0,
+extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
=20
 #define __arch_ioremap	omap_ioremap
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
