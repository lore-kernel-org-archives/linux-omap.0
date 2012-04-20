From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock
 usage
Date: Fri, 20 Apr 2012 17:29:13 +0300
Message-ID: <1334932153.2058.40.camel@deskari>
References: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
	 <1334928673-27943-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Hg9g5SFpsWqX50pmOy/3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50598 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756208Ab2DTO3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 10:29:18 -0400
Received: by lagr15 with SMTP id r15so14436270lag.16
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 07:29:15 -0700 (PDT)
In-Reply-To: <1334928673-27943-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Hg9g5SFpsWqX50pmOy/3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-04-20 at 19:01 +0530, Chandrabhanu Mahapatra wrote:
> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
> divisor LCD.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   25 +++++++++++++++++++------
>  drivers/video/omap2/dss/dss.h   |    1 +
>  2 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index 17ffa71..0417423 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1855,7 +1855,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane p=
lane,
>  			fclk =3D calc_fclk(channel, in_width, in_height,
>  					out_width, out_height);
>  			error =3D (in_width > maxsinglelinewidth || !fclk ||
> -				fclk > dispc_fclk_rate());
> +				fclk > dispc_core_clk_rate());

The patch is now otherwise fine, but I think it needs some more
renaming. Now the code mixes fclk and core-clk names, which is rather
confusing. I guess the calc_fclk should actually be calc_req_core_clk?
And the fclk variable core_clk (or cclk or something)?

 Tomi


--=-Hg9g5SFpsWqX50pmOy/3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPkXK5AAoJEPo9qoy8lh71a/8P/1JArtZKhdCMINwqBB/+QJFn
bVqv3CYj108wXW6HKNLcgsS/26vqJYWES44/DOpT59otzlr+utcrf5J9olWFWBm2
2bb38fFJCow8u88cCj0g7cfNMatMluRZw5xCoklE6jGwo4oOL5QYyX0Uu7WxG6vh
2aaFHgb/01NUvUzk63FbXsXDE+wetzbshBJvEqUQKbT5rCxQls0/cQtFEayIX31u
tJxl9fzdqMO7s5SraE8Sv8tkohZd7OlXDoE8rylbrKkdu5FNfrAfteaUBvahMctS
1I0KqKguZf4jX0iEqrp+YF+dSrhfbMeOfyhLTSPjW4QLF/KsVZO38r5hKKbjXmxF
kIUSqpekjsDhe/5jvv9PaoJ2NR4OPpkEUgoa0/mUl5nHCdPpXRAkSn5M48Uo5ToY
L7cJtx9hqZQxyHza4b4adjdhfy9f5+3cl3dRuH8RPDc0brlW1ahCKiJv5eEELLwi
sSmluVhzcR9vZ/sdLZgRyFhlBf9AhgBnIxbFyD8FT3DGnJ9DSEgev1oT0StWf3lF
NC3jgYy0bRE1ZpEa8j/OdTRt6YkhYp8XmmHVc3aVjkdhaGwMoj3GM3eP8ltlnHk6
xZqNoLx/5TBRGH+vfNDTAWtZF/yfBmRWkNWc18FWGiPrtPKOP5lbeGaYFHiljyZY
C7BYYOpJ93pZTUZbGfIo
=H0D1
-----END PGP SIGNATURE-----

--=-Hg9g5SFpsWqX50pmOy/3--

