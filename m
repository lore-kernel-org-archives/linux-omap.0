Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F83816E0
	for <linux-omap@vger.kernel.org>; Mon,  2 Feb 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052088; cv=none; b=olEU32hX6Z41nQHJ2uV+vuw12CXnMQQgb+p8EQoQeiJfGBegKhxO329djZKcPGlKeQAX9z0WTLAGH89pE3KQrR/uqwpv2iEJ5fysDBWT05zuhlHbVQL1h8sEjbSW/paa4lbmKRvNSQSdAIeamJPSdzuYszIR42qw7PHvfwn7k7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052088; c=relaxed/simple;
	bh=yJvr7IWqWNLafBfMaSBl3AFwi4LUD5evFMVrgV81dIE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=l8uswrJ6mZ/+H6orMIf8wfc+Px/Sj0ipiBELSNc/NKRF2HWZS8pzsQoBBnq1odobgKDq6IBj27K38V09zjqXr8HfOJvuMCZ80FSENmezAdfgJIu+p2Mtl3JXttt2iQAH2RP03DCt2Lgb2T48ZV7jTFpiM0iLaKTGjKkGeLg4l1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2qqhM+kS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2qqhM+kS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A96C0C237F3;
	Mon,  2 Feb 2026 17:08:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEF2560767;
	Mon,  2 Feb 2026 17:07:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9F3E119A8888;
	Mon,  2 Feb 2026 18:07:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770052075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GI+ra4XFLShnydK/2m1O36TI0V8Tq0yYe+Uz1t6wvaU=;
	b=2qqhM+kSc6wGOF8joN8LTC5kMrxJrGg/XunkxEBv7HGKWW75HyI0OdOn6hM8FhiIoOLbd3
	kHALb7zczTwoPZSq91G5IncAHvcy0wuQxdViDhp5+SaJMI5+bRdhUut5E8nKtdG7PfHZrw
	wfJbj7b8NpuTQ82Q7C59YXf/GnO4Ez9sSQi8RlXObT92OBp/oEgSUUqhHhP0DWRka9WRBM
	BZOMylxjxQIkqjQpb5J+CGZqmx1wcgdyFr4RScLEWf6q0A4MXs8foeSROFNQtH1EePquOT
	H3mPAR8Vaaedr9txCYvBevjRa6wIuJ3HvG0l192QPEg5vPqY0IwWYEx8dVK7cQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 18:07:45 +0100
Message-Id: <DG4N39EA7RN5.NARFDHX3IXGE@bootlin.com>
Subject: Re: [PATCH v5 20/25] drm/tilcdc: Use devm_drm_of_get_bridge()
 helper
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
To: "Kory Maincent" <kory.maincent@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
 <20260123-feature_tilcdc-v5-20-5a44d2aa3f6f@bootlin.com>
 <DG269FV5MZ8I.2VFNJXA0N2Y26@bootlin.com>
 <20260202105717.53067aae@kmaincent-XPS-13-7390>
In-Reply-To: <20260202105717.53067aae@kmaincent-XPS-13-7390>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Feb 2, 2026 at 10:57 AM CET, Kory Maincent wrote:
> On Fri, 30 Jan 2026 20:31:11 +0100
> "Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:
>
>> Hi Kory,
>>
>> On Fri Jan 23, 2026 at 5:12 PM CET, Kory Maincent (TI.com) wrote:
>> > Replace drm_of_find_panel_or_bridge() with the newer
>> > devm_drm_of_get_bridge() helper which simplifies the code by:
>> > - Automatically handling both panel and bridge cases internally
>> > - Managing the panel-to-bridge conversion when needed
>> > - Using devres for resource management, eliminating manual cleanup
>> >
>> > This removes the need for explicit panel-to-bridge conversion via
>> > devm_drm_panel_bridge_add_typed() and the associated error handling pa=
th.
>
> ...
>
>> >  	encoder =3D drmm_simple_encoder_alloc(ddev, struct tilcdc_encoder,
>> >  					    base, DRM_MODE_ENCODER_NONE);
>> > @@ -73,12 +70,5 @@ int tilcdc_encoder_create(struct drm_device *ddev)
>> >  	}
>> >  	priv->encoder =3D encoder;
>> >
>> > -	if (panel) {
>> > -		bridge =3D devm_drm_panel_bridge_add_typed(ddev->dev, panel,
>> > -
>> > DRM_MODE_CONNECTOR_DPI);
>>
>> You are introducing a subtle difference here: while you pass the connect=
or
>> type to devm_drm_panel_bridge_add_typed(), devm_drm_of_get_bridge() does
>> not take it and expects it to ahve been set previously and errors out if=
 it
>> hasn't.
>>
>> Can you ensure the connector type is alway set before this
>> devm_drm_of_get_bridge() call?
>
> The connector type should be set by the bridge or the panel driver.
>
> https://elixir.bootlin.com/linux/v6.18.6/source/drivers/gpu/drm/bridge/pa=
nel.c#L397
>  * This function is deprecated and should not be used in new drivers. Use
>  * devm_drm_panel_bridge_add() instead, and fix panel drivers as necessar=
y if
>  * they don't report a connector type.

Ah, right, so it means this patch might cause some regressions due to panel
drivers to be fixed. So it's fine as long as you are ready to handle such
regression, should any happen.

Also other patches did exactly the same, e.g.:

  commit 6e1853589ea6 ("drm/lcdif: switch to devm_drm_of_get_bridge")
  commit a43dd76bacd0 ("drm/vc4: dsi: Switch to devm_drm_of_get_bridge")

And so:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
