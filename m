Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DF33FE05;
	Fri, 23 Jan 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184841; cv=none; b=uWiNhkcfQ10lVGF9OJuwnUcihcpPmGaTE852eOytUv1aS4AqgXlTUXoai7ZlyI4EsZxVBsxnrC8JF0fQCxpoN7IrXp+sKZ6V80kqbACTLPA1joOYQejQzi36MKdFbkDrlMYIiX+hE2TyfmzxWiBi5ba1WtG1EQ+PecGj3GrHRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184841; c=relaxed/simple;
	bh=aCeKtqd0YUBfyry4+WZOz2AteWtdXWDKKDiAdCUtl1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gWcLlrQ2yXYcVhpzsEPmwpVAFVrZxO6SSMbz1KP683sGiO027/O6tEQ/fzniCMBQAk/2euo4yZVPJnJg0t4SDbpSUkEoNcOpPMLrdxWl6cpZeHKn3z2J2YO7uHsqSsxnwxabQx2p/FMqd6DzI8Qvb/fiGEC0H63sx/RklCCHe+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vNzgRP/4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vNzgRP/4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DF4964E42222;
	Fri, 23 Jan 2026 16:13:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B2DC86070A;
	Fri, 23 Jan 2026 16:13:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C584E119A87A7;
	Fri, 23 Jan 2026 17:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769184833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Uo3AvkfjrdalsyUZuA1OMe08gwk1pI/nU7JxApdIRbQ=;
	b=vNzgRP/4QlyxmN1B6SPOg5bar16D4zA4TXor6BZ+mpQqOUe0HiV2XbQdL7hykbou68iU6X
	VpGFhPUqW5MR7Y70Oj9C5dTtlyjzA02q5Tw/65aEhkfq6WAgVocvqM4qjWIL/8xo6bNqvd
	0c3KEEjB5AHHbraDfusdIV++OKV22qrY9X7lMojmq6Ddfg5Z/nblofdexcbE6iqUKP8/Lv
	1qAi5jYGZPIB5PHzTEAIoZJbymgDYOAim8zfFO+n6DXBIxSScOBNwnC3m8GYRfFTn1R53E
	kNpaZf4w0ia5sj/NMWHM4eSKW2CyZnk3Hyq+fiAgdEb6ZvzN/R55yFanlEa4Sg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Fri, 23 Jan 2026 17:12:42 +0100
Subject: [PATCH v5 24/25] drm/bridge: tda998x: Add support for
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-feature_tilcdc-v5-24-5a44d2aa3f6f@bootlin.com>
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

Add support for the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag to allow display
controller drivers to create their own connectors. This modernizes the
driver to work with the current DRM bridge framework.

The implementation includes:
- Refactoring detection and EDID reading into bridge-usable helpers
- Adding bridge operations: edid_read, detect, hpd_enable, hpd_disable
- Setting appropriate bridge ops (DRM_BRIDGE_OP_EDID, DRM_BRIDGE_OP_DETECT,
  DRM_BRIDGE_OP_HPD) and connector type (HDMIA)
- Skipping connector creation when DRM_BRIDGE_ATTACH_NO_CONNECTOR is set
- Handling conditional connector cleanup in bridge_detach

The driver maintains backward compatibility by continuing to create its
own connector when the flag is not set.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 96 +++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index fad3c9bfda383..d9b388165de15 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1193,16 +1193,22 @@ static int tda998x_audio_codec_init(struct tda998x_priv *priv,
 
 /* DRM connector functions */
 
-static enum drm_connector_status
-tda998x_connector_detect(struct drm_connector *connector, bool force)
+static enum drm_connector_status tda998x_conn_detect(struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 	u8 val = cec_read(priv, REG_CEC_RXSHPDLEV);
 
 	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
 			connector_status_disconnected;
 }
 
+static enum drm_connector_status
+tda998x_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
+
+	return tda998x_conn_detect(priv);
+}
+
 static const struct drm_connector_funcs tda998x_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -1276,11 +1282,10 @@ static int read_edid_block(void *data, u8 *buf, unsigned int blk, size_t length)
 	return ret;
 }
 
-static int tda998x_connector_get_modes(struct drm_connector *connector)
+static const struct drm_edid *tda998x_edid_read(struct tda998x_priv *priv,
+						struct drm_connector *connector)
 {
-	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
 	const struct drm_edid *drm_edid;
-	int n;
 
 	/*
 	 * If we get killed while waiting for the HPD timeout, return
@@ -1298,6 +1303,16 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 	if (priv->rev == TDA19988)
 		reg_set(priv, REG_TX4, TX4_PD_RAM);
 
+	return drm_edid;
+}
+
+static int tda998x_connector_get_modes(struct drm_connector *connector)
+{
+	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
+	const struct drm_edid *drm_edid;
+	int n;
+
+	drm_edid = tda998x_edid_read(priv, connector);
 	drm_edid_connector_update(connector, drm_edid);
 	cec_notifier_set_phys_addr(priv->cec_notify,
 				   connector->display_info.source_physical_address);
@@ -1365,10 +1380,8 @@ static int tda998x_bridge_attach(struct drm_bridge *bridge,
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
-	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
-		DRM_ERROR("Fix bridge driver to make connector optional!");
-		return -EINVAL;
-	}
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
 
 	return tda998x_connector_init(priv, bridge->dev);
 }
@@ -1377,7 +1390,8 @@ static void tda998x_bridge_detach(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
-	drm_connector_cleanup(&priv->connector);
+	if (priv->connector.dev)
+		drm_connector_cleanup(&priv->connector);
 }
 
 static enum drm_mode_status tda998x_bridge_mode_valid(struct drm_bridge *bridge,
@@ -1677,6 +1691,59 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 	mutex_unlock(&priv->audio_mutex);
 }
 
+static const struct drm_edid *
+tda998x_bridge_edid_read(struct drm_bridge *bridge,
+			 struct drm_connector *connector)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	const struct drm_edid *drm_edid;
+	const struct edid *edid;
+
+	drm_edid = tda998x_edid_read(priv, connector);
+	if (!drm_edid) {
+		dev_dbg(&priv->hdmi->dev, "failed to get edid\n");
+		return NULL;
+	}
+
+	/*
+	 * FIXME: This should use connector->display_info.has_audio from
+	 * a path that has read the EDID and called
+	 * drm_edid_connector_update().
+	 */
+	edid = drm_edid_raw(drm_edid);
+
+	dev_dbg(&priv->hdmi->dev, "got edid: width[%d] x height[%d]\n",
+		edid->width_cm, edid->height_cm);
+
+	priv->sink_has_audio = drm_detect_monitor_audio(edid);
+	cec_notifier_set_phys_addr_from_edid(priv->cec_notify, edid);
+
+	return drm_edid;
+}
+
+static enum drm_connector_status
+tda998x_bridge_detect(struct drm_bridge *bridge,
+		      struct drm_connector *connector)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	return tda998x_conn_detect(priv);
+}
+
+static void tda998x_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
+}
+
+static void tda998x_bridge_hpd_disable(struct drm_bridge *bridge)
+{
+	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+
+	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
+}
+
 static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.attach = tda998x_bridge_attach,
 	.detach = tda998x_bridge_detach,
@@ -1684,6 +1751,10 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.disable = tda998x_bridge_disable,
 	.mode_set = tda998x_bridge_mode_set,
 	.enable = tda998x_bridge_enable,
+	.edid_read = tda998x_bridge_edid_read,
+	.detect = tda998x_bridge_detect,
+	.hpd_enable = tda998x_bridge_hpd_enable,
+	.hpd_disable = tda998x_bridge_hpd_disable,
 };
 
 /* I2C driver functions */
@@ -1872,6 +1943,7 @@ tda998x_probe(struct i2c_client *client)
 
 		/* enable HPD irq */
 		cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
+		priv->bridge.ops = DRM_BRIDGE_OP_HPD;
 	}
 
 	priv->cec_notify = cec_notifier_conn_register(dev, NULL, NULL);
@@ -1932,6 +2004,8 @@ tda998x_probe(struct i2c_client *client)
 	priv->bridge.of_node = dev->of_node;
 #endif
 
+	priv->bridge.ops |= DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
+	priv->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	drm_bridge_add(&priv->bridge);
 
 	return 0;

-- 
2.43.0

