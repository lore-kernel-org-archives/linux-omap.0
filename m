From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 13/35] arm: omap: irq: call set_handle_irq() from
 intc_of_init
Date: Tue, 29 Jul 2014 04:20:20 +0200
Message-ID: <20140729022019.GB4421@earth.universe>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-14-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406582183-696-14-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2014 at 04:16:01PM -0500, Felipe Balbi wrote:
> this will let us drop .handle_irq and .init_irq fields
> from our generic machine_descs.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/irq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index e6997c5..e452411 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -314,6 +314,8 @@ static int __init intc_of_init(struct device_node *no=
de,
> =20
>  	omap_init_irq(res.start, nr_irq, of_node_get(node));
> =20
> +	set_handle_irq(omap2_intc_handle_irq);
> +
>  	return 0;
>  }
>

if you respin the patchset you may want to call omap_intc_handle_irq
directly. It makes the review of the patchset less confusing.

(I was wondering why omap3 can call omap2_intc_handle_irq until I
noticed, that your previous changes made both functions simple
wrapper functions for omap_intc_handle_irq)

-- Sebastian

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT1wTjAAoJENju1/PIO/qa1OgP/jx26mJVpIDfor+3QG6ER8cI
CI+pDLoC62c6vRnoPJgQfqLD/7yZ1VaeZMJtaUSGmj+DG6JVHJF3QD09JTcvb62f
fI3FTu6Hp+wZ362HIfUyih+liT8fuy9DVP9MirQ4PTVBN6FO9xB/11Owu4n1FhSg
s3JoML3NiNsgbg0J0pHPSXpt24EoyLfzp/7gSe4QxOK//pg1eoUzrSmTsISQGE9U
GojrD6u/7ialr8pbq9f5wxuxsIBaUUcnFioOempWU3M24nwHs0meTIKWhLNSM7CM
s/pSCwlFi7QRds69hAL60au1q+Mb2Dwy9tP8VB70gDpR2IsK5vROmpTiJy9++nzr
EZ9l05fIny5VJ2j6YZ3ZPk1tXvC/wQGr9L9cfP+8pXIi6oY4bcAKhHfHvrBlT84C
siswVV8cKElgjdAprt+igqDVOpWpin7vEqJ7NbU3/YAO2AD/L63VbDYQ+kGByYH8
yjDbecym3ydtcLMVy5unqR+QPAA+yK5235+vz1KAVZ8iTfHmXNxrXNvzoZ3fqwYr
mHhi6vz1yoJhXaFoLFvgVF9vPoRc80y8wZeMMkoXDJyyXopDCsZEyqb2L5MFuqv7
ImPIXGb/Qr7eu9NKGKSwfcrBmas1I2tlS8RuF5dln50dT5f9hmC3viF0WonJb90H
L81vBOMb3bU74joY+a3D
=9sGy
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
