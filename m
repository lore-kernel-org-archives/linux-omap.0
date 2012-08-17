From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] OMAPDSS: APPLY: Remove omap_dss_device references
 in wait_for_go functions
Date: Fri, 17 Aug 2012 15:35:06 +0300
Message-ID: <1345206906.3158.113.camel@deskari>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	 <1345200551-28712-1-git-send-email-archit@ti.com>
	 <1345200551-28712-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Rn6b7eMBWnF9ArPDslC0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53806 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756420Ab2HQMfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 08:35:14 -0400
Received: by lbbgk8 with SMTP id gk8so2518288lbb.13
        for <linux-omap@vger.kernel.org>; Fri, 17 Aug 2012 05:35:11 -0700 (PDT)
In-Reply-To: <1345200551-28712-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Rn6b7eMBWnF9ArPDslC0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-17 at 16:19 +0530, Archit Taneja wrote:
> The functions dss_mgr_wait_for_go() and dss_mgr_wait_for_go_ovl() check i=
f there
> is an enabled display connected to the manager before trying to see the s=
tate of
> the GO bit.
>=20
> The checks related to the display can be replaced by checking the state o=
f the
> manager, i.e, whether the manager is enabled or not. This makes more sens=
e than
> checking with the connected display as the GO bit behaviour is more conne=
cted
> with the manager state rather than the display state. A GO bit can only b=
e set
> if the manager is enabled. If a manager isn't enabled, we can safely assu=
me that
> the GO bit is not set.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/apply.c |   32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/ap=
ply.c
> index 52a5940..74f1a58 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -424,17 +424,23 @@ static void wait_pending_extra_info_updates(void)
>  int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
>  {
>  	unsigned long timeout =3D msecs_to_jiffies(500);
> -	struct mgr_priv_data *mp;
> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
>  	u32 irq;
> +	unsigned long flags;
>  	int r;
>  	int i;
> -	struct omap_dss_device *dssdev =3D mgr->device;
> =20
> -	if (!dssdev || dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> +	if (mgr_manual_update(mgr))

This needs to be inside the spinlock also.

>  		return 0;
> =20
> -	if (mgr_manual_update(mgr))
> +	spin_lock_irqsave(&data_lock, flags);
> +
> +	if (!mp->enabled) {
> +		spin_unlock_irqrestore(&data_lock, flags);
>  		return 0;
> +	}
> +
> +	spin_unlock_irqrestore(&data_lock, flags);
> =20
>  	r =3D dispc_runtime_get();
>  	if (r)
> @@ -442,10 +448,8 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager =
*mgr)
> =20
>  	irq =3D dispc_mgr_get_vsync_irq(mgr->id);
> =20
> -	mp =3D get_mgr_priv(mgr);
>  	i =3D 0;
>  	while (1) {
> -		unsigned long flags;
>  		bool shadow_dirty, dirty;
> =20
>  		spin_lock_irqsave(&data_lock, flags);
> @@ -489,21 +493,28 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ov=
l)
>  {
>  	unsigned long timeout =3D msecs_to_jiffies(500);
>  	struct ovl_priv_data *op;
> -	struct omap_dss_device *dssdev;
> +	struct mgr_priv_data *mp;
>  	u32 irq;
> +	unsigned long flags;
>  	int r;
>  	int i;
> =20
>  	if (!ovl->manager)
>  		return 0;

And this should be inside spinlock (yes, you didn't change that, but now
that you're changing these... =3D)
=20
> -	dssdev =3D ovl->manager->device;
> +	mp =3D get_mgr_priv(ovl->manager);
> =20
> -	if (!dssdev || dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> +	if (ovl_manual_update(ovl))

Inside spinlock here too.

Actually, shouldn't the whole wait_for functions be locked with the
apply mutex? Otherwise the output can be disabled/changed while waiting.

On the other hand, that could be quite a long lock, and I don't see
anything in the code that could really break if the output is disabled
or similar. Perhaps it's fine to just hit the timeout in case something
has been changed. If we add a mutex, we risk breaking something that
currently works =3D).

 Tomi


--=-Rn6b7eMBWnF9ArPDslC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLjp6AAoJEPo9qoy8lh718ycP/idP3h30sgw8q6KABZNvWfEU
rbcGlDKCziELZcnEd+YgRJAD8hSRywwfJa1GEAwa+8kqKBlRRdIy7pHHdBT1UQJb
eH0R1sMYjDa6uPnSlsBWf6gNVDUFbV1j4oj5TQtjanQrArP7nd543tORSzzqoQJk
gCpEuK5mmph5ei4LYHEsJo6xq0CdHknmFl//tRhNSm5YAsZcjgsQj8pOpSLC4WZm
bJ9Zbd/DSBsmW2HyLzSAZITxeS9jQSnL9cpzT/YAUbOgFTPNqXa1AvdqzJvgatiW
Z7TJg+TJQRnYqNO0/KDxoqJ2RkS7PcgTXnctSmpa0ZERdezucjTpkHVxlnOzULaO
ECwtIEF8H0tmNMoaEi2/jCkYdiA514fLN9exKw6ANGp/Zz61Dg2JrFtGEG9PV/Gh
HeQy3FtL87ZtD9IdRTPvF0CMAhPxecutlkdmo1nkK3AfgxpPqzR7UJJAr2Y/Frdh
Rtom6u4IlDaT+rLW1epbbCLoLyhreq/KsscmwgOOJ41nqmq/w63SnU3v60x+VEYu
4Rgs0LnmNbFTpn7MuavxBFwAtZlkV08fQHjcvWKpwILJoRnBz2N2cmHL7j8YKhHh
WdBDfvrm5LmO5JtvDFnppTZG2TH+qFVSFDWa0EvASomcEMBj3UYEb3d36l0vIS/W
+pvgI0vYKXrJb4q3Zq1N
=AwDG
-----END PGP SIGNATURE-----

--=-Rn6b7eMBWnF9ArPDslC0--

