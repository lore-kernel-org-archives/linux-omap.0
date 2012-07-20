From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
Date: Fri, 20 Jul 2012 12:38:06 +0100
Message-ID: <20120720113806.GW4495@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oGy11dVowAZA6eXT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39730 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542Ab2GTLiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 07:38:09 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--oGy11dVowAZA6eXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2012 at 11:27:36AM +0000, AnilKumar, Chimata wrote:
> On Fri, Jul 20, 2012 at 15:29:36, Mark Brown wrote:

> > Every regulator here has a rather large voltage range specified with no
> > consumers added.  Are you sure these voltage ranges make sense in your
> > design and you've not just cut'n'pasted the entire voltage range that
> > your regulator supports without reference to what your board can do?

> tps65217.dtsi is a generic file to be used by the SoCs so these constraints
> were taken from the regulator itself. SoC specific limits can be added in
> SoC specific .dts file to tighten the constraints to require limit. I have
> tested the driver with this approach.

No, this is not a sane approach.  You've no idea if any of these
settings are safe or sane for the board.  Boards should enable things
they know are safe, not remove those they know are broken.

--oGy11dVowAZA6eXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQCUMYAAoJEBus8iNuMP3dBSkP/1Xk53XeV7Tgt3OFZdoJ/Spu
dEdaWkuNrJBjWpmybsVPMBzaYI1YCku8cSVQfem9yq3kIGmXtMk4IxwJexVUDQvG
OCE/CilVMjJnMUjP3LlGElxZg2gp++d3LKufsE9SiyWEHkj0fK5GzsAM8wFK2Vpm
AzqxYGFp2yc8MAqmVn5t+gAzsl3hLikXszFTFO1AJ/abmGRGRHeEDrb29nLdAU1h
mEEnTwU380s8ycLdEfvR/aWExq3csKdxZ29OfuDkLTTHlkX8013EnwrUNAiGcvxD
/MkM+eQKxpNNWQH+OolTNh/1bHODiFOqsgKBOktfohKrqJ5vS4wiG3C902z4FHw7
OTqAysF0FQujjP15THTl9WsA/P1Oxm9+deQjuYddCiqc0ICwYWgV2yt0Is+wG6jl
6lgULRRLKycyE0sG7HGBCboocmJ0MyWuoa3to7SdIsbQVKww0uP2VVUEIQEKIQec
3GtGAtjuvL0JK4Si145ZrCBphZjhs4J/G+/VGwqoPlZwcGYrKLGXxA+F77SwQ8Df
yDL1VF0EVjBGXAvVZZp51IAhr7Hu3FptAxtRFUqh2cw9gHxcQNjy8heBW7Znithj
wYUgBASFk5ILpZZVeUaxbgFWHlyZDROp96m4UQKFIFokvEDIPxkqF5PfFBmoracP
QzXBaoR8qz/7jRaPMvST
=OEzI
-----END PGP SIGNATURE-----

--oGy11dVowAZA6eXT--
