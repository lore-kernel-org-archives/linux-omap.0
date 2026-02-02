Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DE2BDC32
	for <linux-omap@vger.kernel.org>; Mon,  2 Feb 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026252; cv=none; b=SXzXqGyB2ipYuZJ+LlLf8k/L9/223ENHw5vemaea6PbJikuIeHGQdYB2km6+iWxp3fUYcV1v9ISq34r5wctuHUSv3Vtcds0qdEcNX4+0iK6FomWT7JAKDkptIhTo2+w/ytnpn/MtZYKOpFKkmUteD1DCmvr6TW4uDk02krJuA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026252; c=relaxed/simple;
	bh=yP87X20z3tjBiL2FhsQNrvRzYFGHMI6DbStmcFuw5SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF64Tq49ZVUM52nsv+DXhQnwus+iaqFBiiyUGIlFpD90akCIoml5tlrgy5EbKRJt8C0wrE7efPX0QAnhJLd9glIEyVetZhKhnGPmtYUG2F5Sj8/4C4CEj5mNIOo1cJvo8MbqMOdHYNGxbbE1c7I1IZ/kLUjA1Z5sImIVHYF7ZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FXCVqwM7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FXCVqwM7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 250241A2AEE;
	Mon,  2 Feb 2026 09:57:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E12BB60767;
	Mon,  2 Feb 2026 09:57:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24B11119A88F3;
	Mon,  2 Feb 2026 10:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770026246; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S+RzlUEH251YiNbOWqwHIrsXi4zbpi7hYqWeCjzmkvA=;
	b=FXCVqwM72h5FfBEEXwcOFOqTDjIdbJaKQXVYgrJ8vEuINUCHICIlFugMQeTGBCNR3O6Mow
	O8vavTSKTulfNlq/92gz9cn/ivnkcP8CHDf943HUZpYM8vdjSJHF+t1oUXcloP8KCHQ5O9
	L4KfNkJ4Tgs759FtCusyfBX27o+U0DsBRF5F6byiew2+Hqv5mBJkIE5sUaijyqm0KTruKn
	6x7MEh/prgS0XlRexT4gxyKUL/Kr0jKr4oJJ9OxNWE2snMNmeVBKpyITDLkt0I/SsUvjZ0
	kVNpU1wBPIAlEfJCKS5V4JpovaWRxhAPIVTJDU7ySTHTAq8JOCC2197uz7BWHQ==
Date: Mon, 2 Feb 2026 10:57:17 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Jyri Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Russell King" <linux@armlinux.org.uk>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Tony Lindgren" <tony@atomide.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>, "Bajjuri Praneeth"
 <praneeth@ti.com>, "Louis Chauvet" <louis.chauvet@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Miguel Gazquez"
 <miguel.gazquez@bootlin.com>, "Herve Codina" <herve.codina@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v5 20/25] drm/tilcdc: Use devm_drm_of_get_bridge()
 helper
Message-ID: <20260202105717.53067aae@kmaincent-XPS-13-7390>
In-Reply-To: <DG269FV5MZ8I.2VFNJXA0N2Y26@bootlin.com>
References: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
	<20260123-feature_tilcdc-v5-20-5a44d2aa3f6f@bootlin.com>
	<DG269FV5MZ8I.2VFNJXA0N2Y26@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 30 Jan 2026 20:31:11 +0100
"Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:

> Hi Kory,
>=20
> On Fri Jan 23, 2026 at 5:12 PM CET, Kory Maincent (TI.com) wrote:
> > Replace drm_of_find_panel_or_bridge() with the newer
> > devm_drm_of_get_bridge() helper which simplifies the code by:
> > - Automatically handling both panel and bridge cases internally
> > - Managing the panel-to-bridge conversion when needed
> > - Using devres for resource management, eliminating manual cleanup
> >
> > This removes the need for explicit panel-to-bridge conversion via
> > devm_drm_panel_bridge_add_typed() and the associated error handling pat=
h.

...

> >  	encoder =3D drmm_simple_encoder_alloc(ddev, struct tilcdc_encoder,
> >  					    base, DRM_MODE_ENCODER_NONE);
> > @@ -73,12 +70,5 @@ int tilcdc_encoder_create(struct drm_device *ddev)
> >  	}
> >  	priv->encoder =3D encoder;
> >
> > -	if (panel) {
> > -		bridge =3D devm_drm_panel_bridge_add_typed(ddev->dev, panel,
> > -
> > DRM_MODE_CONNECTOR_DPI); =20
>=20
> You are introducing a subtle difference here: while you pass the connector
> type to devm_drm_panel_bridge_add_typed(), devm_drm_of_get_bridge() does
> not take it and expects it to ahve been set previously and errors out if =
it
> hasn't.
>=20
> Can you ensure the connector type is alway set before this
> devm_drm_of_get_bridge() call?

The connector type should be set by the bridge or the panel driver.

https://elixir.bootlin.com/linux/v6.18.6/source/drivers/gpu/drm/bridge/pane=
l.c#L397
 * This function is deprecated and should not be used in new drivers. Use
 * devm_drm_panel_bridge_add() instead, and fix panel drivers as necessary =
if
 * they don't report a connector type.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
