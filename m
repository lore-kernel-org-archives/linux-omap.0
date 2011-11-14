From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Mon, 14 Nov 2011 09:33:19 +0200
Message-ID: <1321255999.1931.18.camel@deskari>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
	 <1321016977-1808-2-git-send-email-mythripk@ti.com>
	 <1321016977-1808-3-git-send-email-mythripk@ti.com>
	 <1321016977-1808-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ldzANRkXOQC2gL8q3WJK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:59470 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236Ab1KNHd0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 02:33:26 -0500
Received: by bke11 with SMTP id 11so8054174bke.33
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 23:33:24 -0800 (PST)
In-Reply-To: <1321016977-1808-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-ldzANRkXOQC2gL8q3WJK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-11-11 at 18:39 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Change the timing match logic, Instead of the statically mapped method
> to get the corresponding timings for a given code and mode, move to a
> simpler array indexed method. It  will help to scale up to add more
> timings when needed.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |  162 ++++++++++++++++------------------=
-----
>  1 files changed, 67 insertions(+), 95 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index f76ae47..b859350 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -58,8 +58,6 @@
>  #define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
>  #define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
> =20
> -#define OMAP_HDMI_TIMINGS_NB			34
> -
>  #define HDMI_DEFAULT_REGN 16
>  #define HDMI_DEFAULT_REGM2 1
> =20
> @@ -88,7 +86,7 @@ static struct {
>   * map it to corresponding CEA or VESA index.
>   */
> =20
> -static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] =
=3D {
> +static const struct hdmi_config cea_timings[] =3D {
>  { {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDMI} },
>  { {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI} },
>  { {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_HDMI} },
> @@ -104,6 +102,8 @@ static const struct hdmi_config cea_vesa_timings[OMAP=
_HDMI_TIMINGS_NB] =3D {
>  { {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI_HDMI} =
},
>  { {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI_HDMI} =
},
>  { {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI_HDMI} =
},
> +};
> +static const struct hdmi_config vesa_timings[] =3D {
>  /* VESA From Here */
>  { {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DVI} },
>  { {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DVI} },
> @@ -126,39 +126,6 @@ static const struct hdmi_config cea_vesa_timings[OMA=
P_HDMI_TIMINGS_NB] =3D {
>  { {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDMI_DVI} =
}
>  };
> =20
> -/*
> - * This is a static mapping array which maps the timing values
> - * with corresponding CEA / VESA code
> - */
> -static const int code_index[OMAP_HDMI_TIMINGS_NB] =3D {
> -	1, 19, 4, 2, 37, 6, 21, 20, 5, 16, 17, 29, 31, 35, 32,
> -	/* <--15 CEA 17--> vesa*/
> -	4, 9, 0xE, 0x17, 0x1C, 0x27, 0x20, 0x23, 0x10, 0x2A,
> -	0X2F, 0x3A, 0X51, 0X52, 0x16, 0x29, 0x39, 0x1B
> -};
> -
> -/*
> - * This is reverse static mapping which maps the CEA / VESA code
> - * to the corresponding timing values
> - */
> -static const int code_cea[39] =3D {
> -	-1,  0,  3,  3,  2,  8,  5,  5, -1, -1,
> -	-1, -1, -1, -1, -1, -1,  9, 10, 10,  1,
> -	7,   6,  6, -1, -1, -1, -1, -1, -1, 11,
> -	11, 12, 14, -1, -1, 13, 13,  4,  4
> -};
> -
> -static const int code_vesa[85] =3D {
> -	-1, -1, -1, -1, 15, -1, -1, -1, -1, 16,
> -	-1, -1, -1, -1, 17, -1, 23, -1, -1, -1,
> -	-1, -1, 29, 18, -1, -1, -1, 32, 19, -1,
> -	-1, -1, 21, -1, -1, 22, -1, -1, -1, 20,
> -	-1, 30, 24, -1, -1, -1, -1, 25, -1, -1,
> -	-1, -1, -1, -1, -1, -1, -1, 31, 26, -1,
> -	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
> -	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
> -	-1, 27, 28, -1, 33};
> -
>  static int hdmi_runtime_get(void)
>  {
>  	int r;
> @@ -188,82 +155,88 @@ int hdmi_init_display(struct omap_dss_device *dssde=
v)
>  	return 0;
>  }
> =20
> -static int get_timings_index(void)
> +static bool hdmi_find_code(const struct hdmi_config *timings_arr,
> +			int len, struct hdmi_config *timing)
>  {
> -	int code;
> +	int i;
> =20
> -	if (hdmi.mode =3D=3D 0)
> -		code =3D code_vesa[hdmi.code];
> -	else
> -		code =3D code_cea[hdmi.code];
> +	for (i =3D 0; i < len; i++) {
> +		if (timings_arr[i].cm.code =3D=3D hdmi.code) {
> +			*timing =3D timings_arr[i];
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}

You could return the hdmi_config pointer instead of making a copy and
returning a bool.

You shouldn't use hdmi.code in this function, but get the code as a
parameter.

> =20
> -	if (code =3D=3D -1)	{
> +static void hdmi_get_timings(struct hdmi_config *timing)
> +{
> +	int r;
> +
> +	if (hdmi.mode =3D=3D 0) {
> +		r =3D hdmi_find_code(vesa_timings,
> +					ARRAY_SIZE(vesa_timings), timing);
> +	} else {
> +		r =3D  hdmi_find_code(cea_timings,
> +					ARRAY_SIZE(cea_timings), timing);
> +	}
> +	if (!r) {
>  		/* HDMI code 4 corresponds to 640 * 480 VGA */
>  		hdmi.code =3D 4;
>  		/* DVI mode 1 corresponds to HDMI 0 to DVI */
>  		hdmi.mode =3D HDMI_DVI;
> +		*timing =3D vesa_timings[0];
> +	}
> +}

Same thing here, you could just return the pointer to hdmi_config.

And also for this function you shouldn't use hdmi.mode and hdmi.code,
but they should be parameters to this function.

And the code in the error path shouldn't modify hdmi.code or hdmi.mode,
it should just return NULL, and the caller would then do what it wants,
in this case use VGA as a fallback.

> +
> +static bool hdmi_timings_compare(struct omap_video_timings *timing,
> +				const struct hdmi_video_timings *temp)

Don't call the second argument "temp". It's not a temporary variable.
Naming the parameters timing1 and timing2 would make much more sense.

 Tomi


--=-ldzANRkXOQC2gL8q3WJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOwMQ/AAoJEPo9qoy8lh71m6cP/RSXDygVN8qT0cOn/9jJQ9m1
Yjfg8U3KQRKEgxzIYTPR+EQVYZA77ztWWyVmBSvU5ez4TAmN95Ng7ZWPUH+8cjvY
rYEqfb71LV+mxm/z6Luwlb9znLn+jWi0gRMjVXTEtoTwWfrZh4alkFAsUonp5+J2
n5TM1fatuzvISZ2P/7M+Hh0bfkqZRzg7mozqLOatyiSbdNI8frl8/MGE+rvjkmpb
5D5FEiuU7OyUEof0pYy9vY9mxUAeAo7AOlusPbPj1z/drQTWvHsbls46GYeBX7sO
xTO+nsS0xXZlJZy5Drii8fnxaMWFQ5QZqTG0ANYilhhg87Mu7kdtXhwdevL77aPD
xwxwvx3L1DseHUKdzllCh91SYtCF+jsooqGBLHL3FNuMnUbMAeZK5uk6b3ccR4iF
7MxMFOlWvW5csMsKjHVeJx9LJLIid8xHqu381daNE++RpLaS7iew/pHehXLx7Uxn
diwTpol0t8wT6FjgrRdeq7V3jwR3yDXU3WJDGzlWMn3QEPcWNQopf6lbqtUzAeI2
+U7QAeWoA3El1GadoVR2ZxXHWC/EKpAQwy6VigbXnHl97kukZt3QtvOQVq5q+wux
eMzxby3uJAkaidi4gA4NT44aD6n5xMGK2W+LJsGZSSPy2VpWzS+x4CHNE5kktblj
G9dN6b4dQ4MIvBo236uD
=tLn3
-----END PGP SIGNATURE-----

--=-ldzANRkXOQC2gL8q3WJK--

