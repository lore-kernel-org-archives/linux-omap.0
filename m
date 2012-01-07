From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Sat, 7 Jan 2012 12:47:01 +0100
Message-ID: <20120107114701.GA3698@avionic-0098.mockup.avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <20120107055817.GG4790@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7023479018965448395=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120107055817.GG4790-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "open list:OMAP SUPPORT" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============7023479018965448395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Shawn Guo wrote:
> On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
[...]
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-im=
x6q.c
> > index c257281..9ed7812 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -95,9 +95,11 @@ static int __init imx6q_gpio_add_irq_domain(struct d=
evice_node *np,
> >  				struct device_node *interrupt_parent)
> >  {
> >  	static int gpio_irq_base =3D MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> > +	struct irq_domain *domain;
> > =20
> >  	gpio_irq_base -=3D 32;
> > -	irq_domain_add_simple(np, gpio_irq_base);
> > +	domain =3D irq_domain_add_simple(np, gpio_irq_base, 32);
> > +	WARN_ON(IS_ERR(domain));
>=20
> Why do we handle the error in a different pattern that is used for
> all above?

Because I wasn't paying attention =3D) It should be returning an error of
course. With the changes that Grant requested, domain will be NULL on error
and I guess returning -ENOMEM would be fine here (and in the above hunks).

It is of course different behaviour because the code would previously
continue execution and ignore the error, but I guess that's okay since
without the IRQ domain being registered the board will not work properly
anyway.

> I just made a small change on top of yours.  Can you please consider
> to amend it to your patch if it looks sane to you?
>=20
> diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/in=
clude/mach/irqs.h
> index 2fda5aa..70376e0 100644
> --- a/arch/arm/plat-mxc/include/mach/irqs.h
> +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> @@ -13,19 +13,20 @@
>=20
>  #include <asm-generic/gpio.h>
>=20
> +#define GIC_NUM_IRQS           160
> +#define TZIC_NUM_IRQS          128
> +#define AVIC_NUM_IRQS          64
> +
>  /*
> - * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
> - * have 128 IRQs, and those with AVIC have 64.
> - *
>   * To support single image, the biggest number should be defined on
>   * top of the list.
>   */
>  #if defined CONFIG_ARM_GIC
> -#define MXC_INTERNAL_IRQS      160
> +#define MXC_INTERNAL_IRQS      GIC_NUM_IRQS
>  #elif defined CONFIG_MXC_TZIC
> -#define MXC_INTERNAL_IRQS      128
> +#define MXC_INTERNAL_IRQS      TZIC_NUM_IRQS
>  #else
> -#define MXC_INTERNAL_IRQS      64
> +#define MXC_INTERNAL_IRQS      AVIC_NUM_IRQS
>  #endif
>=20
>  #define MXC_GPIO_IRQ_START     MXC_INTERNAL_IRQS
> @@ -54,7 +55,6 @@
>  /* REVISIT: Add IPU irqs on IMX51 */
>=20
>  #define NR_IRQS                        (MXC_IPU_IRQ_START + MX3_IPU_IRQS)
> -#define TZIC_NUM_IRQS          128
>=20
>  extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
>=20

Looks good. I'll add it to the patch along with the other requested changes.

Thanks,
Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8IMLUACgkQZ+BJyKLjJp/1yACeLArWDcm5QPj8vFgF/qTcC+gy
24YAn2JrUyS0g+M3WPv/ZB2+Qe5pOuYc
=GNXE
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============7023479018965448395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7023479018965448395==--
