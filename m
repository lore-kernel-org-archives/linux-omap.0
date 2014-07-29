From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 19/35] arm: omap: irq: drop ti,intc-size support
Date: Tue, 29 Jul 2014 04:12:51 +0200
Message-ID: <20140729021251.GA4421@earth.universe>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-20-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406582183-696-20-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2014 at 04:16:07PM -0500, Felipe Balbi wrote:
> we don't need that anymore since specific
> devices are passing correct compatible flags.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/irq.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 7a4ead3..e70c26e 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -313,9 +313,6 @@ static int __init intc_of_init(struct device_node *no=
de,
>  	if (of_device_is_compatible(node, "ti,am33xx-intc"))
>  		nr_irq =3D 128;
> =20
> -	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
> -		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
> -

keeping this code would avoid breaking the DT API. I suggest to
change it to something like the following:

if (!of_property_read_u32(...))
    dev_warn(dev, "ti,intc-size is deprecated, please update your DT file");

Apart from that the Documentation [0] should be updated (add
deprecation notice for ti,intc-size and add new compatible values)
and maybe moved to [1] (where other SoCs put their irq controller
binding docs).

[0] Documentation/devicetree/bindings/arm/omap/intc.txt
[1] Documentation/devicetree/bindings/interrupt-controller/

-- Sebastian

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT1wMiAAoJENju1/PIO/qaRnMP/R+sSdbjQripBSGEtSUy2XP2
iFwUEoO7CyxjYhcCOkc/Lnpa0X8z77WE3rxHCp/e0S/buu2xtY1W0Gp4MWWKrXov
PvK4/P0QycWAZ7YhC8Tu9O0JHiuopYTEZmcCpa9KE6vdUpC0iY5tUUO4DzGkxXZK
L/lN5Cjcvgkejt811QK7JPqRKjvAcoGwcOzELWCI9TcJTO9zRxn5RPmUYiwJr6AN
d4nQdgNJgKfoZl8Po1ZiW3RTU4cpBOtj1VdKp8fQH6a2nGPmzQdcfxgQO1ConnwV
W+3uxQBz0usZLee5l3kgC3AA7vrZ97Mtro/QcAJHvOH022kJVApNHYgX/ksAd87R
ZQEvODFzmqXNQ4p2cHYcm9pqsahDSD574H2PKKRoD62hwG+xKrplEXG72l5R2zA/
FKHW9olFVoxr3adWNqscHUXc3cS24Xy5kzamwlzT6TNWnnWglfhS0E4yRM86SgZf
Rp4KNi53KrtOkGCh8O6Csqy0YQK1H6ldTrjhZwrYkT1sNv+znrj59WuvvpttMonV
/UuYyP1HkAxQlRm7va0pMffKrd9p1QsIsj5RFimV9KjbxsN+u+wq/Hl6il/a71/E
3/FyBTSu2lXgNvjRYW/zKEXY5rEDxJjj4wLjJLL80GYhy2yCaTgCw625hNovPZgb
2dyeFuaZ3fFh6cjCU0Dg
=adkY
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
