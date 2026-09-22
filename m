Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2584BFE76;
	Tue, 22 Sep 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057866; cv=none; b=HEM7XEJb+HOxhd5sgQBD+0dAs+3vFO7rh6N8esnAyDuxYiAv28wKRgTQJIn07wLfnHbjzm9PLlGo2h3ZSRHF5pExm8o0Pq0HrmhmJjbSY22tOTCFem/3PMGi2bmozjutoUYqwJAMjAOBsf9bLPaZrrbRbTPdyRSOme/2aG5AAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057866; c=relaxed/simple;
	bh=4czSwLJZTsPrde7Ae78uOhAxPABOjbRqzcFREuBtK58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQz5+YHf9MU/zBN/vW4GV0bJE/HqeUse7D40LgDEu/HTslkUWI9TatwYuVvPjjhTjtE9Vg+YtULLuIkx4bsgyDvhWnMbotJzVjjD5jtMiU4obuQIaCRv2d6P32Aaxt7hCGccJfRnJ3uWWWRjKCaBhtu2PV8IMYlA3HlgE3xlnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=OADrxjxJ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="OADrxjxJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=AXgjdnDVE3P4oyz6CPuYyFf3otjEytHlCZ6PP8kE4jo=; t=1790057865; x=1791267465; 
	b=OADrxjxJEarq6+sWLEsagEVLfYOIRR30okq2DRVsa5LNadgphnwjU2sAl2eWUzkDacU1UDwxHwn
	79ATjNPb6bWlQOTKwX37D1mgOlaCtxjUZCPaIAFFaEgjWnWr6f3kryRTsrVZ/8sfKURSy6ARwoKC/
	EVL9b9/2aYlrQm2WvTgU8VHUoOODJeja6W1e/Lwg5FmVngW7q2FW0qb6OLX0UZaom+vtcFGeZ3Av3
	+eJA9GxW5OsyI/tKBdJwyAWRvGDVGiB3iDYXc9M+rQd/n1ar8xxMsMUzgmyU8gn/67OiL394S/sqc
	1IAeJEej5JdIuTRjzD9FpB5+PaH9XZALcFvw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:01 +0200
Subject: [PATCH RFC 4/9] drm/bridge: tc358762: Move initialisation to
 pre_enable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-4-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=4czSwLJZTsPrde7Ae78uOhAxPABOjbRqzcFREuBtK58=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBPaD98NTmXxXjQ96vrfZ/ZXTHsWb9Q2v79m7bmfv
 Cu3fNbg7yhlYRDjYpAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAiD6wZ/pcr75WfdHEuU3C5
 +AfmW/8O5MX++2/U+nxbTqZW+4rZJw8w/LM7vTjb7OGbh18NtJROcnu8WeKSz9p/RJO7wVf68sl
 97/kB
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

To allow panels to use SPI already in the prepare function, have things
already setup here.
Maybe setting LCDCTRL in enable might be an idea?

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index e73be376e33c..ec72e6e92b46 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -167,6 +167,12 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 				struct drm_atomic_commit *state)
 {
 	struct tc358762 *ctx = bridge_to_tc358762(bridge);
+	struct drm_connector_state *conn_state;
+	struct drm_bridge_state *bridge_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	struct drm_display_mode *mode;
+	u32 lcdctrl;
 	int ret;
 
 	ret = regulator_enable(ctx->regulator);
@@ -178,21 +184,6 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 		usleep_range(5000, 10000);
 	}
 
-	ctx->pre_enabled = true;
-}
-
-static void tc358762_enable(struct drm_bridge *bridge,
-			    struct drm_atomic_commit *state)
-{
-	struct tc358762 *ctx = bridge_to_tc358762(bridge);
-	struct drm_connector_state *conn_state;
-	struct drm_bridge_state *bridge_state;
-	struct drm_crtc_state *crtc_state;
-	struct drm_connector *connector;
-	struct drm_display_mode *mode;
-	u32 lcdctrl;
-	int ret;
-
 	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
@@ -269,6 +260,13 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	ret = tc358762_clear_error(ctx);
 	if (ret < 0)
 		dev_err(ctx->dev, "error initializing bridge (%d)\n", ret);
+
+	ctx->pre_enabled = true;
+}
+
+static void tc358762_enable(struct drm_bridge *bridge,
+			    struct drm_atomic_commit *state)
+{
 }
 
 static int tc358762_attach(struct drm_bridge *bridge,

-- 
2.47.3

