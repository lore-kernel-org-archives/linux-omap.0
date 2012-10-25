From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS
 interface; use platform_data fn ptr
Date: Thu, 25 Oct 2012 23:59:26 +0300
Message-ID: <20121025205926.GA19439@arwen.pp.htv.fi>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013233.21844.1279.stgit@dusk.lan>
 <50899DB9.8050308@ti.com>
 <alpine.DEB.2.00.1210252015490.21193@utopia.booyaka.com>
 <alpine.DEB.2.00.1210252028330.21193@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992597Ab2JYVFP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 17:05:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210252028330.21193@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 08:29:26PM +0000, Paul Walmsley wrote:
> On Thu, 25 Oct 2012, Paul Walmsley wrote:
>=20
> > On Thu, 25 Oct 2012, Jon Hunter wrote:
> >=20
> > > In the case of booting with device-tree, pdata could be null and so
> > > should we check for this too? In other words ...
> > >=20
> > > +		if (!pdata || !pdata->read_reset_sources)
> > > +			return put_user(0, (int __user *)arg);
> >=20
> > Thanks, good catch, will integrate that fix.
>=20
> Here's the updated patch.
>=20
> - Paul
>=20
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 7 Oct 2012 20:13:26 -0600
> Subject: [PATCH] watchdog: OMAP: use standard GETBOOTSTATUS interface; use
>  platform_data fn ptr
>=20
> Previously the OMAP watchdog driver used a non-standard way to report
> the chip reset source via the GETBOOTSTATUS ioctl.  This patch
> converts the driver to use the standard WDIOF_* flags for this
> purpose.
>=20
> This patch may break existing userspace code that uses the existing
> non-standard data format returned by the OMAP watchdog driver's
> GETBOOTSTATUS ioctl.  To fetch detailed reset source information,
> userspace code will need to retrieve it directly from the CGRM or PRM
> drivers when those are completed.
>=20
> Previously, to fetch the reset source, the driver either read a
> register outside the watchdog IP block (OMAP1), or called a function
> exported directly from arch/arm/mach-omap2.  Both approaches are
> broken.  This patch also converts the driver to use a platform_data
> function pointer.  This approach is temporary, and is due to the lack
> of drivers for the OMAP16xx+ Clock Generation and Reset Management IP
> block and the OMAP2+ Power and Reset Management IP block.  Once
> drivers are available for those IP blocks, the watchdog driver can be
> converted to call exported drivers from those functions directly.

should be "exported functions from those drivers directly."

--=20
balbi

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiaguAAoJEIaOsuA1yqRENZAQAK/Zl5ZoDiJw2ah+ApstlZpL
Ad5E0QJx+2ftUnQQ+6ywhm4/EybJGXMI0W8Ua0bPaN8RT7lkJ2hiUeqI174pucdm
5IxKQImP0IaM//1VOfLOAvNUJLdiJdMu+NZVJSfzaqA+d5ZJ161rkcmsj1IEld3/
yKlG088A/HTInPtbrOe7/H5LHUK9Ja3fPyyrczncDotCGARQl0dqsPEO+FTXdGDr
s2h1rhWJK8TYpeksBBBnXV8MHKtFsbtFycPP5xm1Mw/gxUyuPsxCiaswlMK6gNCJ
scmR2u3xbIob3tpWSjYKtUTg29zoerXSKjhYsMCEhjtsdUH3nBoPyg7u81o7ElaI
m2lW3Ytvyh95nnVohdxFAplFppUSMVgPzGdd2zOGbq9TKwGr2PDAKbnzJhCilFCp
PN9GdZKrrKuzxTJz1EfHNz7cAgnmY3Nwul7x4lh+8iu6DdSfBZmLvQH+DKgt2rmJ
I9qJ0csVfGHItAnkzWHSccS0mtWn0TjTT3i3XmRzD78zk3PKUEkNAOImWstAUyIY
xO0KcTgV3mcoABDyso07WQZLqMOZdeb4hgl9rn6ksfd5XBL6ujWnQJI0yQ7SkJCI
e7cs+bF5fWcF+DKN8P2BZ7XP0crclc99KkobchjLt2caD5jOcXgUEWQsesvPpHVm
PWfctcqGcLbDonvN4F0b
=Lv4x
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
