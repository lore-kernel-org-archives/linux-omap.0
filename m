From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] drm: omap: disconnect devices when omapdrm module
 is removed
Date: Thu, 19 Sep 2013 13:08:07 +0300
Message-ID: <523ACD07.5020406@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <1379580585-18364-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TQWq9ehpqA6q9cttd32uRmJoWW8m6J5eu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab3ISKIL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Sep 2013 06:08:11 -0400
In-Reply-To: <1379580585-18364-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

--TQWq9ehpqA6q9cttd32uRmJoWW8m6J5eu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/09/13 11:49, Archit Taneja wrote:
> omapdrm established connections for omap_dss_device devices when probed=
=2E It
> should also be responsible to disconnect the devices. Keeping the devic=
es
> connected can prevent the panel driver modules from unloading, it can a=
lso
> cause problems when omapdrm is re-inserted.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_drv.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapd=
rm/omap_drv.c
> index 45fbb1c..44a1203 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -86,6 +86,13 @@ static bool channel_used(struct drm_device *dev, enu=
m omap_channel channel)
> =20
>  	return false;
>  }
> +static void omap_disconnect_dssdevs(void)
> +{
> +	struct omap_dss_device *dssdev =3D NULL;
> +
> +	for_each_dss_dev(dssdev)
> +		dssdev->driver->disconnect(dssdev);
> +}

With a quick test, it looks like omapdrm leaves the displays enabled
when exiting. This can be fixed by adding to the above loop:

		if (dssdev->state !=3D OMAP_DSS_DISPLAY_DISABLED)
			dssdev->driver->disable(dssdev);

However... omapdrm still crashes when unloading, and it could be somehow
related to leaving something un-removed. Disabling a CRTC should disable
the display, and maybe omapdrm should disable (and clean-up) all CRTCs
on exit, and maybe that would remove the crash, and also fix the issue
of leaving displays enabled.

But I'm just guessing there, I have no idea how the process of unloading
a drm driver goes.

 Tomi



--TQWq9ehpqA6q9cttd32uRmJoWW8m6J5eu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSOs0HAAoJEPo9qoy8lh71bwwP+gNnAEJkCVUfthH3BuAcfeoq
rc50m4/JlzM2pf/ujqLq1+3qo5U2YmkawuOu3pN8Ien6KTAq5SkhWha+pDIMaW7t
POWKrSFy6uKZKpQlcMuKuRWbVCy32pp8zVKs+0ByTRRpq09OXrG2oDMIBTg2IA2c
jqDbH1Agn/t3MTRyCIVtfmyHPOZR5P8DU9FcKMaF+qu5XdigATz5UG+aDHA5+W2W
s4A6Yb566fbzrV5R/fEbnO+m9v++BEF8CR430D7tdBjFZ+lYVCjQk6c7TL5SPbGg
uIyQxWe0gvlz79XuHHm4dgCoMJszyhILibxCwSrl90DFo5+M2ZQUmBmej5OD8Y3y
RI5/zsvYJrI0VBrf8UXAoJ4S5VVNE40CJ9Xy/GBHO9pLABmmJ/4cJCnyEW0x3+kh
OszE2VcANcNsUEUlJbRjE4qUPkvSt+lNaZZQmqfyd3iLwXhKbpC/q2Mjk0wwtnAq
nX2NR9vMBWtBXFdYbLSpDtKAqr8g9CnLSK8ccyEIaF+pD0iidS8+WaevJX2eN/7v
4AnJE5nDmsF8mbF66YazcshiNhv2gWcDH41hZ5KduuNhcP99sSjSq8vLixTdb22E
jL5r8gxFZ7MIsdPakjgp2MIVoeIvHu4J97TNoV8saqzbKlw8tOb43nbBAh5mbsI/
wKXY37t2V62IDOS4LgwV
=dIu5
-----END PGP SIGNATURE-----

--TQWq9ehpqA6q9cttd32uRmJoWW8m6J5eu--
