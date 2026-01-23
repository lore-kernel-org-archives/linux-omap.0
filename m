Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53E30BBA6;
	Fri, 23 Jan 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184793; cv=none; b=AI1vpYB1MQaxppCmdUuf3LNmusNlIY7BGHqiboRfe79psv4n80BI4mEoNPuK4bSUr2pBeEGzMUjp1GILGLTdqNk29E064Ylwrq/Evo9AcpCWj5f+dUaUTFeBqs5mclpCPBv/1x+cDmDmiLio53FTBVBXquAKlDxEwmPhIdL09jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184793; c=relaxed/simple;
	bh=anGOjvXR2sBBPtdkToB8G08+cDbS6A1JOlVxqn5NMo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k05AXzxHTskUpuGbXWt9gaT+cOAtDHaejU59dFW1REdbtXnWXOuyd+lwBdqq3Tg/L0kpTeOv4g92KZif4f0TmS31Bej7o8XxXSDDtR4MUQtsRXUhYPpD0atUi5tYsmcMruYfThq8p8Dx0aIKOUF5Xiku8jIbd6X2ACqC9zWQVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UZhtlZNG; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UZhtlZNG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 707C7C1F1D0;
	Fri, 23 Jan 2026 16:13:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 227E76070A;
	Fri, 23 Jan 2026 16:13:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A635119A87A9;
	Fri, 23 Jan 2026 17:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769184785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VSTYR5rD8uZJr/69XSbhWZhicV+2XxA/spuf43LjPJU=;
	b=UZhtlZNGWPxInEvj9zRuRCXSDZVbFTqJJSyFiNjvvOET/0ffqRgAun11gbwAI+1Kbz3D74
	4z/TxKl5v2qXjDCry0cvNXmIAbIAwvJzztj3qsNIfUqxtRqXjU1bVg55vctbqM2GTGhMHU
	bghIzcpn4dKuqzAUb5yrNGNT7DnODZsB6ybgh+0tOG0iDpPJameiFZl6/W2z9jqEB7cb0E
	kDppaz5k+yqGReI0O0T2EAPfGQ9x2REBp5mvuBm4Xt23+MVclng4UrjKHqYWVKlHU4BdnP
	smEzUUj30/TMoA1dP8QMC1j7/OetGVo01+iSzGGVFRCBvEcc6SqNrhNheKtahQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Fri, 23 Jan 2026 17:12:27 +0100
Subject: [PATCH v5 09/25] drm/tilcdc: Remove redundant #endif/#ifdef in
 debugfs code
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-feature_tilcdc-v5-9-5a44d2aa3f6f@bootlin.com>
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

Remove the unnecessary #endif/#ifdef CONFIG_DEBUG_FS pair that splits
the debugfs code section. This keeps all debugfs-related code within a
single preprocessor conditional block, improving code readability.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index f865c131dae66..fd6764ce80afa 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -429,9 +429,6 @@ static const struct {
 #undef REG
 };
 
-#endif
-
-#ifdef CONFIG_DEBUG_FS
 static int tilcdc_regs_show(struct seq_file *m, void *arg)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;

-- 
2.43.0

