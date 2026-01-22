Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BC366827
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104490; cv=none; b=htaHiEmjGh+rYmZdyo/CQTc/nZ20xWiZhjJQ/qI5O5u2y/qTCmYvei2kvC26XMUg1DucqLe4nk3XNaxZuq2f29ikDkfyVbH27aOYwrTI+r4Ti+/D0c459oLQ/y6g4+4FgCNvCrXxZpKBUJ0DTPHgCyy9CwOsRt4BOLlpTIWhqY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104490; c=relaxed/simple;
	bh=9++FWI6FiOt8vL2ptkgVtaAFON6QZ6DYaPI7F5pxPA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFSPY52f6bQf5PTLHF9ihWAZh8cOH+8CWYDP57k0MQmNWodjz2h1XkFB6rVtP12CVGbN+16H3XevXQo3J8lgSaytKrYHn03CfWNEfUI9+82aFDDDmqCjrf7soQ7ROmHcv4ws3RA1zIevAIBybhqtgpCAhH2G5I6Kmi13TA5G0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEJW3J/h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEJW3J/h"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29efd139227so9903815ad.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104477; x=1769709277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI40l1zZcp0EM6GPdpYD9qucEk4y4q1/RvaUNk8yFvo=;
        b=BEJW3J/h683xikFGboQCZxnQBfTKl9Ll4du+f69ulQXw+9z0m1dipLJmgsIJyo1L4d
         pqJ1bH98AeY59t1MQ3Gs3TsUrQgAcfqiyaemOHVSZsTxaHp5Zg/VozG+Zbp+HpfPsNN2
         9ACayBVh+bJFGcOsesEzBO2EwzqLosMZaQlr6drFgRKyYb0hmanH8Rs8FaJ4uxxljmcx
         0t5geK9ECHo4sHF2FBmCjzRNl7CboCRdw3rZogqM+SshyiecNt8l3Jm2u1Ln/k4TSQXU
         5eJJgpJ1zb1EE2ZKdRUg94xNnsgMK0+UftMttuuxND7/IpQAv5LQm4gJ8hz1oRtlEtp0
         8KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104477; x=1769709277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FI40l1zZcp0EM6GPdpYD9qucEk4y4q1/RvaUNk8yFvo=;
        b=uVL3qcd/+OP7Kblh+vh+We47G7HCmCXUxg/T4KxvxJh0lwQDDNlYkUlZARWhQMfVah
         OObzfpm2WGMdKLSx4ia9pArEnIe//BPtg7P0YevBhatOdZG1kbU17uqgNDaDPHMIcXDt
         Fby/qp3By2fCJ7/FV2ToSDazcmMEJIKaC0IcHekV2LOrXOrgBPxyXrVJhEJWS8yeYqKX
         8yaIvWfzeJWIqa16Fyz26pN3c9m+dEQ/0O02hs3AHZ6SZHOaLfqWb18eJuZd6z4MvMEE
         4PyOjtKgB1aoXVhU+7sDahAgbwVap0yMcN8Z+TDceGyXcnLBotIw8EORECflo4aXlMZM
         KLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYTqtM4wPuB/8Q4jckmYyk51RbFlgAr7hHnUJAx7fjax57IgPj3RunxJNRmvk4K2OWPiBN8SltKNaI@vger.kernel.org
X-Gm-Message-State: AOJu0YyyS+FOv6tw4SKI5IzKUUxnUNGtb86iByCVPc2H3XHWI9OElZ7h
	GLwqLVKpiiyrKyLzxE7gKrkmAB8Wa17MpvGoBzdmmYZby3REMSMcmv2S
X-Gm-Gg: AZuq6aLYaYv4cRhAzBhYFk569mM2rwxuIiEMaWyrCQzG9GFAe7u4qQ+f6TRFzgtxp3H
	jOMqZ3I5tkSaYMmLYfvkMH7y177KPnaN5n7e/y8pGN+rXK7zjihvo0yhLtPQfiJBQLwizyz8HRz
	Ak6PohhYEq0umb8BhhvG0fo5iTs+ZMoRzhh9P+aTNxRTQzCKsB5VgWCDk29PsCWapFfwyy7KypD
	oWpHh5jyKs7pcjuTViKueVEBi0YKPdLHNSoqOxTACSeRDXoenAScU+HKui8ro0VMgs6sNQJIheg
	e6E51ezS62ZayGeUiOFsxw2Xl6+et71sLP4lny/Z96WpYt9CwNmkyAjgb900keBH+qiN9ABT+Su
	I1p9bxmo5cVUJma45sAFy84jX+9uZAYtvRIl+5hyvLPjdW9+2KYiFQa4GxSjLvZ/w5uwu1vbb4I
	ET6/1/rLjfUFlxDS4xKcIonQnbhL9vnEHXfNO4sa4U5R1y
X-Received: by 2002:a17:902:f681:b0:2a5:99ec:16d7 with SMTP id d9443c01a7336-2a7fe43ecd4mr2224725ad.7.1769104476545;
        Thu, 22 Jan 2026 09:54:36 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm187745195ad.42.2026.01.22.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:54:36 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 22 Jan 2026 17:52:59 +0000
Subject: [PATCH v3 3/3] dt-bindings: phy: ti,control-phy-otghs: convert to
 DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-ti-phy-v3-3-751619729433@gmail.com>
References: <20260122-ti-phy-v3-0-751619729433@gmail.com>
In-Reply-To: <20260122-ti-phy-v3-0-751619729433@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Roger Quadros <rogerq@ti.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Convert TI OMAP Control PHY binding to DT schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../bindings/phy/ti,control-phy-otghs.yaml         | 99 ++++++++++++++++++++++
 Documentation/devicetree/bindings/phy/ti-phy.txt   | 98 ---------------------
 2 files changed, 99 insertions(+), 98 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,control-phy-otghs.yaml b/Documentation/devicetree/bindings/phy/ti,control-phy-otghs.yaml
new file mode 100644
index 000000000000..4ecb1611ee65
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,control-phy-otghs.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/ti,control-phy-otghs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI OMAP Control PHY Module
+
+maintainers:
+  - Roger Quadros <rogerq@ti.com>
+
+description:
+  The TI OMAP Control PHY module is a hardware block within the system
+  control module (SCM) of Texas Instruments OMAP SoCs. It provides
+  centralized control over power, configuration, and auxiliary features
+  for multiple on-chip PHYs. This module is essential for proper PHY
+  operation in power-constrained embedded systems.
+
+properties:
+  $nodename:
+    pattern: "^phy@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - ti,control-phy-otghs
+      - ti,control-phy-pcie
+      - ti,control-phy-pipe3
+      - ti,control-phy-usb2
+      - ti,control-phy-usb2-am437
+      - ti,control-phy-usb2-dra7
+
+  reg:
+    minItems: 1
+    maxItems: 3
+
+  reg-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum: [otghs_control, power, pcie_pcs, control_sma]
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,control-phy-otghs
+    then:
+      properties:
+        reg-names:
+          const: otghs_control
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,control-phy-pcie
+    then:
+      properties:
+        reg:
+          minItems: 3
+
+        reg-names:
+          items:
+            - const: power
+            - const: pcie_pcs
+            - const: control_sma
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,control-phy-usb2
+              - ti,control-phy-usb2-dra7
+              - ti,control-phy-usb2-am437
+              - ti,control-phy-pipe3
+    then:
+      properties:
+        reg-names:
+          const: power
+
+required:
+  - reg
+  - compatible
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    phy@4a00233c {
+        compatible = "ti,control-phy-otghs";
+        reg = <0x4a00233c 0x4>;
+        reg-names = "otghs_control";
+    };
+...
diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
deleted file mode 100644
index 7c7936b89f2c..000000000000
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-TI PHY: DT DOCUMENTATION FOR PHYs in TI PLATFORMs
-
-OMAP CONTROL PHY
-
-Required properties:
- - compatible: Should be one of
- "ti,control-phy-otghs" - if it has otghs_control mailbox register as on OMAP4.
- "ti,control-phy-usb2" - if it has Power down bit in control_dev_conf register
-                        e.g. USB2_PHY on OMAP5.
- "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
-                        e.g. USB3 PHY and SATA PHY on OMAP5.
- "ti,control-phy-pcie" - for pcie to support external clock for pcie and to
-			set PCS delay value.
-			e.g. PCIE PHY in DRA7x
- "ti,control-phy-usb2-dra7" - if it has power down register like USB2 PHY on
-                        DRA7 platform.
- "ti,control-phy-usb2-am437" - if it has power down register like USB2 PHY on
-                        AM437 platform.
- - reg : register ranges as listed in the reg-names property
- - reg-names: "otghs_control" for control-phy-otghs
-	      "power", "pcie_pcs" and "control_sma" for control-phy-pcie
-	      "power" for all other types
-
-omap_control_usb: omap-control-usb@4a002300 {
-        compatible = "ti,control-phy-otghs";
-        reg = <0x4a00233c 0x4>;
-        reg-names = "otghs_control";
-};
-
-TI PIPE3 PHY
-
-Required properties:
- - compatible: Should be "ti,phy-usb3", "ti,phy-pipe3-sata" or
-   "ti,phy-pipe3-pcie. "ti,omap-usb3" is deprecated.
- - reg : Address and length of the register set for the device.
- - reg-names: The names of the register addresses corresponding to the registers
-   filled in "reg".
- - #phy-cells: determine the number of cells that should be given in the
-   phandle while referencing this phy.
- - clocks: a list of phandles and clock-specifier pairs, one for each entry in
-   clock-names.
- - clock-names: should include:
-   * "wkupclk" - wakeup clock.
-   * "sysclk" - system clock.
-   * "refclk" - reference clock.
-   * "dpll_ref" - external dpll ref clk
-   * "dpll_ref_m2" - external dpll ref clk
-   * "phy-div" - divider for apll
-   * "div-clk" - apll clock
-
-Optional properties:
- - id: If there are multiple instance of the same type, in order to
-   differentiate between each instance "id" can be used (e.g., multi-lane PCIe
-   PHY). If "id" is not provided, it is set to default value of '1'.
- - syscon-pllreset: Handle to system control region that contains the
-   CTRL_CORE_SMA_SW_0 register and register offset to the CTRL_CORE_SMA_SW_0
-   register that contains the SATA_PLL_SOFT_RESET bit. Only valid for sata_phy.
- - syscon-pcs : phandle/offset pair. Phandle to the system control module and the
-   register offset to write the PCS delay value.
-
-Deprecated properties:
- - ctrl-module : phandle of the control module used by PHY driver to power on
-   the PHY.
-
-Recommended properties:
- - syscon-phy-power : phandle/offset pair. Phandle to the system control
-   module and the register offset to power on/off the PHY.
-
-This is usually a subnode of ocp2scp to which it is connected.
-
-usb3phy@4a084400 {
-	compatible = "ti,phy-usb3";
-	reg = <0x4a084400 0x80>,
-	      <0x4a084800 0x64>,
-	      <0x4a084c00 0x40>;
-	reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-	ctrl-module = <&omap_control_usb>;
-	#phy-cells = <0>;
-	clocks = <&usb_phy_cm_clk32k>,
-		 <&sys_clkin>,
-		 <&usb_otg_ss_refclk960m>;
-	clock-names =	"wkupclk",
-			"sysclk",
-			"refclk";
-};
-
-sata_phy: phy@4a096000 {
-	compatible = "ti,phy-pipe3-sata";
-	reg = <0x4A096000 0x80>, /* phy_rx */
-	      <0x4A096400 0x64>, /* phy_tx */
-	      <0x4A096800 0x40>; /* pll_ctrl */
-	reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-	ctrl-module = <&omap_control_sata>;
-	clocks = <&sys_clkin1>, <&sata_ref_clk>;
-	clock-names = "sysclk", "refclk";
-	syscon-pllreset = <&scm_conf 0x3fc>;
-	#phy-cells = <0>;
-};

-- 
2.52.0

