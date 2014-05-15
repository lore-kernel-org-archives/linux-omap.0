From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Thu, 15 May 2014 11:57:38 +0300
Message-ID: <53748182.1080705@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-5-git-send-email-tony@atomide.com> <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com> <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com> <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com> <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1jeKGunVfgW41ftxLHlplOnak6Pjishup"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37054 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaEOI6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2014 04:58:05 -0400
In-Reply-To: <20140513213205.GB18001@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--1jeKGunVfgW41ftxLHlplOnak6Pjishup
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/05/14 00:32, Tony Lindgren wrote:

> +&lcd0 {
> +	enable-gpios =3D <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */=

> +	reset-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */=

> +	/*
> +	 * The LCD is sideways, so we want the VGA mode instead of
> +	 * QVGA mode. Probably also want to have omapfb.rotate=3D3
> +	 * in the kernel cmdline until there's a binding for that.
> +	 */
> +	mode-gpios =3D <&gpio5 26 GPIO_ACTIVE_LOW		/* gpio154, lcd MO */
> +		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> +		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */

I don't think that is correct. The panel bindings should define what the
first mode-gpio means. Looking at the panel spec, I think the definition
should be "enable QVGA mode". And in the board's dts above, the
GPIO_ACTIVE_x should tell which is one is correct polarity for QVGA
mode. Which is GPIO_ACTIVE_HIGH here.

If we want to tell the panel driver to use QVGA mode, we should do that
explicitly with a flag, not by hacking the GPIO polarities. It's the
panel driver's job to set the GPIO.

So in the previous mail I suggested the 'vga-mode' flag, but I think we
need actually two flags for each GPIO: one that's used to tell the
driver which mode we want, which is used if the panel driver has control
for the GPIO, and the other that tells which is the hardwired setting.

Then again, the two cases are exclusive, so maybe a single flag per mode
pin is ok. So, for the MO pin, we could have 'qvga-mode' flag in the
=2Edts, which means:

"If there is MO gpio, set MO high. If there's no MO gpio, presume MO pin
is pulled up"

Of course, one could argue that, in case MO is controlled with GPIO, the
'qvga-mode' flag is about SW level configuration, not hardware...

 Tomi



--1jeKGunVfgW41ftxLHlplOnak6Pjishup
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdIGCAAoJEPo9qoy8lh71DYMP/1xJtYbWVC6Ek4cZco768MmR
FNcQSNgo46vAG5YFf65xr2fzvEWY7+Ucm0zRZRoThPOoNvi6apTMnsl3B+53x++F
xyM/QXU6L64f5zRqlDxZRPd2Tv+7ob0CVWTm1LDbF3oVJH9S/E6g6cDyTuXGbVAW
LJAJJb9eI5ebIXDe/z4YMuxUXldDJmvtC2a8FKqEe+d8AXop3+ZWTs0vm/vhgtgn
t/g+XqJS1/dppTExDout++4w3hLnUuA6XKtNF237qiEp4X6BpCJ7HR8Yql4mkipm
aVt9e1LzSPIezpITb88i7SVXlthDrjuLgwSnVpdWiNpInjuxNbbVfHU5qgC8N53P
HKXGOpt5RP4bLO+R9wEqgdNsE7vyIc9W2AeKSUQiwzRWt7Y0gJRJFBaCthVk92NC
8xx+jjDu8YV2iZiMEs4uQvHKQsulgro/EUsEQuOcVn7p/mR5YIrFTubjnK9jV2Rn
SF9LZ6WGRGc+49Fkhata+XPuGrjGn6bBxa/v0i918bQgPSn9t2eQWaatq8KdhybS
LqBR4VVHcpSwN40dnqPC4sOEOBSWL5SGhk6o5yAr+IVke1o78IF4aPv2ZDejE9BA
gxTK588Y5gVKeIO6y5ZEQnsxVWOsuqlgLqdZK5v0pVUXbDWtJyLQKj9w0poWVVF+
yoUkYnIxDXcKwvyEymfi
=m0NP
-----END PGP SIGNATURE-----

--1jeKGunVfgW41ftxLHlplOnak6Pjishup--
