From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
Date: Mon, 10 Jun 2013 19:01:50 +0100
Message-ID: <20130610180150.GQ1403@sirena.org.uk>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
 <20130610103131.GR31367@sirena.org.uk>
 <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
 <20130610164905.GJ1403@sirena.org.uk>
 <CAGo_u6ov=yaCwt8apbvW57ErAvhgUBHHw9gwADBC1fJUrfucUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7295012658139439723=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAGo_u6ov=yaCwt8apbvW57ErAvhgUBHHw9gwADBC1fJUrfucUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============7295012658139439723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vsi50HYs5tPfr+1I"
Content-Disposition: inline


--Vsi50HYs5tPfr+1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 12:51:42PM -0500, Nishanth Menon wrote:

> a) Tegra seems to use Lookup Table for sending predefinied voltage
> values to PMIC. OMAP has no concept of lookup table.

They seem to be doing basically the same thing here, you've got a linear
map of selector to voltage too AFAICT.

> b) Tegra and OMAP h/w blocks seem to use I2C - that is good.
> c) How about the i2c slave and register addresses, slew rates, start,
> end voltages, max voltages that SoC can support etc, I am yet to
> understand those.
> d) OMAP has 3 modules - AVS (SmartReflex), Voltage Processor(VP),
> Voltage Controller(VC) - I am not yet sure about the Tegra hardware
> blocks involved.

This all seems like it's at the implementation detail level - the bit
that seems like we should be able to share it is the big picture bit for
how we describe how the AP side stuff and PMIC are hooked up without
having to have a bunch of completely non-framework stuff for things
like describing the PMIC.

--Vsi50HYs5tPfr+1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRthSLAAoJELSic+t+oim9GT0P+wUSGDd0n0pZGxF3nrCfxkh0
2K1JFJmA/qqah6iv/pT/HNSUjxlKUCWDgQMEwEEYCcbUtDEGYXhFGMNCMl2nDBD6
Oa05MIUSyJYTQW5KiFXc0vzGg8rHYwSG6ScLst59bhsJTXnif8Oa2JAhARFZyjVD
Y18F0sn9RGmI3jnAssuqDdMhH+s3+sFdnJ6y/7h/r5rQs/+zQ+R64Bdfwb6ER2VI
Zlp9ogu06xE1K4+xFeFiv3HudJQhLlB9IpW8uoe3hHRXuczUgeFSh/4un5jaG9J9
/UR0DiJTio1AlH0KUAnl5yV9NI2rDgk/2GbtswXsp1U/P3z5Rjqeu33dTHR4JnYm
ehhm8G+PBRwFtoIE41Ell/jqb0FBBI22jcVjm7SBeCvhhmnS6cTxTI3kopVUbme7
TVsqeZbIXh4V9sMkPGOGi1OeD8Dd6U7CIUmLQuRDUd/O1tK7K+ZBfMeOw1TLzDAV
bPS6JrfpOUpY7cygDD+2CIyc9vToCMAOlwWZLS2Bfx2nZc0a4MmEQRi5DfebiFOJ
JtH8VnXzl6wRoq+zPk6ZxjQRSfrwwUNsUi4mHxJDuQhw2XvaJLQblZiHMfzK8jVr
fkj8xqRnnJ7tf60aQhsfvHqscuwcS7xwWGKuxICo8sfSvYnxhV0J0YxS4Hvx/Lbi
VWV7oBdkm6gTba2xrmT4
=iQkI
-----END PGP SIGNATURE-----

--Vsi50HYs5tPfr+1I--

--===============7295012658139439723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7295012658139439723==--
