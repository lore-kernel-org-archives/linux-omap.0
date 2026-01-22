Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70842F0C6A;
	Thu, 22 Jan 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094202; cv=none; b=bqqTpU6xzbU3zqI+OSWG7D7e7w6sfCGVrHslB7IzwPn+W4aVrFEhGxNznp+4yhlQdZ7VnVWJmvcoF7s6LKzehXldhdTI0mmAsmMbmhBY1wq317pbOfeKApLz6Xk7kMMTqWetcDgppCzJVHl5xeXe0vC3wH8SW7mobq1WY7wf6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094202; c=relaxed/simple;
	bh=L3LXWOEw30hR/WGWej9pBIBlonvnC2+4uM+luFxj4VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQxbRjxePDPg8uGTottPqQPEBgSbO8cTWjmY//34aJBFZpLvfrqKYxUkWWujfa+vNWCIr5OTRB+eWLMKSZ72wnyXB7MgWObW6RG73d+Dgn/2J0mQGJb1yUYpe01xO3F/Gc8kHMaTkUpL+67LKEj0i7LYFQogfjFwpDkJJYkh4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bT6zFJXH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bT6zFJXH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6F7711A2AB5;
	Thu, 22 Jan 2026 15:03:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37575606B6;
	Thu, 22 Jan 2026 15:03:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47242119B82C7;
	Thu, 22 Jan 2026 16:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cNoOeyLdRbrJPSI/I28lkpAsBvsGiM1vvz72sBr9geA=;
	b=bT6zFJXHZg4b/0Yur0HKyDxB7YVrRbw3CMxP+5Ir+R40QcBKAyqf+FJzlDonCEznoyVNhA
	CCIHPkx+8/4GfsBmOyxq6hpQXyXd70tOyjrkZ1mWoKbBcueernf7T74/w7ABXAppVSQiJW
	gDaaxcO7w2GjB17wCIKYfJ9NoXRjJZZRzjuDGxH5yMy0DAUsRJc3+mgmkPcPsf2LgQ9S45
	H0XQkUyNrcZeWp/BK1JoD1rGYKDTSlEW4BU1MHdTqjT6VF1rtFC/yC6cD8knyTdXTEnCjH
	i3JPQ0RGKBnqI0NzKNB/ifdENXRodl2vEY9kS+4LCNKTKV66j0jey1UVBH9f2Q==
Date: Thu, 22 Jan 2026 16:03:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Jyri Sarha
 <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Bartosz Golaszewski <brgl@bgdev.pl>, Tony Lindgren
 <tony@atomide.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miguel Gazquez
 <miguel.gazquez@bootlin.com>, Herve Codina <herve.codina@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 20/25] drm/tilcdc: Use devm_drm_of_get_bridge()
 helper
Message-ID: <20260122160311.658cc219@kmaincent-XPS-13-7390>
In-Reply-To: <20260122-camouflaged-cat-of-sorcery-7af8cf@houat>
References: <20260116-feature_tilcdc-v4-0-2c1c22143087@bootlin.com>
	<20260116-feature_tilcdc-v4-20-2c1c22143087@bootlin.com>
	<DFSVNE16870S.ABQUMH9BWMDY@bootlin.com>
	<20260122-camouflaged-cat-of-sorcery-7af8cf@houat>
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

On Thu, 22 Jan 2026 15:03:21 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
>=20
> On Mon, Jan 19, 2026 at 10:18:12PM +0100, Luca Ceresoli wrote:
> > Maxime, I'd appreciate your opinion about the topic below.
> >=20
> > > -	int ret;
> > >
> > > -	ret =3D drm_of_find_panel_or_bridge(ddev->dev->of_node, 0, 0,
> > > -					  &panel, &bridge);
> > > -	if (ret =3D=3D -ENODEV)
> > > +	bridge =3D devm_drm_of_get_bridge(ddev->dev, ddev->dev->of_node,
> > > 0, 0);
> > > +	if (PTR_ERR(bridge) =3D=3D -ENODEV) =20
> >=20
> > This patch is technically OK in the sense that the code before and after
> > would be equivalent. However if it were me I would not do this change. =
The
> > reason is that both drm_of_find_panel_or_bridge() and *_of_get_bridge()=
 are
> > problematic when introducing drm_bridge hotplug, which is the long-term
> > goal I am working for, but *_of_get_bridge() is more problematic than
> > drm_of_find_panel_or_bridge().
> >=20
> > These functions are still there and not deprecated because there is
> > currently no better replacement (and drm_bridge hotplug is not yet
> > supported because of this and other things still to be done). To have a
> > replacement, the panel_bridge lifetime needs to be reworked first and
> > that's not going to happen overnight. So, all in all, if this patch is =
not
> > crucial to your series I'd consider dropping it. But if it is important=
 I'm
> > fine with applying it, it won't make a huge difference. =20
>=20
> Eh. I'm fine either way. I understand what you're saying, but this patch
> doesn't introduce any *new* problem while it cleans up the driver, so I
> guess we could merge it still. And further clean it up with what you
> were suggesting later on.

As you want. I will then keep the patch. If anyone has reasons why these
patch should not be merged, speak now or forever hold your peace! ^^

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
