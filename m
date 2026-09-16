Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F84BCADD;
	Wed, 16 Sep 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562019; cv=none; b=RDydoVH4j5owdONGa8ul68Iwexd4wugqKCV20csZwZKBKGHjPvjfnQncoL79X+jb80vpoYT8toND1I0FFJ3tYkeFspKIO6iMTwq08GRG4OW9bzd98N+qNfnJZnUEsmTW3yU4bq560seW5F4JCZhZetdr5O78YZtnIr0aIoXfbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562019; c=relaxed/simple;
	bh=DXDx2+TSWEfJmjZydohyLufnt2oHOTUCSroTdLGfutU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQMmaeMJtAWxq2W9hlmS/0RYxEF4L7ak44raAeY06lVuOA4lZkrwwDLLB6sKK4ZaDnZbfysBct1Dqt1Gdc7EhRAihLwKJBTRrz/eXzlY0LvR/iAfBNKRG7ef4q8FoIjeDnFQlCqMzyLzAFnOCeKcJsMGGZmd8/JZ02MiSr8Ujhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nCDbegk/; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nCDbegk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EU
	fD/+RDbL9LTitXCareY04PQrb+fEVXzAQaIiNK0ak=; b=nCDbegk/BndP/UragS
	HzKaK9NAwsiXqxcacYYvLHFEAQaOvWcwg2gvaxPKdmfwVry77MzGHtqTdYX98PZS
	nGeB3XsHvOild1VtP+zCcwZli5hSXO61dShS4DD1kiKnEs/tmMP39zDJS+w/N0Q0
	kI7amFEFMzdWQfAi2WTS+Wffo=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JL1KjKpqEbZDBA--.13280S2;
	Wed, 16 Sep 2026 20:32:12 +0800 (CST)
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
Subject: [PATCH v3 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT schema
Date: Wed, 16 Sep 2026 20:32:09 +0800
Message-ID: <20260916123210.107841-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916015833.112753-1-quchaosheng000406@163.com>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3JL1KjKpqEbZDBA--.13280S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrWfCFyrur1DCFWftF1rXrb_yoW7Ww4UpF
	s5Gas7uFyvgFyaqw4xAr1kCa1rAaykAF40kF1xXFy5JF48tF40yF13Krn8XFy5CFyfZay2
	qF47Ww17Krn7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEpnQnUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wx78GqqjEzR3wAA3q

Convert the TPD12S015 HDMI level shifter binding to DT schema.

The TI TPD12S015 is an HDMI companion chip that combines a level shifter
and ESD protection circuitry. Document the two ports it exposes between
the HDMI transmitter and the connector.

The tpd12s016 is software compatible with the tpd12s015 and is listed as a
fallback compatible by am57xx-idk-common.dtsi, so accept it as a fallback
of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so a board
using the tpd12s016 must list both compatibles.

The gpios property takes the three CT CP HPD, LS OE and HPD GPIOs the
driver obtains through devm_gpiod_get_index(). omap5-igep0050.dts lists the
DDC SCL and SDA lines as two further entries, so allow up to five entries
and keep the property description focused on the ones the driver uses.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
v3:
 - gpios: allow up to five entries. v2 claimed that no in-tree board passes
   more than three, but omap5-igep0050.dts passes five: the three control/HPD
   lines plus the DDC SCL and SDA lines. The three-entry limit added in v2
   therefore broke dtbs_check for that board.

v2:
 - Reword the description: the TPD12S016 can only be used as a fallback of
   "ti,tpd12s015", because the driver matches on "ti,tpd12s015" alone.

 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
deleted file mode 100644
index 26e6d32e3f20..000000000000
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
index 000000000000..86f14f6b75c0
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
+      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first controls
+      the level shifter, the second enables the level shifter outputs and
+      the third reads the hot-plug detect line. The first three entries are
+      the only ones the driver uses; additional board-specific signals, such
+      as the DDC SCL and SDA lines, can follow them.
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
-- 
2.43.0

