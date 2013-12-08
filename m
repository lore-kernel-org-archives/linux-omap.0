From: Sebastian Reichel <sre@debian.org>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sun, 8 Dec 2013 18:10:07 +0100
Message-ID: <20131208171006.GA7178@earth.universe>
References: <20131206213613.GA19648@earth.universe>
 <20131206222725.GM26766@atomide.com>
 <20131208141342.GN30823@blackmetal.musicnaut.iki.fi>
 <20131208164028.GA5830@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:51890 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab3LHRKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Dec 2013 12:10:23 -0500
Content-Disposition: inline
In-Reply-To: <20131208164028.GA5830@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2013 at 08:40:29AM -0800, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [131208 06:15]:
> > Hi,
> >=20
> > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You can see the
> > > > relevant kernel output below. Disabling the AES module in the
> > > > omap3-n900.dts with status =3D "disabled" fixed the boot for me.
> > >=20
> > > OK thanks for letting me know. How about the following patch to
> > > fix it?
> > >=20
> > > Aaro, does this work for you on n9(50)? I'd assume n9(50) needs a
> > > similar patch too.
> >=20
> > Yes, also N9/N950 crashes and your patch fixes that.
>=20
> OK thanks, there's the updated version of this patch if you guys
> care to ack, I'd like to commit it today.

Where is the updated version? I couldn't find it in this thread.

-- Sebastian

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSpKftAAoJENju1/PIO/qakX0P/A67ZwUE0IYhAZu29aWGnevN
zQ+Jy8GW1nFWGHkd1Zd+GxTaBNB5DC9n0tWfYZyHV7Zas+hBJXONsnXVjHc/9zvY
m+Kbr2fkwDa7765dQXtc25HKce0HQkQchmBttJuI+hVtCz59RHNESdDMfrjyFT9+
QkplVUqcHiP4wNi4NY8T+JmK956qvY8G8uaDKLyBg3XFaX+83XInW66EdKk2Jo+f
P4XzgrDxA2aYk9kUv4/O8ex5I0OQWEgblbl/SaFlVXqiINDZLruX7OTIe5qGO4Zk
XDvRG2wPgLpCB5OsSD6xburgQ6cHxUfNfD+8Rt2NvHm/vir3xj461ASCoVprSez9
wCGCxeowh20VTIYaZj1qpcB9POjbPls/ymEwhiDPLxcMx8aJ73H7SCEhp86A3/aa
Lqf60vDfp0NfhUB/3rv44O3UAYwfb4VlUimoHdEhwQdQKLyK4681NKgtLysb9mFP
EmHU34sLX1d9HczJkdsp4YYuRdebs7kaACwdwtqU/2ysNUxNJ+Bnl7HWJfhEjGZQ
PvPUsQcriVP93rc09pm2lfMFUdUw9H/Ec9pMSQg3NBEpV5U+2DB2R2ORpmAfwt8u
ogwzbqa9adXYetyDNUhz56/GLSpo4zxW68VsAp5ysOWgZh4Fa+hHCDYHB9EKsTp3
B1nZKy587GxNfZDOuRv1
=tGsm
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
