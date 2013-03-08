From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 09/10] usb: ehci: tegra: check against CONFIG_USB_PHY
Date: Fri, 8 Mar 2013 09:10:59 +0200
Message-ID: <20130308071059.GC21589@arwen.pp.htv.fi>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
 <1362648969-13737-10-git-send-email-balbi@ti.com>
 <5138FE9D.7040702@wwwdotorg.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42795 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab3CHHLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 02:11:16 -0500
Content-Disposition: inline
In-Reply-To: <5138FE9D.7040702@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Felipe Balbi <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org

--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 01:54:53PM -0700, Stephen Warren wrote:
> On 03/07/2013 02:36 AM, Felipe Balbi wrote:
> > CONFIG_USB_OTG_UTILS will be removed very
> > soon, so we should check CONFIG_USB_PHY
> > instead.
>=20
> The Tegra EHCI driver isn't very useful without the Tegra PHY driver.
> Perhaps its Kconfig should simply "select USB_PHY", and the ifdefs be

no selects anymore.

> removed rather than modified?

One can still compile-test the driver without a PHY. Ideally, though, we
would teach EHCI-core about PHYs.

--=20
balbi

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROY8DAAoJEIaOsuA1yqREeBcP/jmg/+xJ8yDJqp6ITZzyKkUn
PnLTz61ArsYgmzQVaV2kY9tJS7muiGT2ZeM+fbvT6JRXXSbR5XwbdjZtDgK1i28r
gmEM38NyB4s7PjIRifAocMHj7/cCC4eNqgoyaulBInvRsPczWR9ZNSELMfqHu8sc
Hta00KDesRpyZqKNZY//dwPEPjdfuWEwrbUW+gqCokKCruv8/1YwRRvPdhvwS+hv
XSLT2sCsDc3kVa0aCqCpHetyqlS/ELsBTllVFU1T/voMt0ZvM5aXZ1Fj5fIfN0BE
09xbRWkwC2GiSZ73YtASWc7qgm78sDP9ihmqriVNaaAxoqVDx+TQIvNn5G8+WHkO
u9Ml/Z9wiNn7IYZ5es2sK0j2VKXJ/AsU+E9eV758GP6heW6hylt91Abt9UDwSpkN
Gd20EE21oDU4PDd4f2sFNV2eFuVeFisEKvJeFPl1p7tHli3jazYhcdf/JkmlRSkp
XVC2fiDjujmmsIn0YMg6XgnsqHbS1i6Y+RJuq1MgcdYx3NQL6S35EZrpTQ25m54T
r1I568B5tVgvDqTag0tJRm48vCoqbP7pf2PAwG9wTEHZ60ycQqmYF0EgXOZNxNhf
cuGD6b2oCZQ13iBY3ttwQEH8ECQ5CS+E4MT6LyZa/Pil1GikzqLDsdPV3ukQWH5c
oNHOkUZwY+c+OgfOcj2K
=F5U1
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
