From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl6030: add dependency on OF
Date: Fri, 25 Nov 2016 13:03:37 +0000
Message-ID: <20161125130337.lf33cysb4cyq6axl@sirena.org.uk>
References: <20161125074335.6947-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vnrhmoke6rdzhnoo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161125074335.6947-1-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--vnrhmoke6rdzhnoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2016 at 09:43:35AM +0200, Nicolae Rosia wrote:

> This driver was converted to device tree only,
> add dependency on OF symbol and drop of_match_ptr

These are two different changes :(

>  config REGULATOR_TWL4030
>  	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0 PMIC"
>  	depends on TWL4030_CORE
> +	depends on OF

This should be OF || COMPILE_TEST so people can still get build coverage
without DT.

> --- a/drivers/regulator/twl6030-regulator.c
> +++ b/drivers/regulator/twl6030-regulator.c
> @@ -773,7 +773,7 @@ static struct platform_driver twlreg_driver = {
>  	 */
>  	.driver  = {
>  		.name  = "twl6030_reg",
> -		.of_match_table = of_match_ptr(twl_of_match),
> +		.of_match_table = twl_of_match,

This buys us nothing, it's not going to make any practical difference
but on the other hand it costs nothing to have it there either.  The
only impact I can see this having is causing someone doing a cut'n'paste
to miss the of_match_ptr() out.

--vnrhmoke6rdzhnoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYODaoAAoJECTWi3JdVIfQAwoH+wXpjbf7g6c+APA3bPpR8nvq
9M+IXclJrFLchd/APvm+hvNPC66+6sj/OwGu8hRidHzU4751LGC8ICHa5kBR0sOp
cd+/hu9iSs30SY0W8XAEPChELc8F34eGFAab5VgVCRs48CQeUR++x75CJvVfWFFt
DCg662zQhPZxGfw3zdXdne4ZmifrNW74OiOzii6cRBKAtPehfuGmDZQprEADMn3/
p3w4CixU0JfjwBfcYP+V4kjqA3cRzXe+iewiDGAJ9OFkES0QeDi+vSBWLfG/uf8J
9M1//3gkALiOd21p9rs3HK9/Mgvr1idTb7QxYpxrHFO59b8tjbirIvl5JIsuk/g=
=MagU
-----END PGP SIGNATURE-----

--vnrhmoke6rdzhnoo--
