From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH V2 1/8] regulator: Introduce OMAP regulator to
 control PMIC over VC/VP
Date: Thu, 4 Jul 2013 16:41:05 +0100
Message-ID: <20130704154105.GD27646@sirena.org.uk>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
 <1371849949-12649-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1735028794965387270=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371849949-12649-2-git-send-email-nm-l0cyMroinI0@public.gmane.org>
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
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Taras Kondratiuk <taras-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============1735028794965387270==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uIl/38eSFNz6qklc"
Content-Disposition: inline


--uIl/38eSFNz6qklc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2013 at 04:25:42PM -0500, Nishanth Menon wrote:

> +static const struct omap_pmic_info omap_twl4030_vdd1 = {
> +	.slave_addr = 0x12,
> +	.voltage_reg_addr = 0x00,
> +	.cmd_reg_addr = 0x00,
> +	.i2c_timeout_us = 200,
> +	.slew_rate_uV = 4000,
> +	.step_size_uV = 12500,
> +	.min_uV = 600000,
> +	.max_uV = 1450000,
> +	.voltage_selector_offset = 0,
> +	.voltage_selector_mask = 0x7F,
> +	.voltage_selector_setbits = 0x0,
> +	.voltage_selector_zero = false,
> +};

So, this still has the thing where all the data about the PMIC is
replicated (but now in this driver).  It should be possible to pull all
the above information except possibly the I2C timeout and perhaps the
I2C address (if there's a separate control interface) from the standard
regulator core data structures for the PMIC.  This would allow the
driver to Just Work with any PMIC without needing to add it in two
places.

Other than that this looks good, the only issue I see is where the
driver is getting the data from.

--uIl/38eSFNz6qklc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1ZeNAAoJELSic+t+oim9TYQP/i8xdUuqYSquZGFqcd6Q4RR6
sx1wtU1lN5tmlgEa/HrSoU/qc8SRO5fvPYXweEbS0YPAlhWq4e9n+cq7nDSbSr7s
YipfiCHA2sGBOzPd5HhU8ZUG+FvDWJ7vTKUuBrl4M7q8QkKkhGUypUC10Lm+MYlt
mMwpNZ2HFhlLOdf7S7TtkW7Agls0rIE+rzkf0VJKQzxNf+qyJA05K8/I6JA6u4nR
FjMfqFeI+770EDoQxyRP4RCM0VUNMPkYcPRRD8p0sRICYxxDLZieaKQfa1MCDuJY
K9BSK0uJhh/Mhvxb8M82LqzuPxK1n903GRXnKC8iWV1op2EmqUVXbB2sxsCC75Ra
fzEfY2n3RbO1TuMQi7LXiMKcl7ej19YjYfwUdwM51DaquBqLsJkx2M1n3A4Ryq5n
Ykm6h56nzBZwwVktf8c7Rs2xxz3mS3T5K1jjE1mj7NdUHwYreB+ynVpyKseMSFp/
Jqe8RKzGD1V4RhAkwezgedDoqihKDftaULPjREwzqihAcirlGLXnatvSGCVZB8Hd
b+/3xTt78WqUtXTmQv9Pu0YXkgwvd0FSWZUt9i8oogm6eS/bE6OV4WgFXrrAmROb
ZqWZvP1PwjgO8Fm+uXWwoGxa4FD/bRkoal+7wJvqwI6p9Fy8SfrChNHQ5MSN/lyP
VmYNnKKBDikfiRFrBX6N
=VOAi
-----END PGP SIGNATURE-----

--uIl/38eSFNz6qklc--

--===============1735028794965387270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1735028794965387270==--
