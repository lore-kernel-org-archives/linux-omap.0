Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE22C11FA;
	Wed, 16 Sep 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524019; cv=none; b=Dd5Bn6qZcsqcWwy7jJkMyd2rkpEtdVE2MvhtPZ+a9DDlVMHNhUg5ySyWKyCUSArV7utecxnSBRrC006p9pgfHSNyLo3S7z/NtOkM43M8gYd3+SocBFDlMI2mOoWNP5uIBaStUBxC3XEBTXO7uGK9SzjBst+W0fm1vuBhcHZw9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524019; c=relaxed/simple;
	bh=4x1THk5tPNpQ0A2XPcYG+HK3rFk92doOKEFtYCFceHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oko+KlQNqoxwrW+r+AfF8F4f9ehxt5p3SFJrDHG7vwZtl5u8/k5FYJGBmdbdS/8LbJkSXxdD/ZBxN6YgM0r4LxQt0vL/fy/3VOTPvHLZBjUHhfErNP1wZFmXxz4KGk7ndEZjBJic1Cssr+t6ZkPuCGZLiGJoUjgU09ZS2Tb2Iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g7Gmenyv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g7Gmenyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=g2
	CtAMhynmn6DHBR9QDKyNlir7XDVSvCEJcX3emHNPE=; b=g7GmenyvS2UUbanMXu
	bmSSt5Hqi6TR+v4fch48ihZJmLt2QPzOceJBSR1ZJgK6NIaRi1RNPPeDUCLmfb4V
	OANbDtOkhmf1L2SZ/Gje2zEWCj3Bfn8u89+Bv4RAMf62RBzaM+ssEJyDlpyF0JjI
	23kP71Ar3K5ILV36G34TEUDRA=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHlXrK96lqbYrfAw--.61328S2;
	Wed, 16 Sep 2026 09:58:36 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v2 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT schema
Date: Wed, 16 Sep 2026 09:58:32 +0800
Message-ID: <20260916015833.112753-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915120327.47114-1-quchaosheng000406@163.com>
References: <20260915120327.47114-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHlXrK96lqbYrfAw--.61328S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1fGryrGr4DAr4Utw4xWFg_yoW7Jw4rpF
	n5Gas7CFy8WFyaqw4xAF1kCa1rAFWkAr40kF1xXFy5AF40qF40yF13Krn8XFy5CFyfZay2
	qF47Ww17Krn7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE-eOtUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4ww2q2qp98w6gQAA3x

Convert the TPD12S015 HDMI level shifter binding to DT schema.

The TI TPD12S015 is an HDMI companion chip that combines a level shifter
and ESD protection circuitry. Document the two ports it exposes between
the HDMI transmitter and the connector.

The tpd12s016 is software compatible with the tpd12s015 and is listed as a
fallback compatible by am57xx-idk-common.dtsi, so accept it as a fallback
of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so a board
using the tpd12s016 must list both compatibles.

The gpios property takes the three CT CP HPD, LS OE and HPD GPIOs the
driver obtains through devm_gpiod_get_index().

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v2:
 - gpios: drop the five-entry variant. The driver obtains three GPIOs
   through devm_gpiod_get_index() (indices 0, 1 and 2) and never reads a
   fourth or fifth, and no in-tree board passes more than three. Limit the
   property to three entries to match.
 - Reword the description: the TPD12S016 can only be used as a fallback of
   "ti,tpd12s015", because the driver matches on "ti,tpd12s015" alone.
 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 44 deletions(-)
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
index 000000000..96b44bd66
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
@@ -0,0 +1,91 @@
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
+      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first controls
+      the level shifter, the second enables the level shifter outputs and
+      the third reads the hot-plug detect line.
+    minItems: 3
+    maxItems: 3
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
-- 
2.43.0

