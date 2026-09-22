Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF994C10D6;
	Tue, 22 Sep 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057867; cv=none; b=NneMWDcg7ctO+G6V8gSAVHZ+7jhJq8Cj96efdvW5LbGFYHDe0CftlOlBHtchebIBgYJK9LSde4/xZVJNoMRs82yAbOJy8GJ45rWvzqYPvJKf388ZoBUDskqyDd5pS2YOE6cKPziVBM94cWpD6SKehmu1N9AXb/O25iO7LYstHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057867; c=relaxed/simple;
	bh=0ao++1qEowCnecwI5jgyBfK+9SvJvTxqa1J5MX+7yTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJp+xud2AS4sTdlWc9Vv9ks1sGMFsk6dTcowdLdm6QGl7/t5gxeGDZDNl+QNO2i0vXmfmUfbXdN1+F4pOnb8m/kpPfyC0qsCL1/RnHp/6lG4kqfH2O72grzNkjovVjNqVGIvgkOY9nhbuUrn65oU9VfXxJpTLiVgO+3Ig/vTxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=D51TndKW; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="D51TndKW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=3ek7mJzGL/9yBolrQvEtoJoyM66ZQqkeJgFGLDJjQUc=; t=1790057865; x=1791267465; 
	b=D51TndKWkJeuNS3mIX0Foi6uG7JXDGcFTm4hyHncoIndP4ar0k0rSaGzbN/zYIUfJ7BIkqx60d9
	i9OX+5jIc3i7T33ml9NCwImvTi0FBFesicF7FI3G2fB6LG+OnGQJnJioXd9iyIly6Pqpl6OndfJBN
	rv/jYhzWNjVt95V+9PffqFeIPMxVVbzptZOZqBFk79KyHFDL1xpfoqf03gKTnyo4woJ16wcR8TWYR
	Q3r55R4gxtPBklGB5+GWox45CIRurOdrFArVMBE0IfAoXWIV+dKx1kGQ3+F6nYbmbuYocb3GDSIyh
	HNLZFUMvBcOI2NZOrB3ma3xEDEX9URxaTgAQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:04 +0200
Subject: [PATCH RFC 7/9] drm/bridge: tc358762: make LPTXTIMECNT
 configurable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-7-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=0ao++1qEowCnecwI5jgyBfK+9SvJvTxqa1J5MX+7yTk=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBP3lnEYsDT8vnSsiYtbS3mP8PS81sUrzv3za2F6J
 pKQe0Oyo5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIlYVzD8z/v7h3F2sIHUllv8
 rt1WPpz/t8t11GvJch68G2S+Y09kIsM/09uFbS+CY2L583ncJjGEHvrma3XS+VvX43NvNmt/Voz
 gAwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

On the Epson Moverio BT-200, reading back registers does not work with the
default value, so make it configurable. Real meaning of this value is not
known from public sources.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 1bea89fb03a8..194785bff997 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -101,8 +102,6 @@
 
 #define IDREG			0x04A0 /* Chip and Revision ID */
 
-#define LPX_PERIOD		3
-
 struct tc358762 {
 	struct device *dev;
 	struct drm_bridge bridge;
@@ -112,6 +111,7 @@ struct tc358762 {
 	struct spi_controller *spi;
 	bool pre_enabled;
 	int error;
+	u32 lpx_period;
 	bool use_vtg;
 };
 
@@ -246,7 +246,7 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D0S_ATMR, 0);
 	tc358762_write(ctx, PPI_D1S_ATMR, 0);
-	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
+	tc358762_write(ctx, PPI_LPTXTIMECNT, ctx->lpx_period);
 
 	if (ctx->use_vtg) {
 		struct videomode vm = { 0 };
@@ -367,6 +367,9 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 	if (IS_ERR(ctx->reset_gpio))
 		return PTR_ERR(ctx->reset_gpio);
 
+	ctx->lpx_period = 3;
+	device_property_read_u32(dev, "toshiba,lptxtimecnt", &ctx->lpx_period);
+
 	return 0;
 }
 

-- 
2.47.3

