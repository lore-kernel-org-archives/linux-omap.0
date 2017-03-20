From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 09/10] drm: omapdrm: crtc: get manual mode displays
 working
Date: Mon, 20 Mar 2017 13:19:24 +0200
Message-ID: <a2cd12b1-1e47-e86e-7262-7aa5a7068eec@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-9-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0120622599=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170305004309.28259-9-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============0120622599==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2lsGeiSl3S0fpajQcIk7wWfrstFs4nWpE"

--2lsGeiSl3S0fpajQcIk7wWfrstFs4nWpE
Content-Type: multipart/mixed; boundary="jlgxP55GUNt8QwhQHlMlcAv6hbcB2B9Pq";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <a2cd12b1-1e47-e86e-7262-7aa5a7068eec@ti.com>
Subject: Re: [PATCHv2 09/10] drm: omapdrm: crtc: get manual mode displays
 working
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-9-sre@kernel.org>
In-Reply-To: <20170305004309.28259-9-sre@kernel.org>

--jlgxP55GUNt8QwhQHlMlcAv6hbcB2B9Pq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/17 02:43, Sebastian Reichel wrote:
> From: Tony Lindgren <tony@atomide.com>
>=20
> With manual mode displays we need to flush the panel manually.
>=20
> Let's add flushing so we get Tomi's fbtest, kmstest, kmstest --flip,
> and X and wayland working.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> [On Nokia N950]
> Tested-By: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/omap_crtc.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omap=
drm/omap_crtc.c
> index 4601533215d6..e07b0a0be4bf 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -97,6 +97,11 @@ bool omap_crtc_is_manual_updated(struct drm_crtc *cr=
tc)
>  	return omap_crtc->manually_updated;
>  }
> =20
> +static void omap_crtc_manual_needs_flush(struct drm_crtc *crtc)
> +{
> +	omap_crtc_flush(crtc, 0, 0, 0, 0);
> +}
> +
>  /* -------------------------------------------------------------------=
----------
>   * DSS Manager Functions
>   */
> @@ -139,7 +144,11 @@ static void omap_crtc_dss_disconnect(enum omap_cha=
nnel channel,
> =20
>  static void omap_crtc_dss_start_update(enum omap_channel channel)
>  {
> +	struct omap_crtc *omap_crtc =3D omap_crtcs[channel];
> +	struct drm_crtc *crtc =3D &omap_crtc->base;
> +
>  	dispc_mgr_enable(channel, true);
> +	omap_crtc_manual_needs_flush(crtc);
>  }
> =20
>  /* Called only from the encoder enable/disable and suspend/resume hand=
lers. */
> @@ -155,11 +164,12 @@ static void omap_crtc_set_enabled(struct drm_crtc=
 *crtc, bool enable)
>  	if (WARN_ON(omap_crtc->enabled =3D=3D enable))
>  		return;
> =20
> -	if (omap_crtc_output[channel]->output_type =3D=3D OMAP_DISPLAY_TYPE_H=
DMI) {
> -		dispc_mgr_enable(channel, enable);
> -		omap_crtc->enabled =3D enable;
> +	dispc_mgr_enable(channel, enable);

Moving the mgr_enable here causes a race issue, as the irqs are only
registered later below.

 Tomi


--jlgxP55GUNt8QwhQHlMlcAv6hbcB2B9Pq--

--2lsGeiSl3S0fpajQcIk7wWfrstFs4nWpE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz7q8AAoJEPo9qoy8lh71KhIQAJUUUG3w5LVtMbA6vyE8YGAo
iH7DD3PIM+2hdWihbpruwOmgLZ+Pe8/XTr1iAIe1shhsI8mzgiOaYnS9oyV6aw7I
82Qr28Djv2JWbvL0dQtszGPhdKRcKfSfx2O+KPS6QhS5THY5ocqBzBElPrr5ihwg
m3x1RDWnLPq6AyRFhdj8O8+8GYALaqHMba2ECNT+7lbXsii4owIsG+G53iiYYIfm
ichdbh3Ah/7IioROJKCkbBwO1sTncQjnRMrvi11iVqzyKplW43JokkZX7qyoVfbm
TIrS/Q/Y+ZMnRfmjzyindX0DSMrlNKokmtJe8xxk/FcL3+3m4ctOBX5pdeeyHwAD
cGvo2Wrcr2XmELz3jfVE3WO2Chia9uwGPmAp/F7uXFTpU+cqHu5ZZ10cJeCRie0k
jMTaINL1KOKVI5P/0Akb4fKScx38MchiikA0zT/+4NjsRbjt+CisBzwpTcLeEwwx
T3EefqABTRxnNMgFUjT86KOKRN8dABoUy6g5lyKVFm85EBmAxrbSfkWb8RPrEFoK
P7mdOuEDKjbAtZMey4KFzS8yX1fYzOG33twkQlqZeylqUnmmy9HysVWLhoSCUkbL
qX1tDFcA1dhmqVrt2mT8RBWEWK16yGmXCAJJTdm6bfWZav4nTNCVGSdhbohK8u6z
Y8gsLMQUFvTigild+PNI
=xHGh
-----END PGP SIGNATURE-----

--2lsGeiSl3S0fpajQcIk7wWfrstFs4nWpE--

--===============0120622599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0120622599==--
