From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 2/5] OMAPDSS: Apply manager timings instead of direct
 DISPC writes
Date: Tue, 08 May 2012 13:59:34 +0300
Message-ID: <1336474774.1821.11.camel@lappyti>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1336471096-21096-1-git-send-email-archit@ti.com>
	 <1336471096-21096-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zpeLCVdseGYKmsiAlkW8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:43433 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951Ab2EHK7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 06:59:40 -0400
Received: by lagy4 with SMTP id y4so2649900lag.1
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 03:59:37 -0700 (PDT)
In-Reply-To: <1336471096-21096-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-zpeLCVdseGYKmsiAlkW8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 15:28 +0530, Archit Taneja wrote:
> Replace the function dispc_mgr_set_timings() with dss_mgr_set_timings() i=
n the
> interface drivers. The latter function ensures that the timing related DI=
SPC
> registers are configured according to the shadow register programming mod=
el.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dpi.c  |    2 +-
>  drivers/video/omap2/dss/dsi.c  |    5 ++---
>  drivers/video/omap2/dss/hdmi.c |    2 +-
>  drivers/video/omap2/dss/rfbi.c |    4 ++--
>  drivers/video/omap2/dss/sdi.c  |    2 +-
>  drivers/video/omap2/dss/venc.c |    2 +-
>  6 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.=
c
> index cec1166..5d84ab0 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -156,7 +156,7 @@ static int dpi_set_mode(struct omap_dss_device *dssde=
v)
>  		t->pixel_clock =3D pck;
>  	}
> =20
> -	dispc_mgr_set_timings(dssdev->manager->id, t);
> +	dss_mgr_set_timings(dssdev->manager, t);
> =20
>  	return 0;
>  }

I think you can now remove the dispc_mgr_go() from dpi.c in this patch.

And something else, which doesn't need to be fixed now, but just to
point out: dpi_set_timings() currently uses runtime_get to enable the
HW. If everything was in proper shape, this wouldn't be needed.
dpi_set_timings() would call apply.c's functions, and if the output is
disabled, the settings would just be stored in ram. So there wouldn't be
any need to enable the HW with runtime_get().

Then again, if we do change clock settings or non-shadow registers in
dpi_set_timings(), then that's not possible (at least via apply.c's
caching system).

 Tomi


--=-zpeLCVdseGYKmsiAlkW8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqPyWAAoJEPo9qoy8lh71waMQAJ45qCJa5XzxSeWRG9pEPvbF
b/r7n4XLaS9zPDvSDatETUJ+s7ax4tXgEhrq232g4OMA3PePnXVc5P0+Zh4AMeSD
ceQuDatVl7BGXpJuFPSICNh1DLZ6Fz77vY0OWxhlmZMZvmmmm8dY75LhuOGXfzGW
Nnt1uKslL9+EpX8UDkbeqPwKYg4w5xpSnZyRvo2ap4mF3FH4wFmw6qK2+gifHYbc
2n+zVw+ScZKdyw8BZuSVUg/xGX8G60I63wGsWvuBho640QUI1n6lISNeffLEvt9j
nvMlWOoEmHi6mv+r63Rk023PyaTvPskC6ylH8Z0qwmwkHN1xMkzrnQrd8BGnMlnN
e8ZEn7o+7XCLmcxfdYa2hBeErkv75VR1Fkln0638Y8+AHFcw+hhDTvrgUVv3hTjW
UQ++1xrdmH0nxF8Ayb52Qp7zfLUaydccJnrLQ2s21XP2EkPv3jiJ5lUgj9DcrM1o
FJ30gFY7keBU+jw+z/flMbI/Qg8QANUqX8ERWm+x4EVqiK1LkVbm0wNj0KtLtADi
66rl+rrBzgEMDqnxmFKBqR/PMRphqpRh1V2snOuXq6G70OTHVe7GFfnXrqLUMoLt
xai1hmTCE16zbFyD1SxveSFJ31QW/b6eujnxoaBG2dGSyzEpyX/VgYl3a7OjtqZa
mpj+xLcGAT4T+qaevx1U
=uoN5
-----END PGP SIGNATURE-----

--=-zpeLCVdseGYKmsiAlkW8--

