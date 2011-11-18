From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] cbus: Fix initialization of cached IRQ masks
Date: Fri, 18 Nov 2011 15:34:51 +0200
Message-ID: <20111118133450.GD9999@legolas.emea.dhcp.ti.com>
References: <20111118113132.5baeb268@milhouse>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37082 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756338Ab1KRNey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 08:34:54 -0500
Received: by mail-fx0-f50.google.com with SMTP id r15so5090488faa.37
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2011 05:34:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111118113132.5baeb268@milhouse>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2011 at 11:31:32AM +0100, Michael B=FCsch wrote:
> This fixes the initialization of retu/tahvo cached IRQ masks.
>=20
> Signed-off-by: Michael Buesch <m@bues.ch>

Reviewed-by: Felipe Balbi <balbi@ti.com>

>=20
> ---
>=20
> v2: lowercase
>=20
> Index: linux-3.1.1/drivers/cbus/retu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.1.1.orig/drivers/cbus/retu.c	2011-11-17 23:09:26.498214061 +0=
100
> +++ linux-3.1.1/drivers/cbus/retu.c	2011-11-17 23:15:50.280659655 +0100
> @@ -451,7 +451,8 @@ static int __devinit retu_probe(struct p
>  			(rev >> 4) & 0x07, rev & 0x0f);
> =20
>  	/* Mask all RETU interrupts */
> -	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
> +	retu->mask =3D 0xffff;
> +	__retu_write_reg(retu, RETU_REG_IMR, retu->mask);
> =20
>  	ret =3D request_threaded_irq(retu->irq, NULL, retu_irq_handler,
>  			IRQF_ONESHOT, "retu", retu);
> Index: linux-3.1.1/drivers/cbus/tahvo.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.1.1.orig/drivers/cbus/tahvo.c	2011-11-17 23:15:46.684674232 +=
0100
> +++ linux-3.1.1/drivers/cbus/tahvo.c	2011-11-17 23:15:50.280659655 +0100
> @@ -346,7 +346,8 @@ static int __devinit tahvo_probe(struct
>  			(rev >> 4) & 0x0f, rev & 0x0f);
> =20
>  	/* Mask all TAHVO interrupts */
> -	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
> +	tahvo->mask =3D 0xffff;
> +	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, tahvo->mask);
> =20
>  	ret =3D request_threaded_irq(irq, NULL, tahvo_irq_handler,
>  			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>=20
> --=20
> Greetings, Michael.

--=20
balbi

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxl76AAoJEIaOsuA1yqRE7XAQAJJkbNURigwOqY2gSZlIRBEm
p9pkFj0ToKKlq9Ys57+wjsAIKkjjybLRWZuwyelMK9Y33Cv3P2EFHpnqWpGLtfb3
YvU8IOP4NS2e4ovpKnPMlTf4iPp4NUblIZPT18GkW+Ly9MwJVopz1P+dA7a7Esd1
vfWUuQPG7wc65AHdlU/2mjCUZN3B32h/sINkBbbpVgsO68YHKmaTg1NtOVCPYP+R
eNQYmQ7LrDhnL4XSwWZsC91i7+11zJjVK1wnjRuB+ldxLkAnR/XbwSpmMXUY6gzb
nOkfjKmeqo1ov0gJOnyqwEnfbdXgCImjiqITf+xgjwOHStqNma+9A7+p5Gb5d0UX
oC81Pqgm+9sOzzU6gM7CPLf9AqL/o11cYzoGdZrhJedsC4aimSIMN9R5tlEwjCYk
eG2jQHEye3yAIZVVLSB/lVu3dXregO+yuqQeAbT1pwrpf31JmgjVHsRkOb/b4oCs
NjWHA3OoDWCz1qGwKdK4KNhRGovQKmMggWvI+px2OIPUrVZA0fjldAwjGiV2QGLu
PgpGafipwUyv+7EmeQNHGMmP6vDdpFPvI2YtbcyQEEqWitnDJHAfM9UpL5Ig65wL
bcAp8C8FQnUCT5UkTa7/CdwdA/5ocXGS+a8JTkb9+SF0vMttLNNFOcWHYwIuQLUU
XawAzW7k2yjPpslq93/p
=voW2
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
