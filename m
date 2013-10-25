From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] arm: omap2plus_defconfig: enable more drivers
Date: Fri, 25 Oct 2013 10:51:23 -0500
Message-ID: <20131025155123.GF4400@gimli>
References: <1382710831-5758-1-git-send-email-balbi@ti.com>
 <20131025144426.GA15154@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37174 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab3JYPuz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:50:55 -0400
Content-Disposition: inline
In-Reply-To: <20131025144426.GA15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 25, 2013 at 07:44:26AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [131025 07:20]:
> > enable a few more drivers as modules on omap2plus_defconfig,
> > this helps us getting more platforms working out of the box
> > by just building omap2plus_defconfig.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >=20
> > Hi Tony,
> >=20
> > would you consider enabling these drivers ? I didn't, yet,
> > make sure that these drivers won't cause PM regressions. Wanted
> > to make sure you'd be ok enabling so many of them.
>=20
> Sure, we should have all common drivers enabled, preferrably as
> loadable modules where possible.
>=20
> Probably at least MUSB gadgets need to be loadable modulees as at
> least I have my test setup in a rack with USB cables connected
> all the time. That way the PM tests can be done without the USB
> modules loaded.
>=20
> Or maybe we can just PM runtime suspend the USB drivers for PM
> tests?

I'd rather just unload the drivers if they cause issues. The thing is
that with a patch like $subject, we get more working out-of-the-box and
since most everything is really already in mainline (at least after
v3.13 merge window) except for DTS (which should go up on v3.14, all the
pending stuff), then we should be in really good shape after enabling
all the necessary modules.

--=20
balbi

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSapN6AAoJEIaOsuA1yqREZgQP/jWdDqKizUID/ptEoALnsaoT
XB0icpnixJ9a+u7gWpFklJkidsUW8x/m4R3E0XikLZMntGKCepBpxFdI92eaIHpA
uzbUO+1iPGYuNWGq3tVb8nfgU6MU/4DMd53a4E/8N2jZMYWhSgMvoKiZfIV6OBCH
NLhuRIP3lMMg8jhZ0PTgVojgCHBb/c5FNhjDAX9f2+mGH/pFXSsF6Jw3+YJTGM+H
JvI3TTd9mFdaeCWwpDfFr71EPQOxCdbKqmeCMSzPAQZm5E8Re2oKtC2NbAF/sgQu
CXBYaEXdJpP2K+430bB04jeJVg1G9yhfFwrAO8MzEwIxRw1pAz4j95YTNO1BVVqX
mkygE2H8U7SG4CyXVxujYvpAYaUPmiEwPPT2I2CfTR1iZt3meq3EfkxTjMEj1RfU
nzJwYF2dcoMMXOEvw95nsNO60XXjOvdiPfKo1qdOSDlVvxfGl9qkhXsvOdhrtcJf
U2bb6Hh6yFfClDLxVY5aUmHpEIDgGXjSonDGm2f99087q2CvKBBSGbTyafxN6oy0
mT1tJS5qY0mbvDV+HLU2oT/opgNxIYweGuSW+4JkKNq7rcDzfo/ipK/9lb46KU8w
i3e+XyWDbBFYhliwzCREwutBY1gUUiI+p7nDha5vDKRfkDaBA8u59GGcyFaqApo7
dhpVYvMqMPj2Ntt+z3uh
=yQEf
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
