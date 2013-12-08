From: Sebastian Reichel <sre@ring0.de>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sun, 8 Dec 2013 19:09:47 +0100
Message-ID: <20131208180946.GA18132@earth.universe>
References: <20131206213613.GA19648@earth.universe>
 <20131206222725.GM26766@atomide.com>
 <20131208141342.GN30823@blackmetal.musicnaut.iki.fi>
 <20131208164028.GA5830@atomide.com>
 <20131208171006.GA7178@earth.universe>
 <20131208174350.GC5830@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:52074 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997Ab3LHSKA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Dec 2013 13:10:00 -0500
Content-Disposition: inline
In-Reply-To: <20131208174350.GC5830@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2013 at 09:43:51AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [131208 09:11]:
> > On Sun, Dec 08, 2013 at 08:40:29AM -0800, Tony Lindgren wrote:
> > > * Aaro Koskinen <aaro.koskinen@iki.fi> [131208 06:15]:
> > > > Hi,
> > > >=20
> > > > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren wrote:
> > > > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You can see the
> > > > > > relevant kernel output below. Disabling the AES module in the
> > > > > > omap3-n900.dts with status =3D "disabled" fixed the boot for me.
> > > > >=20
> > > > > OK thanks for letting me know. How about the following patch to
> > > > > fix it?
> > > > >=20
> > > > > Aaro, does this work for you on n9(50)? I'd assume n9(50) needs a
> > > > > similar patch too.
> > > >=20
> > > > Yes, also N9/N950 crashes and your patch fixes that.
> > >=20
> > > OK thanks, there's the updated version of this patch if you guys
> > > care to ack, I'd like to commit it today.
> >=20
> > Where is the updated version? I couldn't find it in this thread.
>=20
> It's Message-ID: <20131207003824.GO26766@atomide.com> in this thread,
> the version that disables aes, sham and timer12 like we currently do
> in the hwmod code for legacy booting:
>=20
> http://www.spinics.net/lists/linux-omap/msg101045.html

boots on my N900:

Acked-By: Sebastian Reichel <sre@debian.org>

-- Sebastian

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSpLXqAAoJENju1/PIO/qaoysQAKgfaLg2k1q7XgFnd0Lrjq8b
kT0FlEmIt3+unIhiCfKP3S9tRHuahNcdsrnOjkiKZR9SO6tOlMUbjrQJ9zXwWfve
kGK1aT5PpZO6RykW1HGtkczgNLQDtgXlbskhkYLzMO4ljxQOZii0rhkpGhW5z8w+
aYFylwNI6eoOBpNOHAYtA35HqJZXnAbWhkcsF+1MJ9K1WExGDeXK7CZaM09LWzgt
w+zjWY6bRzgqYemBd4bPKa4o5KtwkE3x5C9J6xU9lfdSkybCGleiaO/KEnVMPYQV
ero/TTbG5XhHz9e0qEMFkIFBANtpsGQhvY2gNMJJlWGPuTcfPBcNA4eCVMzolcvz
QFiIDNgADpLp5JolnYBWo6cPm6Xiz0mr0uDAQHaE5GUzF+J/7stp0kqQQgSV5rFo
NuHrU678Ccs0UP7rElNgRnSAuiX7XfxIpTJVrvUJyzk7SHRmPorlf7FrI8CxFQry
2pR8U3Ex5PrH011lOvfAjo+dtHneaOaGHwhB3BuMB9uVCq7LRKwksxhBNIYtUQqQ
t7UZBSBWDK4Ah5jVhh/9sJLRh0r9hxLllOuodEeSsKsI4xsQfS/IItfUZuGDEZRl
T3iF8iToToc/fF5vpeAkO24RgE9mmXgPEIowHth9yGsnoJ6ayG1olWEF6C6sR7nz
WKErSqaBVYJe/fVfrDDs
=dNCS
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
