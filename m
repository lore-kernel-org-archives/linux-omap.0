From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [RESEND PATCH 3/4] omap: igep0020: add support for IGEP3
Date: Mon, 16 May 2011 09:16:23 +0200
Message-ID: <BANLkTinSNyS9t=yc25y6pNXg6EpH37_EcQ@mail.gmail.com>
References: <cover.1305235542.git.mike@compulab.co.il>
	<ca1b59c2bed6076d68f18bad84a2504b855160d4.1305235542.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56177 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab1EPHQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 03:16:24 -0400
In-Reply-To: <ca1b59c2bed6076d68f18bad84a2504b855160d4.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony.Lindgren.tony@atomide.com, linux-omap@vger.kernel.org, linux-arm@vger.kernel.org

2011/5/12 Mike Rapoport <mike@compulab.co.il>:
> Add IGEP3 machine support to board-igep0020
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0103 ++++++++++++++=
++++++++++++--------
> =C2=A01 files changed, 80 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index ea7cbc6..0d6d583 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -55,6 +55,11 @@
> =C2=A0#define IGEP2_RC_GPIO_WIFI_NRESET =C2=A0139
> =C2=A0#define IGEP2_RC_GPIO_BT_NRESET =C2=A0 =C2=A0137
>
> +#define IGEP3_GPIO_LED0_GREEN =C2=A054
> +#define IGEP3_GPIO_LED0_RED =C2=A0 =C2=A053
> +#define IGEP3_GPIO_LED1_RED =C2=A0 =C2=A016
> +#define IGEP3_GPIO_USBH_NRESET =C2=A0183
> +
> =C2=A0/*
> =C2=A0* IGEP2 Hardware Revision Table
> =C2=A0*
> @@ -69,6 +74,7 @@
>
> =C2=A0#define IGEP2_BOARD_HWREV_B =C2=A0 =C2=A00
> =C2=A0#define IGEP2_BOARD_HWREV_C =C2=A0 =C2=A01
> +#define IGEP3_BOARD_HWREV =C2=A0 =C2=A0 =C2=A02
>
> =C2=A0static u8 hwrev;
>
> @@ -76,6 +82,11 @@ static void __init igep2_get_revision(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 ret;
>
> + =C2=A0 =C2=A0 =C2=A0 if (machine_is_igep0030()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwrev =3D IGEP3_BO=
ARD_HWREV;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mux_init_gpio(IGEP2_GPIO_LED1_RED, OM=
AP_PIN_INPUT);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gpio_request_one(IGEP2_GPIO_LED1_RED, =
GPIOF_IN, "GPIO_HW0_REV")) {
> @@ -332,24 +343,40 @@ static struct platform_device igep_led_device =3D=
 {
>
> =C2=A0static void __init igep_leds_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[0].gpio =3D IGEP2_GPIO_LED0_RED=
;
> - =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[1].gpio =3D IGEP2_GPIO_LED0_GRE=
EN;
> - =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[2].gpio =3D IGEP2_GPIO_LED1_RED=
;
> + =C2=A0 =C2=A0 =C2=A0 if (machine_is_igep0020()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[0].=
gpio =3D IGEP2_GPIO_LED0_RED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[1].=
gpio =3D IGEP2_GPIO_LED0_GREEN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[2].=
gpio =3D IGEP2_GPIO_LED1_RED;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[0].=
gpio =3D IGEP3_GPIO_LED0_RED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[1].=
gpio =3D IGEP3_GPIO_LED0_GREEN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[2].=
gpio =3D IGEP3_GPIO_LED1_RED;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_device_register(&igep_led_device)=
;
> =C2=A0}
>
> =C2=A0#else
> =C2=A0static struct gpio igep_gpio_leds[] __initdata =3D {
> - =C2=A0 =C2=A0 =C2=A0 { IGEP2_GPIO_LED0_RED, =C2=A0 GPIOF_OUT_INIT_L=
OW, "gpio-led:red:d0" =C2=A0 },
> - =C2=A0 =C2=A0 =C2=A0 { IGEP2_GPIO_LED0_GREEN, GPIOF_OUT_INIT_LOW, "=
gpio-led:green:d0" },
> - =C2=A0 =C2=A0 =C2=A0 { IGEP2_GPIO_LED1_RED, =C2=A0 GPIOF_OUT_INIT_L=
OW, "gpio-led:red:d1" =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 { -EINVAL, =C2=A0 =C2=A0 =C2=A0GPIOF_OUT_INIT_=
LOW, "gpio-led:red:d0" =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 { -EINVAL, =C2=A0 =C2=A0 =C2=A0GPIOF_OUT_INIT_=
LOW, "gpio-led:green:d0" },
> + =C2=A0 =C2=A0 =C2=A0 { -EINVAL, =C2=A0 =C2=A0 =C2=A0GPIOF_OUT_INIT_=
LOW, "gpio-led:red:d1" =C2=A0 },
> =C2=A0};
>
> =C2=A0static inline void igep_leds_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> + =C2=A0 =C2=A0 =C2=A0 if (machine_is_igep0020()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[0].=
gpio =3D IGEP2_GPIO_LED0_RED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[1].=
gpio =3D IGEP2_GPIO_LED0_GREEN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[2].=
gpio =3D IGEP2_GPIO_LED1_RED;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[0].=
gpio =3D IGEP3_GPIO_LED0_RED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[1].=
gpio =3D IGEP3_GPIO_LED0_GREEN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[2].=
gpio =3D IGEP3_GPIO_LED1_RED;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gpio_request_array(igep_gpio_leds, ARR=
AY_SIZE(igep_gpio_leds))) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain leds gpios\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> @@ -386,6 +413,9 @@ static int igep_twl_gpio_setup(struct device *dev=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_gpio_leds[3].gpio =3D gpio + TWL4030_=
GPIO_MAX + 1;
> =C2=A0#endif
>
> + =C2=A0 =C2=A0 =C2=A0 if (machine_is_igep0030())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * REVISIT: need ehci-omap hooks for exter=
nal VBUS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * power switch and overcurrent detect
> @@ -548,18 +578,20 @@ static void __init igep_i2c_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>
> - =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* Bus 3 is attached to the DVI port wher=
e devices like the pico DLP
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* projector don't work reliably with 400=
kHz
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 ret =3D omap_register_i2c_bus(3, 100, igep2_i2=
c3_boardinfo,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARRAY_SIZE(igep2_i=
2c3_boardinfo));
> - =C2=A0 =C2=A0 =C2=A0 if (ret)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("IGEP2:=
 Could not register I2C3 bus (%d)\n", ret);
> -
> - =C2=A0 =C2=A0 =C2=A0 igep_twldata.codec =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_codec_data;
> - =C2=A0 =C2=A0 =C2=A0 igep_twldata.keypad =C2=A0 =C2=A0 =3D &igep2_k=
eypad_pdata;
> - =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2 =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_vpll2;
> + =C2=A0 =C2=A0 =C2=A0 if (machine_is_igep0020()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Bus 3 is a=
ttached to the DVI port where devices like the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* pico DLP p=
rojector don't work reliably with 400kHz
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D omap_regis=
ter_i2c_bus(3, 100, igep2_i2c3_boardinfo,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARRAY_SIZE(igep2_i2c3_boardinfo));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.codec=
 =C2=A0 =C2=A0 =C2=A0=3D &igep2_codec_data;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.keypa=
d =C2=A0 =C2=A0 =3D &igep2_keypad_pdata;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2=
 =C2=A0 =C2=A0 =C2=A0=3D &igep2_vpll2;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_pmic_init("twl4030", &igep_twldata);
> =C2=A0}
> @@ -575,6 +607,17 @@ static const struct usbhs_omap_board_data igep2_=
usbhs_bdata __initconst =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.reset_gpio_port[2] =3D -EINVAL,
> =C2=A0};
>
> +static const struct usbhs_omap_board_data igep3_usbhs_bdata __initco=
nst =3D {
> + =C2=A0 =C2=A0 =C2=A0 .port_mode[0] =3D OMAP_USBHS_PORT_MODE_UNUSED,
> + =C2=A0 =C2=A0 =C2=A0 .port_mode[1] =3D OMAP_EHCI_PORT_MODE_PHY,
> + =C2=A0 =C2=A0 =C2=A0 .port_mode[2] =3D OMAP_USBHS_PORT_MODE_UNUSED,
> +
> + =C2=A0 =C2=A0 =C2=A0 .phy_reset =3D true,
> + =C2=A0 =C2=A0 =C2=A0 .reset_gpio_port[0] =3D -EINVAL,
> + =C2=A0 =C2=A0 =C2=A0 .reset_gpio_port[1] =3D IGEP3_GPIO_USBH_NRESET=
,
> + =C2=A0 =C2=A0 =C2=A0 .reset_gpio_port[2] =3D -EINVAL,
> +};
> +
> =C2=A0#ifdef CONFIG_OMAP_MUX
> =C2=A0static struct omap_board_mux board_mux[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> @@ -597,7 +640,7 @@ static void __init igep_wlan_bt_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_g=
pios[0].gpio =3D IGEP2_RB_GPIO_WIFI_NPD;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_g=
pios[1].gpio =3D IGEP2_RB_GPIO_WIFI_NRESET;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_g=
pios[2].gpio =3D IGEP2_RB_GPIO_BT_NRESET;
> - =C2=A0 =C2=A0 =C2=A0 } else if (hwrev =3D=3D IGEP2_BOARD_HWREV_C) {
> + =C2=A0 =C2=A0 =C2=A0 } else if (hwrev =3D=3D IGEP2_BOARD_HWREV_C ||=
 machine_is_igep0030()) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_g=
pios[0].gpio =3D IGEP2_RC_GPIO_WIFI_NPD;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_g=
pios[1].gpio =3D IGEP2_RC_GPIO_WIFI_NRESET;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_g=
pios[2].gpio =3D IGEP2_RC_GPIO_BT_NRESET;
> @@ -645,10 +688,14 @@ static void __init igep_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_wlan_bt_init();
>
> - =C2=A0 =C2=A0 =C2=A0 omap_display_init(&igep2_dss_data);
> - =C2=A0 =C2=A0 =C2=A0 igep2_display_init();
> - =C2=A0 =C2=A0 =C2=A0 igep2_init_smsc911x();
> - =C2=A0 =C2=A0 =C2=A0 usbhs_init(&igep2_usbhs_bdata);
> + =C2=A0 =C2=A0 =C2=A0 if (machine_is_igep0020()) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_display_init(=
&igep2_dss_data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_display_init=
();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_init_smsc911=
x();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usbhs_init(&igep2_=
usbhs_bdata);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usbhs_init(&igep3_=
usbhs_bdata);
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0}
>
> =C2=A0MACHINE_START(IGEP0020, "IGEP v2 board")
> @@ -660,3 +707,13 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.init_machine =C2=A0 =3D igep_init,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.timer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &omap_timer,
> =C2=A0MACHINE_END
> +
> +MACHINE_START(IGEP0030, "IGEP OMAP3 module")
> + =C2=A0 =C2=A0 =C2=A0 .boot_params =C2=A0 =C2=A0=3D 0x80000100,
> + =C2=A0 =C2=A0 =C2=A0 .reserve =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D omap_r=
eserve,
> + =C2=A0 =C2=A0 =C2=A0 .map_io =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap3_=
map_io,
> + =C2=A0 =C2=A0 =C2=A0 .init_early =C2=A0 =C2=A0 =3D igep_init_early,
> + =C2=A0 =C2=A0 =C2=A0 .init_irq =C2=A0 =C2=A0 =C2=A0 =3D omap_init_i=
rq,
> + =C2=A0 =C2=A0 =C2=A0 .init_machine =C2=A0 =3D igep_init,
> + =C2=A0 =C2=A0 =C2=A0 .timer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
omap_timer,
> +MACHINE_END
> --
> 1.7.3.1
>
>
Acked-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
