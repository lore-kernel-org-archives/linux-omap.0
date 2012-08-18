From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] I2C: OMAP: xfer: fix runtime PM get/put balance on error
Date: Sat, 18 Aug 2012 10:13:00 +0200
Message-ID: <20120818081300.GE24639@pengutronix.de>
References: <1340761532-27231-1-git-send-email-khilman@ti.com>
 <87wr1b35qb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53745 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab2HRINF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Aug 2012 04:13:05 -0400
Content-Disposition: inline
In-Reply-To: <87wr1b35qb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2012 at 05:28:44PM -0700, Kevin Hilman wrote:
> Hi Wolfram,
>=20
> Kevin Hilman <khilman@ti.com> writes:
>=20
> > In omap_i2c_xfer(), ensure pm_runtime_put() is called, even on
> > failure.
> >
> > Without this, after a failed xfer, the runtime PM usecount will have
> > been incremented, but not decremented causing the usecount to never
> > reach zero after a failure.  This keeps the device always runtime PM
> > enabled which keeps the enclosing power domain active, and prevents
> > full-chip retention/off from happening during idle.
> >
> > Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> > This patch applies to current i2c-embedded/for-next branch
>=20
> This one is needed for v3.6.  Can you queue this up as a fix for
> v3.6-rc?

Done, applied to -current, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvTowACgkQD27XaX1/VRvHagCdFt7xlJ91Z97p3QZp8wmDm4zD
/T4AoLGEWoPGu4bl86uqWKkFEW2L8uTf
=IhI+
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
