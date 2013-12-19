From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 18:00:29 +0100
Message-ID: <20131219170028.GA24230@earth.universe>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
 <20131218215536.GA23674@earth.universe>
 <20131219005151.GA27928@earth.universe>
 <52B2848A.80807@ti.com>
 <20131219100840.GA923@earth.universe>
 <20131219135608.GA11654@earth.universe>
 <20131219163557.GM27438@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:34152 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab3LSRAf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 12:00:35 -0500
Content-Disposition: inline
In-Reply-To: <20131219163557.GM27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 08:42:31AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [131219 05:57]:
> > On Thu, Dec 19, 2013 at 11:08:40AM +0100, Sebastian Reichel wrote:
> > > > Are you able to check if the bootloader muxes dat3 to SDI mode?
> > >=20
> > > The bootloader's source code is not available as far as i know.
> > >=20
> > > [...], but I get an external abort on non-linefetch.
> > > So I can't check it :(
> >=20
> > Ok. This is fixed by applying [0] (Thanks for the hint, Tomi!).
> > This is the mux configuration from the bootloader:
> >=20
> > [...]
> >=20
> > [0] https://patchwork.kernel.org/patch/3283781/
>=20
> Do we need to update Laurent's patch with this?

No, the patch is only needed to avoid the mentioned external abort
on non-linefetch when doing "cat /sys/kernel/debug/pinctrl/.../pins".

> Or can we use it as it is and maybe you can ack it?

Sure. I will add an Ack.

-- Sebastian

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSsyYsAAoJENju1/PIO/qakS0P/161ZheZMNywgT8nOrS2hQ13
MHiqnvj5rq09Fk7zSnPDI4Nq/0Nu9X/K0GftdYZ6b1WE7IUJKspetlqdBtGjzAkX
O1W099I3bXpK5Bf5tl6EZrhmYRXkkGAXv796dW+siT+nAIu6pRpKM1mO6+7gBc93
mLt+FUuuE5px8lCS6++ns1RKHeigSV8UqH9ly0MRyJ6NNcXikD1psRff0W8TlNfx
2IOXIl8xsaUnON+EfkwsqaKEdP9S62RCXmjTzVlP1lLV+TyU12uxOfxawDJlO+WA
fQkon1eA848Cz8loGBPO+UpLcfOtDWBEhax/K/2caTq4MIzegthyJJQNMpOR80e+
5PPz/+976e/GgzjrU9jZTb164OBi5bNAmlStv78/791edQyq18KvOlmjY6G/ptGe
pvCPJqACg93qVg8FoNUEQrQLELVJFTfDVuLVTKvicrHwj2QRmgMc72Apn2Mz1D3K
ILkhozdZLQv3JHkMdeGd8U78GryvPU5oOAfxkAn7d77BdhM2A0WUcZ9abJiNvFWt
5tqktPOlRqeSZQF2DrYPgFBSFhe2ACro7b7WkU/aOXtoy9hBDRDwTrLHnsNzwol2
IzbfOiqyVOmzfXthLi1LoAo2h6aWy/DT1moivqqHobBc7PuzgxF8OV/XTpdXek/Z
GwwF9sFEZFYWwPCTMGPH
=n52k
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
