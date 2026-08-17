Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278A3A9DA1
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003244; cv=none; b=atHdrXkqHJCguAPXtV3Q/VXCkEBfHtG5bfauKPBWw97VeijRqSMMN7OPNnpGMcJQFZqWPfRpgpiSeVCHyEMHvVVZGoHdC7VbMAsKtHMAI8xU+tbMjskN/wWr5A1mf7cvBhqA+fiXywK6msBOShXqltHmbgKf3dqOB/Vy8QJVIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003244; c=relaxed/simple;
	bh=F21VF5WZIFeBDrvSp00yu7wITz+jK3eO7gUtavE26gU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ersy1NvmCvDPfnm4JnsOXheiD9kFi4FozHy14G89C9zzK+X5ybRYpKqkQaJZ5iCY0++aF7k02KhtpWFJoFdq74UTtjZe7CUYDgNecKNxNTgU52SSFHD+arUMCx4TB87ekhVZebBJN1TfViAAwW3q5dY89BAXEmYI5tF9yHctIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpszVG3v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpszVG3v"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccae46de39so6405715ad.3
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003241; x=1787608041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOOkvXfOzPtXa3REAJ+vIHNnVAQOzE4LMS85Pw6e9+0=;
        b=NpszVG3vKdF96MZFsvwBlbN4zwj1eAzR1BYqK750p0AX3VjZIJ35b4wmh5Uq6eemdj
         RLkk1DM4VBoFxPBGHf0P/zhXmQcrV8C36rCnnZGIuOozxwztnwOQAhq3mZjqyxJl4VMS
         By36HZhBWidNVdXtYKukyHRtNZ3aSu3ljkuFDzdX0UG6nbrKdXFCyEEP7BJrc9ZoDyjp
         YQ325EV7Rf/Hv/EODxkaUfRZt0ad0ViwVwIbCnKj6zmyKxSdp6BS80Z/wE0to2mOKD+w
         jER4Z2EfrqnS2ehAzCHNhw2HQROL/RRk+5XLxR3gma4kPti19Hin307/bT/HKg6hCnL5
         xVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003241; x=1787608041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOOkvXfOzPtXa3REAJ+vIHNnVAQOzE4LMS85Pw6e9+0=;
        b=BKCsSJecEzpdgHx2a/lnak7fT5fHkejn6knDb95j8x1EBKs8nPv/uGRcH8IOmFL+W2
         M08ux5gsJzlBPA+kF8UKK22y5febhvh1/LjBOTE3Y7HTmUYW3+HSuEYC+2BmlCkraAQ4
         IWr8IM+LlG7lpWnuOH6A1xNNN97qqL7R+rIGG4CSigz21/ScSZGxtXIK62otBrPNqqAu
         1j27+MGaRxS9iPO8maHCwHyeB35t6y3Qwo+AlbKbiVMuGBmYNr0WN2vMO0ugxOBN09Nn
         KDSicC3yuajXr67eqrO8sSElJTpz0V7cTXZkRpd80EFJEgv6gKV/F09/dtPg2QEYLY7G
         SFlA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+XJSx7mFJ4ba8LIy4dAjQfQLaNYzWjwaG8+s3PuatOMW8HclaygA/WksfEXo+kZYQwT3dIR2EdZxk@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzVbUOpbYA43oCVOutEHzjfGH516d8UoACyzok4Ucc2h/RugV
	/boY5hZ5545UEzLGVhwLl3n1VKxCSp7QLwN44/hVRA+ceUDeerN7hlPe
X-Gm-Gg: AR+sD10YQ3UfMgIm0ZF+gMJ+fnxt8iAC4JlOdrHe1PxC6NZKyw0/TfpqgY/AJNnDG06
	9J9qBz5oVbZXaEZBLerEEb4QZC11GbO4ZGdEWu42kQjcXQJxa2/gSS3c5gBt9T0LWzMasHE5D2O
	TefvwZXM2tMWn4pfRL7roeLmxcj5a8MSn+VTLoAaIBJbmgoMTqeO4JDsa649dkhaK8dchVE4M1y
	sFsOkBGZ12J6/pDhAJgCRrf1kLvzzHFw+8RYbMbSqXInz64RId3vNzhP0AMsptO62Pd0smeWwWX
	i5hIQ7X+d6CdCGFGzqkj9M+0CMJKhqIp+jHFMylkMjcrSoz5rIBX3vFjpmDp2BMEWtc9XaaUPb0
	vzJaojCBF/Do9gYNtXlBts9A0Oc/3+69RbAdygCVR0qlOsKPMzbsRLdBCYOC2qHElZHWX9D/oIh
	qBn+aCcvNUxBpVqGFeYW8WTh30GJ1w2sjcZzi/XwwpqCLE2HLMCXGMsA9kdwo+pPuRv2ZlAspYW
	g==
X-Received: by 2002:a17:902:f785:b0:2c9:8287:fd0d with SMTP id d9443c01a7336-2d3b0c9fa62mr234832805ad.3.1787003241426;
        Mon, 17 Aug 2026 14:47:21 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:5053:3384:1c8f:aa2d:e07e:6d3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e3csm10153024eec.21.2026.08.17.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:47:20 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 18 Aug 2026 03:16:31 +0530
Subject: [PATCH 1/7] dt-bindings: dma: ti,cppi41: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-ti-am33-usb-v1-1-69ac5f92df45@gmail.com>
References: <20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com>
In-Reply-To: <20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787003201; l=5423;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=F21VF5WZIFeBDrvSp00yu7wITz+jK3eO7gUtavE26gU=;
 b=HvBPE2YFgPKs1xpfA4//8wMC2+0JImWTrf+vPM4dpDHJnioYai6vZ+YntmxTM5KSe7QMI5+Cy
 KB4isr3/y85CaLXnWXDnMqbKCE4jJcMoQeu46l6lnifgbNCKHhV7fuY
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert TI CPPI 4.1 DMA controller text bindings to DT schema. Add
ti,am3359-cppi41 and ti,da830-cppi41 into single schema since they share
the same hardware IP block and driver. Add undocumented #dma-requests
and power-domains properties to match existing DTS usage.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/dma/ti/ti,cppi41.yaml      | 108 +++++++++++++++++++++
 .../devicetree/bindings/usb/am33xx-usb.txt         |  14 ---
 .../devicetree/bindings/usb/da8xx-usb.txt          |  12 ---
 3 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/ti,cppi41.yaml b/Documentation/devicetree/bindings/dma/ti/ti,cppi41.yaml
new file mode 100644
index 000000000000..110cf62c66d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,cppi41.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,cppi41.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI CPPI41 DMA Controller
+
+maintainers:
+  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - ti,am3359-cppi41
+      - ti,da830-cppi41
+
+  reg:
+    minItems: 3
+    maxItems: 4
+
+  reg-names:
+    minItems: 3
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: glue
+
+  "#dma-cells":
+    const: 2
+
+  dma-channels:
+    description: Number of DMA channels supported.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  dma-requests:
+    description: Number of DMA requests supported.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  power-domains:
+    maxItems: 1
+
+  "#dma-channels":
+    description: Deprecated, use dma-channels instead.
+    deprecated: true
+
+  "#dma-requests":
+    description: Deprecated, use dma-requests instead.
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#dma-cells"
+  - dma-channels
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am3359-cppi41
+    then:
+      properties:
+        reg:
+          minItems: 4
+        reg-names:
+          items:
+            - const: glue
+            - const: controller
+            - const: scheduler
+            - const: queuemgr
+        power-domains: false
+      required:
+        - interrupt-names
+        - dma-requests
+    else:
+      properties:
+        reg:
+          maxItems: 3
+        reg-names:
+          items:
+            - const: controller
+            - const: scheduler
+            - const: queuemgr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dma-controller@7402000 {
+        compatible = "ti,am3359-cppi41";
+        reg = <0x47400000 0x1000>,
+              <0x47402000 0x1000>,
+              <0x47403000 0x1000>,
+              <0x47404000 0x4000>;
+        reg-names = "glue", "controller", "scheduler", "queuemgr";
+        interrupts = <17>;
+        interrupt-names = "glue";
+        #dma-cells = <2>;
+        dma-channels = <30>;
+        dma-requests = <256>;
+    };
diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 654ffc62d013..8431de346129 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -51,20 +51,6 @@ USB
 The controller should have an "usb" alias numbered properly in the alias
 node.
 
-DMA
-~~~
-- compatible: ti,am3359-cppi41
-- reg: offset and length of the following register spaces: USBSS, USB
-  CPPI DMA Controller, USB CPPI DMA Scheduler, USB Queue Manager
-- reg-names: glue, controller, scheduler, queuemgr
-- #dma-cells: should be set to 2. The first number represents the
-  endpoint number (0 … 14 for endpoints 1 … 15 on instance 0 and 15 … 29
-  for endpoints 1 … 15 on instance 1). The second number is 0 for RX and
-  1 for TX transfers.
-- dma-channels: should be set to 30 representing the 15 endpoints for
-  each USB instance.
-- #dma-channels: deprecated
-
 Example:
 ~~~~~~~~
 The following example contains all the nodes as used on am335x-evm:
diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
index fb2027a7d80d..00320d92d3bb 100644
--- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
@@ -27,18 +27,6 @@ Optional properties:
 ~~~~~~~~~~~~~~~~~~~~
  - vbus-supply: Phandle to a regulator providing the USB bus power.
 
-DMA
-~~~
-- compatible: ti,da830-cppi41
-- reg: offset and length of the following register spaces: CPPI DMA Controller,
-  CPPI DMA Scheduler, Queue Manager
-- reg-names: "controller", "scheduler", "queuemgr"
-- #dma-cells: should be set to 2. The first number represents the
-  channel number (0 … 3 for endpoints 1 … 4).
-  The second number is 0 for RX and 1 for TX transfers.
-- dma-channels: should be set to 4 representing the 4 endpoints.
-- #dma-channels: deprecated
-
 Example:
 	usb_phy: usb-phy {
 		compatible = "ti,da830-usb-phy";

-- 
2.55.0

