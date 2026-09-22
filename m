Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B64BFE95;
	Tue, 22 Sep 2026 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057869; cv=none; b=OJ8l26UeclVjQfK0yWZ0jVimfyVRAH7lyUaMC5j9CDk8wPKvjkGd3MACPlnqdWEP0g14OkMfTT8Onk27K3TD/vEX9Ax9ggoOTI10aH2G086yQIP2rVgWkna9WLSIpXDokPzgg3U/ZKp7WQwpKpsjzMTd8Y7Kxz8TY6ZKgfbxSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057869; c=relaxed/simple;
	bh=SZZDOxjSbhFTa00lyQhARQyw0jJ19hBFtbzPZiAJf9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqYumJrPzQ7pne+p8718H7vwn0Xl1nxrvQxcQBmGDCaxGSw6t0F0sj9cZwbdaPZ5W6ipHOw6WHRavJsejJnya4GowJIpgsD+jQTRVlPlGczqk9qa3jgrKuBOKn+oiAtbt3KNeShWKmNavHy64ViqX82EJVI+GkNVravqjHXrTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=pb4P6Nay; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="pb4P6Nay"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=+7KDxv/cOzYl/nJudk7vFNU85IqTSwiD51deVVxls2Q=; t=1790057866; x=1791267466; 
	b=pb4P6NayGIfQTZ0xf59sGzdtgyP8SYcVq2pkhQbsCRWRh0LwclOMmqrI2XxYFKC0NG5n4uWX0PT
	7LKPSxwvW6D+GEHpmmtl2QmA6/zONQkWaXP38PQp3um4mA2R+mK+WtHeaVjRJ0hGNJCfs1IgZI8tY
	mNeGIe5GT76rj8bTsKDNmihEfTvqrnJ/GtcCtiw2W378B6CODKNLJo42gdRUSmhQoMke5aZpEWjFn
	OjkYsm90mYRAOc2Ra8NRS6BErPoSTJLcaYfSMYDCvqGqO6GHRGFO03DM4pMAwVt9T1KFVfAeQTi1h
	6d2Mm3vqyI5HwCGI5/af2RloKe0MzREgfK7Q==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:02 +0200
Subject: [PATCH RFC 5/9] drm/bridge: tc358762: add SPI master support to
 control panels
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-5-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=SZZDOxjSbhFTa00lyQhARQyw0jJ19hBFtbzPZiAJf9U=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBNDvi1598qg3py1O2PfsTkimQ1Rvw8dFWrlmbGGd
 4Hr+n7ZjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACayKoKR4chWjaNmEtc0bWs5
 v762E+ZRPu21I+x7yLqZ+eymi5PkNjD8M4o13uGv1Fq2e0/PqxABC//9TxZeWe16xviZ2M3SmI8
 ebAA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

To allow to use panels with their SPI port connected to the bridge, add
SPI master support. Due to lack of a complete datasheet, mode and speed
are not configurable. It is also unclear how CS behaves.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 72 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index ec72e6e92b46..8024e49e2868 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -16,6 +16,9 @@
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/unaligned.h>
 
 #include <video/mipi_display.h>
 #include <video/videomode.h>
@@ -72,7 +75,11 @@
 
 /* SPI Master Registers */
 #define SPICMR			0x0450
-#define SPITCR			0x0454
+#define SPI_SEL_CS0		0x0002
+
+#define SPITCR1			0x0454
+
+#define WCMDQUE			0x0500
 
 /* System Controller Registers */
 #define SYSCTRL			0x0464
@@ -98,6 +105,7 @@ struct tc358762 {
 	struct regulator *regulator;
 	struct drm_bridge *panel_bridge;
 	struct gpio_desc *reset_gpio;
+	struct spi_controller *spi;
 	bool pre_enabled;
 	int error;
 	bool use_vtg;
@@ -252,11 +260,25 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
+	/*
+	 * value just copied from vendor driver, no idea which settings
+	 * are configured
+	 */
+	if (ctx->spi)
+		tc358762_write(ctx, SPITCR1, 0x00000122);
+
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
 	tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
 
 	msleep(100);
 
+	/*
+	 * no idea when CS is actually asserted, maybe once per handling of
+	 * one packet written to WCMDQUE? Maybe just after setting SPI_SEL_CS0
+	 */
+	if (ctx->spi)
+		tc358762_write(ctx, SPICMR, SPI_SEL_CS0);
+
 	ret = tc358762_clear_error(ctx);
 	if (ret < 0)
 		dev_err(ctx->dev, "error initializing bridge (%d)\n", ret);
@@ -308,6 +330,40 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 	return 0;
 }
 
+static int tc358762_spi_transfer_one(struct spi_controller *ctlr,
+				     struct spi_device *spi,
+				     struct spi_transfer *t)
+{
+	struct tc358762 *ctx = spi_controller_get_devdata(ctlr);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	/*
+	 * limits to be determined, just define something which is
+	 * enough for current use case.
+	 */
+	u8 data[8];
+
+	if (!ctx->pre_enabled)
+		return -ENODEV;
+
+	if (t->len > sizeof(data) - 2)
+		return -EOVERFLOW;
+
+	/*
+	 * half duplex is supported by the bridge,
+	 * but due to lack of testing possibilities, support only simplex write
+	 */
+	if (t->rx_buf)
+		return -EINVAL;
+
+	if (!t->tx_buf)
+		return -EINVAL;
+
+	put_unaligned_le16(WCMDQUE, data);
+	memcpy(data + 2, t->tx_buf, t->len);
+
+	return mipi_dsi_generic_write(dsi, data, t->len + 2);
+}
+
 static int tc358762_configure_regulators(struct tc358762 *ctx)
 {
 	ctx->regulator = devm_regulator_get(ctx->dev, "vddc");
@@ -321,6 +377,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
 	struct tc358762 *ctx;
+	struct device_node *spi_node;
 	int ret;
 
 	ctx = devm_drm_bridge_alloc(dev, struct tc358762, bridge,
@@ -333,6 +390,19 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->dev = dev;
 	ctx->pre_enabled = false;
 
+	if (IS_ENABLED(CONFIG_SPI)) {
+		spi_node = of_get_child_by_name(dev->of_node, "spi");
+		if (spi_node) {
+			ctx->spi = devm_spi_alloc_host(dev, 0);
+			spi_controller_set_devdata(ctx->spi, ctx);
+			ctx->spi->transfer_one = tc358762_spi_transfer_one;
+			ctx->spi->dev.of_node = spi_node;
+			ret = devm_spi_register_controller(dev, ctx->spi);
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "register spi controller  failed\n");
+		}
+	}
+
 	/* Always use VTG */
 	ctx->use_vtg = true;
 

-- 
2.47.3

