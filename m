From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Fri, 6 Jan 2012 17:12:12 +0100
Message-ID: <20120106161212.GA5593@avionic-0098.mockup.avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <20120106160744.GA7687@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1246158186841207138=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120106160744.GA7687-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "open list:OMAP SUPPORT" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============1246158186841207138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* David Brown wrote:
> On Fri, Jan 06, 2012 at 03:28:25PM +0100, Thierry Reding wrote:
> > diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/boar=
d-msm8x60.c
> > index 0a11342..a50c7e2 100644
> > --- a/arch/arm/mach-msm/board-msm8x60.c
> > +++ b/arch/arm/mach-msm/board-msm8x60.c
> > @@ -84,8 +84,11 @@ static void __init msm8x60_dt_init(void)
> > =20
> >  	node =3D of_find_matching_node_by_address(NULL, msm_dt_gic_match,
> >  			MSM8X60_QGIC_DIST_PHYS);
> > -	if (node)
> > -		irq_domain_add_simple(node, GIC_SPI_START);
> > +	if (node) {
> > +		struct irq_domain *domain =3D irq_domain_add_simple(node,
> > +				GIC_SPI_START, NR_MSM_IRQS);
> > +		WARN_ON(IS_ERR(domain));
> > +	}
> > =20
> >  	if (of_machine_is_compatible("qcom,msm8660-surf")) {
> >  		printk(KERN_INFO "Init surf UART registers\n");
>=20
> This is probably a consequence of MSM not really being "simple", but
> just using that.  However, NR_MSM_IRQS is only the number of IRQs on
> the MSM core.  There are also GPIO irqs, and potentially board IRQs
> (the board has an I2C-based chip with a bunch of IRQ lines on it).
>=20
> The only define that captures this now is 'NR_IRQS', even though we're
> trying to get rid of that.
>=20
> Ultimately, the correct answer will be to get the various interrupt
> controllers using their own domains,

Yes.

> but for now, this needs to be a larger value to avoid missing a bunch of
> the interrupts.

Okay, I'll make it NR_IRQS then.

Thierry

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8HHVwACgkQZ+BJyKLjJp9y4ACeK2t99UfeYkXJW5iymRldUEZd
LaAAn3oUq/CryoO51er7DPO/by7y5onm
=g/2u
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--===============1246158186841207138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1246158186841207138==--
