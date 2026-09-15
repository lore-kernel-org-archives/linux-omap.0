Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3734A8A12;
	Tue, 15 Sep 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473959; cv=none; b=ZdOnzaVNA3NXtITiC5x/xbaDuFjVeHjaxDzOqKexWRVdsbu1z9VLyHK5pIVmBzZSezR8VoAks87g8+swvIsfPAOND/MPtOfOreBeQ6FOWMxYtOcMU2Ze0tyQwHY2422y9Do+kPFGQNt3skMcPwSBZWmdEOrFQ2MOgcNuslJO3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473959; c=relaxed/simple;
	bh=smDUg2lzTohEI4WrRi8fPXD2+62NnBCDLDMxeX1VJ54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKh4igTXqgafYbeEM8Tn5H10dpEnZL95AE//bmAhrFcLZrvtNOoIcsm6uzfKidTw40jg5YvdO55jHkpBD5Zfk6a153SYNfJTvagZA1YiUA+MQN+b23AfpS5YWz/wfNCg1YShSQQ/bBDPRsPswaPvgnvIMOZfxWmT8thgzJzrtTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZL7fcFTW; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZL7fcFTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2T
	LMma9ufzb1/Q0mvHHgvC1iRVn+AuJXO1UOIk5GqbM=; b=ZL7fcFTWJL9Y2OJw/o
	BwEoK5PB15Wp+g69CllCy+PP7WRpsE1ES3+NiqDtePb+qKQ8f9k22JLEsFwsqjS0
	3+8EUVHbm253ODxCJr/ijJcHsXQJS0jov49xnLPCT7by52R9uNhm3i9/8LkxEHWp
	LrJ4mGx34P/n/EeBsTU5H26Lg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnN_cQNKlq1ig+Aw--.34817S4;
	Tue, 15 Sep 2026 20:03:29 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quchaosheng <quchaosheng000406@163.com>
Subject: [PATCH 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT schema
Date: Tue, 15 Sep 2026 20:03:26 +0800
Message-ID: <20260915120327.47114-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN_cQNKlq1ig+Aw--.34817S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy3KFy3uw4kWw45WFWDtwb_yoWrurWxpF
	n5Ga929F1kWFyaqw4xAF1kCa1rAFWkJF40kF1xXFy5ta10qF40yF43Krn5XFy5GFyfZaya
	qF47Ww17Krn7uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEUGYJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xIWi2qpNBJzrgAA3U

Convert the TPD12S015 HDMI level shifter binding to DT schema.

The TI TPD12S015 is an HDMI companion chip that combines a level shifter
and ESD protection circuitry. Document the two ports it exposes between
the HDMI transmitter and the connector.

The tpd12s016 is described as software compatible with the tpd12s015 and
is listed as a fallback compatible by am57xx-idk-common.dtsi, so accept
both orderings. Boards that also route the DDC lines through the chip
pass five GPIOs rather than three.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
deleted file mode 100644
index 26e6d32e3..000000000
--- a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-TPD12S015 HDMI level shifter and ESD protection chip
-====================================================
-
-Required properties:
-- compatible: "ti,tpd12s015"
-
-Optional properties:
-- gpios: CT CP HPD, LS OE and HPD gpios
-
-Required nodes:
-- Video port 0 for HDMI input
-- Video port 1 for HDMI output
-
-Example
--------
-
-tpd12s015: encoder@1 {
-	compatible = "ti,tpd12s015";
-
-	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
-		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
-		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			tpd12s015_in: endpoint@0 {
-				remote-endpoint = <&hdmi_out>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-
-			tpd12s015_out: endpoint@0 {
-				remote-endpoint = <&hdmi_connector_in>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
new file mode 100644
index 000000000..b3351b601
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPD12S015 HDMI level shifter and ESD protection chip
+
+maintainers:
+  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
+
+description: |
+  The TPD12S015 is an HDMI companion chip that combines a level shifter and
+  ESD protection circuitry. It sits between an HDMI transmitter and the HDMI
+  connector, and provides control over the level shifter enable and the
+  hot-plug detect signals.
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,tpd12s015
+      - items:
+          - const: ti,tpd12s016
+          - const: ti,tpd12s015
+
+  gpios:
+    description:
+      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first GPIO
+      controls the level shifter, the second enables the level shifter
+      outputs and the third reads the hot-plug detect line. Boards that
+      also route the DDC lines through the chip use five entries, with
+      the SCL and SDA GPIOs appended.
+    minItems: 3
+    maxItems: 5
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: HDMI input from the transmitter.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: HDMI output to the connector.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    encoder1 {
+        compatible = "ti,tpd12s015";
+
+        gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,    /* 60, CT CP HPD */
+                <&gpio2 9 GPIO_ACTIVE_HIGH>,    /* 41, LS OE */
+                <&gpio2 31 GPIO_ACTIVE_HIGH>;    /* 63, HPD */
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                tpd12s015_in: endpoint {
+                    remote-endpoint = <&hdmi_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                tpd12s015_out: endpoint {
+                    remote-endpoint = <&hdmi_connector_in>;
+                };
+            };
+        };
+    };
+
+...

