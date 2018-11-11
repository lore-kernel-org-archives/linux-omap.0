From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 4/4] drm/omap: Move DISPC runtime PM handling to omapdrm
Date: Sun, 11 Nov 2018 02:45:36 +0100
Message-ID: <20181111014536.wb3zpfywennjh2x7@earth.universe>
References: <20181110111654.4387-1-laurent.pinchart@ideasonboard.com>
 <20181110111654.4387-5-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311284491=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181110111654.4387-5-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============0311284491==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eoj6oktd3jdmgerk"
Content-Disposition: inline


--eoj6oktd3jdmgerk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 10, 2018 at 01:16:54PM +0200, Laurent Pinchart wrote:
> The internal encoders (DSI, HDMI4, HDMI5 and VENC) runtime PM handlers
> attempt to manage the runtime PM state of the connected DISPC, based on
> the rationale that the DISPC providing data to the encoders requires
> ensuring that the display is active whenever the encoders are active.
>=20
> While the DISPC provides data to the encoders, it doesn't as such
> constitute a resource that encoders require in order to be taken out
> of suspend, contrary to for instance a functional clock or a power
> supply. Encoders registers can be accessed without the DISPC being
> active, and while the encoders will not output any video stream without
> being fed by the DISPC, the DISPC PM state doesn't influence the
> encoders PM state.
>=20
> For this reason the DISPC PM state is better managed from the omapdrm
> driver, in the CRTC enable and disable operations. This allows the
> encoders PM state to be handled separately from the DISPC, and in
> particular at times when the DISPC may not be available (for instance at
> probe due to the DSS probe being deferred, or at remove time du to the
> DISPC being already removed).
>=20
> Fixes: edb715dffdee ("drm/omap: dss: dsi: Move initialization code from b=
ind to probe")
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

+1 for writing fixes, that cleanup the code at the same time :)
Decoupling DISPC from encoders also helps to fix DSI support.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/gpu/drm/omapdrm/dss/dsi.c   |  7 -------
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c | 27 ---------------------------
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c | 27 ---------------------------
>  drivers/gpu/drm/omapdrm/dss/venc.c  |  7 -------
>  drivers/gpu/drm/omapdrm/omap_crtc.c |  6 ++++++
>  5 files changed, 6 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index b9d5ad7e67d8..36123c086d97 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -5473,19 +5473,12 @@ static int dsi_runtime_suspend(struct device *dev)
>  	/* wait for current handler to finish before turning the DSI off */
>  	synchronize_irq(dsi->irq);
> =20
> -	dispc_runtime_put(dsi->dss->dispc);
> -
>  	return 0;
>  }
> =20
>  static int dsi_runtime_resume(struct device *dev)
>  {
>  	struct dsi_data *dsi =3D dev_get_drvdata(dev);
> -	int r;
> -
> -	r =3D dispc_runtime_get(dsi->dss->dispc);
> -	if (r)
> -		return r;
> =20
>  	dsi->is_enabled =3D true;
>  	/* ensure the irq handler sees the is_enabled value */
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi4.c
> index 073fa462930a..aabdda394c9c 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -841,32 +841,6 @@ static int hdmi4_remove(struct platform_device *pdev)
>  	return 0;
>  }
> =20
> -static int hdmi_runtime_suspend(struct device *dev)
> -{
> -	struct omap_hdmi *hdmi =3D dev_get_drvdata(dev);
> -
> -	dispc_runtime_put(hdmi->dss->dispc);
> -
> -	return 0;
> -}
> -
> -static int hdmi_runtime_resume(struct device *dev)
> -{
> -	struct omap_hdmi *hdmi =3D dev_get_drvdata(dev);
> -	int r;
> -
> -	r =3D dispc_runtime_get(hdmi->dss->dispc);
> -	if (r < 0)
> -		return r;
> -
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops hdmi_pm_ops =3D {
> -	.runtime_suspend =3D hdmi_runtime_suspend,
> -	.runtime_resume =3D hdmi_runtime_resume,
> -};
> -
>  static const struct of_device_id hdmi_of_match[] =3D {
>  	{ .compatible =3D "ti,omap4-hdmi", },
>  	{},
> @@ -877,7 +851,6 @@ struct platform_driver omapdss_hdmi4hw_driver =3D {
>  	.remove		=3D hdmi4_remove,
>  	.driver         =3D {
>  		.name   =3D "omapdss_hdmi",
> -		.pm	=3D &hdmi_pm_ops,
>  		.of_match_table =3D hdmi_of_match,
>  		.suppress_bind_attrs =3D true,
>  	},
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi5.c
> index b0e4a7463f8c..9e8556f67a29 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -825,32 +825,6 @@ static int hdmi5_remove(struct platform_device *pdev)
>  	return 0;
>  }
> =20
> -static int hdmi_runtime_suspend(struct device *dev)
> -{
> -	struct omap_hdmi *hdmi =3D dev_get_drvdata(dev);
> -
> -	dispc_runtime_put(hdmi->dss->dispc);
> -
> -	return 0;
> -}
> -
> -static int hdmi_runtime_resume(struct device *dev)
> -{
> -	struct omap_hdmi *hdmi =3D dev_get_drvdata(dev);
> -	int r;
> -
> -	r =3D dispc_runtime_get(hdmi->dss->dispc);
> -	if (r < 0)
> -		return r;
> -
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops hdmi_pm_ops =3D {
> -	.runtime_suspend =3D hdmi_runtime_suspend,
> -	.runtime_resume =3D hdmi_runtime_resume,
> -};
> -
>  static const struct of_device_id hdmi_of_match[] =3D {
>  	{ .compatible =3D "ti,omap5-hdmi", },
>  	{ .compatible =3D "ti,dra7-hdmi", },
> @@ -862,7 +836,6 @@ struct platform_driver omapdss_hdmi5hw_driver =3D {
>  	.remove		=3D hdmi5_remove,
>  	.driver         =3D {
>  		.name   =3D "omapdss_hdmi5",
> -		.pm	=3D &hdmi_pm_ops,
>  		.of_match_table =3D hdmi_of_match,
>  		.suppress_bind_attrs =3D true,
>  	},
> diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm=
/dss/venc.c
> index ff0b18c8e4ac..b5f52727f8b1 100644
> --- a/drivers/gpu/drm/omapdrm/dss/venc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/venc.c
> @@ -946,19 +946,12 @@ static int venc_runtime_suspend(struct device *dev)
>  	if (venc->tv_dac_clk)
>  		clk_disable_unprepare(venc->tv_dac_clk);
> =20
> -	dispc_runtime_put(venc->dss->dispc);
> -
>  	return 0;
>  }
> =20
>  static int venc_runtime_resume(struct device *dev)
>  {
>  	struct venc_device *venc =3D dev_get_drvdata(dev);
> -	int r;
> -
> -	r =3D dispc_runtime_get(venc->dss->dispc);
> -	if (r < 0)
> -		return r;
> =20
>  	if (venc->tv_dac_clk)
>  		clk_prepare_enable(venc->tv_dac_clk);
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdr=
m/omap_crtc.c
> index 62928ec0e7db..caffc547ef97 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -350,11 +350,14 @@ static void omap_crtc_arm_event(struct drm_crtc *cr=
tc)
>  static void omap_crtc_atomic_enable(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *old_state)
>  {
> +	struct omap_drm_private *priv =3D crtc->dev->dev_private;
>  	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
>  	int ret;
> =20
>  	DBG("%s", omap_crtc->name);
> =20
> +	priv->dispc_ops->runtime_get(priv->dispc);
> +
>  	spin_lock_irq(&crtc->dev->event_lock);
>  	drm_crtc_vblank_on(crtc);
>  	ret =3D drm_crtc_vblank_get(crtc);
> @@ -367,6 +370,7 @@ static void omap_crtc_atomic_enable(struct drm_crtc *=
crtc,
>  static void omap_crtc_atomic_disable(struct drm_crtc *crtc,
>  				     struct drm_crtc_state *old_state)
>  {
> +	struct omap_drm_private *priv =3D crtc->dev->dev_private;
>  	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
> =20
>  	DBG("%s", omap_crtc->name);
> @@ -379,6 +383,8 @@ static void omap_crtc_atomic_disable(struct drm_crtc =
*crtc,
>  	spin_unlock_irq(&crtc->dev->event_lock);
> =20
>  	drm_crtc_vblank_off(crtc);
> +
> +	priv->dispc_ops->runtime_put(priv->dispc);
>  }
> =20
>  static enum drm_mode_status omap_crtc_mode_valid(struct drm_crtc *crtc,
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--eoj6oktd3jdmgerk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvnib0ACgkQ2O7X88g7
+po5Dg/9HlY/rm9fO7WAokUnRMwi8DGzQX18pVzt6uAIcykJTaWoQUUUm3Ldu7sZ
e62xfoHyjleZprpQxg7qv63vFOyDUsHS89dDaN3ZuqFqEjjQOVOqzIRUCHB9eG8N
syb1Bgze4UxehQ3rwYdSCnDzO3U3YoYMfIIjvw82yyRPIULkms/pHCzazCN2PHEc
wg/c37ap+QwBf+hTIgcqN/U6c3BOLwKmbGYE+zDl7QVtiuLHsBzEQRHcdU95nPzb
QI2oAK7L1wYinQYm1HXiypqfxgQ4eIi3KZY4wMoecJ+Q/ijoKHTEqE7PtUrSLo0F
fMoGrcDlpc1FnE9MS6dwDfv3cbtrtwCoi/I+d9TWieSbVTbBlNfsOYGg+wi8g18w
yONT8hrJi/iI5Y8PaPW88Gd31XlFIhcWyyDzmel4Zy6eN+MUVRlMj/CnNm/E8NQY
cZGf9gWdXlXH/lNlCSYr3JBZhT30N5Z2soF0YUUEkRLdlO4zcgtzeLIsrrtZp8yF
yjHLLuLtDCj71dAxdDr2sJtnOqakCUXvwYVL45VLEnys6zSdPu1z1jN2Z59mvNrb
6nCWp0uQp5pmGTeZljp/4+lmA+Q7aPVp7YPfiA9T4cwDrjjmEIKK2k2ssDslt/Gu
4zIIloD2//8mj2e8YXM91kxb2WJu7e5HyGwRlw9liTWmvJg5MFk=
=H1P5
-----END PGP SIGNATURE-----

--eoj6oktd3jdmgerk--

--===============0311284491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0311284491==--
