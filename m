From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: arm: fiq: fix build breakage with CONFIG_FIQ
Date: Wed, 17 Sep 2014 20:51:28 -0500
Message-ID: <20140918015127.GA5745@saruman.home>
References: <1410984101-16762-1-git-send-email-balbi@ti.com>
 <541A193F.2060503@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43209 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757004AbaIRBwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 21:52:32 -0400
Content-Disposition: inline
In-Reply-To: <541A193F.2060503@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Nicolas Pitre <nico@linaro.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 17, 2014 at 04:29:03PM -0700, Daniel Thompson wrote:
> On 17/09/14 13:01, Felipe Balbi wrote:
> > commit e1add97 (ARM: 8150/2: fiq: Replace default FIQ handler)
> > has a typo which causes build breakage whenever CONFIG_FIQ is
> > set.
> >=20
> > The bug is very clear as can be noted that a new struct pt_regs
> > def_fiq_regs was defined but code uses dfl_fiq_regs.
>=20
> Quite so. My fault.
>=20
> This error was picked up by Olof's autobuilder and I have offered
> a fix as 8150/3 (posted to mailing list in this thread
> http://thread.gmane.org/gmane.linux.kernel/1789554 ).

aaa, alright. I missed that one :-)

> Your fix and mine are slightly different (I standardised on
> dfl_fiq_regs) but both approaches should be functionally identical.

sure thing, no issues. I reckon it should be in next within the next
couple days ?

cheers

--=20
balbi

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUGjqfAAoJEIaOsuA1yqREJuAP/3eZyQLyOCz6tD4PLf0XTk4D
0xulSQjum0O+bAZaA+dJieYPGHM1dZIIixtaJAhyhUkasEYAcARSAepHTVxo2hSu
RQ4EDQ21vwrJljBKeU9AsKyrRFQ0y0dcOk419L9ig0Zo+n5aDj83TV4AgwKh/dO8
GxtFlKMbtZsFzwZmyM3UpkjXcGLR6PDIPHrZWbQ8RqmyAGR53ArkHCvz4gs09VsM
vvSQcrCY910hYxkjuNlu+DLELpzX62VceXfsz6Vpbde51r2QlQNi5BpeSXYS/JPM
MazgY+kvKEHiOyvPrpoZqMy+jxQO7GZvN4fTLA19HvmLJw5JTtk/vN9Ul0q0HHFY
aV2C6R0utQOCweu/U+lfS0HySX7LEO1BJE5Gp42tZhhXHcvj85Uq9zm4J0voMArS
JSQSI+lB/3EkILKvW8UWcSLu/7GPZEXukthpA1dAYn/UWjOWOHs9c2O6ayceodrd
Ba6fgbChjMOBBtx+t6VmPagoYYMRIpGNPqbPtJJLwtiEtLrdEDdqF0tc2NlcUNWl
xCBnRL13doMFO3DWBM/TJ3meNOixmoW5WndIzI0aGdXUyfQs/odbqAi/lhrHMXoT
eW1fLgexrQyxOEsxX+2BAh7rObfLWJxmMUXX4GEY1jtbeosECMhCirtD5/vBhUHD
BvItml03dIFBzXfazQ92
=9/Gf
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
