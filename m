From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix omap-gpio warnings when compiling for ARCH_OMAP15XX
Date: Wed, 26 Nov 2008 09:54:19 -0800
Message-ID: <20081126175418.GR11997@atomide.com>
References: <20081111225348.GZ3162@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56474 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYKZRyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 12:54:19 -0500
Content-Disposition: inline
In-Reply-To: <20081111225348.GZ3162@earth.li>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [081111 15:44]:
> When compiling for ARCH_OMAP15XX I get the following compiler warning=
 in
> gpio.c:
>=20
> arch/arm/plat-omap/gpio.c: In function =E2=80=98_set_gpio_wakeup=E2=80=
=99:
> arch/arm/plat-omap/gpio.c:848: warning: unused variable =E2=80=98flag=
s=E2=80=99
>=20
> Simple patch below fixes this.

Sorry for the delay on responding to this.. Let's rather start
splitting the gpio code into common code and processor specific code
to fix issues like this for good. In this case, we would only register
set_wakeup functions for 16xx, 24xx, and 34xx.

Regards,

Tony

>=20
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
>=20
> -----
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 8bb4542..bfbe366 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -845,7 +845,10 @@ static inline void _set_gpio_irqenable(struct gp=
io_bank *bank, int gpio, int ena
>   */
>  static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int en=
able)
>  {
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) |=
| \
> +		defined(CONFIG_ARCH_OMAP34XX)
>  	unsigned long flags;
> +#endif
> =20
>  	switch (bank->method) {
>  #ifdef CONFIG_ARCH_OMAP16XX
> -----
>=20
> J.
>=20
> --=20
> Web [   Asking whether machines can think is like asking whether   ]
> site: http:// [           submarines can swim.           ]       Made=
 by
> www.earth.li/~noodles/  [                      ]         HuggieTag 0.=
0.23
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
