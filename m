Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6E4CDDF5;
	Fri,  9 Oct 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543279; cv=none; b=Cfv5GDkylbSm9y49O7WWJ9hBs4Z9Q1PFP/bh/Q6PyJuYt0YNt0NSTUarWZ3gl3cGsAhREdfrgbFfST07vPOGlfE2kzTmKfVCKkPW2vTmBd+KvTIaeCF5fVx4qbI7szjTVbOmqluOjEbdpyW77EaNP2L6E6NXSB3y5z1NDq1FXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543279; c=relaxed/simple;
	bh=w/txRNxnmPrNw4TG7aUycpIsCYyczBIRXTmWOLGgVeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jN3bEMy14zIIIxZBWEu5S+dw5xoA/R9NJiR4vas3BM3tGeKwH6NAH1EGA4bfnl8mB2oIdfx4xBiOTM9OE3hEy/qy0U+YFOwb5CGlwRPF0OBI76rm3bDRp4/cttf5M3SK8bIDOPtYmqaV/QhM/b/HiXc/eIewA9NiJ/3s2x9Y3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JBJZc6hR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JBJZc6hR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=N0
	UHDUvgrExzuUIvmY5lEGVvWVWCcps+KEQmmx2+7ZE=; b=JBJZc6hRPvIF4715ez
	3AaoPB9BvzTSPoysnDMhEqCcgdNy5nrQ3V2as2USmUbgpeyWPpVKJmkBJlowC8+N
	yBJ9AdIyZAmk5sx8bXcGf7dl50Y5RuinkUoU+5k/c44Q+/+JkPfXIwRHVvcVqBEa
	cAvfBULH/SPGGhbDN5lX4Gxt0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3vmvUx8hqvTiFDg--.2548S3;
	Fri, 09 Oct 2026 18:54:13 +0800 (CST)
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
Subject: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT schema
Date: Fri,  9 Oct 2026 18:54:10 +0800
Message-ID: <20261009105412.300338-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105412.300338-1-quchaosheng000406@163.com>
References: <20261009105412.300338-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3vmvUx8hqvTiFDg--.2548S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyDtr1xCr1UZF1rCr45Wrg_yoWruryxpF
	n5Gas7uFy8WFyaqw40yr1kCa1rAFykAF40kF1xJFy5Ja10qF48tF13Krn8XFy5Ga4xZay2
	qF47Ww17Kwn7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi-VycUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xXzaWrIx9XWDQAA3H

From: Chaosheng Qu <quchaosheng000406@163.com>

Convert the TPD12S015 HDMI level shifter binding to DT schema.

The TI TPD12S015 is an HDMI companion chip that combines a level shifter
and ESD protection circuitry. Document the two ports it exposes between
the HDMI transmitter and the connector.

The tpd12s016 is software compatible with the tpd12s015 and is listed as
a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
a board using the tpd12s016 must list both compatibles.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 44 deletions(-)
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
index 000000000000..1927da3bd736
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
@@ -0,0 +1,90 @@
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

