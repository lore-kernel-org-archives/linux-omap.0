Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5C33A713;
	Fri, 23 Jan 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184827; cv=none; b=D35aOw8hpNMbyrMsSag6/laphsUdpfdgsmkWgYovosLKsww81RwdtekPl9/QZBA5Q9kWSvDtPCGP2Zq8SiShZ1G7+ORyVOLjfet8dvMLCmSEw2qnFc0Yz759LbfWEvVEcdvxv51nhYIOLo98ALqzunmEPWe+S9OA73XlvAxTimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184827; c=relaxed/simple;
	bh=HYWg+i9nVutthHgrYsisg/kOoj2oui3PeuCa9uR2feU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aflmaj+6KGVF4kZEo1Zzd0QGcgAbGulUlIth5fgqTb5w3rufkv6bBpbWQ42E/xCk88BK1j2Bv9+7PUKO9zPTNT3qgwmEBigUXPNzyOcSp2HHjv55dmiQhKqggUT3olGelRBjxmwx7tC/hz4Hx94KEGOUpADCUc7Nw5UhgcrTEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TaOM18VG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TaOM18VG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AC9634E42225;
	Fri, 23 Jan 2026 16:13:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F3A66070A;
	Fri, 23 Jan 2026 16:13:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EA9C119A87D8;
	Fri, 23 Jan 2026 17:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769184822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KWkTccmCT3nJgrNSLZ1R/jzxD1Y0UvqRHyoXQxdCfEk=;
	b=TaOM18VGmxTiCUeR/4iMknDf61aN4LVb5MlgCerGYbrjEx75KjIRTpr4yKSyGpD6K1gV3z
	A1qZHsbcApq1LvfTQS2BL0JTMrs4ipv5LPXczRP13nCDp004KEX51k+53d3/3cCw4+WzJ0
	IeSZZ3iMofLug0XWuRSC5+jgpxP8Gk5N4oN6S9owAH2wgQdyTE7yFQ7r8xFRaRc8pkbzbn
	EJyZp/x5m7xnYbc5KCaRDH8o5BMFu6Jry7e0oC8CBNrzjDrewoVtJ+CvdLfMroRz+2yPRl
	ybb1M5mRTwIDE5By9MPVY38CIu7+8CPOtT25nk87hM0IZZAWKcWnqllICd2TRw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Fri, 23 Jan 2026 17:12:38 +0100
Subject: [PATCH v5 20/25] drm/tilcdc: Use devm_drm_of_get_bridge() helper
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-feature_tilcdc-v5-20-5a44d2aa3f6f@bootlin.com>
References: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
In-Reply-To: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Tony Lindgren <tony@atomide.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-47773
X-Last-TLS-Session-Version: TLSv1.3

Replace drm_of_find_panel_or_bridge() with the newer
devm_drm_of_get_bridge() helper which simplifies the code by:
- Automatically handling both panel and bridge cases internally
- Managing the panel-to-bridge conversion when needed
- Using devres for resource management, eliminating manual cleanup

This removes the need for explicit panel-to-bridge conversion via
devm_drm_panel_bridge_add_typed() and the associated error handling path.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v4:
- New patch
---
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
index a34a10337f6a8..546fe7e6ee815 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
@@ -55,15 +55,12 @@ int tilcdc_encoder_create(struct drm_device *ddev)
 	struct tilcdc_drm_private *priv = ddev_to_tilcdc_priv(ddev);
 	struct tilcdc_encoder *encoder;
 	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
 
-	ret = drm_of_find_panel_or_bridge(ddev->dev->of_node, 0, 0,
-					  &panel, &bridge);
-	if (ret == -ENODEV)
+	bridge = devm_drm_of_get_bridge(ddev->dev, ddev->dev->of_node, 0, 0);
+	if (PTR_ERR(bridge) == -ENODEV)
 		return 0;
-	else if (ret)
-		return ret;
+	else if (IS_ERR(bridge))
+		return PTR_ERR(bridge);
 
 	encoder = drmm_simple_encoder_alloc(ddev, struct tilcdc_encoder,
 					    base, DRM_MODE_ENCODER_NONE);
@@ -73,12 +70,5 @@ int tilcdc_encoder_create(struct drm_device *ddev)
 	}
 	priv->encoder = encoder;
 
-	if (panel) {
-		bridge = devm_drm_panel_bridge_add_typed(ddev->dev, panel,
-							 DRM_MODE_CONNECTOR_DPI);
-		if (IS_ERR(bridge))
-			return PTR_ERR(bridge);
-	}
-
 	return tilcdc_attach_bridge(ddev, bridge);
 }

-- 
2.43.0

