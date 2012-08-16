From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: VENC: Maintian copy of video output
 polarity in private data
Date: Thu, 16 Aug 2012 14:38:38 +0300
Message-ID: <1345117118.15132.7.camel@lappyti>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	 <1345102594-6222-1-git-send-email-archit@ti.com>
	 <1345102594-6222-7-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-9PMbwUd2vYiJiCXT93Yn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48371 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071Ab2HPLio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 07:38:44 -0400
Received: by lahc1 with SMTP id c1so1483616lah.26
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 04:38:42 -0700 (PDT)
In-Reply-To: <1345102594-6222-7-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-9PMbwUd2vYiJiCXT93Yn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
> The VENC driver currently relies on the omap_dss_device struct to configu=
re the
> video output polarity. This makes the VENC interface driver dependent on =
the
> omap_dss_device struct.
>=20
> Make the VENC driver data maintain it's own polarity field. A panel drive=
r
> is expected to call omapdss_venc_set_vid_out_polarity() before enabling t=
he
> interface.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dss.h        |    2 ++
>  drivers/video/omap2/dss/venc.c       |   13 ++++++++++++-
>  drivers/video/omap2/dss/venc_panel.c |    6 ++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index c17d298..b2cf5530 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -479,6 +479,8 @@ u32 omapdss_venc_get_wss(struct omap_dss_device *dssd=
ev);
>  int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
>  void omapdss_venc_set_type(struct omap_dss_device *dssdev,
>  		enum omap_dss_venc_type type);
> +void omapdss_venc_set_vid_out_polarity(struct omap_dss_device *dssdev,
> +		enum omap_dss_signal_level vid_out_pol);
>  int venc_panel_init(void);
>  void venc_panel_exit(void);
> =20
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/ven=
c.c
> index 2d90fcf..8cb372f 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -303,6 +303,7 @@ static struct {
> =20
>  	struct omap_video_timings timings;
>  	enum omap_dss_venc_type type;
> +	enum omap_dss_signal_level vid_out_pol;
>  } venc;
> =20
>  static inline void venc_write_reg(int idx, u32 val)
> @@ -447,7 +448,7 @@ static int venc_power_on(struct omap_dss_device *dssd=
ev)
>  	else /* S-Video */
>  		l |=3D (1 << 0) | (1 << 2);
> =20
> -	if (dssdev->phy.venc.invert_polarity =3D=3D false)
> +	if (venc.vid_out_pol =3D=3D OMAPDSS_SIG_ACTIVE_HIGH)
>  		l |=3D 1 << 3;

Are you sure this is correct? I know practically nothing about analog
TV, but the TRM doesn't seem to say much about that bit, except it can
be used to "invert the video output". It doesn't say there's an
active/inactive level for the signal.

 Tomi


--=-9PMbwUd2vYiJiCXT93Yn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLNu+AAoJEPo9qoy8lh717vgP/37PJrnjBOgiqwH78UUXRnFO
FRzGGKeiA59nCg0gBtP/Pps9uOKbmg0ue8jSfq3TO+aidckSLSUt8smMQedJOmVj
aCGPVc4oRAy/6lotI92eDKv4Jwgbl5xxflEeDMuODP4i/OhbVLe/PHHWzAomsbZ4
TOact4UTQFRIRTmqIEg4GX9s9FxxvzxAcjq40Nc6nkwFRCmrEfVXI/iZoqaBLCZF
PmtEMKLEkGVYQ+7FdX+7KiN2lQAII4sEbVS8fp721/jCEygNBC1HNjejth8CiMYX
cNovbBzL6N9uPsk+g+CkWx9i+DpYlshmHJCgdDWo3Ch+TE4myyJrgjDW6Xpu7zWm
DuIgUWhxTqQmtKZtKkfVHrGc23uwUoaHNLcAAdY7amNqMBVaCT9zBmILEXt788wq
U+bp2Z4YqVkRd7nonfVLYO30iF/K4m10b1cRFHlZEdi08nn7mv2JnNje03GgHLUW
WuRzcfTItGL7Ov0tXaE5lEy9sotfarw8F0Be8i4ObmIvtyXNMHOuzNBpcbxzxymy
BGGPLm6sJZRBh/E/xjN6XMV6pgRdVTWSOIIkmbnyG0tBdH70nGFkOnDgVlNp1SVF
pgpBn2hU6JyhJS1VgAECjL8t7kjVuu5uy5tHQOQRfzMLEIpsvWFXURtvsDA5V/Iy
C9hjfc0c8RXtQiZ9pCzn
=U6O4
-----END PGP SIGNATURE-----

--=-9PMbwUd2vYiJiCXT93Yn--

