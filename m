From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] cbus: Fix initialization of cached IRQ masks
Date: Fri, 18 Nov 2011 11:15:26 +0200
Message-ID: <20111118091524.GC9759@legolas.emea.dhcp.ti.com>
References: <20111117233847.64fad21a@milhouse>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42663 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365Ab1KRJP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 04:15:29 -0500
Received: by mail-fx0-f49.google.com with SMTP id r25so4779856faa.8
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2011 01:15:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111117233847.64fad21a@milhouse>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2011 at 11:38:47PM +0100, Michael B=FCsch wrote:
> This fixes the initialization of retu/tahvo cached IRQ masks.
>=20
> Signed-off-by: Michael Buesch <m@bues.ch>
>=20
> ---
>=20
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
> +	retu->mask =3D 0xFFFF;

nitpicking but please use lowercase as it was before :-)

--=20
balbi

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxiIsAAoJEIaOsuA1yqRETGoP/jXROA2knS4yEnazdp0dMpJG
oS9VFZlEWG2gV42/SsbAO98W3qoquJmfG1Usf7XErzotuTbIa9NQzFgEqUEB48zg
CjNE5x4zSaJntiZ9A1r914qv/Rg8xuet2wvHlTjg/UiVl64fGLrc4J1t9ERKA+ol
iPggMI/fACf1pEl8bUL6ImAhQnrtWRXnC9mi6c56KDr9Ba6e+JrQ40W4IV0Tyf0P
BysTVyiXVbQTEzN2yF7RVMvFFshZFqEfcvoM9A3oXTl5O9jOcFx4RsGu6fHvtkB+
UCmwmwu0JP1F0elcGSNUAPafVkJE+NZZtP46/4FFyUFdmY+jYrhVwAwDlIFY1ZfL
B2eLH2VmT9pS8Ru4KLQXd0v8QzW+JC5qXw0K3J9CRHzAHe/E2dE9yl8cZ/1Am/IQ
D7iS6MKWZi1STqKdfEAo9izaee5oS/hqHcT3zUIsIZFH/JpVUnC5vt3fnGFYNwvH
uNLiIreZO3q2QEbH2hozjj8foLuI+MyW3oFz7FazOC2JkupZmsGHpNoNPc/VrHiZ
l1YvMIbfQ2asIzYBDO6LNcQs7q2+B219NQXPeLfXYJjta8iMwC55SWyg1tfX4E75
fakr8n5oXEk6soYmyVOUcRTFaE6yNanFP+AhO/Etb1toxUpN73dr/lTt/gJhoYf/
/qlJjJVv5LU0iuaA+UIV
=i/WN
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
