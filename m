From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4 5/6] drm/omap: add framedone interrupt support
Date: Sat, 17 Nov 2018 22:08:40 +0100
Message-ID: <20181117210840.GE22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-6-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0416544342=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181115230645.15748-6-sebastian.reichel@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0416544342==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This prepares framedone interrupt handling for
> manual display update support.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void *ar=
g)
> =20
>  		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc, ch=
annel))
>  			omap_crtc_error_irq(crtc, irqstatus);
> +
> +		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, ch=
annel))
> +			omap_crtc_framedone_irq(crtc, irqstatus);
>  	}
> =20
>  	omap_irq_ocp_error_handler(dev, irqstatus);

Will the mgr_get_framedone_irq(priv->dispc, channel) change from
interrupt to interrupt? Would it make sense to cache result as a
micro-organization?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwg1gACgkQMOfwapXb+vLFpQCeNilH3N4aHSKuC7+SOdkSpzsJ
o1wAn1tveKkDFp0iguGX+u4YNlK19vmx
=HLOK
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--

--===============0416544342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0416544342==--
