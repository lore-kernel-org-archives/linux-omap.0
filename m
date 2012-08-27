From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Correct DISPC_IRQ bit definitions for LCD3
Date: Mon, 27 Aug 2012 12:26:25 +0300
Message-ID: <1346059585.14793.3.camel@deskari>
References: <1346057599-5691-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2zUeJOOQurMEIzlMzr1G"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40356 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753057Ab2H0J0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 05:26:31 -0400
Received: by lage12 with SMTP id e12so3802333lag.27
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 02:26:28 -0700 (PDT)
In-Reply-To: <1346057599-5691-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: mark.tyler@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-2zUeJOOQurMEIzlMzr1G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-27 at 14:23 +0530, Chandrabhanu Mahapatra wrote:
> The DISPC_IRQ bit definitions pertaining to channel LCD3 as DISPC_IRQ_VSY=
NC3,
> DISPC_IRQ_SYNC_LOST3, DISPC_IRQ_ACBIAS_COUNT_STAT3 AND DISPC_IRQ_FRAMEDON=
E3
> which were incorrectly set in previous LCD3 patches have been corrected h=
ere.
>=20
> Reported-by: Mark Tyler <mark.tyler@ti.com>
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  include/video/omapdss.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index b868123..9c7cca3 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -48,10 +48,10 @@
>  #define DISPC_IRQ_FRAMEDONEWB		(1 << 23)
>  #define DISPC_IRQ_FRAMEDONETV		(1 << 24)
>  #define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
> -#define DISPC_IRQ_FRAMEDONE3		(1 << 26)
> -#define DISPC_IRQ_VSYNC3		(1 << 27)
> -#define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 28)
> -#define DISPC_IRQ_SYNC_LOST3		(1 << 29)
> +#define DISPC_IRQ_SYNC_LOST3		(1 << 27)
> +#define DISPC_IRQ_VSYNC3		(1 << 28)
> +#define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 29)
> +#define DISPC_IRQ_FRAMEDONE3		(1 << 30)
> =20
>  struct omap_dss_device;
>  struct omap_overlay_manager;

Thanks, applied.

 Tomi


--=-2zUeJOOQurMEIzlMzr1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQOz1BAAoJEPo9qoy8lh71qcsP/3665t0xNTtTW3kik3D/Tq/X
YODsDaW/KL6N4DIv97k5PuN7pYOzCfVoID0WLbpYnI3FTN1MzhYxG7Bjj/8egKkT
sAbOa9tTYsUFm9AxVyXxruOmz7Qn4CiUGQw8bOpODpK3V9pq6ivm3apozymypgQG
hP/cnyDqbahhj1AjU0mfzOZe98/idq4yhrhKeY7EJLp1dYePJn3YWqK18IFdSJSZ
37T2TZlXzfzftkOhC2fBx3vCl59f51jAzi2gisC66bBIakjN+NE7C02HlVn4gMdu
3iq/yH+DPFVJc/9tEsybA1skfwfPsd16lmO9tAoMJDcaJGZf+Z8XQP9/gbMYAY2l
9h6Byv6hAqMn6t7iP4H4c/3ycowG1fhAtgwsvpf/fV+xH4YhbEyrT3F1juf7QqfU
rD9VfaYzmNnFypigAkRNkhpH/isoJgB9U4MLAGEjzfH4GD/3ylDFEnts2BIi8zLw
cUwfMDAkr6zwYZY5Bi87cVEMDkQYx90s0HxmkRxIy+dpnL9I5XETbFHa+O83jcb7
1OffU3BDe6aSH2IG4YiGwpxpbCleOsU9LWBLbemMGETfvxoqVv3HEHvgnMgoEidf
W81lWzc6ufk/xtec9/ehS664EYAKkaRc66Y4tC/Ku1jSCNKgDLa2QHtU+I0UQ9LO
H4tCSd+ejqO8+OYHiiVp
=KL/o
-----END PGP SIGNATURE-----

--=-2zUeJOOQurMEIzlMzr1G--

