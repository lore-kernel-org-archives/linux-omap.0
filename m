From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
Date: Wed, 15 Oct 2014 15:13:34 +0300
Message-ID: <543E64EE.4070104@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4TpcVPunbIQ9inEExOTE2bq1g6OPJh2F1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33266 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbaJOMOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 08:14:02 -0400
In-Reply-To: <1413311335-25083-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--4TpcVPunbIQ9inEExOTE2bq1g6OPJh2F1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/10/14 21:28, Felipe Balbi wrote:
> if we leave __exit annotation, driver can't be unbound
> through sysfs.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/v=
ideo/fbdev/omap2/omapfb/omapfb-main.c
> index ec2d132..9cbf1ce 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> @@ -2619,7 +2619,7 @@ err0:
>  	return r;
>  }
> =20
> -static int __exit omapfb_remove(struct platform_device *pdev)
> +static int omapfb_remove(struct platform_device *pdev)
>  {
>  	struct omapfb2_device *fbdev =3D platform_get_drvdata(pdev);
> =20
> @@ -2636,7 +2636,7 @@ static int __exit omapfb_remove(struct platform_d=
evice *pdev)
> =20
>  static struct platform_driver omapfb_driver =3D {
>  	.probe		=3D omapfb_probe,
> -	.remove         =3D __exit_p(omapfb_remove),
> +	.remove         =3D omapfb_remove,
>  	.driver         =3D {
>  		.name   =3D "omapfb",
>  		.owner  =3D THIS_MODULE,

Interesting. I don't know if I'm doing something funny, but without this
patch, I can unbind omapfb, kind of.

"echo omapfb > unbind" goes ok, but remove is obviously not called.
Somehow omapfb device is still unbound from the driver, as I can then
bind it again, causing probe to be called. Which breaks everything.

I would've thought that unbinding is not possible if remove is missing,
but that doesn't seem to be the case. I guess it just means that remove
is not called when the driver & device are unbound.

We have 18 __exit_p()s in omapdss and related drivers. I guess they are
all broken the same way.

Note that omapfb unbind & bind does not work even with this patch, but
results in a crash as some old state is left into omapdss. The same
happens also with unloading and loading omapfb module (but keeping
omapdss module loaded).

So there seems to be more issues around this.

 Tomi



--4TpcVPunbIQ9inEExOTE2bq1g6OPJh2F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPmTuAAoJEPo9qoy8lh71choP/3HQtsx2set1FOQsrLMrXjfO
WwsBfxJpjl+rfAAftq8TgJ/q+bCzpCxXEgfk5juDNuRk5W81z5gpYZnBjOQghNOk
XDDqqkIAksZY3F9b+WpiDXX7ei66cZQ45hAJllmXlxYz8raqzVDYq154cgH2aZ5f
/EMp4jjK3AFq0QjJBbO+USeWbZtxaHIMqre6/APThtWoLhaTZIupJ/V72aDuG3l7
1bBVY1i5GKBkoI7Nufohq7CArq7mbL611GFTv75YZoopsefqpfeFdzsjd/XbOwCn
yXqjnNbbAO5cR5p/azLgOrYqBMi0KAFzQJBWkOMgYX/+9JiEWYszYHJ/VuReB9E4
xD7CPa0ciR8UjkgoS024SfbijxzzFtehuPZHY6t4HfF3H7FRoh4Wsp0fKhxW0SKz
OFqrjtDHrtawkBRuTD84QtPnlxMwFtVOFktb55HTmUbT3fjnLbU65f7rojfphR43
6YGWER009+BSQaUVyKdeRTQGZDE5cV5V0MzTPtp6UAZSsCYP6jOxo7Z+PzlEkQwP
qFYJU3Wis5b80jV5wQTnonknvk3OUq0cfSWOT/u77+DU5EtuCXbO3+3C+DOIRbXa
W1IA8cpp09iULV7TG+19YEpZTYT3hee2yoRnjNFCBAsLXQENWBEf0FChsMH8KNt1
8QpM/X3lAtopnIMDXPjA
=xczO
-----END PGP SIGNATURE-----

--4TpcVPunbIQ9inEExOTE2bq1g6OPJh2F1--
