From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
Date: Thu, 12 Dec 2013 15:48:20 -0600
Message-ID: <20131212214820.GT1939@saruman.home>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tRcR9GoWqjXrt11v"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386884755-12366-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

--tRcR9GoWqjXrt11v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 12, 2013 at 03:45:55PM -0600, Felipe Balbi wrote:
> +static const struct dev_pm_ops kdwc3_dev_pm_ops =3D {
> +	.prepare	=3D kdwc3_prepare,
> +	.complete	=3D kdwc3_complete,
> +
> +	SET_SYSTEM_SLEEP_PM_OPS(kdwc3_suspend, kdwc3_resume)
> +	SET_RUNTIME_PM_OPS(kdwc3_runtime_suspend, kdwc3_runtime_resume, NULL)
> +};

did I really forget to use this ? Wonder why compiler didn't annoy me
:-(

there I go to v3. Will fix in my tree only to avoid the extra traffic in
the mailing list.

--=20
balbi

--tRcR9GoWqjXrt11v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqi8kAAoJEIaOsuA1yqREF6wP/ilKU3Xzrc42X70O/7O3DbZr
dGkSQqekmDe/WN40Y5RQfGsjcfWSNmw+9O9b9AWrd70He3kF0vqvCVDXPkVAmM7q
AsgG/5nJVG9Kre99EO+D2uuXBw6ZWHRUBv1WJqffpZWvtsKFMfld3MJLRDuR/MzV
qN0WLYG0fyg2KsIClwFxPhxIiANFKnEhg+ozitmiBUY847HWQpZjl9MFqHC84Zc+
Cj6glB7t+lh54s963rlP0BBHJ8FP0smr8UCaPPvU4/jeaghM/BgwXBaA2OYHF9N1
ZztxUBnpCn/eJ9joivUCy0eGl4QuBzN2iJCYUEYhz/7cXv3XMTTgEe9Jc5m08b7Q
wWHC8ZLfgwA8dt16cav9RhAwzAFPQ39rXxoXftrc5oCkQG/ivkc8vUSPVrI/Cieh
AuWQjZ/wiTG4jcnbuCLoT5vpTdDr4bq/bjx+rSEbaxUCCTm3L3yXM9PrX14EkMKn
jDq6IOIIvdO08glBeOFTDh5M94lQYmMBpe1+DmDHpLukRbLzFdnZ4AedGNtCJ10R
WrzVcNYAMYBTitTpUkhbqRR70MWer0RyjIijZp0z69AQqyR7nE3jfv9dnqYt1K8u
saV2GfyCr0wydwzTqJzeM6W6f/D7h6HmsDthii/IDsUvT3HThNbclirAHEYi69bi
ah9nrRVjkniPAh+opbS2
=hiYV
-----END PGP SIGNATURE-----

--tRcR9GoWqjXrt11v--
