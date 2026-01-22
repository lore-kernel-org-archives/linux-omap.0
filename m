Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616D34B1B6
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104482; cv=none; b=NnANh/Qqa+krbFD64ofJlEKAU3XpW6538HvkrROZuwOq28MkkccHW+kUoBOamjpyTDEqkrTfavr3Js1ZturIzaFqCPE17Me9aqCJaom7kM3p/TfZSTR81MpgTbcBLTiBbTC0ohlX12Lc6A84CePKWEY7IO9p13vxNUMjgbN5MMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104482; c=relaxed/simple;
	bh=n7boxvUn3Yk1HQ2wGXunhG0eYxqe8LzA2OtLvcsbp2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcxauIzcYLgwwoM909L8QvzEQJqP1jM3PpyilTg9KzvL7LtcrTqVAo4pGQsCYXAQuNDdsKTWkTlTj7goiviV1CWocKWvz5pSP/LN/JzauYwu1wLY4t0rklwAZxcASPxau17FPtQUn7tI7iE31FDAykQ7/kpwAmKhcjSMpCN18Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn7KaNm8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn7KaNm8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f102b013fso10315005ad.2
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104472; x=1769709272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hr9aR0CWSK1c9Om5bLkEGlAjVnpQPsFLIXPSY4tyYVs=;
        b=Qn7KaNm8VIZXlIYcsDtG7rOZ6AE2R997Tg7CtlwNtDFTBz1TpWkSiTGUev/YqyEVYL
         7VmpFHB4bjGG68pgeNVfByeBk95gAyoqhfZ0Zy4BrTjF+jjfRP6XGTDYo+V4/NOdpDIn
         eZCjYE1ZsWayd8B4udRT+Ls7xQwhnkqltq2vs7jN7X06CYy+lSKWhIj/CNBtigX2+7E+
         QuSKERsNbOgHkgETFe1NymhJm8uTBt0W0zNwUL/4OgGC2yOIokES8fBqA4YkMG1vm72i
         oQdyc2YHkK6I8D2UK/na7vyZFECu6cC1u8JIIwKuwPEPjGdfkuTw/S9jLzSyh+BGdtmm
         Gizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104472; x=1769709272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hr9aR0CWSK1c9Om5bLkEGlAjVnpQPsFLIXPSY4tyYVs=;
        b=cfggvimPwuAFNpyG6MfW2azZbFqXCTMa8GwPE66LiinRhAeVyqBF7QcXsLSUu/F4DJ
         9J2NTYceEVXesidavuRt0VcL99b7aGYuSC2HbcrT+vJ5QZJvpXkgD413nQMevEcJaskQ
         lApXBUQr+M7LG3s3QFcwnJzHm/SM6xqQCVOnj3GJ+LhtykaZpQcCwHcyQgJqQDg5Zs5K
         AHa9qXrpjHNTKJIoglQQRjhoRYO7jSWWbgb/UkBRX6NKfUrqwLoZYmQYGrMmmOHKa/KG
         ldCzD+7L6rXQBjUsO95yz3LaCxTKjP0ewlenUoczUKlPWVmYfVXYt+tl2YWe7lawCeYC
         LtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWozWxRDrWGNFgQ+1x6EGFCnrlQUQ8/2cn0xixUYFqZzZqk8+5M5moaxTMa5D10tXqx8xmQKcyzFL6Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+XBWZIx0OpB8oBfMHfeFEmvJ4FJVrFZfAS00GxT546rF2LO0
	JdLd91BVwHald0MWAnDxWzSj/XOC4Gj8D4hihvsU5/Obd4juGBrMr/Dd
X-Gm-Gg: AZuq6aJvvCs+iacO9Zr2jm489CqYZgTWVlhLNj/TKtUZP4MBO1Vt1xIvcMLBOCH2QHh
	QlEUMNIVTkGVXBKpjK0lzKCJe1TX9DE7FTNSAcAwqX2fXD0dWX5susfQJs4XmZkhQKdJjDtwfDL
	zEQTA6fCTCVbURPEcaF//nVTwjnA+3Ah/GxZoXc2Ta8EVUo1nQBTTtL7LNBBBxbYYgUbJkEbUd8
	hdrlwnLg/7uvLu9f8x6uMLiEeF/xXSYf2wAPOHixzf9Jjpob6n6ziueZ3oXjPt+1XSWXMaJk+M/
	rsDPlQyL+++tPYxqBPx4dBKtdJyR5TblaH2s1CGwvjO4a6Y91tFDpxZbeEZ5PZKX6PRy5HvuZL/
	YjKrfJ5gFaYcluvR112yqmidHieXkDetl2Za25R/+D5/lR7OBybenVtTyEX2hs4+T+Ckp9EAtge
	H0C8ZEzozQ97UZEAlQQyohW3HLmONXXDKvPt9FcYVICCc6
X-Received: by 2002:a17:902:f652:b0:2a3:1b33:ae11 with SMTP id d9443c01a7336-2a7fe75705fmr1806385ad.53.1769104471890;
        Thu, 22 Jan 2026 09:54:31 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm187745195ad.42.2026.01.22.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:54:31 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 22 Jan 2026 17:52:58 +0000
Subject: [PATCH v3 2/3] dt-bindings: phy: ti,phy-usb3: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-ti-phy-v3-2-751619729433@gmail.com>
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

Convert TI PIPE3 PHY binding to DT schema.
Changes during conversion:
- Define a new pattern 'pcie-phy' to match nodes defined in DT.
- Drop obsolete "id" property from the schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 .../devicetree/bindings/phy/ti,phy-usb3.yaml       | 135 +++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
new file mode 100644
index 000000000000..605f12f0f79a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-usb3.yaml
@@ -0,0 +1,135 @@
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
+    items:
+      items:
+        - description: Phandle to the system control module
+        - description: Register offset controlling PHY power
+
+  syscon-pllreset:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: Phandle to the system control module
+        - description: Register offset of CTRL_CORE_SMA_SW_0
+
+  syscon-pcs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
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
+        reg = <0x4A096000 0x80>,  /* phy_rx */
+              <0x4A096400 0x64>,  /* phy_tx */
+              <0x4A096800 0x40>;  /* pll_ctrl */
+        reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+        clocks = <&sys_clkin1>, <&sata_ref_clk>;
+        clock-names = "sysclk", "refclk";
+        syscon-pllreset = <&scm_conf 0x3fc>;
+        #phy-cells = <0>;
+    };
+...

-- 
2.52.0

