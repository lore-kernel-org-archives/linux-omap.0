From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Tue, 03 Jan 2012 12:04:46 +0200
Message-ID: <1325585086.1973.30.camel@deskari>
References: <1325493896-26355-1-git-send-email-mythripk@ti.com>
	 <1325493896-26355-2-git-send-email-mythripk@ti.com>
	 <1325493896-26355-3-git-send-email-mythripk@ti.com>
	 <1325493896-26355-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ILrru3BBCa7TtAjL5I0H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39883 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477Ab2ACKEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 05:04:52 -0500
Received: by lagj5 with SMTP id j5so14098549lag.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 02:04:49 -0800 (PST)
In-Reply-To: <1325493896-26355-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-ILrru3BBCa7TtAjL5I0H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-02 at 14:14 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Change the timing match logic, Instead of the statically mapped method
> to get the corresponding timings for a given code and mode, move to a
> simpler array indexed method. It  will help to scale up to add more
> timings when needed.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |  174 +++++++++++++++++-----------------=
------
>  1 files changed, 75 insertions(+), 99 deletions(-)


> -static int get_timings_index(void)
> +static const struct hdmi_config *hdmi_find_timing(
> +					const struct hdmi_config *timings_arr,
> +					int len)
>  {
> -	int code;
> +	int i;
> +	const struct hdmi_config *timing, timing1 =3D { {0}, {0} };
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
> +	timing =3D &timing1;
> +	return timing;
> +}

You should return NULL if the find fails, not a timing struct with zero
values. And then there's no need for timing nor timing1 variables.

Furthermore, the code is broken. The timing1 value is allocated from the
stack frame of hdmi_find_timing function. You return a pointer to that,
but the value is no longer valid after the function returns.

> =20
> -	if (code =3D=3D -1)	{
> -		/* HDMI code 4 corresponds to 640 * 480 VGA */
> -		hdmi.code =3D 4;
> -		/* DVI mode 1 corresponds to HDMI 0 to DVI */
> -		hdmi.mode =3D HDMI_DVI;
> +static const struct hdmi_config *hdmi_get_timings(void)
> +{
> +	const struct hdmi_config *timing;
> =20
> -		code =3D code_vesa[hdmi.code];
> +	if (hdmi.mode =3D=3D 0) {
> +		timing =3D hdmi_find_timing(vesa_timings,
> +					ARRAY_SIZE(vesa_timings));
> +	} else {
> +		timing =3D hdmi_find_timing(cea_timings,
> +					ARRAY_SIZE(cea_timings));
> +	}
> +	return timing;
> +}

hdmi.mode is enum hdmi_core_hdmi_dvi, isn't it? Then you should use the
enum values when comparing, not 0. Although the use of that enum seems
to be broken elsewhere also, as struct hdmi_cm uses int instead of the
enum. That (and the other similar mode problems) should be fixed in a
separate patch.

And I think this function would be cleaner this way:

static const struct hdmi_config *hdmi_get_timings(void)
{
	const struct hdmi_config *arr;
	int len;

	if (hdmi.mode =3D=3D HDMI_DVI) {
		arr =3D vesa_timings;
		len =3D ARRAY_SIZE(vesa_timings);
	} else {
		arr =3D cea_timings;
		len =3D ARRAY_SIZE(cea_timings);
	}

	return hdmi_find_timing(arr, len);
}

> +static bool hdmi_timings_compare(struct omap_video_timings *timing1,
> +				const struct hdmi_video_timings *timing2)
> +{
> +	int timing1_vsync, timing1_hsync, timing2_vsync, timing2_hsync;
> +
> +	if ((timing2->pixel_clock =3D=3D timing1->pixel_clock) &&
> +		(timing2->x_res =3D=3D timing1->x_res) &&
> +		(timing2->y_res =3D=3D timing1->y_res)) {
> +
> +		timing2_hsync =3D timing2->hfp + timing2->hsw + timing2->hbp;
> +		timing1_hsync =3D timing1->hfp + timing1->hsw + timing1->hbp;
> +		timing2_vsync =3D timing2->vfp + timing2->vsw + timing2->vbp;
> +		timing1_vsync =3D timing2->vfp + timing2->vsw + timing2->vbp;
> +
> +		DSSDBG("timing1_hsync =3D %d timing1_vsync =3D %d"\
> +			"timing2_hsync =3D %d timing2_vsync =3D %d\n",
> +			timing1_hsync, timing1_vsync,
> +			timing2_hsync, timing2_vsync);
> +
> +		if ((timing1_hsync =3D=3D timing2_hsync) &&
> +			(timing1_vsync =3D=3D timing2_vsync)) {
> +			return true;
> +		}
>  	}
> -	return code;
> +	return false;
>  }
> =20
>  static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
>  {
> -	int i =3D 0, code =3D -1, temp_vsync =3D 0, temp_hsync =3D 0;
> -	int timing_vsync =3D 0, timing_hsync =3D 0;
> -	struct hdmi_video_timings temp;
> +	int i;
>  	struct hdmi_cm cm =3D {-1};
>  	DSSDBG("hdmi_get_code\n");
> =20
> -	for (i =3D 0; i < OMAP_HDMI_TIMINGS_NB; i++) {
> -		temp =3D cea_vesa_timings[i].timings;
> -		if ((temp.pixel_clock =3D=3D timing->pixel_clock) &&
> -			(temp.x_res =3D=3D timing->x_res) &&
> -			(temp.y_res =3D=3D timing->y_res)) {
> -
> -			temp_hsync =3D temp.hfp + temp.hsw + temp.hbp;
> -			timing_hsync =3D timing->hfp + timing->hsw + timing->hbp;
> -			temp_vsync =3D temp.vfp + temp.vsw + temp.vbp;
> -			timing_vsync =3D timing->vfp + timing->vsw + timing->vbp;
> -
> -			DSSDBG("temp_hsync =3D %d , temp_vsync =3D %d"
> -				"timing_hsync =3D %d, timing_vsync =3D %d\n",
> -				temp_hsync, temp_hsync,
> -				timing_hsync, timing_vsync);
> -
> -			if ((temp_hsync =3D=3D timing_hsync) &&
> -					(temp_vsync =3D=3D timing_vsync)) {
> -				code =3D i;
> -				cm.code =3D code_index[i];
> -				if (code < 14)
> -					cm.mode =3D HDMI_HDMI;
> -				else
> -					cm.mode =3D HDMI_DVI;
> -				DSSDBG("Hdmi_code =3D %d mode =3D %d\n",
> -					 cm.code, cm.mode);
> -				break;
> -			 }
> +	for (i =3D 0; i < ARRAY_SIZE(cea_timings); i++) {
> +		if (hdmi_timings_compare(timing, &cea_timings[i].timings)) {
> +			cm =3D cea_timings[i].cm;
> +			goto end;
> +		}
> +	}
> +	for (i =3D 0; i < ARRAY_SIZE(vesa_timings); i++) {
> +		if (hdmi_timings_compare(timing, &vesa_timings[i].timings)) {
> +			cm =3D vesa_timings[i].cm;
> +			goto end;
>  		}
>  	}
> =20
> -	return cm;
> -}
> +end:	return cm;
> =20
> -static void update_hdmi_timings(struct hdmi_config *cfg,
> -		struct omap_video_timings *timings, int code)
> -{
> -	cfg->timings.x_res =3D timings->x_res;
> -	cfg->timings.y_res =3D timings->y_res;
> -	cfg->timings.hbp =3D timings->hbp;
> -	cfg->timings.hfp =3D timings->hfp;
> -	cfg->timings.hsw =3D timings->hsw;
> -	cfg->timings.vbp =3D timings->vbp;
> -	cfg->timings.vfp =3D timings->vfp;
> -	cfg->timings.vsw =3D timings->vsw;
> -	cfg->timings.pixel_clock =3D timings->pixel_clock;
> -	cfg->timings.vsync_pol =3D cea_vesa_timings[code].timings.vsync_pol;
> -	cfg->timings.hsync_pol =3D cea_vesa_timings[code].timings.hsync_pol;
>  }
> =20
>  unsigned long hdmi_get_pixel_clock(void)
> @@ -325,7 +295,7 @@ static void hdmi_compute_pll(struct omap_dss_device *=
dssdev, int phy,
> =20
>  static int hdmi_power_on(struct omap_dss_device *dssdev)
>  {
> -	int r, code =3D 0;
> +	int r;
>  	struct omap_video_timings *p;
>  	unsigned long phy;
> =20
> @@ -341,8 +311,14 @@ static int hdmi_power_on(struct omap_dss_device *dss=
dev)
>  		dssdev->panel.timings.x_res,
>  		dssdev->panel.timings.y_res);
> =20
> -	code =3D get_timings_index();
> -	update_hdmi_timings(&hdmi.ip_data.cfg, p, code);
> +	hdmi.ip_data.cfg =3D *(hdmi_get_timings());
> +	if (hdmi.ip_data.cfg.timings.x_res =3D=3D 0) {

Here you should check if the function returns NULL, and use that to
decide if it failed or not.

> +		/* HDMI code 4 corresponds to 640 * 480 VGA */
> +		hdmi.code =3D 4;
> +		/* DVI mode 1 corresponds to HDMI 0 to DVI */
> +		hdmi.mode =3D HDMI_DVI;
> +		hdmi.ip_data.cfg =3D vesa_timings[0];
> +	}
=20
 Tomi


--=-ILrru3BBCa7TtAjL5I0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPAtK+AAoJEPo9qoy8lh71UjUP/iZacAKwfRC9IaRg+Rq/lSif
au9Y7hDdT5kFwAUpnt5M6g6GdtX5rYvBXwqFVRx0a89KpqIwBEcB50ix3nZ8HYRI
Y2WHtTVQvk901Ph4Pppy71oB13iWL30s2Suo1MWEsCYwruPKDmb5stvU6ZjPRKDs
k85Vt/+82yrxB0MrPOnFwSPtCtv2ntP0NvbcbSExCrfbxRPSrsK/0LUycTXMuY9p
WjkRc0crrQ6w9H57Fbswclgenps+BCTxa9l7LWSPXMACWvkOIYmWgfOg9SIoFHhQ
oLZnLoOiNXnEfqF7On0BcFXoLWfuXwBeNOTyxNnOwgggomWiALU8ubFA5Bm6lXyE
jOLepYv+dNadAZ9sg79TMhXVRt4qvyzI2Wo/4YitaKTNu66iP3LT+0r9uvq7LWhJ
pE9GFu3dff4V1JKGPtOPuqcbSVSbeWQ4DVS71d570mMTKGJnYtM2EqiKak8OaIs/
o48DtiughZ8hqokKboAe1KxihsO/FqTf5hotdRnn+j4JpFFMBlyGoIJ3UlVfPx4G
NbW9T2NNL52hSPMykr6Y/S3Kh6kdU9jv1Vzk4Ez1rVungxzASZX/FAIhlrZZjYel
AbahcNVeHuPaKaTofNwK+X4lQu6VC7nIUUcagal7lomnM98PyHRuRAmKz3cZyd3j
yNtzaliOUjse+YYANgsN
=QFB8
-----END PGP SIGNATURE-----

--=-ILrru3BBCa7TtAjL5I0H--

