Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA099370D6B
	for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063502; cv=none; b=KcHbjPi77Jo2JvnzB1keXqgcz1wXSJmFfnVWZipQkb40qfhOyDiE1oBD503qxR4YglFvfBGR/P+OtRBjLSDBRpjYu28JJjbLFwk6/H4UxbjfMsNt7MilLYIestYG5BN33OULwivB1RRzw9AtLCVRlLpx1DcAQuUJfkv13j9uWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063502; c=relaxed/simple;
	bh=bJqIbElUcpqQLiMeMmTF1fWVKJqAYL76gZjzfUU7oAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTRGTASIvXWFvdzxCWevFDnfP9TzOPcFiFO37NPSjd8Owl6Vz54avNbTzYYKh3D9W1K6KHGvr2Q9g/jb4HWsv2FlwDU0wEHvgp8Q9r5tfeqIpZQJQzyvdPQ7q4TtKNr1EFP9AzX+ULEDGTVl4Oef24Y+GUv6PYqf/xeclpfgs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd1YM4ww; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd1YM4ww"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38fe113c792so532538a91.3
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063500; x=1787668300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RE21JFz7XFYmP4oZ5LDGVF5TCaoOBdwIPAfKGxU/5ig=;
        b=Bd1YM4ww4z9ihbH0kiibqxjOxVk+86ussTA4NNVhMAtYoadrhNgGsBoZGwNhZMOHol
         qo6pQw3u7IFPRTlHSbKVwpz0tabRtLuEygayJdCqj0abBkaAlUbwLscOJBvJhcHW5iPE
         N8L1QnJxhZVUG1lq/NEP7e7m0WeIXfoJQNLNQA/lJaUnJC2xPrHvCWAvnOZZ+zXMqxlx
         qjX3aH/WpW4KMHHy7uzU5PC7wlUDLFgoH6V2zsa7ewTCzqe1PDWBya6j5ExGyNQK+8G2
         08FjTYn4qMPgduhZRCQb7KXuB5OSJDa3gFsa0AQL2YwYgcDpy+jc+IOOAHV0Jd25ubT3
         h+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063500; x=1787668300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RE21JFz7XFYmP4oZ5LDGVF5TCaoOBdwIPAfKGxU/5ig=;
        b=DLj9XpgDWcTOi2j304uaWTNUG7Lk+YICt63fQgkmGDyMQQQGlUzzrFFSG6pZFAyrLs
         yj72fAOkyrc1UaBvRO6sSkdQbT6tQjE9t4s1yB1Katr62YAN3DZIu2R0E1rrolgIix5e
         gMYD/NAnTkwOxJ6esqyaoKmhGsPy12Q+2F1xpgVP/ev1IMyMNW7MVitui7IdXvFSauT3
         XPxuSJ19AzKRV35XWdCmWMX3Id+YBHQcscZuh7fkGcRcaED76OmTQaZQDSi8TBnbJcMz
         F/tq9Cqg9CrbZoBnuHN7ku3KVh59Z1ENQJm+n6jVNX0yOXNwCmPcSKgJyej4/IDBQN5j
         tk/A==
X-Forwarded-Encrypted: i=1; AHgh+RrUlmgG7yduV4DipYNh5h/k9JGCOC4w8MFlwMlsJ02EnRJg2XYSpEypwcpC6aeBVYRMR4Y2AikUWE/r@vger.kernel.org
X-Gm-Message-State: AOJu0YxEF1eoT1i2+MZn26Br4YJQon+0iUWqLK16Mgtf3MIa3ykyv5r5
	RxAhFnw7ne1MSxiv6eUa830Z1hpBzVyMn4CaKA4PTvxwOTFUEVPfgRT7
X-Gm-Gg: AR+sD11ShHY4Htr5YCEJmp4ofOaMqvXUeY2cDxs3aG3qdFYVC4pWBTPkz32RhC0Jyb3
	QiCS7teXKQwTcBYDIGVBRADaA7h9VGgSmGNJCb6hwMHHyI9C6GoxiUilZFPDvQdGobWU5uZA7fn
	rmDkZYVHySy/HRKD6ECCVz2hgOGEXoMSgF8+ttudmuZzTPJ37PhfuhYUH8/i/hjFh+M2KMIFnuH
	hWbPvdeu60GUBEtKSHR7xhr+Ixn1Iw4gjZtDYTVRSIp0GYta0pErXbPopcMvSSGSETFZMo/hZWw
	pgUoWgUm/PBudsogOd0/nRxP6fkQzk+CHIqAUk4xjReqhOlS8EJYQ/6DYOMA5yMtZZW6aRS1/Gd
	JT/GJG8jDTY+TiAbcODPH/IE7QX6uBKj5K1ann3YPWqrFQZkZrSYAQKAORfqvaLSEk1TuRKmfY9
	1KBEvjegRlLyn3FAs1IcldySBenAsMar4cyjHrO9ugilUl+8/Kbedjkw9HLbAsfrBKVCYMKljo
X-Received: by 2002:a17:90b:164b:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-3933b95a6b0mr24932418a91.4.1787063499757;
        Tue, 18 Aug 2026 07:31:39 -0700 (PDT)
Received: from [10.90.163.252] ([2409:40c2:501a:6e15:dc3f:c23f:e55e:d03d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327b43d488dsm9043527eec.29.2026.08.18.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:31:39 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 18 Aug 2026 19:58:49 +0530
Subject: [PATCH v2 7/7] dt-bindings: usb: ti,da830-musb: Convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ti-am33-usb-v2-7-66fd44d66824@gmail.com>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
In-Reply-To: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrzej Siewior <bigeasy@linutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>, 
 Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787063337; l=5232;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=bJqIbElUcpqQLiMeMmTF1fWVKJqAYL76gZjzfUU7oAc=;
 b=ajK8gPvHZukbS3OTmoaPWtiAJLKyEZ4GPUFMq/CpE/Is60UY8/yuYcdWqrtu0dzz4DNm5f3F8
 Xln7lr2e1j+Bnn0KSAPjfBGJwlj+o/H8ZUzSgbPQCIDrSgByE2tgdsM
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the TI DA8xx/OMAP-L1x MUSB text bindings to DT schema. Since
DA8xx MUSB node acts as a parent bus for the CPPI41 DMA controller add
required #address-cells, #size-cells, and ranges properties.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/usb/da8xx-usb.txt          |  69 -------------
 .../devicetree/bindings/usb/ti,da830-musb.yaml     | 113 +++++++++++++++++++++
 2 files changed, 113 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
deleted file mode 100644
index 00320d92d3bb..000000000000
--- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-TI DA8xx MUSB
-~~~~~~~~~~~~~
-For DA8xx/OMAP-L1x/AM17xx/AM18xx platforms.
-
-Required properties:
-~~~~~~~~~~~~~~~~~~~~
- - compatible : Should be set to "ti,da830-musb".
-
- - reg: Offset and length of the USB controller register set.
-
- - interrupts: The USB interrupt number.
-
- - interrupt-names: Should be set to "mc".
-
- - dr_mode: The USB operation mode. Should be one of "host", "peripheral" or "otg".
-
- - phys: Phandle for the PHY device
-
- - phy-names: Should be "usb-phy"
-
- - dmas: specifies the dma channels
-
- - dma-names: specifies the names of the channels. Use "rxN" for receive
-   and "txN" for transmit endpoints. N specifies the endpoint number.
-
-Optional properties:
-~~~~~~~~~~~~~~~~~~~~
- - vbus-supply: Phandle to a regulator providing the USB bus power.
-
-Example:
-	usb_phy: usb-phy {
-		compatible = "ti,da830-usb-phy";
-		#phy-cells = <0>;
-	};
-	usb0: usb@200000 {
-		compatible = "ti,da830-musb";
-		reg = <0x00200000 0x1000>;
-		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupts = <58>;
-		interrupt-names = "mc";
-
-		dr_mode = "host";
-		vbus-supply = <&usb_vbus>;
-		phys = <&usb_phy 0>;
-		phy-names = "usb-phy";
-
-		dmas = <&cppi41dma 0 0 &cppi41dma 1 0
-			&cppi41dma 2 0 &cppi41dma 3 0
-			&cppi41dma 0 1 &cppi41dma 1 1
-			&cppi41dma 2 1 &cppi41dma 3 1>;
-		dma-names =
-			"rx1", "rx2", "rx3", "rx4",
-			"tx1", "tx2", "tx3", "tx4";
-
-
-		cppi41dma: dma-controller@201000 {
-			compatible = "ti,da830-cppi41";
-			reg =  <0x201000 0x1000
-				0x202000 0x1000
-				0x204000 0x4000>;
-			reg-names = "controller", "scheduler", "queuemgr";
-			interrupts = <58>;
-			#dma-cells = <2>;
-			dma-channels = <4>;
-		};
-
-	};
diff --git a/Documentation/devicetree/bindings/usb/ti,da830-musb.yaml b/Documentation/devicetree/bindings/usb/ti,da830-musb.yaml
new file mode 100644
index 000000000000..0faf2a1a17c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,da830-musb.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,da830-musb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DA8xx MUSB
+
+maintainers:
+  - Sergei Shtylyov <sshtylyov@ru.mvista.com>
+
+allOf:
+  - $ref: /schemas/usb/usb-drd.yaml#
+
+properties:
+  compatible:
+    const: ti,da830-musb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: mc
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb-phy
+
+  dmas:
+    minItems: 1
+    maxItems: 8
+
+  dma-names:
+    minItems: 1
+    maxItems: 8
+    items:
+      pattern: "^(rx|tx)[1-4]$"
+
+  vbus-supply:
+    description: Phandle to a regulator providing the USB bus power.
+
+  clocks:
+    maxItems: 1
+
+  clock-ranges: true
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "^dma-controller@[0-9a-f]+$":
+    $ref: /schemas/dma/ti/ti,cppi41.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - phys
+  - phy-names
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    usb@200000 {
+        compatible = "ti,da830-musb";
+        reg = <0x00200000 0x1000>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <58>;
+        interrupt-names = "mc";
+
+        dr_mode = "host";
+        vbus-supply = <&usb_vbus>;
+        phys = <&usb_phy 0>;
+        phy-names = "usb-phy";
+
+        clocks = <&psc1 1>;
+        clock-ranges;
+
+        dmas = <&cppi41dma 0 0>, <&cppi41dma 1 0>,
+               <&cppi41dma 2 0>, <&cppi41dma 3 0>,
+               <&cppi41dma 0 1>, <&cppi41dma 1 1>,
+               <&cppi41dma 2 1>, <&cppi41dma 3 1>;
+        dma-names = "rx1", "rx2", "rx3", "rx4",
+                    "tx1", "tx2", "tx3", "tx4";
+
+        dma-controller@201000 {
+            compatible = "ti,da830-cppi41";
+            reg = <0x201000 0x1000>,
+                  <0x202000 0x1000>,
+                  <0x204000 0x4000>;
+            reg-names = "controller", "scheduler", "queuemgr";
+            interrupts = <58>;
+            #dma-cells = <2>;
+            dma-channels = <4>;
+        };
+    };

-- 
2.55.0

