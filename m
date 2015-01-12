From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] can: c_can: use regmap_update_bits() to modify RAMINIT
 register
Date: Mon, 12 Jan 2015 12:43:58 +0000
Message-ID: <20150112124358.GG4160@sirena.org.uk>
References: <1420641162-8634-1-git-send-email-rogerq@ti.com>
 <54AFDCB0.5060908@ti.com>
 <54B39A8E.4090006@ti.com>
 <54B39BAD.4070604@ti.com>
 <20150112120541.GD4160@sirena.org.uk>
 <54B3C001.501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52783 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbALMp2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 07:45:28 -0500
Content-Disposition: inline
In-Reply-To: <54B3C001.501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mkl@pengutronix.de, linux-can@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de, linux-omap@vger.kernel.org


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2015 at 02:37:21PM +0200, Roger Quadros wrote:
> On 12/01/15 14:05, Mark Brown wrote:

> > The usual thing to do here is an explicit write clearing the latch,
> > either immediately after setting it or immediately before setting it.
> > If the register is marked as volatile and the hardware doesn't read back
> > the latched state that also does the trick.

> How does this work if driver has access to only 1 bit that can only be
> written with 1 to clear a condition? Writing a 0 is no-op.

The expectation is that for hardware like that writes of zero will be
ignored so you can just do one (generally this is the point of such
things - you write to explicitly clear the bits you want to clear so by
extension other bits are ignored.

> It can read back 0 or 1 depending on the condition.

If the hardware readback has nothing to do with what's read back then
by definition this isn't something you should be updating with
update_bits() - it's doing a read/modify/write cycle so if the read part
doesn't correspond to the write part things will go wrong.

> I didn't understand the volatile trick :P.

If the hardware always reads back zero then if the register isn't cached
(which it sounds like this one shouldn't be) the comparison done by
update_bits() will always show that the latch bit needs writing.

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs8GNAAoJECTWi3JdVIfQZhgH/2c2uodAbmXAkMWx6pm2WGMM
uVwkqjtUHT/0KLd7xjnqJEP+05bYkvz08U5QO6dlpMLEFrNgWI83vDtw2EUzqjmv
21rAPr3GHSM5NXxHXg5DPJl0tacNi5U7g/WP8OKz62hf5R5UpUq2+R9A5iNoXRuM
tm49cUXKDG9+FywfhidpcTkSN15zsc7CgvAFjbYXUPqxGFXuGDRqTWhAbXg+TK9W
cIEzeWqS2jXd8SpF5bIt0T4/Gkpx/6yVMSWk5Av7U9ju+EEP4oKzAaXZ/i4I1uTq
Fxk6/5SYCjUjoyZ3Q9JIm7RBcdMd/L3Nv20TPi6a/HwLmF+EMF6vayYmu0BXrBE=
=c3xe
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
