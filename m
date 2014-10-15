From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
Date: Wed, 15 Oct 2014 10:54:11 -0500
Message-ID: <20141015155411.GA15770@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <543E64EE.4070104@ti.com>
 <20141015144140.GD10888@saruman>
 <543E962C.2050505@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53839 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbaJOPyo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 11:54:44 -0400
Content-Disposition: inline
In-Reply-To: <543E962C.2050505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 15, 2014 at 06:43:40PM +0300, Tomi Valkeinen wrote:
> >> Somehow omapfb device is still unbound from the driver, as I can then
> >> bind it again, causing probe to be called. Which breaks everything.
> >>
> >> I would've thought that unbinding is not possible if remove is missing,
> >> but that doesn't seem to be the case. I guess it just means that remove
> >> is not called when the driver & device are unbound.
> >=20
> > if no remove it provided on platform_driver structure, platform bus
> > assumes you have nothing to do on your ->remove(), so you end up leaking
> > all resources you allocated on ->probe() (unless you *really* don't need
> > to do anything on ->remove).
>=20
> Yep. That's quite odd, still. grep shows quite many uses of __exit_p(),
> and all for remove callback. So, if you have something to release in
> remove(), you should set it always, for both module and built-in. And if
> you don't have anything to release, you would always just set .release
> to NULL.
>=20
> I mean, what's the use case for __exit_p()? With a quick glance, at
> least some of the other users also use __exit_p() the same way omapdss
> does (i.e. in the wrong way).

__exit_p() meant something else a few years back, perhaps those were
left over from some tree-wide cleanups.

> >> We have 18 __exit_p()s in omapdss and related drivers. I guess they are
> >> all broken the same way.
> >=20
> > yup, I should've grepped.
> >=20
> >> Note that omapfb unbind & bind does not work even with this patch, but
> >> results in a crash as some old state is left into omapdss. The same
> >> happens also with unloading and loading omapfb module (but keeping
> >> omapdss module loaded).
> >=20
> > It worked fine for me. I unbound and bound omapfb multiple times.
>=20
> Hmm, ok. Odd, the bug was quite clear and I think it should happen every
> time. Well, I was using omap4. If you used AM4xx, that's basically omap3
> DSS. Maybe there's a diff there.

could very well be :-)

> >> So there seems to be more issues around this.
> >=20
> > quite a few more, I'd say
>=20
> Yep, I'll have a look at this.

alright

--=20
balbi

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPpijAAoJEIaOsuA1yqREu7wP/04VFwcrVrWHjlegS+39L4RR
9queCT5Zv1YO2nMT1vAnojfd04lcuZ6L2Z4IhJckr1nkkh50cNzZ6WFrD1isSnXy
6V+416YL9zIHsUX1/84992K6hGOUzB4AXTD2U74h+Y3iHDrkIisAwZe4mfjoBwCf
ZNHH6zb0cpxEFdRsHTU2mInKF7yjG+M1suVhBhpGX/wyFYNDgZudMFgN1sric9Cp
TZXRwLA4UXXfzrjI5Uamk5+jXDtVstE7Eq7UoVZAItpV38YH8JQwyAaVYsPOMDCj
Dh6bbGlwjT/JIvuI8hqRxitbine75dHlAlwez+whPTYhFhVWHqBSCdru9KlBmr/T
wIJC8uHaYmLYGfkvi45wLE5TTFMVNaXpyykSk4EnwDDHyOPh20o8jiqtscGNVW0W
SL24cFZ+/CBz+ipyQmOnR7N7X+roffHx0l1E+w9a64i+//6FtOyvfe18/+bt50EQ
0K5dsWil7MF7460TEF13qvJ9mHGycbPmPX23QvHsMHOuTu6vcRCz1I3yl1MB8mWb
rs3lg6lbx4omNm0Nm76XOGP1aPq6Rzv/iOssQ6x0ZSLppvEJyl/cKdC6/5Zmr8Qq
Kgi4LfcpBw8ffHeLNZgBGlFZcjJEkCn/aCcWKja7DWFSKyyoEgx9z1s73rAL2LHt
s+NOgsEABxMGJltjjUjJ
=SYB9
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
