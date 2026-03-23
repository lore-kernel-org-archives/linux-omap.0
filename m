Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922923B2FE0
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278185; cv=none; b=uYCnRDGz08bZLOy5Aq9X++yuc6xNN6ngF6g5bW8ovGcM488h70K9OaWqYdJXE61gSeoZQ3FTnIBNDjUABcujQ35jTL+PrsrHRHr5Bt1YWRL1eSy7tl8tyet6upsd250YKbLPxk7fnZUDuFiHo7Y9ZZ2WW1Xwqg7kp0MZ0HSGwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278185; c=relaxed/simple;
	bh=SQ0tVpelw5gTioGeYexAskj+zZqRZRumKOwNGWTMR4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pw4b1k1zp6RLPdpfTY489FqznV2Ae6qfNFjxw21WdvPMqNvkWgogvMJu8qbvOiAt9z8NnP/LkdjzqgUWWpVKE8pHiOKgUzw4jc3dmL1AaRzK7n21ck5TNuVRDeRFwO08ADikJ6LMfMmWrYEOLiBEHC4BVFZ0thFLcjTs3b+/Mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hQnbXqRI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hQnbXqRI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 54CE74E427B2
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:03:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B46B5FEF6;
	Mon, 23 Mar 2026 15:03:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F028C10450FC6;
	Mon, 23 Mar 2026 16:02:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nzMhpUhFMgmicdXs6rb/lVvOvdoLRNH76pVL85a8Emc=;
	b=hQnbXqRIkmXv+fq57SL4Adqi4DsBGYSRJ4aKtq0lnhPcE2pD/CfnTKYUcPeDO8jijmWDyD
	QKESozZUhFE1LOjnzvL+Rvcq5pl8JWD3bz9a0pmCo5KbP60w3yYRWhkP3J0l+bwyPudQGl
	6aMDECqew1o+KjkGYZ9jfJ0VmJ2oPAxX1sIHyozlV9z3seDMStGNXdQXsKshcmLDKi67Js
	ar57e4pq3+FtuZzbq6ReS06tygDSflHc4yu3g/BCcV0QrW54oWM0Od1NfDPhb/inpII1/m
	gZppL6LzVzIyUmd5pLX2mHz5YAi+KBWuzYQubfEpBouxn5vds/NbzuehqTpubA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:46 +0100
Subject: [PATCH 5/8] dt-bindings: mfd: ti,omap-usb-host: Convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-5-b668132124ac@bootlin.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
In-Reply-To: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Convert OMAP HS USB Host binding to DT schema. The 'ti,hwmods' property is
not mandatory anymore as it is no longer required when the omap-usb-host
node is a child of a new interconnect target (ti,sysc).

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 .../devicetree/bindings/mfd/omap-usb-host.txt      | 103 ----------------
 .../devicetree/bindings/mfd/ti,omap-usb-host.yaml  | 131 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 132 insertions(+), 103 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
deleted file mode 100644
index a0d8c30c2631e534cae50dfc7183cd04e744f31f..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
+++ /dev/null
@@ -1,103 +0,0 @@
-OMAP HS USB Host
-
-Required properties:
-
-- compatible: should be "ti,usbhs-host"
-- reg: should contain one register range i.e. start and length
-- ti,hwmods: must contain "usb_host_hs"
-
-Optional properties:
-
-- num-ports: number of USB ports. Usually this is automatically detected
-  from the IP's revision register but can be overridden by specifying
-  this property. A maximum of 3 ports are supported at the moment.
-
-- portN-mode: String specifying the port mode for port N, where N can be
-  from 1 to 3. If the port mode is not specified, that port is treated
-  as unused. When specified, it must be one of the following.
-	"ehci-phy",
-        "ehci-tll",
-        "ehci-hsic",
-        "ohci-phy-6pin-datse0",
-        "ohci-phy-6pin-dpdm",
-        "ohci-phy-3pin-datse0",
-        "ohci-phy-4pin-dpdm",
-        "ohci-tll-6pin-datse0",
-        "ohci-tll-6pin-dpdm",
-        "ohci-tll-3pin-datse0",
-        "ohci-tll-4pin-dpdm",
-        "ohci-tll-2pin-datse0",
-        "ohci-tll-2pin-dpdm",
-
-- single-ulpi-bypass: Must be present if the controller contains a single
-  ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
-
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-
-- clock-names: should include:
-  For OMAP3
-  * "usbhost_120m_fck" - 120MHz Functional clock.
-
-  For OMAP4+
-  * "refclk_60m_int" - 60MHz internal reference clock for UTMI clock mux
-  * "refclk_60m_ext_p1" - 60MHz external ref. clock for Port 1's UTMI clock mux.
-  * "refclk_60m_ext_p2" - 60MHz external ref. clock for Port 2's UTMI clock mux
-  * "utmi_p1_gfclk" - Port 1 UTMI clock mux.
-  * "utmi_p2_gfclk" - Port 2 UTMI clock mux.
-  * "usb_host_hs_utmi_p1_clk" - Port 1 UTMI clock gate.
-  * "usb_host_hs_utmi_p2_clk" - Port 2 UTMI clock gate.
-  * "usb_host_hs_utmi_p3_clk" - Port 3 UTMI clock gate.
-  * "usb_host_hs_hsic480m_p1_clk" - Port 1 480MHz HSIC clock gate.
-  * "usb_host_hs_hsic480m_p2_clk" - Port 2 480MHz HSIC clock gate.
-  * "usb_host_hs_hsic480m_p3_clk" - Port 3 480MHz HSIC clock gate.
-  * "usb_host_hs_hsic60m_p1_clk" - Port 1 60MHz HSIC clock gate.
-  * "usb_host_hs_hsic60m_p2_clk" - Port 2 60MHz HSIC clock gate.
-  * "usb_host_hs_hsic60m_p3_clk" - Port 3 60MHz HSIC clock gate.
-
-Required properties if child node exists:
-
-- #address-cells: Must be 1
-- #size-cells: Must be 1
-- ranges: must be present
-
-Properties for children:
-
-The OMAP HS USB Host subsystem contains EHCI and OHCI controllers.
-See Documentation/devicetree/bindings/usb/generic-ehci.yaml and
-Documentation/devicetree/bindings/usb/generic-ohci.yaml.
-
-Example for OMAP4:
-
-usbhshost: usbhshost@4a064000 {
-	compatible = "ti,usbhs-host";
-	reg = <0x4a064000 0x800>;
-	ti,hwmods = "usb_host_hs";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	usbhsohci: ohci@4a064800 {
-		compatible = "ti,ohci-omap3";
-		reg = <0x4a064800 0x400>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 76 0x4>;
-	};
-
-	usbhsehci: ehci@4a064c00 {
-		compatible = "ti,ehci-omap";
-		reg = <0x4a064c00 0x400>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 77 0x4>;
-	};
-};
-
-&usbhshost {
-	port1-mode = "ehci-phy";
-	port2-mode = "ehci-tll";
-	port3-mode = "ehci-phy";
-};
-
-&usbhsehci {
-	phys = <&hsusb1_phy 0 &hsusb3_phy>;
-};
diff --git a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7831ad891229aee650d83adcd82405c9dde472a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,omap-usb-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP HS USB Host
+
+maintainers:
+  - Thomas Richard <thomas.richard@bootlin.com>
+
+description: |
+  description
+
+properties:
+  compatible:
+    const: ti,usbhs-host
+
+  reg:
+    maxItems: 1
+
+  ti,hwmods:
+    const: usb_host_hs
+
+  num-ports:
+    description:
+      number of USB ports. Usually this is automatically detected from the IP's
+      revision register but can be overridden by specifying this property. A
+      maximum of 3 ports are supported at the moment.
+    maximum: 3
+
+  single-ulpi-bypass:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Must be present if the controller contains a single ULPI bypass control
+      bit. e.g. OMAP3 silicon <= ES2.1ULPI bypass control bit.
+      e.g. OMAP3 silicon <= ES2.1.
+
+  clocks:
+    description: clock-specifier
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: usbhost_120m_fck
+      - items:
+          - const: refclk_60m_int
+          - const: refclk_60m_ext_p1
+          - const: refclk_60m_ext_p2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^port[0-3]-mode$":
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      String specifying the port mode for port N, where N can be from 1 to 3.
+      the port mode is not specified, that port is treated as unused. When
+      specified, it must be one of the following.
+    enum:
+      - ehci-phy
+      - ehci-tll
+      - ehci-hsic
+      - ohci-phy-6pin-datse0
+      - ohci-phy-6pin-dpdm
+      - ohci-phy-3pin-datse0
+      - ohci-phy-4pin-dpdm
+      - ohci-tll-6pin-datse0
+      - ohci-tll-6pin-dpdm
+      - ohci-tll-3pin-datse0
+      - ohci-tll-4pin-dpdm
+      - ohci-tll-2pin-datse0
+      - ohci-tll-2pin-dpdm
+
+  "^usb@":
+    type: object
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      patternProperties:
+        "^usb@": true
+    then:
+      required:
+        - ranges
+        - "#address-cells"
+        - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        usbhshost: usbhshost@4a064000 {
+            compatible = "ti,usbhs-host";
+            reg = <0x4a064000 0x800>;
+            ti,hwmods = "usb_host_hs";
+            port1-mode = "ehci-phy";
+            port2-mode = "ehci-tll";
+            port3-mode = "ehci-phy";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            usbhsohci: usb@4a064800 {
+                compatible = "ti,ohci-omap3";
+                reg = <0x4a064800 0x400>;
+                interrupt-parent = <&gic>;
+                interrupts = <0 76 0x4>;
+            };
+
+            usbhsehci: usb@4a064c00 {
+                compatible = "ti,ehci-omap";
+                reg = <0x4a064c00 0x400>;
+                interrupt-parent = <&gic>;
+                interrupts = <0 77 0x4>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62b77515aa1a1fee1c7d3e594869fa..28da3ac5896681bcdab29c23c98eff3612dc181d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19397,6 +19397,7 @@ W:	http://linux.omap.com/
 Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 F:	Documentation/devicetree/bindings/arm/ti/omap.yaml
+F:	Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
 F:	drivers/bus/omap*.[ch]

-- 
2.53.0

