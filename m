From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: OMAPFB: Fix possible null pointer dereferencing
Date: Mon, 19 Nov 2012 10:44:01 +0200
Message-ID: <50A9F151.3010607@ti.com>
References: <1353301815-21277-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90FD851EC1C168587686640B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33603 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146Ab2KSIoF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 03:44:05 -0500
In-Reply-To: <1353301815-21277-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-omap@vger.kernel.org, archit@ti.com, patches@linaro.org

--------------enig90FD851EC1C168587686640B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-19 07:10, Tushar Behera wrote:
> If display is NULL, display->output would lead to kernel panic.
>=20
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
> index 55a39be..532a31b 100644
> --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
> @@ -787,7 +787,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int =
cmd, unsigned long arg)
> =20
>  	case OMAPFB_WAITFORVSYNC:
>  		DBG("ioctl WAITFORVSYNC\n");
> -		if (!display && !display->output && !display->output->manager) {
> +		if (!display || !display->output || !display->output->manager) {
>  			r =3D -EINVAL;
>  			break;
>  		}
>=20

Thanks, good catch. However, the patch description is not very good.
If you agree with the change, I'll apply the patch with the description:


OMAPFB: Fix possible null pointer dereferencing                          =

                                                                         =

Commit 952cbaaa9b8beacc425f9aedf370468cbb737a2c (OMAPFB: Change          =

dssdev->manager references) added checks for OMAPFB_WAITFORVSYNC ioctl   =

to verify that the display, output and overlay manager exist. However,   =

the code erroneously uses && for each part, which means that             =

OMAPFB_WAITFORVSYNC may crash the kernel if no display, output or        =

manager is associated with the framebuffer.                              =

                                                                         =

This patch fixes the issue by using ||.                                  =



 Tomi



--------------enig90FD851EC1C168587686640B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqfFRAAoJEPo9qoy8lh71gnkP/3Tl03zSIaLDshMMAUk7fSjN
Nsp5hBYLIIVYUF6RyyFIqW0HD4cquP9hEojb9TvjaCiRrZ3HOokrQOEyQYvXGSnA
DFZu09CAWSi/e2a8hb2Y10i3D3mnXKmQLbjgwm8hRr+XgKInF55/9xcBHGN/IATY
gp04uP9YqfoYObtFJ+VyO887c7lQy2ccovJqaPHdQWJjJ/1l6sebhrQ2dcyJPm7Q
xZwafz5JDUSO6qD5A2eP6z80KnIEmwqe7PgR4ZlggqbL45xExTMvER1bA80qBT4D
di55FxBxj/nLrlpYU1Gy+ST8CI90gZ9XLtAbaguBkwJEmJ+nU2MiQukxONKjJPjZ
bjePz/WcfIuHxE7GHj6QZTxQE/i8EAuyX7iU+o4l4hGDqhMU9bpGgMvfcpYTSi3T
6Yikr1A9NeDTZ99PwLoxJkrJp3Fe+3mfMu/VA81gBBgnJv3ekPjDMRQ9WcVS4Dh7
UvImKsuC+tVTwqJ/J1SR9mIy36NXgaqu2mgXeSqQrGiAIYcD093sbacEUlgVByQ4
OoWHvMoMC7W5kA0jaqFwOhpxqpK9tXoZp4yDESiEyJw2fbcKz44/ox6/prKL/9MQ
+lklmw/hQuWQ6LDjLbkKdzkTLLFLdtUgXE7/TQ2Bf50IXoMORhzU1P9c9Qbx3JFi
jfpBHjVqRw3svyD0SpQY
=8off
-----END PGP SIGNATURE-----

--------------enig90FD851EC1C168587686640B--
