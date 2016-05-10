From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 18/23] drm: omapdrm: panel-dsi-cm: use threaded irq handler
Date: Tue, 10 May 2016 15:19:43 +0300
Message-ID: <5731D1DF.5050304@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-19-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0699767336=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1457455195-1938-19-git-send-email-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0699767336==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mgai4hqmfwWVnXgveQbaohIMX6o8F9fnL"

--mgai4hqmfwWVnXgveQbaohIMX6o8F9fnL
Content-Type: multipart/mixed; boundary="oS8JJt7XGolHAA3axq8W4GsWnADXwrDQd"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <5731D1DF.5050304@ti.com>
Subject: Re: [PATCH 18/23] drm: omapdrm: panel-dsi-cm: use threaded irq
 handler
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-19-git-send-email-sre@kernel.org>
In-Reply-To: <1457455195-1938-19-git-send-email-sre@kernel.org>

--oS8JJt7XGolHAA3axq8W4GsWnADXwrDQd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 08/03/16 18:39, Sebastian Reichel wrote:
> Use threaded irq handler for the tearing effect gpio,
> since it updates the display content, which requires
> too much time for a fastpath irq.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/=
gpu/drm/omapdrm/displays/panel-dsi-cm.c
> index 768e92d1ec8b..8316b6c2d8aa 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> @@ -1317,9 +1317,9 @@ static int dsicm_probe(struct platform_device *pd=
ev)
>  			return r;
>  		}
> =20
> -		r =3D devm_request_irq(dev, gpio_to_irq(ddata->ext_te_gpio),
> -				dsicm_te_isr,
> -				IRQF_TRIGGER_RISING,
> +		r =3D devm_request_threaded_irq(dev, gpio_to_irq(ddata->ext_te_gpio)=
,
> +				NULL, dsicm_te_isr,
> +				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  				"taal vsync", ddata);
> =20
>  		if (r) {
>=20

I don't have a problem with moving to threaded irq, but it does make me
wonder, what's happening there that's taking so much time? I think it
should be just writing the configs to the registers and starting the
transfer.

 Tomi


--oS8JJt7XGolHAA3axq8W4GsWnADXwrDQd--

--mgai4hqmfwWVnXgveQbaohIMX6o8F9fnL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMdHfAAoJEPo9qoy8lh71B0MP/1t0lya9iY/+RchJYF5YbAds
Xp9Iqnp+9xTMoFXZ2F7bhHph5qFo7nJPk7mnxqB3i5Gv0kb+boWg3Ie+mJzySY7U
XL0YKUr5l+FMky851ZaCpgVU8/yBD2TE0YwG0m+5wfMTPYvP3ZTtiZGrlmWnMChO
tHTRU0NljW3imOvIT60iR4rezAmGmzzMopsZIeqtiWh9uBukbGAvIEHidZQBmmoR
zPNivakq4WDK2fQ1ygkOEImoSIP6mtXRedU0A/hfsDRRNEhSebJ2hzd3zODlwPZV
A2GnOrInVrbfi3VYiHAGf+L2+qMEBjAez63G5S7Egc4427iTITxomLXEsK1MU2iT
5kQgXYfPZxpTuyFonVDjfurU7pEuKVB5Q2NWHzx7fFilMXDZWSOJNj593ywq6MQW
1C8qN+zj/E3D0g90bqHRvEEW5Y6cmbscoedPYe/PzuLb42huvkzEG0HZYA6qJW15
kuRVolnUBkNIb6jkTThzgUBYg2STYfbhUb96VtYOv33pPefJWishsbU8os5CQnjr
vyMOwa93JI2sFTT5BaRYir8CGfErOr9RCfknkD89Wv+2PopVivkBBL1ROT/leot4
NuaoHYd6rua62Q+xpbsgS4REJS3p3ritzQMvMJedpKw7t9M9VwWyR7A5qlpX55QE
40fvqk1u0siV3EbYffbL
=oiep
-----END PGP SIGNATURE-----

--mgai4hqmfwWVnXgveQbaohIMX6o8F9fnL--

--===============0699767336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0699767336==--
