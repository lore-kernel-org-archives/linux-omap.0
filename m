From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sun, 18 Jan 2015 23:29:45 +0100
Message-ID: <20150118222944.GA1698@earth.universe>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel>
 <20150113204219.GJ2419@atomide.com>
 <201501132150.56938@pali>
 <20150118210217.GB31807@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53424 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbbARW3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Jan 2015 17:29:51 -0500
Content-Disposition: inline
In-Reply-To: <20150118210217.GB31807@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 10:02:17PM +0100, Pavel Machek wrote:
> > He reported also some (still not fixed) regressions on n900.
>=20
> adp1653 flash driver does not have device tree bindings, yet. Patches
> were submitted, but I guess I'll need to push them some more.

Yes, but that's not a regression, since mainline kernel does not
load adp1653 when booted in legacy mode.

-- Sebastian

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUvDPVAAoJENju1/PIO/qaryUP/0A7i1EY0CL6EYR6KCnBxm3y
eC17z75KbX+mpFwaJj7jABd0E37WpG7dqivnxoYFQVL1zpgr+oUzMjD1pAPc3tr7
bTNnXR2lH0MKeLBBRfOCjOgKtf6Tyz7DI9/BVBAvOflBlGoi9/uW+HzupGVQ/Bf2
VbVSMFf0pU+ek8EH1166LzpnN4X+WZCGj08ZsbsL5JHFeluzbxBVM/TakeULnrSC
3d808dlkZ2Ki3tDgAdYUy//EEFlnFfZ4VoUef1B3NIuOMFas7GuXFSgShrAxMM0w
2cNQVATxf6OOl5bCqOPE5xu+f4T1MG1KzHFwOQIS6aMaFW9NXrvo3SCTsCnadcS7
fdj84DQGgbh3m7UuPv+fCX+GviQI75z2GB+J+H/tuu/AJ7il4rqqE/94vMcIICdz
J4hkqkdMIUCBBO1dmHJ4T0a+01wd+zLyVxGJi2mUH+00HIu/B1o2qblLDMgaCABZ
bv02b50GEZFT+925seQWocbEpnZ34B99Rt7qgrXfWSqghh1oYUKa7WiWL1sxOIYa
q3r0cews9RTeF5FsZm8aR2Si1DHCkrMcGo1/p6gyCfBGwGvj4jNIN4VMGAN8jL4e
Osmbua/4wXkl9HGbWSevdnrVUS1kKWWkbCfirQb6MHgKe0pA8m+vroQ1sqw3MfLR
g7KU0G++93zldU3dnJwd
=e4eA
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
