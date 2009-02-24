From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 16/23] usb: host: ehci: add
	platform_data
Date: Wed, 25 Feb 2009 00:35:05 +0200
Message-ID: <6ed0b2680902241435j6c11e093t66722c098a9c4ed@mail.gmail.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:27066 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZBXWfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:35:09 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1852579fkf.5
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 14:35:06 -0800 (PST)
In-Reply-To: <1235415335-17408-17-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>

On Mon, Feb 23, 2009 at 8:55 PM, Felipe Balbi <me@felipebalbi.com> wrot=
e:
> Adding a platform_data to the driver allow us
> to remove some of the ifdeferry in the code.
>

<snip>

> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach=
-omap2/board-omap3pandora.c
> index b8a78c0..08215c0 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -297,7 +297,7 @@ static void __init omap3pandora_init(void)
> =A0 =A0 =A0 =A0spi_register_board_info(omap3pandora_spi_board_info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap3pandor=
a_spi_board_info));
> =A0 =A0 =A0 =A0usb_musb_init();
> - =A0 =A0 =A0 usb_ehci_init();
> + =A0 =A0 =A0 usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 6=
1);

Perhaps it would be better to have .chargepump and .phy_reset set to
false by default, as pandora doesn't need that chargepump thing (I
guess some other boards too), and phy reset GPIO is wrong not only for
pandora I think. Board maintainers can then send patches as needed.
There also should be a way to specify only one reset GPIO, most boards
have only one EHCI port I think. Note that .phy_reset is required for
EHCI to work on pandora (in case you have thoughts of removing that
code later).

> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb=
-ehci.c
> index 23fe857..30e1ad6 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -145,8 +145,20 @@ static void setup_ehci_io_mux(void)
> =A0 =A0 =A0 =A0return;
> =A0}
>
> -void __init usb_ehci_init(void)
> +void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int chargepump, int phy_reset, int rese=
t_gpio_port1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int reset_gpio_port2)
> =A0{
> + =A0 =A0 =A0 struct ehci_hcd_omap_platform_data pdata =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .phy_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 phy_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chargepump =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 chargepump,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .phy_reset =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 phy_reset,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reset_gpio_port1 =A0 =A0 =A0 =3D reset=
_gpio_port1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reset_gpio_port2 =A0 =A0 =A0 =3D reset=
_gpio_port2,
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 ehci_device.dev.platform_data =3D &pdata;
> +

hmm, doesn't pdata end up on stack here? platform_device_register()
doesn't seem to make a copy of that structure.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
