From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: fix compiler warning
Date: Tue, 31 May 2011 03:13:05 -0700
Message-ID: <20110531101305.GQ11352@atomide.com>
References: <1301070101-12631-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11909 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751859Ab1EaKNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 06:13:07 -0400
Content-Disposition: inline
In-Reply-To: <1301070101-12631-1-git-send-email-michael.jones@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: linux-omap@vger.kernel.org

* Michael Jones <michael.jones@matrix-vision.de> [110325 09:20]:
>   CC      arch/arm/plat-omap/gpio.o
> arch/arm/plat-omap/gpio.c: In function =E2=80=98omap_gpio_chip_init=E2=
=80=99:
> arch/arm/plat-omap/gpio.c:1675: warning: unused variable =E2=80=98d=E2=
=80=99

This needs to be refreshed a bit as gpio.c now lives under
drivers. Please also Cc the right mailing lists in addition
to linux-omap, you can get it with:

$ scripts/get_maintainer.pl -f drivers/gpio/gpio-omap.c
Grant Likely <grant.likely@secretlab.ca> (maintainer:GPIO SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Regards,

Tony
=20
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
>  arch/arm/plat-omap/gpio.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 971d186..a1d4d1b 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1672,7 +1672,9 @@ static void __init omap_gpio_chip_init(struct g=
pio_bank *bank)
> =20
>  	for (j =3D bank->virtual_irq_start;
>  		     j < bank->virtual_irq_start + bank_width; j++) {
> +#ifdef CONFIG_LOCKDEP
>  		struct irq_desc *d =3D irq_to_desc(j);
> +#endif
> =20
>  		lockdep_set_class(&d->lock, &gpio_lock_class);
>  		set_irq_chip_data(j, bank);
> --=20
> 1.7.4.1
>=20
>=20
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
