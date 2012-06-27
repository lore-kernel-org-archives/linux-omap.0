From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 17/17] OMAPDSS: DSI: Remove redundant fields in
 omap_dss_dsi_videomode_data
Date: Wed, 27 Jun 2012 15:05:46 +0300
Message-ID: <1340798746.2649.51.camel@deskari>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
	 <1340703414-1915-19-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JQAKqyUs8o/52/fHmkuW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55735 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755599Ab2F0MFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 08:05:50 -0400
Received: by lbon10 with SMTP id n10so1900555lbo.13
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 05:05:47 -0700 (PDT)
In-Reply-To: <1340703414-1915-19-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-JQAKqyUs8o/52/fHmkuW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
> The struct omap_dss_dsi_videomode_data holds polaritiy/logic level inform=
ation
> of the DISPC video port signals DE, HSYNC and VSYNC. This information alr=
eady
> exists in the omap_video_timings struct.
>=20
> Use the fields in omap_video_timings to program VP_DE_POL, VP_HSYNC_POL a=
nd
> VP_VSYNC_POL in DSI_CTRL. Remove the redundant fields in
> omap_dss_dsi_videomode_data.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dsi.c |   11 ++++++++---
>  include/video/omapdss.h       |    3 ---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.=
c
> index 061bf53..3844430 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -3628,13 +3628,18 @@ static void dsi_config_vp_num_line_buffers(struct=
 omap_dss_device *dssdev)
>  static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
>  {
>  	struct platform_device *dsidev =3D dsi_get_dsidev_from_dssdev(dssdev);
> -	int de_pol =3D dssdev->panel.dsi_vm_data.vp_de_pol;
> -	int hsync_pol =3D dssdev->panel.dsi_vm_data.vp_hsync_pol;
> -	int vsync_pol =3D dssdev->panel.dsi_vm_data.vp_vsync_pol;
> +	int de_pol, hsync_pol, vsync_pol;
> +	int de_level =3D dssdev->panel.timings.de_level;
> +	int hsync_level =3D dssdev->panel.timings.hsync_level;
> +	int vsync_level =3D dssdev->panel.timings.vsync_level;
>  	bool vsync_end =3D dssdev->panel.dsi_vm_data.vp_vsync_end;
>  	bool hsync_end =3D dssdev->panel.dsi_vm_data.vp_hsync_end;
>  	u32 r;
> =20
> +	de_pol =3D de_level =3D=3D OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
> +	hsync_pol =3D hsync_level =3D=3D OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
> +	vsync_pol =3D vsync_level =3D=3D OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
> +
>  	r =3D dsi_read_reg(dsidev, DSI_CTRL);
>  	r =3D FLD_MOD(r, de_pol, 9, 9);		/* VP_DE_POL */
>  	r =3D FLD_MOD(r, hsync_pol, 10, 10);	/* VP_HSYNC_POL */

This patch makes the code cleaner, but I find this DSI sync code a bit
strange.

The sync polarities between DISPC and DSI do not matter elsewhere, they
do not affect the DSI output, so why do we have them in the panel data?
Why doesn't dsi.c just use some hardcoded values for these.

 Tomi


--=-JQAKqyUs8o/52/fHmkuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6vcaAAoJEPo9qoy8lh71dRsQAJwvE4Uh55XMgT4LJ+he+4+W
9d6mjY363QwQu1PYIeO5F2tQBVUycwHgH3ksDXGBCiqaX/Ixhpm2/y6ugh7w9DDn
zjQNdNdiJP1MNuvJZIZWpRdPjR/LMUR/DWOcKgpX4NBBnsunKekLY3cfBYatwRmF
HbkpQbiRMH5ifm6ZwHMYk8WZSuzPHTwVM2tdQh1BHQsUVpAUoX3AVV5t1/PBiAOd
5XQeg1DjO71dsSPfNmELh3BRwT2OPW22U0jl8pKzo0/Wg+twwMgmJ7RqiuIUdoLy
DvvvL+fM8UbS1pWyvI25t+mh7T7Dgms40u3LMBVMfGFa+mjO7GjsurjKKkWbsGJD
+EibYqPXsMgXJdyQnHIy1YzjVCKgZGMxtdBKDztCJMCYAwfZ0oPil9nPQAht+nJb
L1twPyB3cKhc9b+560pRpmRJ5OgKm7E3o1CZ1XLFDZyQec+uKiXSVIc4df8M1AlB
i6luIcBVuHxYCMw6pTxKIRMp82/X/LCzjQyT/pVWO7Jk1IkdV+galqPBJA7YZAnE
NGwqTUvJEox16wRFD/o4Kdxvq6A/4D2q7UxGJCL/bP9/kkI5PVBgRNiR+W0e5ORz
NQ3pC5CwQA/5bbcykKohxF10JPgEDpVs6ti3vthPNjNdQFUTJXxeqgjbUbkpUGAF
dklxk/w3vX5TePeAiaH6
=F0xd
-----END PGP SIGNATURE-----

--=-JQAKqyUs8o/52/fHmkuW--

