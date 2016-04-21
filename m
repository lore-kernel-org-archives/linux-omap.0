From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI5: Fix AVI infoframe
Date: Thu, 21 Apr 2016 17:43:50 +0300
Message-ID: <5718E726.4020504@ti.com>
References: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EkukSHN5gwlR3hJ8f4gIK1MDwT0t4nsBB"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com
Cc: "Lodes, Jim" <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

--EkukSHN5gwlR3hJ8f4gIK1MDwT0t4nsBB
Content-Type: multipart/mixed; boundary="7EAituEikVxD754tlQRS1IW3WjCX42MA3"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com
Cc: "Lodes, Jim" <jim.lodes@garmin.com>,
 "J.D. Schroeder" <jay.schroeder@garmin.com>
Message-ID: <5718E726.4020504@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI5: Fix AVI infoframe
References: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
In-Reply-To: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>

--7EAituEikVxD754tlQRS1IW3WjCX42MA3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 21/04/16 16:48, J.D. Schroeder wrote:
> From: "Lodes, Jim" <jim.lodes@garmin.com>
>=20
> The AVI infoframe R0-R3 in the 2nd data byte represents the
> Active Format Aspect Ratio. It is four bits long not two bits.
> This fixes that mask used to extract the bits before writing the
> bits to the hardware registers.
>=20
> Signed-off-by: Lodes, Jim <jim.lodes@garmin.com>
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>

Thanks, looks good. Can you fix the email here too, and resend?

 Tomi

>  drivers/gpu/drm/omapdrm/dss/hdmi5_core.c          | 2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm=
/omapdrm/dss/hdmi5_core.c
> index d993f78..8ab2093 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
> @@ -458,7 +458,7 @@ static void hdmi_core_write_avi_infoframe(struct hd=
mi_core_data *core,
> =20
>  	c =3D (ptr[1] >> 6) & 0x3;
>  	m =3D (ptr[1] >> 4) & 0x3;
> -	r =3D (ptr[1] >> 0) & 0x3;
> +	r =3D (ptr[1] >> 0) & 0xf;
> =20
>  	itc =3D (ptr[2] >> 7) & 0x1;
>  	ec =3D (ptr[2] >> 4) & 0x7;
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/driver=
s/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
> index f3e4b81..bbfe7e2 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
> @@ -442,7 +442,7 @@ static void hdmi_core_write_avi_infoframe(struct hd=
mi_core_data *core,
> =20
>  	c =3D (ptr[1] >> 6) & 0x3;
>  	m =3D (ptr[1] >> 4) & 0x3;
> -	r =3D (ptr[1] >> 0) & 0x3;
> +	r =3D (ptr[1] >> 0) & 0xf;
> =20
>  	itc =3D (ptr[2] >> 7) & 0x1;
>  	ec =3D (ptr[2] >> 4) & 0x7;
>=20


--7EAituEikVxD754tlQRS1IW3WjCX42MA3--

--EkukSHN5gwlR3hJ8f4gIK1MDwT0t4nsBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXGOcmAAoJEPo9qoy8lh71cxQP/RnDCFXT2BvdtUa4JXPxuCil
LPXC4G2LUMqGmN1z9Mw6lCPI46ILDOSDYDdI/9/HG/hLVuNjebkIgVDgRD3O2fpm
QgIM0v1Z32zg8vl12nNJ6c9xwQjQsbJHbBTLdxyd2YGterSHvWv1+1NRRP4l7UhR
yQ1jb/OEwIYDs+Ba9PjC4Zd4G1ZhZKMZidp/0ILLJx6e+fTxTBYxJh+ASJENen14
LkpJlB3oaLK6YBwe0a1pYb7h8ssbO0wNYegt8xi+yZAaAo6mF+nT+KXl16b+c8Ib
GhareJZDwOg1Ze06r8H+pRFr76rKHYI0UJk9xdzCILvECa1cYKLntkEBtLDfshyT
p1/mFzLfY5NeQo1A64oxhHw/IC2RYAENO61OvCsAp+OkMSzrMXDpLIZX98Z8iU/2
m8or/XejoHhZHN6t8kUyni0OInlX9jAoQHz+r64U/FnB/BrmbBxrFd7fWpb5M9NT
6NTMsdd3n47sWdOJttZZIJvRm0MQ5HfJFgbl1CqPofw96oADo/sx7ueCk+WSnFq8
uObzD1FyyPe1JuRvlzfgylnzirx7XwQhBqmU4LiURu2AUq8Hc/GbEg4uGvdijTWn
WqKNfp4mzV08+BWvZFSGvsSjZ1Xevk9mDTNCUp5KCQ/gQ/5CpmswEBSZZ1wu8RiC
OfiEiUBFrMxrAF0GBDNV
=zPSs
-----END PGP SIGNATURE-----

--EkukSHN5gwlR3hJ8f4gIK1MDwT0t4nsBB--
