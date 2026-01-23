Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297D2E06EA
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182779; cv=none; b=CWpW33PuN99MJKzODsIKyUh6CRhwEdO0d8esA2fvBPUqiTyxkFtjzAS0zzcIE+0yQTtFO8gk/KNMBZOdVjU6WRIoyDYob9czpwLN45A/sa+doBKLNfyiddQwviLlOQkPKcwMgAqxFVxO6UxmQ7xb83TqnSisDpDSwbm+a3xN80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182779; c=relaxed/simple;
	bh=CJvO7aMk3MA7KtqDmLej4/JbooJxQuWwJyxMBgmalpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtunuHr3JVgw2freitGEtcYF/0Bm/2Klw1Qf9mM/3aZZjqaRL5MKpFI+rVzKhPKHM6KUq3v0IJKIGagzgrJzzBElJQO1csgV4njLko4O1t8iHFjvSN1xVUnFDNA7GuZbOY52RemBwLXD3vcX4DNy/67dAqbcao13qss8F7nLpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3e7yzEt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3e7yzEt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07fac8aa1so18663125ad.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 07:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769182777; x=1769787577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSR3AHGBnzfA//kFOlkmDaGhGRWpqjPMPn6vjrluFLw=;
        b=A3e7yzEtDE3eyIxzXxToTzM8oShCrjK0OKUmoBeBsmCgN0wFMv4SynSb1qzBWE3MNO
         TKY1JNPKGjpN+KnLTV/qXYVufEkpeCDt+AU3pY2xmbWMGjicAziALdE9jnvkDogJtPSy
         ekmCknZ50yn9NdMOq535DgYsyYng2Y+yHOnuuoF5uq/zRdBPeMqr5GflICWPq0AsAorr
         6KogEioq1yfAoE4a2elOf4P/i47z+TsU5En68g7iJ9ecwDYjXiIwxkEQ4vP7fKAFzxkc
         sAcyAeChFFUG3hcpDHrjgxX+q9XT5vMJDsk2nmpHbUomYbI8sRPijHuAV6wv/8f8NhP2
         +Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769182777; x=1769787577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSR3AHGBnzfA//kFOlkmDaGhGRWpqjPMPn6vjrluFLw=;
        b=jUhe/UkdWSZVjFJt5zklXZ3fOhrwx2CpOAHcqZQuRsLrpGtVCj6z87Uync/7IslREk
         uGHAxf8MzeyIeGnPNqhJ2OSlMXDEHYq64N85QldF20n9jz6QwyLmtlc47huGPZAgtUBH
         0RalCWPOhrXEMykSYAhTiyfOEHKbLDZtRgkFPG9Z+zfqoHpaJh+YUMseem8Vee3YvXJs
         NWKo6SEHhzoNesSIn6fI70CDb6yT3HHYV8fyYE0Sg8fFkZbrHqLgylM/1hLQHPH1d20m
         26BJHPI9HpCL7eIACShLZGRu1QgAMzmC/olZCBBX3RO+Ih/hoyJ4WD48vE5mihNaBQ0K
         OSAg==
X-Forwarded-Encrypted: i=1; AJvYcCWV9ygLsb/R5DxA82HqJPN0RfUoK1JWoTlHCtaXd0FoRS21ooHBM/v4H+j5QBEk4eBcjOIqxlZQakJ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyxqn64qY/ubpYIZI5w61yLzl/uF3CVu+J/BC15c/mXOQ3pzIR
	UmVt999IPj8A0GwEWrVcbO3cNMZnrzem0Tq1Zq9TZGfs1jFm709y/cnw
X-Gm-Gg: AZuq6aL6kHXH5SX/87Afxag+rrP0GGXBeDwu09eJ1Pv0VTskdjL0HLDh4GSuvzU+s48
	axMnldXcKCvWQFAr4e+tchTfJZKmBglr3WBFdUr4i1l5Ooj1g6KaL6zzkS/zH9CTawZMF1Va/4T
	BHFWsM5ktLgWcKQKM6W+oKj8Yi4QM+kWKs1UVhCp+7ybtROxpKt4b/O07yY53MU9hgQ7EkebGx0
	lDR8wsFM/dQL/UHVMLeApN37ETrCi2z1tui2BSY3A0ViatZef5Zf0W1KgKTN6XLpex5mUPpwA5a
	XW3HP6F3AbSKvTYxr6EH8obZgVsZ5P2JhqU/Pjl+nK7w0UR5XedTZu8pVa/2w3lMLDulLaah1c9
	vJ0cCIqM3B/MXfhc3IMgsMPlrQ44hVNJDQ4ZCH7s2f4AzIC74e3Nk+BzTeHy+n+osVBUsSXPQKB
	PdGUq97dhaR0LMRaFqjySIvE4jb5jb+bGK5g==
X-Received: by 2002:a17:903:2351:b0:29f:1bf:6424 with SMTP id d9443c01a7336-2a7fe56f8d2mr29592255ad.18.1769182776616;
        Fri, 23 Jan 2026 07:39:36 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a802f9769esm23732205ad.60.2026.01.23.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:39:36 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 23 Jan 2026 15:39:04 +0000
Subject: [PATCH v4 3/3] dt-bindings: phy: ti,control-phy-otghs: convert to
 DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-ti-phy-v4-3-b557e2c46e6f@gmail.com>
References: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
In-Reply-To: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

