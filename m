Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6B4C10FB;
	Tue, 22 Sep 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057867; cv=none; b=V698ufGdbERuSVSAXzoCO2iS3y9IVHRX6V4cho0MPtLbxLV5ZXdFvDmZg8zcHnMmQEwcIilklzGj494l4qxH41YY8SafW0nTXxctLKZ1tXGWlJgu5D/xdTdm+G0BUkItDl/joHkr5dEAjd+O46XYcFon7K7eBuWcQcwUTQGa5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057867; c=relaxed/simple;
	bh=FgdE4S79rUwu02PcPAK2OqiniqhAhf0hXGN4VJbaZeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+lyMDT/T6Cu4hKBw1rr5gB+oGCA8eYidEAnqG1oo9kOrID/Z3nvLfuteDXn3k5Cjk0wmYuLPVM0z8biB3lmPonNlG6Mpbg+0WLHL2ZlBRlGbdeeXzj3NwGyzx3QTMDBP7PNoXHs7nSYev1fGe1TxBUFQ2aFi3yL/vq6WscZCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=j5CaNOd9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="j5CaNOd9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=HXDSp/hZMea/g/uCBirxGqC15DoS4eWxIXlEZsOk6QI=; t=1790057865; x=1791267465; 
	b=j5CaNOd9cqXwHoWvoXnKK/k8E+39h7uwLCX/2V3WE4oAj7X1/WZkrpQWlCVcJ0KY8E7cavS8/Et
	9eEjjM0V5llAtpkHpAPfCJqYmGoZZfMdjaCHGkF+/U2o9PjlW/DPlJAVyp1UlK5Ux9RkqYHSIN0VE
	5E/brcBhDUaB4piaHtB8gbEe+GOjm81pCK6qTZwJ19vPGsgNMDp1CaCQmn53koG1dAWgo39fk3Z1V
	T32dz+5Xjqjz3WR5hzwnalddhemq1kXQoz71Fv/qfTn7l3uJjCHAyX2W1D+RVm8GwhCiwZYM3wsJC
	AmhtgDAV+7q7fL7mfsR/w2VwLzpH1rPIE0BQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:00 +0200
Subject: [PATCH RFC 3/9] dt-bindings: display: bridge: tc358762: Add some
 missing properties
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-3-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=FgdE4S79rUwu02PcPAK2OqiniqhAhf0hXGN4VJbaZeI=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBMM2DiZ03boOdxYssnOlrXzoYTQNc4jdorbZzBEb
 Ph7Syu2o5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIlMmsPwv3j75NqyZU4uYTM/
 bpa4duPmRqM/X27bJc5cpV3H1vlEo4Xhv1/773nhOX9bsifymHyqcFLIYXne+Jx9evHkjKS+i2E
 F3AA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The TC358762 can act as an SPI master with two CS for controlling DPI
slave devices. Add a spi subnode for that.
Add a property to describe number of DSI data lanes. If two lanes
are used, an external clock is required.

There is the LPTXTIMECNT register which needs to be set to a non-standard
value on Epson Moverio BT-200, add a property for it. I know nothing about
it besides the required value.
---
 .../bindings/display/bridge/toshiba,tc358762.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
index 6c1de0b21722..0e380f2a56e6 100644
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
@@ -44,6 +44,20 @@ properties:
     required:
       - port@1
 
+  spi:
+    $ref: /schemas/spi/spi-controller.yaml#
+    unevaluatedProperties: false
+
+  dsi-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+  toshiba,lptxtimecnt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.47.3

