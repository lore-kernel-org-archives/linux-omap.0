From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
Date: Mon, 10 Jun 2013 11:31:31 +0100
Message-ID: <20130610103131.GR31367@sirena.org.uk>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1139649006129072814=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1369246717-4167-2-git-send-email-nm-l0cyMroinI0@public.gmane.org>
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
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============1139649006129072814==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gxw6znBFH3c9xIzC"
Content-Disposition: inline


--gxw6znBFH3c9xIzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2013 at 01:18:34PM -0500, Nishanth Menon wrote:

So, the biggest problem here has been patch 4 (having to have a hack to
deploy this stuff is a bit worrying) plus the general not having a real
driver thing.

> +- ti,i2c-slave-address - I2C slave address of the PMIC
> +- ti,i2c-voltage-register - I2C register address where voltage commands are
> +	to be set.
> +- ti,i2c-command-register - I2C register address where commands are to be set
> +	when OMAP enters low power state. This may be the same as
> +	ti,i2c-voltage-register depending on the PMIC.
> +- ti,slew-rate-microvolt - worst case slew rate of rise / fall for voltage
> +	transition in microvolts per microseconds (uV/uS)
> +- step-size-micro-volts - Step size in micovolts as to what one step in voltage
> +	selector increment translates to. See example.
> +- regulator-min-microvolt - Minimum voltage in microvolts which is supported by
> +	the PMIC in ti,step-size-microvolt increments. See example.
> +- regulator-max-microvolt - Maximum voltage in microvolts which is supported
> +	by the PMIC in ti,step-size-microvolt increments. See example.

The other thing is this whole business of encoding the properties of the
PMIC in the DT like this.  Paul Walmsley has started doing some work for
some similiar hardware where instead of doing this the regulator is in
the DT as normal and then the driver for the offloaded voltage scaling
gets the information about the register layout from the regulator
driver.  This is a bit neater overall and would cope with determining
which method to use at runtime.

--gxw6znBFH3c9xIzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtasAAAoJELSic+t+oim9jasP/2dvydlJLP5IbSvqaG/6tgke
O0T+KfvVqYSyaOFL6ob3x+PCKHkj9NvTxYPtvt+X45hrxJs+DELupn+FK76rFxdC
KsEBi6kev9wZUFBMY0WgRTxPuk89vS8xJuFSB4gHEqvAyTlx6GqHIO5csllPP4gD
bZR2VhCRoPnNCEd5oUg47zlh316Er3GhcXbOq8Q7uR9+y3IWFEdf0tZ6GkjPr/uZ
2zBtPDni0uD3hDmULYSqLEcKoGWKpfiscjtl9lpupyY8dZNLkbBFPpvSObaFbpn0
WDM8zIpXPKl6ruoHAt1jnZn413PmfVrbrPanfFFVe8nDJfJLQNVVt3YkzZrRLLln
oevtYLhxxOCug0HCQdBSCQpNsVDEa48HV7AvprBOPm8+HPhafw8PtmV3lYFKkadA
Xr1dDMQZYMzhjsVsFgV4jjMpbqGJS+xm0oD+nsU84scOM1ju671Qd1HBl0DVdJjv
tPqO+D3IAt2ImBcGa4AR6+hqzBiNRjNTdXGnn25kViOedMDm93w3wGkL8OLPrGo1
A06Q5hxJaZLgvZLdFGSwAwofAst34WxAD7QA1UT0I1Rf620Vn+2ZjUKq41QcKOrt
6c2g0C1OmAgMrIKtAAaoUAyKdZtI98KfNS9ARfgQYwgYd5XjrGrSfS41VDMGP1Wk
Z2qYTM5PE4PLqKo8oAqV
=PxT3
-----END PGP SIGNATURE-----

--gxw6znBFH3c9xIzC--

--===============1139649006129072814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1139649006129072814==--
