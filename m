From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 02/10] drm: omapdrm: panel-dsi-cm: add regulator support
Date: Fri, 17 Mar 2017 16:26:40 +0100
Message-ID: <20170317152640.GH8723@amd>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-2-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1594175283=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170305004309.28259-2-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1594175283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The N950's display requires two regulators.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 55 +++++++++++++++++++=
++++--
>  1 file changed, 52 insertions(+), 3 deletions(-)

> @@ -590,25 +594,43 @@ static int dsicm_power_on(struct panel_drv_data *dd=
ata)
>  		.lp_clk_max =3D 10000000,
>  	};
> =20
> +	if (ddata->vpnl) {
> +		r =3D regulator_enable(ddata->vpnl);
> +		if (r) {
> +			dev_err(&ddata->pdev->dev,
> +				"failed to enable VPNL: %d\n", r);
> +			goto err0;
> +		}
> +	}

Having err0 that just returns .. is quite confusing. Just return here?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljMADAACgkQMOfwapXb+vK25gCfXrHZugqmmILPxQskqGu3lW0t
wLkAnR8hJwl+rfP9kHjfmcNRRSKP5JLM
=CLUn
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--

--===============1594175283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1594175283==--
