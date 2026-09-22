Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE534C10C6;
	Tue, 22 Sep 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057868; cv=none; b=E61FOqx5/STe+A2pTkSR6XZA2fMfSXcVe6saI424xXNgu21A5jf4pczzOtw7OIyZ1kejJ9LVae9UbVgi8+3VEJz7SqDbSmAyt7JeYeiMWyqrZk+15nq0vkihBxmj+aqiHqaQMu9HJ4mEax7V5QfaH8QAWrV2rk4P3QeeZB0YYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057868; c=relaxed/simple;
	bh=ZJ58LzJ2jrYN033jXkMli6AXdpzXramyNMhGzt3PCbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7N0TasfWk5WEq1xOds9Udy8VEynLouzceV2WHc8RLIXAzDM/HcTUL8vb1lAawV8dMH311vRy5wgt33sd/jPXIXn166O59VkX9T+2CkXUF3HgtLCR5GU+pTvP0hs7lIWu6/LFZgjE+jZhfrUpcO9qqxcUyd5CzHtdf21LHDPf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=wn+gTUPz; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="wn+gTUPz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=vJZZJlgqSTq1ItDpGK2L5K9Nw6kWH7euwhjPFDICo3Y=; t=1790057865; x=1791267465; 
	b=wn+gTUPz2Ia0pRLOP6b3B1893QjIW/Xe3mMIWXoSYRd/jB2QyEhU6jHWRT0ANP9Cd5DmJ5Ybg4f
	f4wSU6U5MaOvpHJsoXmuYJvhDMpjutYYjJomJnucPltDBydy7zPn/SQwCI0Q8ngu4/MrejdMcyoRb
	Q0gT4MWTZtZhIp9WmE40ITTRhJhpVZ2yOtU5FakUQ+LV78XvHYcNwoR9L+wenZuicpfuY+UqCgMx8
	0QCGq6SX8nhxwmllGkrWtb8oTHy518oFYyuhnDhaX8dX9C+B34R+uYGx42OupPfQLUqumbcK1+jKh
	acdE5pI5e4ikPAKBpGuI9KTpRb700sjLtKxA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:05 +0200
Subject: [PATCH RFC 8/9] drm/bridge: tc358762: Basic support for 2 lanes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-8-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6006; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=ZJ58LzJ2jrYN033jXkMli6AXdpzXramyNMhGzt3PCbE=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBPj7of3ZlyqFj2o/DC94IoQo27kwiqVmbuO86hOk
 tS38LrdUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwEQW1DL8T1/AZjnlda681uzJ
 VZM11r1YUdkdvfNq4L0veSab+hhYYxkZerz+TA5S0LEralA/uXLjorQbKxcXWJa9/dMemVf1aXs
 MGwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add support for 2 data lanes. Enabling the PLL is required. This are just
the values working for the Epson Moverio BT-200. With the standard mode
flags, the panel mode was deemed unusable, adjust them to have more freedom
in case of 2 data lanes operation.
Nice looking values for the input clock for the PLL were not found.

Setting the required register needs special sequences, entering ULPS in
between is the way to do it in the vendor kernel. It seems that some
stop mode transitions are also enough. This all seems not to work
if LPM is used for writing the register, to temporarily disable that.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 87 +++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 194785bff997..632597fec20d 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -100,6 +100,8 @@
 #define SYSCTRL_PCLKDIV_DIV_2	2
 #define SYSCTRL_PCLKDIV_DIV_3	4
 
+#define SYSPLL3                         0x0470          /*  */
+
 #define IDREG			0x04A0 /* Chip and Revision ID */
 
 struct tc358762 {
@@ -183,6 +185,7 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 	if (!ctx->pre_enabled)
 		return;
 
+	to_mipi_dsi_device(ctx->dev)->mode_flags |= MIPI_DSI_MODE_LPM;
 	ctx->pre_enabled = false;
 
 	/* Turn off the DPI output */
@@ -208,7 +211,9 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	u32 lcdctrl;
 	int ret;
 	u32 id;
+	u32 sysctrl;
 
+	to_mipi_dsi_device(ctx->dev)->mode_flags |= MIPI_DSI_MODE_LPM;
 	ret = regulator_enable(ctx->regulator);
 	if (ret < 0)
 		dev_err(ctx->dev, "error enabling regulators (%d)\n", ret);
@@ -233,15 +238,26 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 
 	tc358762_write(ctx, RDPKTLN, 3);
 
-	tc358762_write(ctx, SYSCTRL,
-		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
-		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
-		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
+	sysctrl = FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
+		  FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA);
+
+	if (to_mipi_dsi_device(ctx->dev)->lanes == 2)
+		sysctrl |= FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_2);
+	else
+		sysctrl |= FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3);
+
+	tc358762_write(ctx, SYSCTRL, sysctrl);
 
 	msleep(100);
 
-	tc358762_write(ctx, DSI_LANEENABLE,
-		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
+	if (to_mipi_dsi_device(ctx->dev)->lanes == 2)  {
+		tc358762_write(ctx, DSI_LANEENABLE,
+			       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN |
+			       DSI_LANEENABLE_L1EN);
+	} else {
+		tc358762_write(ctx, DSI_LANEENABLE,
+			       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
+	}
 	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D0S_ATMR, 0);
@@ -329,6 +345,43 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 static void tc358762_enable(struct drm_bridge *bridge,
 			    struct drm_atomic_commit *state)
 {
+	struct tc358762 *ctx = bridge_to_tc358762(bridge);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
+	u32 syspll;
+
+	if (dsi->lanes == 2) {
+		tc358762_read(ctx, SYSPLL3, &syspll);
+		dev_dbg(ctx->dev, "syspll reg: %x\n", syspll);
+		/*
+		 * as handling of these registers is bound to certain
+		 * conditions, avoid write if already set
+		 */
+		if (syspll != 0xB8640000) {
+			dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+			/*
+			 * SYSPLL3 seems to get set to 0x47000000 without it.
+			 * Also trigger some stop mode transitions
+			 * TODO: find some sane value for clock input and add proper dividers
+			 */
+			tc358762_write(ctx, SYSPLL3, 0xB8640000);
+			ret = tc358762_clear_error(ctx);
+			if (ret) {
+				dev_err(ctx->dev, "error writing to SYSPLL3: %d\n", ret);
+				return;
+			}
+
+			msleep(20);
+			/*
+			 * control read to see if this is wonky, probably also includes
+			 * stop mode transitions
+			 */
+			ret = tc358762_read(ctx, SYSPLL3, &syspll);
+
+			if ((ret) || (syspll != 0xB8640000))
+				dev_err(ctx->dev, "failed to configure PLL %d\n", ret);
+		}
+	}
 }
 
 static int tc358762_attach(struct drm_bridge *bridge,
@@ -355,6 +408,7 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 {
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
+	u32 lanes;
 
 	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
 	if (IS_ERR(panel_bridge))
@@ -367,6 +421,13 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 	if (IS_ERR(ctx->reset_gpio))
 		return PTR_ERR(ctx->reset_gpio);
 
+	if (!device_property_read_u32(dev, "dsi-lanes", &lanes)) {
+		if (lanes > 2)
+			return -EINVAL;
+
+		to_mipi_dsi_device(ctx->dev)->lanes = lanes;
+	}
+
 	ctx->lpx_period = 3;
 	device_property_read_u32(dev, "toshiba,lptxtimecnt", &ctx->lpx_period);
 
@@ -459,13 +520,21 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	 */
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
-
 	ret = tc358762_parse_dt(ctx);
 	if (ret < 0)
 		return ret;
 
+	if (dsi->lanes == 2) {
+		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+				  MIPI_DSI_CLOCK_NON_CONTINUOUS |
+				  MIPI_DSI_MODE_LPM;
+
+		dsi->hs_rate = 800000000;
+		dsi->lp_rate = 9200000;
+	} else
+		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+				  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
+
 	ret = tc358762_configure_regulators(ctx);
 	if (ret < 0)
 		return ret;

-- 
2.47.3

