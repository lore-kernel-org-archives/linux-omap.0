From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 2/4] drm/omap: hdmi4: Ensure the device is active
 during bind
Date: Sun, 11 Nov 2018 01:48:07 +0100
Message-ID: <20181111004807.2lxh7oqo67rm2ip3@earth.universe>
References: <20181110111654.4387-1-laurent.pinchart@ideasonboard.com>
 <20181110111654.4387-3-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0836111314=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181110111654.4387-3-laurent.pinchart@ideasonboard.com>
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


--===============0836111314==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mnx6xmvqcqzf23k"
Content-Disposition: inline


--7mnx6xmvqcqzf23k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 10, 2018 at 01:16:52PM +0200, Laurent Pinchart wrote:
> The bind function performs hardware access (in hdmi4_cec_init()) and
> thus requires the device to be active. Ensure this by surrounding the
> bind function by hdmi_runtime_get() and hdmi_runtime_put() calls.
>=20
> Fixes: 27d624527d99 ("drm/omap: dss: Acquire next dssdev at probe time")
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v2:
>=20
> - Call hdmi_runtime_put() instead of hdmi_runtime_get() in error path
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi4.c
> index cf6230eac31a..073fa462930a 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -635,10 +635,14 @@ static int hdmi4_bind(struct device *dev, struct de=
vice *master, void *data)
> =20
>  	hdmi->dss =3D dss;
> =20
> -	r =3D hdmi_pll_init(dss, hdmi->pdev, &hdmi->pll, &hdmi->wp);
> +	r =3D hdmi_runtime_get(hdmi);
>  	if (r)
>  		return r;
> =20
> +	r =3D hdmi_pll_init(dss, hdmi->pdev, &hdmi->pll, &hdmi->wp);
> +	if (r)
> +		goto err_runtime_put;
> +
>  	r =3D hdmi4_cec_init(hdmi->pdev, &hdmi->core, &hdmi->wp);
>  	if (r)
>  		goto err_pll_uninit;
> @@ -652,12 +656,16 @@ static int hdmi4_bind(struct device *dev, struct de=
vice *master, void *data)
>  	hdmi->debugfs =3D dss_debugfs_create_file(dss, "hdmi", hdmi_dump_regs,
>  					       hdmi);
> =20
> +	hdmi_runtime_put(hdmi);
> +
>  	return 0;
> =20
>  err_cec_uninit:
>  	hdmi4_cec_uninit(&hdmi->core);
>  err_pll_uninit:
>  	hdmi_pll_uninit(&hdmi->pll);
> +err_runtime_put:
> +	hdmi_runtime_put(hdmi);
>  	return r;
>  }
> =20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--7mnx6xmvqcqzf23k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvnfEcACgkQ2O7X88g7
+pohHBAAqgun3+ciqTwCOTMnJ1sIuMlw4nxYpQEqJAhXKTpprsQ8tXaFIr8S34mH
P7SQXRMPrzsjDIKHad3wN0swKTRHLUg15re1QYdx0RDAsZDKCM+wbZkr01o4Igkl
MbQLiNRtNG6LTUxk9L2W8PUfP3Rt0fIDOdzDpoJGmF0ugLIhbfcZqnNNjTiEnagB
VqBc++9yXZXvnTU4T407PCctD+3+aCjGcBHf8jBRMsg8YeCg205re9jBuZsGnjVC
tF0wWI4Buq68E4kxQI8sUTXYHyMHm8beofmgILL+HTu/aak0z8lW320uTTojyyrN
vWCjyT54Hz+DD558EW/KSTxGuVF+NAgTE3vna2oHqDCh0FzMOpI9LCUyYcaPk+ry
wDCMgD4Tpv54O2PHOwJ5Rearu2guhRlKB+it47EUtkP0PUWip7mxrSaWeR5v5GZv
K188+KYHNmnjV6PT9uYehhAO4k9ps1iT9PE+RTpW/WjoVDMTtdgd4/xiLwowh0UK
o/SCdjukO46SlNua0rR2QH8hjBRNYzyckgz8wxaWhyK20iNQeHInpincafYPmdQG
NfBOqwA8I3s68S4YuAp4iaM2rdMebe4kMCDe3RKEXt8INbiaF6RZ2BAuJDejZIKk
MJ+qN5J6oYSaVOAxCgsxyw+3VDvDF/BKNoAcSLNWRac+x/mnE24=
=vndu
-----END PGP SIGNATURE-----

--7mnx6xmvqcqzf23k--

--===============0836111314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0836111314==--
