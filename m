From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] staging: drm/omap: remove reclaim_buffers callback
Date: Wed, 01 Aug 2012 14:51:33 +0200
Message-ID: <1343825493.2719.41.camel@mattotaupa>
References: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-fjWnVFUK6FLtbEkKl5Vk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:40742 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab2HAMvr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 08:51:47 -0400
In-Reply-To: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: greg@kroah.com, rob@ti.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-fjWnVFUK6FLtbEkKl5Vk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 01.08.2012, 15:02 +0530 schrieb Chandrabhanu Mahapatra:
> The reclaim_buffers callback has already been removed by Daniel Vetter
> <daniel.vetter@ffwll.ch> with his patch "drm: kill reclaim_buffers callba=
ck"

Please add the first eight characters of the commit hash behind the
summary in parentheses.

> for which the kernel compilation fails with omapdrm support. So, the call=
back
> for reclaim_buffers is removed from omapdrm.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/staging/omapdrm/omap_drv.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm=
/omap_drv.c
> index 342645a..b8e79eb 100644
> --- a/drivers/staging/omapdrm/omap_drv.c
> +++ b/drivers/staging/omapdrm/omap_drv.c
> @@ -778,7 +778,6 @@ static struct drm_driver omap_drm_driver =3D {
>  		.irq_postinstall =3D dev_irq_postinstall,
>  		.irq_uninstall =3D dev_irq_uninstall,
>  		.irq_handler =3D dev_irq_handler,
> -		.reclaim_buffers =3D drm_core_reclaim_buffers,
>  #ifdef CONFIG_DEBUG_FS
>  		.debugfs_init =3D omap_debugfs_init,
>  		.debugfs_cleanup =3D omap_debugfs_cleanup,

Acked-by: Paul Menzel <paulepanter@users.sourceforge.net>


Thanks,

Paul

--=-fjWnVFUK6FLtbEkKl5Vk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlAZJlUACgkQPX1aK2wOHVjrdwCfWem5v8yyBkpBwQnLAxvXrhBw
uaAAnAsxzxtfmZUyjdcAUR8fZ2aWAVcF
=XGSV
-----END PGP SIGNATURE-----

--=-fjWnVFUK6FLtbEkKl5Vk--

