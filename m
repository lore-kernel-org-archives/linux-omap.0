Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83FB4C33DE;
	Tue, 22 Sep 2026 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057869; cv=none; b=biuW/OiuzQWsxVGgajsOG0AsoiXzry8NUwCDEyzz3v0PhhAE+jFsUCBICoso+OJCVTmeOTMFyXoilP/6oOFOvN9j92DtcJwj73Fk42oxMWXdgvovkASgBBbWUw62ETI8s30FCw2s8RqvGmY3upkpwn/HwdxaWwaZFDqG1BARa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057869; c=relaxed/simple;
	bh=Dlvgd0UudJORSQnd74jpr6AQcYnRPW/gMWkWTlZoOBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ON4kVGCnOeBU3YOm6RKEVMYyuXLgoPSjIQCR96ru7kSEOr8tJHz+SYzVkfXNT5MrNHUJikOE8Vt3RQ4lnq/EcG3DDGWAD6KKRX4dCXlOCDJn02Wrm7wzsPtQPKajbeLXXmc/qFxqreKJSHVLUxCCe3ncieUtR+0jnzmsHmupDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=0BL5ehbb; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="0BL5ehbb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=gUei3VkdYe4QGVULvKFk3kc0jWO1YmCI+V/38vza53A=; t=1790057866; x=1791267466; 
	b=0BL5ehbbWfsdD1qqR6ujjCNPEKiDNiXSn76vJRq2R+I3fMbHY+lfu18G0Oc2OCjI5ERi3+w3AXp
	5dX9uZ8PHUZdeFbiaZ6CfZpEJXE4n0LcIVnNxxUeUMveaxUBN8HNmgU/hc8F7+FSN7zHz6qreJN6v
	vgm1tJFrRZY6V8HgPg7Yo5IgUXes96cFUTFNJAFX9kW1RejM2hfVdt4cU/2aBvc7FCQ8doPt0ZutQ
	MyC/n0YGcPGRzrJDZd216o5/3jn+mkXIEGGgcvJB6NnMZYERkFGAdF7Re397pPhYI8WvaXmvz5RyO
	/p0q75LKe/rMZ5XGcS7rHZFevBJTnVN3FYnQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:16:59 +0200
Subject: [PATCH RFC 2/9] drm: panel: Add panel for Epson Moverio BT200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-2-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=9695; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=Dlvgd0UudJORSQnd74jpr6AQcYnRPW/gMWkWTlZoOBI=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBN+yR+Uke8OXSH79cjLxCXlmw6aCYcukk+cGnVij
 koow7OZHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAEyk7gcjw/uFCjdfLc5ZJ6ij
 wX91sZHi9ln2iQslKldnB3b/kw/7aMDw32lOtRx374GXjZtsg57c7xHY2KYuq8EfkhQZ/+xmykw
 3XgA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Not much is known about the panel, initialisation sequence
and parameters come from the vendor kernel. As it is located
in glasses, it is hard to disassemble to find out more.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/panel/Kconfig             |  10 ++
 drivers/gpu/drm/panel/Makefile            |   1 +
 drivers/gpu/drm/panel/panel-epson-bt200.c | 251 ++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index cbdf7b8f7f7a..0cb56687294d 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -159,6 +159,16 @@ config DRM_PANEL_ELIDA_KD35T133
 	  KD35T133 controller for 320x480 LCD panels with MIPI-DSI
 	  system interfaces.
 
+config DRM_PANEL_EPSON_BT200
+	tristate "Epson BT200 panel driver"
+	depends on OF && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the 960x540
+	  pixel panels used in the Epson Moverio BT200. They are used
+	  together with the TC358762 DSI-to-DPI bridge. To compile this
+	  driver as a module, choose M here.
+
 config DRM_PANEL_FEIXIN_K101_IM2BA02
 	tristate "Feixin K101 IM2BA02 panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 3b523cf37833..921af234d335 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
 obj-$(CONFIG_DRM_PANEL_EDP) += panel-edp.o
 obj-$(CONFIG_DRM_PANEL_EBBG_FT8719) += panel-ebbg-ft8719.o
 obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
+obj-$(CONFIG_DRM_PANEL_EPSON_BT200) += panel-epson-bt200.o
 obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) += panel-feixin-k101-im2ba02.o
 obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
 obj-$(CONFIG_DRM_PANEL_FOCALTECH_OTA7290B) += panel-focaltech-ota7290b.o
diff --git a/drivers/gpu/drm/panel/panel-epson-bt200.c b/drivers/gpu/drm/panel/panel-epson-bt200.c
new file mode 100644
index 000000000000..c26a4f8ae15e
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-epson-bt200.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/backlight.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+#include <linux/spi/spi.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+static const struct drm_display_mode default_mode = {
+	.clock			= 41600,	/* kHz */
+#if 0
+	/* values matching struct omap_video_timings in vendor kernel */
+	.hdisplay		= 960,
+	.hsync_start		= 960 + 176,
+	.hsync_end		= 960 + 176 + 20,
+	.htotal			= 960 + 176 + 20 + 86,
+#else
+	/* values from what is writted to LCDCTRL on vendor kernel */
+	.hdisplay		= 960,
+	.hsync_start		= 960 + 33,
+	.hsync_end		= 960 + 33 + 20,
+	.htotal			= 960 + 33 + 20 + 86,
+#endif
+	.vdisplay		= 540,
+	.vsync_start		= 540 + 9,
+	.vsync_end		= 540 + 9 + 3,
+	.vtotal			= 540 + 9 + 3 + 12,
+	.flags			= 0,
+};
+
+struct bt200_panel {
+	struct drm_panel panel;
+	struct spi_device *spi;
+};
+
+static int bt200_panel_write(struct bt200_panel *ctx, u8 addr, u8 data)
+{
+	u8 val[2];
+
+	val[0] = addr;
+	val[1] = data;
+
+	return spi_write(ctx->spi, val, sizeof(val));
+}
+
+static inline struct bt200_panel *panel_to_bt200(struct drm_panel *panel)
+{
+	return container_of(panel, struct bt200_panel, panel);
+}
+
+static int bt200_disable(struct drm_panel *panel)
+{
+	struct bt200_panel *ctx = panel_to_bt200(panel);
+
+	bt200_panel_write(ctx, 0x0A, 0);
+	return 0;
+}
+
+static int bt200_unprepare(struct drm_panel *panel)
+{
+	return 0;
+}
+
+/* found this table in vendor kernel */
+static struct {
+	u8 addr;
+	u8 data;
+} lcddr_init[] = {
+	{0x01, 0x00}, {0x02, 0x00}, {0x03, 0x00}, {0x05, 0x01},
+	{0x07, 0x00}, {0x0A, 0x00}, {0x10, 0x03}, {0x11, 0x44},
+	{0x12, 0x44}, {0x13, 0x55}, {0x14, 0x03}, {0x15, 0x00},
+	{0x16, 0x2A}, {0x17, 0x20}, {0x18, 0x00}, {0x19, 0x10},
+	{0x1A, 0x12}, {0x1B, 0x0E}, {0x1C, 0x0F}, {0x1D, 0x10},
+	{0x1E, 0x0F}, {0x1F, 0x1B}, {0x20, 0x0F}, {0x21, 0x00},
+	{0x22, 0x00}, {0x23, 0x00}, {0x24, 0x00}, {0x28, 0x14},
+	{0x29, 0x19}, {0x2A, 0x17}, {0x2B, 0x2B}, {0x2C, 0x99},
+	{0x2D, 0x13}, {0x2E, 0x2A}, {0x30, 0x0B}, {0x31, 0x00},
+	{0x32, 0x00}, {0x33, 0x01}, {0x34, 0x00}, {0x35, 0x0B},
+	{0x36, 0x04}, {0x37, 0x21}, {0x38, 0x00}, {0x39, 0x46},
+	{0x3A, 0x01}, {0x3B, 0x06}, {0x3C, 0x03}, {0x3D, 0x00},
+	{0x3E, 0x06}, {0x3F, 0x04}, {0x40, 0x00}, {0x41, 0x0D},
+	{0x42, 0x00}, {0x43, 0x2E}, {0x45, 0x08}, {0x46, 0x00},
+	{0x47, 0x01}, {0x48, 0x00}, {0x49, 0x00}, {0x4A, 0x0B},
+	{0x4B, 0x38}, {0x4C, 0x03}, {0x4D, 0x04}, {0x50, 0x0F},
+	{0x51, 0x04}, {0x52, 0x01}, {0x53, 0x0E}, {0x54, 0x11},
+	{0x55, 0x9F}, {0x56, 0x36}, {0x57, 0x00}, {0x58, 0x68},
+	{0x59, 0x01}, {0x5A, 0xE0}, {0x5B, 0x00}, {0x5C, 0x00},
+	{0x5D, 0x10}, {0x5E, 0x36}, {0x5F, 0x36}, {0x60, 0x00},
+	{0x61, 0x04}, {0x62, 0x12}, {0x63, 0x00}, {0x64, 0x80},
+	{0x65, 0x00}, {0x66, 0x80}, {0x67, 0x1C}, {0x68, 0x00},
+	{0x69, 0x00}, {0x6A, 0x00}, {0x6B, 0x00}, {0x6C, 0x00},
+	{0x70, 0x00}, {0x71, 0x55}, {0x72, 0x44}, {0x73, 0x33},
+	{0x74, 0x22}, {0x75, 0x33}, {0x76, 0x22}, {0x77, 0x22},
+	{0x78, 0x33}, {0x79, 0x22}, {0x7A, 0x44}, {0x7B, 0x55},
+	{0x7C, 0x00}, {0x80, 0x00}, {0x81, 0x66}, {0x82, 0x22},
+	{0x83, 0x33}, {0x84, 0x22}, {0x85, 0x33}, {0x86, 0x22},
+	{0x87, 0x22}, {0x88, 0x33}, {0x89, 0x44}, {0x8A, 0x44},
+	{0x8B, 0x44}, {0x8C, 0x00}, {0x90, 0x00}, {0x91, 0x77},
+	{0x92, 0x66}, {0x93, 0x33}, {0x94, 0x11}, {0x95, 0x33},
+	{0x96, 0x22}, {0x97, 0x22}, {0x98, 0x44}, {0x99, 0x44},
+	{0x9A, 0x33}, {0x9B, 0x44}, {0x9C, 0x00}, {0xA0, 0x88},
+	{0xA1, 0x88}, {0xA2, 0x88}, {0xA3, 0x88}, {0xA4, 0x88},
+	{0xA5, 0x88}, {0xA6, 0x88}, {0xA7, 0x88}, {0xA8, 0x88},
+	{0xA9, 0x88}, {0xAA, 0x88}, {0xAB, 0x88}, {0xAC, 0x88},
+	{0xAD, 0x88}, {0xAE, 0x88}, {0xAF, 0x88}, {0xB0, 0x88},
+	{0xB1, 0x88}, {0xB2, 0x88}, {0xB3, 0x88}, {0xB4, 0x88},
+	{0xB5, 0x88}, {0xB6, 0x88}, {0xB7, 0x88}, {0xB8, 0x88},
+	{0xB9, 0x88}, {0xBA, 0x88}, {0xBB, 0xA6}, {0xBC, 0x88},
+	{0xBD, 0x88}, {0xBE, 0x88}, {0xBF, 0x88}, {0xC0, 0x88},
+	{0xC1, 0x88}, {0xC2, 0x88}, {0xC3, 0x88}, {0xC4, 0x88},
+	{0xC5, 0x88}, {0xC6, 0x88}, {0xC7, 0x88}, {0xC8, 0x88},
+	{0xC9, 0x88}, {0xD0, 0x36}, {0xD1, 0x26}, {0xD2, 0x21},
+	{0xD3, 0x1F}, {0xD4, 0x17}, {0xD5, 0x15}, {0xD6, 0x13},
+	{0xD7, 0x10}, {0xD8, 0x08}, {0xD9, 0x08}, {0xDA, 0x18},
+	{0xDB, 0x1D}, {0xDC, 0x1F}, {0xDD, 0x27}, {0xDE, 0x29},
+	{0xDF, 0x2B}, {0xE0, 0x2E}, {0xE1, 0x36}, {0xE6, 0x00},
+	{0xF1, 0x00}, {0xF2, 0x00}, {0xF3, 0x00}
+};
+
+static int init_lcd(struct bt200_panel *ctx)
+{
+	int i;
+	int r;
+
+	r = spi_setup(ctx->spi);
+	if (r < 0)
+		return r;
+
+	for (i = 0; i < ARRAY_SIZE(lcddr_init); ++i) {
+		r = bt200_panel_write(ctx, (u16)lcddr_init[i].addr,
+				      lcddr_init[i].data);
+		if (r) {
+			dev_err(ctx->panel.dev, "failed to write initial config (write) %d\n", i);
+			return r;
+		}
+	}
+
+	return 0;
+}
+
+static int bt200_prepare(struct drm_panel *panel)
+{
+	int r;
+	struct bt200_panel *ctx = panel_to_bt200(panel);
+
+	r = init_lcd(ctx);
+	if (r)
+		return r;
+
+	msleep(50);
+	return 0;
+}
+
+static int bt200_enable(struct drm_panel *panel)
+{
+	struct bt200_panel *ctx = panel_to_bt200(panel);
+
+	return bt200_panel_write(ctx, 0x0A, 1);
+}
+
+static int bt200_get_modes(struct drm_panel *panel, struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs bt200_panel_funcs = {
+	.disable = bt200_disable,
+	.unprepare = bt200_unprepare,
+	.prepare = bt200_prepare,
+	.enable = bt200_enable,
+	.get_modes = bt200_get_modes,
+};
+
+static int bt200_probe(struct spi_device *spi)
+{
+	struct bt200_panel *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(&spi->dev, struct bt200_panel, panel,
+				   &bt200_panel_funcs, DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	spi_set_drvdata(spi, ctx);
+	ctx->spi = spi;
+	ctx->panel.prepare_prev_first = true;
+
+	spi->bits_per_word = 8;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+	return 0;
+}
+
+static void bt200_remove(struct spi_device *dsi)
+{
+	struct bt200_panel *ctx = spi_get_drvdata(dsi);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id bt200_of_match[] = {
+	{ .compatible = "epson,panel-bt200", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, bt200_of_match);
+
+static const struct spi_device_id bt200_ids[] = {
+	{ "panel-bt200", 0 },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(spi, bt200_ids);
+
+static struct spi_driver bt200_driver = {
+	.probe = bt200_probe,
+	.remove = bt200_remove,
+	.id_table = bt200_ids,
+	.driver = {
+		.name = "panel-bt200",
+		.of_match_table = bt200_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+module_spi_driver(bt200_driver);
+
+MODULE_AUTHOR("Andreas Kemnade <andreas@kemnade.info>");
+MODULE_DESCRIPTION("bt200 panel driver");
+MODULE_LICENSE("GPL");

-- 
2.47.3

