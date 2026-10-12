Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969D456E19;
	Mon, 12 Oct 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795187; cv=none; b=FLG3YQUpTrnqHMZD9gme1XXrYwSQUNIjGh4M1rJ9FE95EREiHTWQySNk9AvlmUmqtp0IjLStDIsseTC9dyXS36LOKCUsYEdUuDJCBhi9dvk4gS/oT/pEy9vv9w/70ziFf7ZV6xs/MRsTVy88MYLGUfg3th9MHirlCK/Kjj147sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795187; c=relaxed/simple;
	bh=U/4R+YeEifWvncRpESdhDZ4w+cUor9JJYVYqHdW156s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbFSniV5pIVCC7LPYLACLkfhOLk0v6Z+zXoCGxjRY1tv2CYitctbTqhScE6u+NAX3hHvdyy3LJcInoacoZMPadd0cZtcdtYkIcfUeskys6MRqjDbulkcggYv6UmKsgE3UEiQOhAxFl5hGBu3F2cwaAY8UoULD+sKwMwKadbsijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nuBJCiAk; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nuBJCiAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c6
	hLHbjPTyEX9KzDzUTEOrlIWSSx4BZg1YF3Q/YxGBk=; b=nuBJCiAkp6Hum4nfzm
	r/8sCWH8rNF4Hf+aFH2UCObWxRV83w1PuGPvuvelI+WFuodwN3d3xoALJbUi1nLo
	bI3vr9sb1R2LN2cqsxKK76eU4fn3d5eZTrJ3apNQb1DvVbGeC/+OCJAZZ/EUeU2S
	RKf+3RCu4/GJ/5g/iycggQ0Qk=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXn6rVn8xqjDtnEA--.23112S3;
	Mon, 12 Oct 2026 16:52:39 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH v5 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT schema
Date: Mon, 12 Oct 2026 16:52:35 +0800
Message-ID: <20261012085237.377612-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012085237.377612-1-quchaosheng000406@163.com>
References: <20261012085237.377612-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn6rVn8xqjDtnEA--.23112S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyDtr1xCr1UZF1rCr45Wrg_yoWruF45pF
	n5Gas7CFy8WFyaqw4Iyr1kCa1rAFykAF40kF1xJFy5tF40qF4ktF13Krn8XFy5Ga4xZayY
	qF47Ww17Kwn7Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piQ6pPUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xjrYWrMn9iZzQAA3E

From: Chaosheng Qu <quchaosheng000406@163.com>

Convert the TPD12S015 HDMI level shifter binding to DT schema.

The TI TPD12S015 is an HDMI companion chip that combines a level shifter
and ESD protection circuitry. Document the two ports it exposes between
the HDMI transmitter and the connector.

The tpd12s016 is software compatible with the tpd12s015 and is listed as
a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
a board using the tpd12s016 must list both compatibles.

The ports carry no properties beyond the graph ones, so each port takes
the plain graph port schema.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ----------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 44 deletions(-)
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
index 000000000000..5955f2e6421c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
@@ -0,0 +1,88 @@
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
+description:
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
+    maxItems: 3
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: HDMI input from the transmitter.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
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

