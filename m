Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02883D6CCF
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218640; cv=none; b=DE4BBpttwQcmYYoVSRufNg7xQAxczeSGt3r5i2rguQ98L5o98tr5ab4WCfHoizqSO7R6jGVl3eqQwZBp7IOnNqJSIZEYIiHzZ4VnkBAwTvY2m4jbk1m/VE3/XnuRKqcNFti1qtk6VRsqRgYd2VQcUCdIJI94a9nonfTFByDD2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218640; c=relaxed/simple;
	bh=HIZOfZztkTOerpbTCbh6mnrcWPp1/knZyXp0t7QNArY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeyE5TJrLLi7hd2364RXar1dc7BpPKU3a9HWKhv23ZO3bW593FsXf19ExH5q2g9Khle/050oFo9ta2pmNyjagx6T2x1pLdaNWg3+dDjbn8ZUOg5TG08ItHqLow0Ox/bQZwG96AL8Mcm9fwA8gUuGFTfZb19dNJxo60aynxxe27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVNAJ9d+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVNAJ9d+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b21b02f3so317670a91.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788218638; x=1788823438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3EuOR9GUslMYy5cLrs5U/qjnYbkc8yoD6yTFWIvT+M=;
        b=RVNAJ9d+5Yfd5wv0q6idwasClhGVkQ5gyA9ildjGSO3eNxJ2stjTIHHEGnz/KNGLiv
         BHxk6Pq6S+pJote1usa3YDh4XVSgSOWboQbRvA0HgxY+mpTyv1sDbWV1h5ZSLW3vc9kE
         uF+l2F+FBMXKdGikAtIfhjfzktysQsUme4tDl45x2toIzn6fu43/n2wxf5jqGLzLPnoz
         RUViaw9XMWJCFnGQI7VUSfb3WbbCD//dCSWugGGzoiXAIHLHSd4xoGfO3v6rPiBNvWOW
         +mf1cNyqAqbCyrKEvxxrwqERL0j+AN6NanZYcXWeFgWZzm0f0C6g6VUHpD/H3XT6XBiw
         Pl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788218638; x=1788823438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3EuOR9GUslMYy5cLrs5U/qjnYbkc8yoD6yTFWIvT+M=;
        b=o0zXw0o1kHIvzE2G4ODgyT4qjE267kcgYmNkRwdWqN8SYqpQp44sn0EJPTrr0UjCVy
         HU1RBo3nnlRle3r+JBuqcR+Rw46jGp2idZMul4c0xzSOfgOQrio5CjvoMpGHr+CkE5eu
         IcpmrO+R4vva+i8RUJ76cHrE1tVx7QC+avv8fl19va7B6DDiEzIDqp+DyZSxlr/3X5Fi
         Maew/WQU/Y6pMV7E6fS+5rt9yYZNWc73avOlegNKA8x1okVNBlnnYgo1PtWGiSF45/Av
         Jkuce/UY6LttH6p4jS8+4ZEKahdNEkKo41jFnrCaVzcwDpDLhV/Mhdf9pJgXXe8Mry2v
         uScg==
X-Forwarded-Encrypted: i=1; AKwUvBz7UncvmdFQyhU11ykp3TQMJ4DIJHsag0q7LblhCwoAN+4CkKkA9NQT89XIqfPrOawkV1jPfzMfbw1P@vger.kernel.org
X-Gm-Message-State: AFuF++ma4b3RDvZOndO4jESaKBDj8uueZ5JAEgzmWz8FLubZfcG29rTK
	ez0oqSy8DQT23R9X/S5ifYT1KWRXbLvaSLr4woKtK1iDwwxNWw5OlmKQ
X-Gm-Gg: AYBFou2KQ/+e9My18Gri6vBSwPjSpwFcBGmuAzrAsvid7R28GvSBs4rpGrWWqXSLG9W
	/7EpknMvhJ7ld9fTDplzmvrMjrvHdMvegoHY0e5rqs7dre6uFtK2ID/d3RMAbWyrz3c0rCTi2ly
	0U7DJnh6eyUmZutP1KNeAvM7Rxgnd/qZgbgVVZO3alMRogdx3dODXU17BdGVNTJfd86BBmo7Yzo
	0NJt79LcnbFbJKqaOMeRbdiHUgODmD9KJHcl38LuMq8rKybnZyY8lmj5QBOxsT4AKtFNbXMC97m
	nhHGC9d4fQq6kBMDigF03SCy/pldA5bX0GB3zuyUqqXkdi4kc7vtPEEZt97icF5OxRzXMzn0VlO
	vvuJCcyxNXRfjXneSWuYnVRJFIrXb83zLqifEPZZad5OwVom/JSRtVxdN798e5TESilyBaefKqY
	V78/BZUlFV13XfRJvNklfC2f/AAJ0qxpaFheQeX0iwvxaq2FdQHIw3re7oBE1pIA30Edtq1Nk=
X-Received: by 2002:a17:90b:5288:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-398babbaa1bmr16637563a91.3.1788218637567;
        Mon, 31 Aug 2026 16:23:57 -0700 (PDT)
Received: from [10.60.78.252] ([2409:40c2:5002:4362:354a:8f21:7ceb:c8a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm1963213a91.12.2026.08.31.16.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:23:57 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 01 Sep 2026 04:53:05 +0530
Subject: [PATCH v3 1/6] dt-bindings: dma: ti,cppi41: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-ti-am33-usb-v3-1-5e15c617d2e9@gmail.com>
References: <20260901-ti-am33-usb-v3-0-5e15c617d2e9@gmail.com>
In-Reply-To: <20260901-ti-am33-usb-v3-0-5e15c617d2e9@gmail.com>
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
 Manivannan Sadhasivam <mani@kernel.org>, Bin Liu <b-liu@ti.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-omap@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788218595; l=5496;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=HIZOfZztkTOerpbTCbh6mnrcWPp1/knZyXp0t7QNArY=;
 b=JXYLTjSgWVbdPooDMpJ/A4F3QlYlYjO7N0T4XSe0L+hgJAlH064Ttg3iMKDCGtIF2aOqfjK7t
 vNvl8IiNelaAeL+PHj8zJxwwAdETjJ3vAHpVCEfkmYdpfSkxF+XmX5n
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert TI CPPI 4.1 DMA controller text bindings to DT schema. Add
ti,am3359-cppi41 and ti,da830-cppi41 into single schema since they share
the same hardware IP block and driver. Add undocumented #dma-requests
and power-domains properties to match existing DTS usage.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/dma/ti/ti,cppi41.yaml      | 109 +++++++++++++++++++++
 .../devicetree/bindings/usb/am33xx-usb.txt         |  14 ---
 .../devicetree/bindings/usb/da8xx-usb.txt          |  12 ---
 3 files changed, 109 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/ti,cppi41.yaml b/Documentation/devicetree/bindings/dma/ti/ti,cppi41.yaml
new file mode 100644
index 000000000000..a8c28e8ada07
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,cppi41.yaml
@@ -0,0 +1,109 @@
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
+        - interrupts
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

