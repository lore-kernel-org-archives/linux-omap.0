From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Thu, 05 Jan 2012 09:21:50 +0200
Message-ID: <1325748110.2045.23.camel@deskari>
References: <1325675397-15241-1-git-send-email-mythripk@ti.com>
	 <1325675397-15241-2-git-send-email-mythripk@ti.com>
	 <1325675397-15241-3-git-send-email-mythripk@ti.com>
	 <1325675397-15241-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fsX0lVBuK6ia7XiEVf7y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49466 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756991Ab2AEHV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 02:21:56 -0500
Received: by lagu2 with SMTP id u2so70369lag.9
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 23:21:53 -0800 (PST)
In-Reply-To: <1325675397-15241-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-fsX0lVBuK6ia7XiEVf7y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-04 at 16:39 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Change the timing match logic, Instead of the statically mapped method
> to get the corresponding timings for a given code and mode, move to a
> simpler array indexed method. It  will help to scale up to add more
> timings when needed.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |  177 +++++++++++++++++-----------------=
-----
>  1 files changed, 77 insertions(+), 100 deletions(-)

> -static int get_timings_index(void)
> +static const struct hdmi_config *hdmi_find_timing(
> +					const struct hdmi_config *timings_arr,
> +					int len)
>  {
> -	int code;
> +	int i;
> +	const struct hdmi_config *timing =3D NULL;
> =20
> -	if (hdmi.mode =3D=3D 0)
> -		code =3D code_vesa[hdmi.code];
> -	else
> -		code =3D code_cea[hdmi.code];
> +	for (i =3D 0; i < len; i++) {
> +		if (timings_arr[i].cm.code =3D=3D hdmi.code) {
> +			timing =3D &timings_arr[i];
> +			return timing;
> +		}
> +	}
> +	return timing;

You don't need the timing variable at all. Just return &timings_arr[i]
or NULL.
=20
> @@ -341,9 +312,15 @@ static int hdmi_power_on(struct omap_dss_device *dss=
dev)
>  		dssdev->panel.timings.x_res,
>  		dssdev->panel.timings.y_res);
> =20
> -	code =3D get_timings_index();
> -	update_hdmi_timings(&hdmi.ip_data.cfg, p, code);
> -
> +	if (hdmi_get_timings() =3D=3D NULL) {
> +		/* HDMI code 4 corresponds to 640 * 480 VGA */
> +		hdmi.code =3D 4;
> +		/* DVI mode 1 corresponds to HDMI 0 to DVI */
> +		hdmi.mode =3D HDMI_DVI;
> +		hdmi.ip_data.cfg =3D vesa_timings[0];
> +	} else {
> +		hdmi.ip_data.cfg =3D *(hdmi_get_timings());
> +	}

Now you are searching for the timings twice... Do:

timings =3D hdmi_get_timings();

if (timings =3D=3D NULL) {
	/* default to VGA */
	...
} else {
	hdmi.ip_data.cfg =3D *timings;
}

 Tomi


--=-fsX0lVBuK6ia7XiEVf7y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPBU+OAAoJEPo9qoy8lh717RkP/3+7UzPZuMtic/fntbEdr29W
hYmAmSToxXVbDeHLzhQ9KtvQ9N+WHP2MOdrDMSQXwGIP3H+mCq/FGfmMGa0D4MN4
98MKaMYFKaL5S0OUheSKDyNPK0D+OSFQ5hqe/fBws816+2HTUtgBGPjowijbY3RM
p1BcJo9r2bpUBV9Kap7bZPApmHiPmR8cklhq0wRlbnbpKhcZftDSWszjDE7YydLk
O0fXA8K2XhMDafRziMzKm8vrHywEbOfQEtDuCYQK0fW/H3GqHzMmGvfEKH5P/WdB
/48VtXGa4U+X0IPWTQm+ZhpJ7ErT+WeO3JvaCvJDjk1PoYoVyOgrOyPp3dChxmRo
HeUutpEuBjZyj/BIgaZYOcooeosm/772cDV7i3AcWx+85MHVxjnR6oMZvudp3Cbf
0DoradpcRyUDcVLKbMEOyKVRJT3v4Uys1AqaPlTG/M08DAcj3Hf34gVmPZBjDFSM
hfBtxelgiQQuPJEgS6mJ1WeAZKl5SeNpvTXLscjt1BqeKEMFIV6iE1HQKiBJaEQ2
oqaFU7tzBobJxZI2bLdDm0zS8jHTjeAFMr1IGOMzNUufTfSI3YoWhIzJRwZ2pxze
PdwUDH0LKHFJ5Fq1h0YzGQOGP5kO/wwGGzYalX2urnlB012VCEe+NdP93M4nywPD
zlE6zPawkVEr0BY3QFOR
=cq1o
-----END PGP SIGNATURE-----

--=-fsX0lVBuK6ia7XiEVf7y--

