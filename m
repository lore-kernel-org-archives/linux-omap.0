From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 1/3] drm: encoder_slave: Add drm_i2c_encoder_attach()
Date: Tue, 13 Jan 2015 19:12:26 +0200
Message-ID: <03c8beb19439c8c20770bba34178c8b7053a5f1d.1421167634.git.jsarha@ti.com>
References: <cover.1421167634.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55032 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbbAMRMk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 12:12:40 -0500
In-Reply-To: <cover.1421167634.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Add drm_i2c_encoder_attach() for attaching an already probed i2c
encoder. This is needed for instance if the encoder is probed from
device tree.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/drm_encoder_slave.c |   51 +++++++++++++++++++++++++++++++++++
 include/drm/drm_encoder_slave.h     |    3 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/drm_encoder_slave.c b/drivers/gpu/drm/drm_encoder_slave.c
index d18b88b..ed627f7 100644
--- a/drivers/gpu/drm/drm_encoder_slave.c
+++ b/drivers/gpu/drm/drm_encoder_slave.c
@@ -120,6 +120,57 @@ void drm_i2c_encoder_destroy(struct drm_encoder *drm_encoder)
 }
 EXPORT_SYMBOL(drm_i2c_encoder_destroy);
 
+/**
+ * drm_i2c_encoder_attach - Attach an I2C slave encoder
+ * @dev:	DRM device.
+ * @encoder:	Encoder to be attached to the I2C device. You aren't
+ *		required to have called drm_encoder_init() before.
+ * @client:	I2C encoder to be attached.
+ *
+ * Attach the I2C device specified to the specified &drm_encoder_slave.
+ * The @slave_funcs field will be initialized with the hooks provided by
+ * the slave driver.
+ *
+ * Returns 0 on success or a negative errno on failure, in particular,
+ * -ENODEV is returned when no matching driver is found.
+ */
+int drm_i2c_encoder_attach(struct drm_device *dev,
+			   struct drm_encoder_slave *encoder,
+			   struct i2c_client *client)
+{
+	struct drm_i2c_encoder_driver *encoder_drv;
+	struct module *module = NULL;
+	int err = 0;
+
+	if (!client->dev.driver) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+	module = client->dev.driver->owner;
+	if (!try_module_get(module)) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+	encoder->bus_priv = client;
+
+	encoder_drv =
+		to_drm_i2c_encoder_driver(to_i2c_driver(client->dev.driver));
+
+	err = encoder_drv->encoder_init(client, dev, encoder);
+	if (err)
+		goto fail_put;
+
+	return 0;
+
+fail_put:
+	module_put(module);
+fail:
+	return err;
+}
+EXPORT_SYMBOL(drm_i2c_encoder_attach);
+
 /*
  * Wrapper fxns which can be plugged in to drm_encoder_helper_funcs:
  */
diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
index 8b9cc36..4f7f8d5 100644
--- a/include/drm/drm_encoder_slave.h
+++ b/include/drm/drm_encoder_slave.h
@@ -106,6 +106,9 @@ int drm_i2c_encoder_init(struct drm_device *dev,
 			 struct i2c_adapter *adap,
 			 const struct i2c_board_info *info);
 
+int drm_i2c_encoder_attach(struct drm_device *dev,
+			   struct drm_encoder_slave *encoder,
+			   struct i2c_client *client);
 
 /**
  * struct drm_i2c_encoder_driver
-- 
1.7.9.5

