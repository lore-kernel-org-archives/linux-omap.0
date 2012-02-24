From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
Date: Fri, 24 Feb 2012 13:24:09 +0000
Message-ID: <20120224132408.GF5450@opensource.wolfsonmicro.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46412 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755195Ab2BXNYL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 08:24:11 -0500
Content-Disposition: inline
In-Reply-To: <1330089398.4102.539.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 03:16:38PM +0200, Tero Kristo wrote:

> I still ain't quite sure how this would work, do you mean adding
> something like this:

> +static int twl6030smps_list_voltage(struct regulator_dev *rdev,
> +                                   unsigned int selector)
> +{
> +       return selector;
> +}

Yes.

> I believe this would fail still. I took a look at a few drivers that use
> regulator_list_voltage(), but all of these seem to numerate voltages
> based on regulator_count_voltages(), which will return -EINVAL for the
> SMPS ones as the num_voltages is zero. Also, even if I defined
> num_voltages here, I would be attempting to list_voltage for zero index,
> returning zero, but this would be invalid voltage for the cpu obviously
> (and is also out of range for the regulator min_voltage, and also
> according to docs invalid return value for the function in the first
> place.)

Well, clearly some of the values won't actually be useful and you should
feel free to return error values for those or apply an offset or
something but the basic principle applies.

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR49wAAoJEBus8iNuMP3dE8wP/0xHuw0LoUuD+ddPukhatvUy
wGXUfLKqt384A97XZnaN0xKZ+THlQU/03DOWLOkqVXxPHgN5Sy7DzcROe9lKf0sN
UI1gK6svlL7Ke2M8E2h66pxmabCyouAa3cJppx3Xo1Kf/78jlDKcpvrsfBn/ZMPq
/iCKheJG3oYsVyI67XJZt/0bbzj5+Vn5OKxlPmdVIvgCPovLjUUi9CStSPWjK6u8
A7QX/oOsLtWY3HZcT9QQlZktT2Ird5iBSFTc1xXm3yOTfwBYO12eG2uqwIQdFu3j
bG67fPqmjvlaDGstEGBgn6M602dvQJmOOAc0G8vU9IRLTKPMa97t3QH3+ovTJvjM
ABaD4dJVAmEsOGis4A1vkKcte+hiip1acPIPl7HG3jbjp8LvL/gm+c0sAke2BOQN
vEMHae1sjGXg/Ejh9y9kK2qFhhQklxPi/QHASsgJ2GxK1s1alJIZBtznIKGzUSAU
QJL3ljgZn5t//EmRhH5OLp1tu3WeAr0g9Rqk+D6mr2V0ZaPx65gEHxoiOTD74E7N
mG0ijHMW64ePFuGsET68mGAt5rXVPKxhm3bi1FWW/mskpfmtQ0YQ+2Wv+FofiEDk
ekSCW7m2iF+keFNcWvR08knsDay554HAXKh32u1GownBOzmg74TYOzApzQWRJF4b
Y7cmDS2JVNb9rasFDj4f
=lt2V
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
