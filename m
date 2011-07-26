From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 02/19] OMAP3+: voltage: fix build warning
Date: Tue, 26 Jul 2011 16:12:26 +0300
Message-ID: <20110726131225.GO32582@legolas.emea.dhcp.ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
 <1299338962-5602-3-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OAiy6VLsECigG9dy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44081 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1GZNMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 09:12:30 -0400
Received: by mail-ey0-f176.google.com with SMTP id 28so747705eya.7
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 06:12:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1299338962-5602-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>


--OAiy6VLsECigG9dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 05, 2011 at 08:59:05PM +0530, Nishanth Menon wrote:
> Handle the case for a future SoC where sys_ck_name might be
> uninitialized. Fixes the build warning:
> arch/arm/mach-omap2/voltage.c: In function 'omap_voltage_late_init':
> arch/arm/mach-omap2/voltage.c:86:8: warning: 'sys_ck_name' may be used un=
initialized in this function
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/voltage.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index e0cbd93..56961df 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -91,10 +91,14 @@ static int __init _config_common_vdd_data(struct omap=
_vdd_info *vdd)
>  	 * XXX Clockfw should handle this, or this should be in a
>  	 * struct record
>  	 */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  		sys_ck_name =3D "sys_ck";
> -	else if (cpu_is_omap44xx())
> +	} else if (cpu_is_omap44xx()) {
>  		sys_ck_name =3D "sys_clkin_ck";
> +	} else {
> +		pr_err("%s: Unsupported OMAP\n", __func__);
> +		return -EINVAL;
> +	}
> =20
>  	/*
>  	 * Sys clk rate is require to calculate vp timeout value and
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--OAiy6VLsECigG9dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLr05AAoJEAv8Txj19kN1tBEIAKbEUC6ZdvgUicK9oKwj2BvT
PRb7LlYq2CV15s5P9xMk8DHj3O+gNJO8zy+l3gtrPFlClDECUXhJgLAQCQttpvTt
x/ZRNNJpILWfQX8s7FLCuUrmSNVuEt9N0cLKxjkiIqblTj8igeM/b3BPeYQ3htHo
32o6VwD5qaRFM44YBLEvMvHBWktDJfz432Veg5u1jCv/My/Ydggug7ggflP1Bksf
IFBiLLTsn/0d0hHjKeGNWJiJ31aLT9kLm4vNA/oeapPx/gg1CXGKIDLsvFTh+VRy
0mjXFddEQc6mzyg6jLH9+UYnYkAV2QtC8DiZmTZGsKygpqY4Iv0OHTfOBYSnKPE=
=8B+I
-----END PGP SIGNATURE-----

--OAiy6VLsECigG9dy--
