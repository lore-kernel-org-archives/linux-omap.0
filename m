From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/13] Add dummy smsc911x regulators to zoom-debugboard.
Date: Thu, 22 Mar 2012 11:37:23 +0000
Message-ID: <20120322113722.GF3091@opensource.wolfsonmicro.com>
References: <20120321194133.GP9859@atomide.com>
 <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
 <1332393594-23993-14-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48694 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755781Ab2CVLhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 07:37:24 -0400
Content-Disposition: inline
In-Reply-To: <1332393594-23993-14-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 10:19:54PM -0700, Russ Dill wrote:

> +static struct regulator_consumer_supply dummy_supplies[] = {
> +	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),

Why do none of these boards use -1 as the ID for the device?

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaw7rAAoJEBus8iNuMP3dKEQP/3h9ZuTlKBF/Unk7hL3g7Vrd
71YQMEceI+nMtvZVd1Y2jf7/sTS7NHYySS6sRmExWsF6tNcHcp7Tyk7Xuf3NXmnQ
GbzP0mlt0+ySDxfXAn+9DrFW+no4P8R5r5xsL2G55IUNA+fHHGV3nN4iWvLtIPQu
tDyO/4raSS4eCHIgyTlYn1Ap4YhswzF/yt8ipsc46zvzuhVmNGfOK2uY+rQjqi7c
O1jwkL5yt7M5IX3Uym1fwtl7HJhZBR+4zhp6warX2PA+11t3b9auxHFl1boAaNqX
LPS75KZGu8iAlhepHpM3jmw1BM7PPSvjFDy1JF3pYyhlIjBIBRaKzDpnso3qHed4
LHwrl2xOF3mxSZ2eV8hnTsDzly7fywRi4xY76vGyYsUxCk42+SuNtazwdtKN1TpY
M+7FyNvGNatlHv8ZenXO8aypiVvwxzBwt/0ubCTzQkGbOrahRsCflM9NHMVgPEV4
/TPQUmXiyEY0TpCmrJYXX/h9PqxNq/KOnsqYKeVETt5t8/yWqLc8LE0nNaxrtLqY
df0w6mSvWmb9AUTebaJgjKl/2JsBBr8NxT99KZo8q9MOcM+3fOim/LBjvfz62sAQ
qegCDGJdT2hJUTdX3TlIjxwbmxMXwbN66Ix1iRE4y4PEv4o9e1/cLjwpxs96sDCM
I8vkggl0fSYbyXM3Mi1Q
=pJWw
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
