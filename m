From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] phy: cpcap-usb: Fix missing return statement
Date: Mon, 12 Jun 2017 11:41:59 +0200
Message-ID: <20170612094159.7rqk5pquu4bktgxu@earth>
References: <20170612081223.20743-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j43zrf5ahb3zsoa4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170612081223.20743-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--j43zrf5ahb3zsoa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2017 at 01:12:23AM -0700, Tony Lindgren wrote:
> Commit 8ae904e3c236 ("phy: cpcap-usb: Add CPCAP PMIC USB support")
> is missing return statement as noted by Colin Ian King
> <colin.king@canonical.com>. If the optional pins are not configured,
> we just want to return early and not attempt to configure the pins.
>=20
> Fixes: 8ae904e3c236 ("phy: cpcap-usb: Add CPCAP PMIC USB support")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  drivers/phy/motorola/phy-cpcap-usb.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/=
phy-cpcap-usb.c
> --- a/drivers/phy/motorola/phy-cpcap-usb.c
> +++ b/drivers/phy/motorola/phy-cpcap-usb.c
> @@ -468,6 +468,8 @@ static int cpcap_usb_init_optional_pins(struct cpcap_=
phy_ddata *ddata)
>  		dev_info(ddata->dev, "default pins not configured: %ld\n",
>  			 PTR_ERR(ddata->pins));
>  		ddata->pins =3D NULL;
> +
> +		return 0;
>  	}
> =20
>  	ddata->pins_ulpi =3D pinctrl_lookup_state(ddata->pins, "ulpi");
> --=20
> 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--j43zrf5ahb3zsoa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk+YeQACgkQ2O7X88g7
+ppSBRAAjMGyS+aaTWuvA8Lm/nQDcQ2kRROfthOB8ruL6ymcrJQ46qufWwoJKFVd
hml3FdHp2vd4oqLA1Lj3Ia8xfrDHKAPj/DOJOjCa7yaCDpEtNPQvDJS09IMYgN7j
DT9yIY23Ctd6mZ3Nb8HoAv8wi0vRS2WVmMuaKJOQmkkSZlqxBepoEuQat4F1BOR+
K+E8ovjk09Ot4Vygnm7rQqUOwyKuLvBZ2uDPEbLKJX6M4128lXBoZWzXbidVagrA
6I/7RV37RAhIFpgnJPSgWdVd1Zsm86eNINyTZQ9kw0jd4cScwbtxL8RDxny3648B
HJGJRcYIWjrB1gpOpsipz1Iox7r6M29xytIRb2aGIvjS3RCmjQ1wy6dq8fhXvlUY
W4udeTLPuooR7EwltO7CGRX+cqhsLgVbzEGfP9JPvC9ZHVd/qeEmgV4IAOJoWQRN
wbnP2ELIdo6iGCqrnq+8J654Ioi4qbf5SC8oF3iEdQVwBBf0UFs37sUFQpkGCkLk
bArkbpjs2161MPnunCJ/7HYEFm+AOrfyzeA4bOVE4z6/EhMspeIKSvni0djSlTOm
HbPHHNSokhbj7JVOdxL/3DGRXPMMmzulEXwHWLQNydZ19lcyZn8FalUysIl+9Wdp
womF5aV4Ovda4NrhAWbuCnXZL3hDNCSwIjMc/IPKmcgpT9D2FYI=
=kOCh
-----END PGP SIGNATURE-----

--j43zrf5ahb3zsoa4--
