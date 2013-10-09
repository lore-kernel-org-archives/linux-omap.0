From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Correctly compare timings
Date: Wed, 9 Oct 2013 11:30:46 +0300
Message-ID: <52551436.3090709@ti.com>
References: <1380825919.12133.10.camel@asus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0ufaPdVOEOu5mPE6NXOdnTLBbt4PNGcfh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747Ab3JIIas (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 04:30:48 -0400
In-Reply-To: <1380825919.12133.10.camel@asus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?= <richard.rojfors@gmail.com>, linux-omap@vger.kernel.org

--0ufaPdVOEOu5mPE6NXOdnTLBbt4PNGcfh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/13 21:45, Richard R=C3=B6jfors wrote:
> There is currently a copy and paste error where the hdmi vsync timings =
are not
> compared correctly, this patch fixes this.
>=20
> Signed-off-by: Richard R=C3=B6jfors <richard.rojfors@gmail.com>
> ---
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> index 82a9640..e3ea2d5 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -391,7 +391,7 @@ static bool hdmi_timings_compare(struct omap_video_=
timings *timing1,
>  		timing2_hsync =3D timing2->hfp + timing2->hsw + timing2->hbp;
>  		timing1_hsync =3D timing1->hfp + timing1->hsw + timing1->hbp;
>  		timing2_vsync =3D timing2->vfp + timing2->vsw + timing2->vbp;
> -		timing1_vsync =3D timing2->vfp + timing2->vsw + timing2->vbp;
> +		timing1_vsync =3D timing1->vfp + timing1->vsw + timing1->vbp;
> =20
>  		DSSDBG("timing1_hsync =3D %d timing1_vsync =3D %d"\
>  			"timing2_hsync =3D %d timing2_vsync =3D %d\n",
>=20

Thanks, queuing for 3.13.

 Tomi



--0ufaPdVOEOu5mPE6NXOdnTLBbt4PNGcfh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVRQ2AAoJEPo9qoy8lh71aNUQAKAiHnHohVyOCNyg0cr+vAFy
CpA2E96k3VLayR1Aaddv7tPs0RzlFcTi5z+GS8eABZZpUBIHN4Q07yRMbtdXfYQ5
vf3EPe9c89Ac4l0Pjl0W26qB9KoO2/6xEfRr9+boE4LMOLEd5Jd80DMBQerXcT6I
TI16wWFNgKVVnWHiaEXPmVJsvlsekYtSEXGk/s7BYj0LgfLuoOrrr98WVXN9yZLe
3mjvoAlxeRF8/9ZYHqwGncaiQocvIoDdj2KydcEzI4fG53qkGmmgvVRjy3oNxLTu
LbXqH/KJslZlrTfVfQejpdyUo8XChEChdgwmBx+xDRtcgmWU4OvMoo84avGLdAyo
moMASiqzXD7L0qtySdPC4DqHmOt7yqLhJjnhFyuOOiH29ENZUPid/bwR/dhvHIB5
OvcMKDgrJ5YKHkGuL185IELdPTYYFqlVOLLVmcUkV5GgN2bS5eWtjBAWvAViD+zK
NuC2FSY81UGJuueVsNzJz9sY9DC5U1JXX2LSuEC9ONSk/eT+P8mOCZ6a7VJvmwOY
dY//q/aXey1+N+7w5RMuFeUNt39HA+0PtNkMCGYWE6oAudTF+5px6G7hzLX5xT3a
jnHe89DCZw3xS4Gn0oEuIyZpoh0xOdxsomnHhKGn4FYpc/J3jTOXUHt3vsDCWdAa
y5lgWDEwmpgxolg7nApD
=TOEi
-----END PGP SIGNATURE-----

--0ufaPdVOEOu5mPE6NXOdnTLBbt4PNGcfh--
