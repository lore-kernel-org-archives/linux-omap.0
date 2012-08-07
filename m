From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 11:48:17 +0300
Message-ID: <20120807084815.GK8468@arwen.pp.htv.fi>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:50396 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752307Ab2HGIvw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 04:51:52 -0400
Received: by lbao2 with SMTP id o2so2199827lba.10
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 01:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 07, 2012 at 01:57:42PM +0530, Chandrabhanu Mahapatra wrote:
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2=
/dss/dss_features.c
> index 9387097..b8d5095 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -567,6 +567,48 @@ static const struct omap_dss_features omap4_dss_feat=
ures =3D {
>  	.burst_size_unit =3D 16,
>  };
> =20
> +static const struct dispc_ops omap2_dispc_ops =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_24xx,
> +	.calc_core_clk		=3D	calc_core_clk_24xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_24xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_24xx,
> +};
> +
> +static const struct dispc_ops omap3_2_1_dispc_ops =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_34xx,
> +	.calc_core_clk		=3D	calc_core_clk_34xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_24xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_24xx,
> +};
> +
> +static const struct dispc_ops omap3_3_0_dispc_ops =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_34xx,
> +	.calc_core_clk		=3D	calc_core_clk_34xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_44xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_44xx,
> +};
> +
> +static const struct dispc_ops omap4_dispc_ops =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_44xx,
> +	.calc_core_clk		=3D	calc_core_clk_44xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_44xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_44xx,
> +};
> +
> +void dispc_init_ops(const struct dispc_ops *ops)
> +{
> +	if (cpu_is_omap24xx()) {
> +		ops =3D &omap2_dispc_ops;
> +	} else if (cpu_is_omap34xx()) {
> +		if (omap_rev() < OMAP3430_REV_ES3_0)
> +			ops =3D &omap3_2_1_dispc_ops;
> +		else
> +			ops =3D &omap3_3_0_dispc_ops;
> +	} else {
> +		ops =3D &omap4_dispc_ops;
> +	}
> +}

you're not really removing. You're moving cpu_is_* somewhere else. A
better approach, IMHO, would be to use the DSS_REVISION register to
differentiate the DSS IP itself, not the OMAP.

--=20
balbi

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQINZPAAoJEIaOsuA1yqREUWYQAI69ffH+0aaptSMneIP4CSIO
C+unqD25boeHK74D2YE2rd7t2xbyHXWirgs4SrOZp+QZCmw9dErWTTSsDpes2vh2
xLauq8la7/9FTowNVHc8hMDKvvlfqcVrUXU1/mP5emq6XE0UJ0u3Vb0Yp7MNxFNv
vvcV6vLcYvbgRrtb/fkkGsMQdDyb8WFYSWl2UVx6gIbZ0o23XrdRmHC7v8BAJ9zU
R2WHyeWEp5ePGchAUDAfWR8MQFcZmE8jRmeuX1RilYbl9OnXXAAThH4WRtOxda6o
LSD9raOmMwlU+/xQVNzQozGTJaQ4jp3Qmmr6Ut85PhfZ2d6R3ePo28VX3i6Q1stl
8EyaNA1RadR3ZLVyJTzaV8YgUQfPW/6TxCT/DFv2W1PnrBZIx/l7J0w/Uoonf+w1
F7qoMb+kT//k+38zdCb3/Jxov0MMiPeDFW9WkbN9ibVYe6NxDkyNW1zZbub7VlxV
y+UOqNTnO/HZNo+2aqn6WCIdRFK/Cax+y34/KRwD5iJgvXcISwmkSu4mFm1oi/3r
3eVR/ieF4vTYBUim/LGoyqO5mthjmNmpGr0w0gABNHPw+8ugMJ4Ipy9FwJWeygE0
EdklWf3OS4GNrSiZF0dsNe7rIU05ELas6Bzxk/y7sXYqtQG5GHaJwpXTfbLOguiN
xO/lWtCxYBpcikUHbI1n
=SrZ6
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
