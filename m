From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 01/27] clk: ti: clkctrl: fix error messages to print out
 node name properly
Date: Mon, 30 Oct 2017 21:45:03 +0100
Message-ID: <20171030204503.767jcweqm2mn237w@earth>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m2rj2gqqvm6ztmw4"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509368685-29112-2-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org


--m2rj2gqqvm6ztmw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 30, 2017 at 03:04:19PM +0200, Tero Kristo wrote:
> Current node name does not convey any information, as it is always "clk".
> Instead, print out the full node path, which will tell us better where
> something went wrong.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/clk/ti/clkctrl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
> index 53e71d0..2db7d40 100644
> --- a/drivers/clk/ti/clkctrl.c
> +++ b/drivers/clk/ti/clkctrl.c
> @@ -351,8 +351,8 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct =
of_phandle_args *clkspec,
>  	if (ti_clk_parse_divider_data((int *)div_data->dividers,
>  				      div_data->max_div, 0, 0,
>  				      &div->width, &div->table)) {
> -		pr_err("%s: Data parsing for %s:%04x:%d failed\n", __func__,
> -		       node->name, offset, data->bit);
> +		pr_err("%s: Data parsing for %pOF:%04x:%d failed\n", __func__,
> +		       node, offset, data->bit);
>  		kfree(div);
>  		return;
>  	}
> @@ -428,7 +428,7 @@ static void __init _ti_omap4_clkctrl_setup(struct dev=
ice_node *node)
>  	}
> =20
>  	if (!data->addr) {
> -		pr_err("%s not found from clkctrl data.\n", node->name);
> +		pr_err("%pOF not found from clkctrl data.\n", node);
>  		return;
>  	}
> =20
> --=20
> 1.9.1
>=20
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--m2rj2gqqvm6ztmw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAln3j0sACgkQ2O7X88g7
+pqQzg//fce/diZEsEfq7hI76IpG6g1Y3mybbH1+p1R1rito8uAbuWyBxcZzXIav
xVDe8gTh1GD1X7JunzQvgwMoaTKe0PtkCpJMe63xBGzeVpzbRojuSOGKTHskIhQb
DoKePsDRIE+SoGLAbWKfjMIOqiY8hb3sGDi4OMmTOq6YbOx06KmcY65mF4HJDFvk
Sw1Tc4M4qC4Od+fXIU3BgsdMrZzyEvDyZPMmuNuZuumyjmCd6itPg++PGpnC/qQe
YwynG+UjEw3yTxRFTPUB2ZJ8G1+3m0CkpHitUbG5Ue/2SR8t5Ro+Njomt8cuN8fa
TUz965FhWFG6344d6v65W2/eEHfdBhLeBWoOQAd701CbVwjms/Q+FnFOYcMd8Z5D
2uHF72tFq0noyz3a/QmATzEpFhauy5893Cszvsw5rPPVFKIDbjAybB9CMwH3dIsy
/3zHYfi56TIWTHe9b8VAhao1ESjS1rDg2upcXnjuVTZQrezQM2J0K6vLfFK+mnrn
2ONEf/zzm3tSTevisxmT4jRGgxdk+SbvqO5pySEh0sN8t4CnVHDHaUCTvi3r7haV
45xrRIwPqkL2pROSkutGO89jqlRhdEY3rja5lvZfOs1Ctanfp7zACGzzI80P68oY
WJU/Acwonv9B92232Sd1BDzD28a8LcxZ+dBiIEkuCvgjMPvGpzs=
=+9A8
-----END PGP SIGNATURE-----

--m2rj2gqqvm6ztmw4--
