From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Wed, 9 Mar 2016 15:33:00 +0100
Message-ID: <20160309143300.GA25784@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
 <20160308204510.GA31069@earth>
 <56DFCC64.7010405@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56DFCC64.7010405@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 09, 2016 at 09:10:28AM +0200, Tomi Valkeinen wrote:
> Hmm there's only so called DMA rotation, which shouldn't work. It's only
> meant for really small displays, when the framebuffer is in SRAM. So I'm
> a bit baffled as to what rotation you are using and why is it working =3D=
).
>
> There is also VRFB rotation on omap3, but that's not supported by omapdrm.

yeah, I was also wondering why it's working. I just did "xrandr -o
left" and my display was rotated unexpectedly :) I have not yet
checked what happens in that case.

> > But yeah, we probably want to change the default
> > rotation. Especially since touchscreen should have
> > the same default rotation as the screen. (TS is
> > horizontal, correct orientation for keyboard usage)
>=20
> I don't know much about touchscreens, but I'm guessing that it's easier
> to rotate the coordinates from touch than achieve good panel rotation on
> N950.

Yes, rotating the TS coordinates is simpler than panel rotation,
since much less information must be rotated. I just mentioned
TS, since the _default_ orientation should be the same for both.
In the end both must be rotated at the same time (and thus both
must support rotation).

-- Sebastian

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW4DQYAAoJENju1/PIO/qa75wQAKIL51Ww79sFd3p7xGX/bbRU
HQ/lV6mQeHlfATEqIsQug28VZp1l/ew9OvAPJ2Gm8Ad94+3uZB9wIIE7AW8pxq2C
XwNDEm0fqdyPfJiqP121hdnpAgZdYM/lUerCwL/6MDW0rJNXC7v0GUjAlapx/TuV
duBAOD8P4MHGm9Pv8znDj+QwtTnKf9B+NzZe+bvlgtff9poHAjrxeKiJfCOOdCOu
RESBKS+YO/AiJ7wAlzPbgvF9malSwz8QsgFkAa+rsLTgwgd8KhdAf6zh2XQ0XG3b
L60yfhLRPEs67YnumaAl7ORaxejW/k/IcSOT7OPaua5N5OSQeUrmYwKP7nLDWzA4
ln1A3g1kXYPG8AyWNOu31kqtazdRSIvhOfWkJ1aLVpKzW9zDzi4jBVm46OJh4JgS
PfSQ6a+D7JVBY5sWtIh9UuPKZ3jhe5kdEiykuAGam/Fdt2eIZlN8iwJq2bYL2ES6
XXTSv6pZ/1Scbz5XWwDW/mb5rFAUgieWKMvfHgnwTGXZP95CAPJTuaGgYqZZr4UN
uW5wpiQezgsV2KN2uW6kjaTSssklKd+bVohHVKanceg49Gt7x8mnL9m6HVFLy9Te
nzJrqSVxgYsFckWahxOm38DY3qM0gIYBSqJR+n0e91CmmGonOUu27nwJ9YG+P/KW
DcdXxC/vui1heA5pr9yx
=STQ6
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
