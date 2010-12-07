From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] OMAP2+: resolve section mismatch warnings in OMAP core code
Date: Tue, 7 Dec 2010 09:34:51 +0800
Message-ID: <AANLkTi=ip3BJEToZ+vttJa2oJEm7iY8ohU3Cn=DF+77g@mail.gmail.com>
References: <alpine.DEB.2.00.1012061731500.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43342 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0LGBfN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:35:13 -0500
Received: by qyk11 with SMTP id 11so4345739qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 17:35:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012061731500.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul,

I did the similar patch several days ago.
https://patchwork.kernel.org/patch/367011/


On Tue, Dec 7, 2010 at 8:32 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Resolve the following section mismatch warnings in the OMAP core code
> when building omap2plus_defconfig:
>
> WARNING: vmlinux.o(.text+0x2617c): Section mismatch in reference from=
 the function zoom_twl_gpio_setup() to the (unknown reference) .init.da=
ta:(unknown)
> WARNING: vmlinux.o(.text+0x26378): Section mismatch in reference from=
 the function cm_t35_twl_gpio_setup() to the (unknown reference) .init.=
data:(unknown)
> WARNING: vmlinux.o(.data+0x1f460): Section mismatch in reference from=
 the variable h4_config to the (unknown reference) .init.data:(unknown)
> WARNING: vmlinux.o(.data+0x1fc88): Section mismatch in reference from=
 the variable sdp2430_config to the (unknown reference) .init.data:(unk=
nown)
> WARNING: vmlinux.o(.data+0x20258): Section mismatch in reference from=
 the variable apollon_config to the (unknown reference) .init.data:(unk=
nown)
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/board-2430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+-
> =A0arch/arm/mach-omap2/board-apollon.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+-
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 =
+-
> =A0arch/arm/mach-omap2/board-h4.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A06 +++---
> =A05 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap=
2/board-2430sdp.c
> index b527f8d..9ab8bb1 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -135,7 +135,7 @@ static inline void board_smc91x_init(void)
>
> =A0#endif
>
> -static struct omap_board_config_kernel sdp2430_config[] =3D {
> +static struct omap_board_config_kernel sdp2430_config[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0{OMAP_TAG_LCD, &sdp2430_lcd_config},
> =A0};
>
> diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap=
2/board-apollon.c
> index 2c6db1a..5c432d8 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -270,7 +270,7 @@ static struct omap_lcd_config apollon_lcd_config =
__initdata =3D {
> =A0 =A0 =A0 =A0.ctrl_name =A0 =A0 =A0=3D "internal",
> =A0};
>
> -static struct omap_board_config_kernel apollon_config[] =3D {
> +static struct omap_board_config_kernel apollon_config[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0{ OMAP_TAG_LCD, =A0 =A0 =A0 =A0 &apollon_lcd_config },
> =A0};
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2=
/board-cm-t35.c
> index 63f764e..df16d69 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -594,7 +594,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> =A0};
>
> -static struct ehci_hcd_omap_platform_data ehci_pdata __initdata =3D =
{
> +static struct ehci_hcd_omap_platform_data ehci_pdata =3D {

How about move out the code of ehci init from cm_t35_twl_gpio_setup
like others did?

> =A0 =A0 =A0 =A0.port_mode[0] =3D EHCI_HCD_OMAP_MODE_PHY,
> =A0 =A0 =A0 =A0.port_mode[1] =3D EHCI_HCD_OMAP_MODE_PHY,
> =A0 =A0 =A0 =A0.port_mode[2] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/boa=
rd-h4.c
> index 929993b..5549f2c 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -283,7 +283,7 @@ static struct omap_usb_config h4_usb_config __ini=
tdata =3D {
> =A0 =A0 =A0 =A0.hmc_mode =A0 =A0 =A0 =3D 0x00, =A0 =A0 =A0 =A0 /* 0:d=
ev|otg 1:disable 2:disable */
> =A0};
>
> -static struct omap_board_config_kernel h4_config[] =3D {
> +static struct omap_board_config_kernel h4_config[] __initdata =3D {
> =A0 =A0 =A0 =A0{ OMAP_TAG_LCD, =A0 =A0 =A0 =A0 &h4_lcd_config },
> =A0};
>
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/=
mach-omap2/board-zoom-peripherals.c
> index 86c9b21..e58fe1e 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -196,7 +196,7 @@ struct wl12xx_platform_data omap_zoom_wlan_data _=
_initdata =3D {
> =A0 =A0 =A0 =A0.board_ref_clock =3D 1,
> =A0};
>
> -static struct omap2_hsmmc_info mmc[] __initdata =3D {
> +static struct omap2_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "externa=
l",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> @@ -224,8 +224,8 @@ static struct omap2_hsmmc_info mmc[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> =A0};
>
> -static int zoom_twl_gpio_setup(struct device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned gpio, unsigned ngpio)
> +static int zoom_twl_gpio_setup(struct device *dev, unsigned gpio,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned=
 ngpio)
> =A0{
> =A0 =A0 =A0 =A0/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> =A0 =A0 =A0 =A0mmc[0].gpio_cd =3D gpio + 0;
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
