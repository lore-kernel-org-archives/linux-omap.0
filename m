Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1F2D2397
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004853; cv=none; b=B5LCVv8DndkpfCLLpRieeMYkLkaHs5wfBA9pLRjTMyh2VLhrPXZtc9cwzL22l57zklhgpzij3/9sFxeZFLGipI25a7VvZ6vv0l5druuQeQQRsMmIRFOMRLYNiKx3oXUUFUI36Em+QC/+KC5mIqrXNJ9iWUdr9WbDKfdQ+1PNm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004853; c=relaxed/simple;
	bh=Y/7M5txzQgTaQBXJXuGNgcHSTitWaotNSQWTwgoi/P8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUauktmN6Uhbzpxcy1A4gKas4YekVT6rNgQJedDd5f6mqMOU9/IMDZqvSydx0/L6uPwRNmGAPB7jqDqbQEo47Oos+T76xiVMNgw1JtBteo9F0kXIJMj1JRG3FTTXTWI7acTKhExPOd3wGRE0/vvQQ3zbhKMB0XiwHur2UHFm+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CbFfAUW2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CbFfAUW2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 865D44E421C5;
	Wed, 21 Jan 2026 14:14:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 557D86070A;
	Wed, 21 Jan 2026 14:14:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D14E119B152E;
	Wed, 21 Jan 2026 15:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769004847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jJAdXppBbAOIvtuneW6gr8WXXxU/lyeSburTzUqxCrI=;
	b=CbFfAUW26FQeqLMmADKrfn042P8OpRUkcoMywRGcVRQIj4RPFkNsJqohbnCTLqUNRPcShc
	xrAByGcR11i0cK/s3YHc5Id0v+RBcxzTg/Rt7noXa6pfUp47lVbD0Y73jbQPiBOw/LATgm
	xQe8+jFuvMqKhOWM9jw1aPohA9PcK3peRIsp4DawVDHQPorffVc0ZkOxet4OUwPBy1JVUw
	wwnSB9YHi5LBBUEgClaqJyJxhQuaJF15p+qRbGoXGchAJ7DfIcHdZWJMZWQHsYBbX8a/j+
	jZW5pEi7kHlrdkhP5aWWSwbBod6XxTP32pLCM25qscz8Pee2tDeokCbEFsSaBg==
Date: Wed, 21 Jan 2026 15:13:56 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Bartosz Golaszewski <brgl@bgdev.pl>, Tony
 Lindgren <tony@atomide.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miguel Gazquez
 <miguel.gazquez@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 05/25] drm/tilcdc: Convert legacy panel binding via
 DT overlay at boot time
Message-ID: <20260121151356.14d88273@bootlin.com>
In-Reply-To: <20260116-feature_tilcdc-v4-5-2c1c22143087@bootlin.com>
References: <20260116-feature_tilcdc-v4-0-2c1c22143087@bootlin.com>
	<20260116-feature_tilcdc-v4-5-2c1c22143087@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kory,

On Fri, 16 Jan 2026 18:02:05 +0100
"Kory Maincent (TI.com)" <kory.maincent@bootlin.com> wrote:

> To maintain backward compatibility while removing the deprecated
> tilcdc_panel driver, add a tilcdc_panel_legacy subdriver that converts
> the legacy "ti,tilcdc,panel" devicetree binding to the standard
> panel-dpi binding at early boot.
> 
> The conversion uses an embedded device tree overlay that is applied and
> modified during subsys_initcall. The process:
> 
> - Apply embedded overlay to create a tilcdc-panel-dpi node with
>   port/endpoint connections to the LCDC
> - Copy all properties from the legacy panel node to the new
>   tilcdc-panel-dpi node
> - Copy display-timings from the legacy panel
> - Convert legacy panel-info properties (invert-pxl-clk, sync-edge) to
>   standard display timing properties (pixelclk-active, syncclk-active)
> - Disable the legacy panel by removing its compatible property to
>   prevent the deprecated driver from binding
> 
> The result is a standard tilcdc-panel-dpi node with proper endpoints and
> timing properties, allowing the DRM panel infrastructure to work with
> legacy devicetrees without modification.
> 
> Other legacy panel-info properties are not migrated as they consistently
> use default values across all mainline devicetrees and can be hardcoded
> in the tilcdc driver.
> 
> This feature is optional via CONFIG_DRM_TILCDC_PANEL_LEGACY and should
> only be enabled for systems with legacy devicetrees containing
> "ti,tilcdc,panel" nodes.
> 
> Suggested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Link: https://lore.kernel.org/all/1d9a9269-bfda-4d43-938b-2df6b82b9369@ideasonboard.com/
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---

Looks good to me.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
