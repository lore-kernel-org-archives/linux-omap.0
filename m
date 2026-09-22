Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0434C10EF;
	Tue, 22 Sep 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057868; cv=none; b=UQGXCOtfZMOaUeX23HT+mWFIqw96OfOM4us9XQa28W+nVXvt+xkZkl4TAjbIMwTCxw7lqyQmwjVcgbRL350L5SwZHZmdTdvGGooDGA5KxnuFA/2qHpIOUT6Q2dK+jedWyPMr9+Mjl6raiqTIhnEiDenGichKUSyLJ+qHLwCwwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057868; c=relaxed/simple;
	bh=sN0jHjhiKPr+hku2Fc2l8CjScf+8Lhcf3qtojt/qNiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QV5pM2hl95A0K8E3HqxrVkgKVpkZjB26mT8RJZ0umcAxcddzh2YjfJlu1DyzQ6xVutUfc5uVsOWQFVj/68/xr9Ra2G9U5xkRhWA5yHbruatVd1f1owg0MQcxIL2VU41bhIUM8RssqpRuFKfuvdpaRMaiNmd6BupbOub7zXLV8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=YTxY27pO; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YTxY27pO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=AwsqmmNGM1CwkfnwhjdwYP4bj/OynYd8p0qPRgSwWUk=; t=1790057865; x=1791267465; 
	b=YTxY27pO+dDTbjKldhJdj24iZgPjiwQ/Se4ngJyJVYM14tSfeMSxomlrcwQhxlSYqfXCQXgY5Bf
	nlJtljXUw8Ftn1P4CIy7e1OLgBa2WmF+dcpgQCEKhx0sziXzv9HK351Gr8bBj3HD7PzlOZYY43uVG
	bOABaurhKhDQJlYBxSBCT+sNe6L0nmZNMZwrqPUHEQb53eDQdQFW1eWFFdXWNvLnEdLMimPnUqABl
	LnSKSy8M2IhGkTWW/8Pd8GU9rQ3RqjOWUbNAqyXGUlP3d9Px0VcRG8pC/GIPANoyS2TKrS3h09YA4
	rinvl2yY3UTfx6E+4vD569IfugyAZaNSiXAg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:16:58 +0200
Subject: [PATCH RFC 1/9] dt-bindings: display: panel: Add panel for Epson
 Moverio BT-200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-1-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=sN0jHjhiKPr+hku2Fc2l8CjScf+8Lhcf3qtojt/qNiQ=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBP6cuLjH32J65lfquB/cqbhhouTOW+cPpHqOdVv+
 2X2XKGFHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAEwkZzbDX8EXm7Ma/I4c2n8j
 yfXl5olaq6+2bl236/Wuq+1e77a/eB/O8D/s8p427Xmf9x7bq3LnSvnv2DNxewW5b1xaFlH6I12
 oqoIZAA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The Epson Moverio BT200 has two DPI panels with SPI control
input in its glasses. The chip is unknown and not feasible to
non-destructively find out more, so just add a more generic
compatible.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/display/panel/epson,panel-bt200.yaml  | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/epson,panel-bt200.yaml b/Documentation/devicetree/bindings/display/panel/epson,panel-bt200.yaml
new file mode 100644
index 000000000000..b3ea09d194aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/epson,panel-bt200.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/epson,panel-bt200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Panels of the Epson Moverio BT-200 head unit
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: epson,panel-bt200
+
+  reg:
+    const: 0
+
+required:
+  - compatible
+  - port
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "epson,panel-bt200";
+            reg = <0>;
+
+            port {
+                lcd_in: endpoint {
+                    remote-endpoint = <&dpi_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.47.3

