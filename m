Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C33D524D
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878262; cv=none; b=p6scE4ZpT7xWiU0/nMQEdppl/nNI4DROlOZWjNs3ghtvDYbV8JVv5smVbbPh+gsHnduUj1qNJkIKbYcivhw9f6S4tZnXFUXN4e54o1GvnLyAbpjEHj/S2A03ne7pkIC183yRmSkpdD5bLSeoa/CX56Lp/nrV0Jc4+r70VbzYdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878262; c=relaxed/simple;
	bh=HT2S4uUtT8wmyqvtDS4yj7sOyV7xg6knc4XeDEpIpXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwOYCRgSk0jrxycJasKP3a7MlrAPsycTwephLgHG9+aOcHDU+YrXXDznEzorU/ldRpCkNjpbyV2QQ7i64UtrhK5b23Dm4FrhntWPzL/wcoktDlPvs++ZUyvFTFGRR/K974kojKchMzgQOe0RlM/RrJHvCPxTvUfnk2QAZR7+Xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gCr0uHa8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gCr0uHa8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9C91F4E42868;
	Mon, 30 Mar 2026 13:44:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 719B65FFA8;
	Mon, 30 Mar 2026 13:44:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AA9C104505CA;
	Mon, 30 Mar 2026 15:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pffeqr9U3U/KN61RGqMyzqpdMr20pWUmvq0/A2SzNzw=;
	b=gCr0uHa8LygQz58KdCh9rNyILIAZlmrI7pEdI6c85incQ8UbokAVjrN7R2lH/yExAyxj0r
	38fI+ErBrLx47U4YF6RXaqxEeLO9Au29rPYt9xgedfl9eGTDf+BcRALTbblLQqfS3U0/t7
	XfGlMi1manbqgZig8v3haL+nf8hE0JxgsCVcn7u3keP/iaXJjytHr0ppeW2NvaP0KB3fpg
	38IjjQstojOpRZguc9ya5VcQcw5RLSW/0+cGA42eIuvoevBG4gJjUxt2X/PjoVZjSzNVhz
	dJvIrIl4RxUQKUSquQVzZns/Sy5IYnRPn+75h0zUeb09Xmf22lZLkhNlfc3s7Q==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:43:58 +0200
Subject: [PATCH v2 01/11] dt-bindings: regulator: ti,pbias-regulator:
 Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-1-1c1e11b190dc@bootlin.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
In-Reply-To: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Convert PBIAS internal regulator binding to DT schema.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 .../bindings/regulator/pbias-regulator.txt         |  32 ------
 .../bindings/regulator/ti,pbias-regulator.yaml     | 125 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 126 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
deleted file mode 100644
index acbcb452a69a..000000000000
--- a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-PBIAS internal regulator for SD card dual voltage i/o pads on OMAP SoCs.
-
-Required properties:
-- compatible:
-  - should be "ti,pbias-dra7" for DRA7
-  - should be "ti,pbias-omap2" for OMAP2
-  - should be "ti,pbias-omap3" for OMAP3
-  - should be "ti,pbias-omap4" for OMAP4
-  - should be "ti,pbias-omap5" for OMAP5
-  - "ti,pbias-omap" is deprecated
-- reg: pbias register offset from syscon base and size of pbias register.
-- syscon : phandle of the system control module
-- regulator-name : should be
-			pbias_mmc_omap2430 for OMAP2430, OMAP3 SoCs
-			pbias_sim_omap3 for OMAP3 SoCs
-			pbias_mmc_omap4 for OMAP4 SoCs
-			pbias_mmc_omap5 for OMAP5 and DRA7 SoC
-
-Optional properties:
-- Any optional property defined in bindings/regulator/regulator.txt
-
-Example:
-
-		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
-			reg = <0 0x4>;
-			syscon = <&omap5_padconf_global>;
-			pbias_mmc_reg: pbias_mmc_omap5 {
-				regulator-name = "pbias_mmc_omap5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-			};
diff --git a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
new file mode 100644
index 000000000000..3e020d87701b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,pbias-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PBIAS internal regulator
+
+maintainers:
+  - Thomas Richard <thomas.richard@bootlin.com>
+
+description: |
+  PBIAS internal regulator for SD card dual voltage i/o pads on OMAP SoCs.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,pbias-dra7
+          - ti,pbias-omap2
+          - ti,pbias-omap3
+          - ti,pbias-omap4
+          - ti,pbias-omap5
+      - const: ti,pbias-omap
+
+  reg:
+    maxItems: 1
+
+  syscon:
+    description: Phandle of the system control module
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+patternProperties:
+  '^pbias_*':
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - syscon
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pbias-omap2
+    then:
+      patternProperties:
+        '^pbias_*':
+          properties:
+            regulator-name:
+              contains:
+                enum:
+                  - pbias_mmc_omap2430
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pbias-omap3
+    then:
+      patternProperties:
+        '^pbias_*':
+          properties:
+            regulator-name:
+              contains:
+                enum:
+                  - pbias_mmc_omap2430
+                  - pbias_sim_omap3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pbias-omap4
+    then:
+      patternProperties:
+        '^pbias_*':
+          properties:
+            regulator-name:
+              contains:
+                enum:
+                  - pbias_mmc_omap4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,pbias-dra7
+              - ti,pbias-omap5
+    then:
+      patternProperties:
+        '^pbias_*':
+          properties:
+            regulator-name:
+              contains:
+                enum:
+                  - pbias_mmc_omap5
+
+examples:
+  - |
+    bus {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        pbias_regulator: pbias_regulator@0 {
+            compatible = "ti,pbias-omap5", "ti,pbias-omap";
+            reg = <0 0x4>;
+            syscon = <&omap5_padconf_global>;
+            pbias_mmc_reg: pbias_mmc_omap5 {
+                regulator-name = "pbias_mmc_omap5";
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <3000000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..15052c0f5377 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19406,6 +19406,7 @@ W:	http://linux.omap.com/
 Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 F:	Documentation/devicetree/bindings/arm/ti/omap.yaml
+F:	Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
 F:	drivers/bus/omap*.[ch]

-- 
2.53.0

