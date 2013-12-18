From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: tps65910: Add backup battery regulator
Date: Wed, 18 Dec 2013 16:24:52 +0000
Message-ID: <20131218162452.GX28455@sirena.org.uk>
References: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3xHYp4KIwhE2rfeC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34159 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3LRQYz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 11:24:55 -0500
Content-Disposition: inline
In-Reply-To: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--3xHYp4KIwhE2rfeC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 03:50:07PM +0100, Markus Pargmann wrote:

> @@ -771,7 +794,7 @@ static struct regulator_ops tps65910_ops = {
>  	.get_voltage_sel	= tps65910_get_voltage_sel,
>  	.set_voltage_sel	= tps65910_set_voltage_sel,
>  	.list_voltage		= regulator_list_voltage_table,
> -	.map_voltage		= regulator_map_voltage_ascend,
> +	.map_voltage		= regulator_map_voltage_iterate,
>  };

You should make separate ops for this rather than make all the other
regulators take the performance hit.

>  static struct regulator_ops tps65911_ops = {
> @@ -944,6 +967,7 @@ static struct of_regulator_match tps65910_matches[] = {
>  	{ .name = "vaux2",	.driver_data = (void *) &tps65910_regs[10] },
>  	{ .name = "vaux33",	.driver_data = (void *) &tps65910_regs[11] },
>  	{ .name = "vmmc",	.driver_data = (void *) &tps65910_regs[12] },
> +	{ .name = "vbb",	.driver_data = (void *) &tps65910_regs[13] },
>  };

Ugh, these numbered tables aren't good.  Not a problem from this patch
though.

> -		pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;
> +		if (tps65910_chip_id(tps65910) == TPS65910 &&
> +				i == TPS65910_REG_VBB)
> +			pmic->desc[i].enable_mask = BBCH_BBCHEN_MASK;
> +		else
> +			pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;

switch statements please - it means if additional things need
customising they can drop right in.

--3xHYp4KIwhE2rfeC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSscxRAAoJELSic+t+oim9m4AP/0JRrHvbk5qCqwcjPJl94riS
Akr1Hhz/uyug5ZpeVjPKjtfxBNf80/PtOWNp0TxjTtLK+2w1GN/4yZ8rqvjlYgG+
xl5moNL+/ZnW5ycZnfIYlGxLg6s2Ozz+PoF7Fkjy4HcP+abJhYa8ppjkWo1+Z2s/
lrl2YGVGXDNcxC+fYR4m2M7pjHgeyx/hpBXXpcsocjEK9H1PyJTElGVKOQXs45X6
Lz4SbMCwE69sQMrkCL4Forde0Bbx1PxL5oM1kMAlWzb8OinQgcfA2sei+BYFlrZe
klH+oWwOyXbYSVSAWDtcDD31JTZbVrupc2DW2lECZonL/vIHeD+yCKp6MM3+yxIq
6qZ6o33a83ZBg7qFcTBmyLkvp31HBLqCk4+x8bCV0Eo1/kPyl6rowP+xiU/06uiG
MRz+4ikxdFcNWvHf/YTZ2D7spwH/WtJNMiOWlxU3D9GI6ZImBAMSSp0AxU4SU+3i
nQtfsoiOaXJ/ETRmL5JmdugbMuMLqWSbXt+9z4NbjgBFlr5ImXnRNU2TGzzWNhlj
pgar0CfBv++u8GQmdwZ8m2lyN4/xGbAwNK9ayfHzr/wihgfIPFWJKbwnMX3TCXXH
sVM+I5dD4TsEtTGFAdrnXDHLg401F8rDes3YAXZ1pbwchFIQvtFBh+//yOxGUAVo
Uc5C0EspqWxxq0qvrblT
=OR1K
-----END PGP SIGNATURE-----

--3xHYp4KIwhE2rfeC--
