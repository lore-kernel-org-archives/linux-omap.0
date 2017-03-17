From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 08/10] drm: omapdrm: crtc: handle framedone directly
Date: Fri, 17 Mar 2017 16:26:54 +0100
Message-ID: <20170317152654.GI8723@amd>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-8-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1883340020=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170305004309.28259-8-sre@kernel.org>
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


--===============1883340020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Content-Disposition: inline


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> @@ -264,8 +267,10 @@ int omap_drm_irq_install(struct drm_device *dev)
>  			priv->irq_mask |=3D omap_underflow_irqs[i];
>  	}
> =20
> -	for (i =3D 0; i < num_mgrs; ++i)
> +	for (i =3D 0; i < num_mgrs; ++i) {
>  		priv->irq_mask |=3D dispc_mgr_get_sync_lost_irq(i);
> +		priv->irq_mask |=3D dispc_mgr_get_framedone_irq(i);
> +	}
> =20

i++, we are no C++. OTOH, not your fault.

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljMAD4ACgkQMOfwapXb+vKUZQCgsQKihrZnT1JIwn5ednATnsVu
zHsAoIIroAoGR674XDRPUp8IBZrShQ8R
=QcAq
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--

--===============1883340020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1883340020==--
