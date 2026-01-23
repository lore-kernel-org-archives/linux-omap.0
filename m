Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631828B7DB
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182774; cv=none; b=kWyey21flLLPOZZRoB3f9wa35tv4suxA/DfHTswEV3Te8eQ+myWKa52AiPxncq35mG7RjTk9vv9CYn/pEMMM83BLwEsKe0nyRKykVkTlUut2386ECGqEgJ1wmj1MJ2tNRth+9FVQBGQ7vbzG0uWZdr2td49F+nTj0Sc/gH81x68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182774; c=relaxed/simple;
	bh=EWRtX14XBOJn75+Yxu8XUThdANVXjkr8JgKSNkcgHfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZWqR8/E4E7efcRyB7aMxyravUSTpdFjdD02TCPCm0RxBGmMkNxu3ObLBhQ25zxkRd+OHcl6M3BvAurN6+R8NGK2Mt1CwOwmvQDjYzq57erCL3QP0t6gtA+eK183Zp9xBVWPp84boO19x4vpFEJRrcLLnrBoE0y2xTTjp1Fe1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF1+MoC3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF1+MoC3"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c613161b489so889207a12.0
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769182772; x=1769787572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaQlFGJc3VjbA6sYXTYZs4MxTaxJLLlXJGLonhTWD3Y=;
        b=iF1+MoC3fOWWKXVqBKAi9PEGOOKLXhjT9KIsbq/u4LCOZKWujMZGMjr5/C3TxvbBuR
         Gq2VX7wH5lGkdYscqNcUceWC3VPJIxIHL+UqOdsu8hWlNwA6P7+ojVaXcnmDfNhMH4mG
         7UjHihdCx8RZUPqfj93SwsH/jRmUvL3uBhfvJhgcRxPDKzQG22KtU7s76RJWCRYh83oG
         7YtaaUdYazIsbNEIDmeSf9mvZITXNfoBhDP/cw2aU5zzPPOdzgxJAACFDFtXbKsK6D/H
         vL9jurGCn95S+IDS3R1LClxE53E9rgCq4Bd/MSt2wOEtz+omAkjpMyml8HWmX8B/XnXs
         kqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769182772; x=1769787572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SaQlFGJc3VjbA6sYXTYZs4MxTaxJLLlXJGLonhTWD3Y=;
        b=kV8U/1I8KJoZYFUhSvCSYwVGVk1nvSmkyX8FxAdQaUSsI5xcTYtFhR20H41FW8+QYv
         LPcLznKJtikO0G5VG4KIMe59KtMYW3wnehfCVzDEQd0ORn+HbHH/ID4YUXHa1QjWvWlC
         3yq2UzyI4ur9JePKK3m92MIEMdT2Y/cykPnymVlKwlIQbRYIL15fafLQ7e5LfrFO4gI5
         hO8OEzJDKCnPP4LF8QE3UrkapcS0XU/VCd8AyouV5LmGFQBmyiKVikfwgOlx0G8ekKhX
         WRIlEGO8A1vgUewAfBhS3xTNJPXkNBZWaSlFSYteVllV+U0XLKl7YS1bbRL4z4S1tI5V
         KkXA==
X-Forwarded-Encrypted: i=1; AJvYcCXaSgJCvStEb8Dja3Z7td+2k1RGOqJE65jusHiCSJD36fNDi88rfEqK6NOLDJ6TcsEDvgYZaK3OdnwD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcie9mt/fjt94raeaUmAnleBoRKHIV3D6lKaWZg9ulUDb0dbxk
	mtGm9ue2oqJQPGc+BckiL+VRgrMQsR/Ue5IbqxEzkJk4vlNjzlm8fUV2
X-Gm-Gg: AZuq6aKl/VARjOCuVz0YqMt6cnW+ncwOi0EkFMsMqwz+XzzFRHiwxHL8o/kVQI9HgG2
	k7JP9UtESPidP3dR+T55BBqwAgwrk8a1LXeCTLUYsLGJNIo/Ll7hb2DxZZkb1rlbCBEUgt1OEj7
	FdjKK76F/l7nxUSAyAv6SicO4bEsZNim/DlMxicDPH9fuCPW3THXb7eOdU158HfIt6z0bnq6KeV
	R5yQzec4dNTCyqhzo28cHnBt9CnNibXEwisaY/qdp54hKjcIP8wLVCVaZXu56bPxw7xGSNtNLCe
	C44wt2cYVMI4tbYdhzLWt3kLdCiAccSW/vfLY91YYhfHeqCEDpFsJZ62+iAX6iO0PFo0rEbCoJc
	cuTnOo9VUVt6bEbvXHob1vyAAt2mLYK1jE1hzB/cGaiqMgtvyr+XrfwCRtDdqmAaVbgFq6kHgPP
	2Qn0ESO02XWVysvqqmofbvPFP4rapxM6yHLg==
X-Received: by 2002:a17:903:32c9:b0:29f:3042:407f with SMTP id d9443c01a7336-2a7fe5740b5mr34186845ad.21.1769182772016;
        Fri, 23 Jan 2026 07:39:32 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a802f9769esm23732205ad.60.2026.01.23.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:39:31 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 23 Jan 2026 15:39:03 +0000
Subject: [PATCH v4 2/3] dt-bindings: phy: ti,phy-usb3: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-ti-phy-v4-2-b557e2c46e6f@gmail.com>
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

Convert TI PIPE3 PHY binding to DT schema.
Changes during conversion:
- Define a new pattern 'pcie-phy' to match nodes defined in DT.
- Drop obsolete "id" property from the schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../devicetree/bindings/phy/ti,phy-usb3.yaml       | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
new file mode 100644
index 000000000000..84f538aa587c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/ti,phy-usb3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI PIPE3 PHY Module
+
+maintainers:
+  - Roger Quadros <rogerq@ti.com>
+
+description:
+  The TI PIPE3 PHY is a high-speed SerDes (Serializer/Deserializer)
+  transceiver integrated in OMAP5, DRA7xx/AM57xx, and similar SoCs.
+  It supports multiple protocols (USB3, SATA, PCIe) using the PIPE3
+  interface standard, which defines a common physical layer for
+  high-speed serial interfaces.
+
+properties:
+  $nodename:
+    pattern: "^(pcie-phy|usb3-phy|phy)@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - ti,omap-usb3
+      - ti,phy-pipe3-pcie
+      - ti,phy-pipe3-sata
+      - ti,phy-usb3
+
+  reg:
+    minItems: 2
+    maxItems: 3
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: phy_rx
+      - const: phy_tx
+      - const: pll_ctrl
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    minItems: 2
+    maxItems: 7
+
+  clock-names:
+    minItems: 2
+    maxItems: 7
+    items:
+      enum: [wkupclk, sysclk, refclk, dpll_ref,
+             dpll_ref_m2, phy-div, div-clk]
+
+  syscon-phy-power:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    items:
+      items:
+        - description: Phandle to the system control module
+        - description: Register offset controlling PHY power
+
+  syscon-pllreset:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    items:
+      items:
+        - description: Phandle to the system control module
+        - description: Register offset of CTRL_CORE_SMA_SW_0
+
+  syscon-pcs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    items:
+      items:
+        - description: Phandle to the system control module
+        - description: Register offset for PCS delay programming
+
+  ctrl-module:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of control module for PHY power on.
+    deprecated: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,phy-pipe3-sata
+    then:
+      properties:
+        syscon-pllreset: true
+    else:
+      properties:
+        syscon-pllreset: false
+
+required:
+  - reg
+  - compatible
+  - reg-names
+  - "#phy-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* TI PIPE3 USB3 PHY */
+    usb3-phy@4a084400 {
+        compatible = "ti,phy-usb3";
+        reg = <0x4a084400 0x80>,
+              <0x4a084800 0x64>,
+              <0x4a084c00 0x40>;
+        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+        #phy-cells = <0>;
+        clocks = <&usb_phy_cm_clk32k>,
+                 <&sys_clkin>,
+                 <&usb_otg_ss_refclk960m>;
+        clock-names = "wkupclk", "sysclk", "refclk";
+        ctrl-module = <&omap_control_usb>;
+    };
+
+  - |
+    /* TI PIPE3 SATA PHY */
+    phy@4a096000 {
+        compatible = "ti,phy-pipe3-sata";
+        reg = <0x4a096000 0x80>,  /* phy_rx */
+              <0x4a096400 0x64>,  /* phy_tx */
+              <0x4a096800 0x40>;  /* pll_ctrl */
+        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+        clocks = <&sys_clkin1>, <&sata_ref_clk>;
+        clock-names = "sysclk", "refclk";
+        syscon-pllreset = <&scm_conf 0x3fc>;
+        #phy-cells = <0>;
+    };
+...

-- 
2.52.0

