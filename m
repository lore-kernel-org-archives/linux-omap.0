Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91831AF3B;
	Thu, 22 Jan 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090605; cv=none; b=gwcYSQYt/Ue1MUUhDw/3C4Evt9NZCIYRkhYjPKx8utY7GBw9YQYnAYo78eQ68hczG14m9oGBNWyhLg+JYBXAK8IP/sYydpTl7yJHaQF6fPpq9r2LYD0dTwO4rWXbXkU/jxP+Ds4Zer9LfSi0DCGkPiESCsQk4sNlLfM+aFJUrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090605; c=relaxed/simple;
	bh=3SHkyRGYKQ9i0FYPx3pRbT9QJT80ZePTrHdczjnXiWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM7hYf37m//hlXenva3inQKcVHzXqQrhW1OejyjYHOsh2BxGYqAXob4/9m1iLBXFDxGJJi741hClAFa2+WTFrOKz0gsIs5kJ4FulvzFqVM9vwnVB5tQEy5CsicjgAbJV6OZxDgZQdYUeC/+bc5/zwYHbLrG+EwTmzhQYXtVgais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkiQK3Bs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkiQK3Bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EDDC116D0;
	Thu, 22 Jan 2026 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769090604;
	bh=3SHkyRGYKQ9i0FYPx3pRbT9QJT80ZePTrHdczjnXiWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkiQK3BsP1UxoTEIDr+vIclBy0qGP6nUp9EjpTxDWH9+CXX0/Yg8JbgmmhpdMGcmE
	 m94q7Pd0mQ7BV6F03TkQSVNiAafPQovTzjZc94OJCSjdokwbyUwLcYO+AEewleCh48
	 AcsaREyJ5cy9B2bPVQHiGkMVPQpUkuL9V66imBc/Bwb0ta+3tfFvB1849FiTOvBRVz
	 QyW3l/vevpPBhqN/QiaV1oSh+AQNTJGMdZDqHiI8caRNophFKmbgV8E636M1tVj4BS
	 yjU5uAkTD0p85/R/NXcxrqZ8/TIaiSvPHehb33T9zC58dBVZgS4SDAYmyFgCBi9inm
	 E0yYHmJO68rlQ==
Date: Thu, 22 Jan 2026 15:03:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Tony Lindgren <tony@atomide.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Bajjuri Praneeth <praneeth@ti.com>, Louis Chauvet <louis.chauvet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miguel Gazquez <miguel.gazquez@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 20/25] drm/tilcdc: Use devm_drm_of_get_bridge() helper
Message-ID: <20260122-camouflaged-cat-of-sorcery-7af8cf@houat>
References: <20260116-feature_tilcdc-v4-0-2c1c22143087@bootlin.com>
 <20260116-feature_tilcdc-v4-20-2c1c22143087@bootlin.com>
 <DFSVNE16870S.ABQUMH9BWMDY@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="koxasmrivanfnujl"
Content-Disposition: inline
In-Reply-To: <DFSVNE16870S.ABQUMH9BWMDY@bootlin.com>


--koxasmrivanfnujl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 20/25] drm/tilcdc: Use devm_drm_of_get_bridge() helper
MIME-Version: 1.0

Hi,

On Mon, Jan 19, 2026 at 10:18:12PM +0100, Luca Ceresoli wrote:
> Maxime, I'd appreciate your opinion about the topic below.
>=20
> On Fri Jan 16, 2026 at 6:02 PM CET, Kory Maincent (TI.com) wrote:
> > Replace drm_of_find_panel_or_bridge() with the newer
> > devm_drm_of_get_bridge() helper which simplifies the code by:
> > - Automatically handling both panel and bridge cases internally
> > - Managing the panel-to-bridge conversion when needed
> > - Using devres for resource management, eliminating manual cleanup
> >
> > This removes the need for explicit panel-to-bridge conversion via
> > devm_drm_panel_bridge_add_typed() and the associated error handling pat=
h.
> >
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >
> > Change in v4:
> > - New patch
> > ---
> >  drivers/gpu/drm/tilcdc/tilcdc_encoder.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c b/drivers/gpu/drm/=
tilcdc/tilcdc_encoder.c
> > index a34a10337f6a8..546fe7e6ee815 100644
> > --- a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> > +++ b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
> > @@ -55,15 +55,12 @@ int tilcdc_encoder_create(struct drm_device *ddev)
> >  	struct tilcdc_drm_private *priv =3D ddev_to_tilcdc_priv(ddev);
> >  	struct tilcdc_encoder *encoder;
> >  	struct drm_bridge *bridge;
> > -	struct drm_panel *panel;
> > -	int ret;
> >
> > -	ret =3D drm_of_find_panel_or_bridge(ddev->dev->of_node, 0, 0,
> > -					  &panel, &bridge);
> > -	if (ret =3D=3D -ENODEV)
> > +	bridge =3D devm_drm_of_get_bridge(ddev->dev, ddev->dev->of_node, 0, 0=
);
> > +	if (PTR_ERR(bridge) =3D=3D -ENODEV)
>=20
> This patch is technically OK in the sense that the code before and after
> would be equivalent. However if it were me I would not do this change. The
> reason is that both drm_of_find_panel_or_bridge() and *_of_get_bridge() a=
re
> problematic when introducing drm_bridge hotplug, which is the long-term
> goal I am working for, but *_of_get_bridge() is more problematic than
> drm_of_find_panel_or_bridge().
>=20
> These functions are still there and not deprecated because there is
> currently no better replacement (and drm_bridge hotplug is not yet
> supported because of this and other things still to be done). To have a
> replacement, the panel_bridge lifetime needs to be reworked first and
> that's not going to happen overnight. So, all in all, if this patch is not
> crucial to your series I'd consider dropping it. But if it is important I=
'm
> fine with applying it, it won't make a huge difference.

Eh. I'm fine either way. I understand what you're saying, but this patch
doesn't introduce any *new* problem while it cleans up the driver, so I
guess we could merge it still. And further clean it up with what you
were suggesting later on.

Maxime

--koxasmrivanfnujl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaXIuKQAKCRAnX84Zoj2+
dmgwAYDLY4OXhO7mg+WUhmw0Yc4L5lUQhZ+IdcuEGFz8PoHCodhBLdEMRMEQeyrZ
Lg3ek6YBgKnjvmAsvQieYruFGJdc16JOzCVf95Xa7TlPn2/TL9Du2bGHrv7SWGiW
2GbEtp3WOw==
=T8Px
-----END PGP SIGNATURE-----

--koxasmrivanfnujl--
