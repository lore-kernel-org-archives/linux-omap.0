From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 3/3] OMAPDSS: DISPC: Correct DISPC functional clock
 usage
Date: Tue, 27 Mar 2012 14:03:35 +0300
Message-ID: <1332846215.1867.130.camel@deskari>
References: <1332323530-9088-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9YAtgOjyhCHdhHZ1ymVO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:33678 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750707Ab2C0LDl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 07:03:41 -0400
Received: by lbbgi4 with SMTP id gi4so6318541lbb.34
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 04:03:38 -0700 (PDT)
In-Reply-To: <1332323530-9088-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-9YAtgOjyhCHdhHZ1ymVO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-21 at 15:22 +0530, Chandrabhanu Mahapatra wrote:
> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
> divisor LCD.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index d8a1672..1fdac73 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1761,6 +1761,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane p=
lane,
>  				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
>  	const int max_decim_limit =3D 16;
>  	unsigned long fclk =3D 0;
> +	unsigned long dispc_core_clk =3D dispc_mgr_lclk_rate(channel);

Hmm, I don't think this is correct. dispc_mgr_lclk_rate() returns the
logic clock for the LCD output path. It's not DISPC core clock.

 Tomi


--=-9YAtgOjyhCHdhHZ1ymVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZ6HAAoJEPo9qoy8lh71HLQP/3o8FYs/R2LelzYDnJ1WguIQ
PZtObi477Np3+ZXN3nT+h3dJywf6KQjWm/VXWbrl/9oynjU0QHEXxuIXYvskrfcH
XNG8Noal6VHaNhcGUlGW827Z+bMGaW0TpUcOgL4AgTMooKJ0UkpkVvOJDKhizhmE
jRQp9tiEC3R91/6fRHWEKqoyQTu/9rtPF/o1X/jYKuNIt+UVeyeQu5HP0UPkSc4A
X9HR7l9e/Ue7yboKn3g9kQLBKNaL7N/7fDBbmKJKzhTv20IsKO409q75cCPVUJAj
QB+4ovbDN3gzXktycp0n5theNRjpBj4xkEfovjpCmwJHBf1jFovJiYJ7Vg72I4va
HWpe5t7Bp6wSX90+a6byIWTjU3SYWwJnt7cV8KF+PPuZ4QWqKGypfb6pzap73zDh
eqQ9jcCPRFRTNLNOBJZz4PPEBOYuKwkWYygrBT7pOP/K+VauLciIYBUeYMFQKSWE
6r/h7r3ibG/WpjxaGf8hT2ljEUfFcNuwUl9B4K78/TgR+QDK7RHTHZBRUcUDRyhw
0n5LB931qSzoi/y4pAEZk3ssl6AqYX/aC8plf+62ZePy42JPwT96Ayiv/qkEiWGj
tEXjpIYwYBXxvlXHog+dAN6Q5PWUXVmLvSFLxmezFd+/gtAZ05nlGHGluAQN4Yhi
5vYSt6iN0WQ1oqN4wmcw
=9ZS/
-----END PGP SIGNATURE-----

--=-9YAtgOjyhCHdhHZ1ymVO--

