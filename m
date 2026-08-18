Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5537E302
	for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063377; cv=none; b=GDkJF7kqDmAXKcqBVE+Q/sSHwcbPG7edqiFTiqcEeuYha9B0XzZ0kTsTCq5Ckkn7CwFTDCp0IY1+6N5QSYibD6Zh5QGPNHSOYzZgQNVCVF343SDVyVDwciLafpAHB2ZBp2gfrNX8xmnTnZwjRnyZXjZ8ZIxFwb7MWbtyFNssyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063377; c=relaxed/simple;
	bh=GN8OC0qmWePc65/nVwGP+m4XJ9TN93CBwZAGUXRbCQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQaKGxySZ2pzjVrJAzfxLgAqmrGz8EahrpM5e1cdQqoihkf+dy771MmvwJY0tCz8KgzgslgKH3rNNGFA/m/vvHkY6nVao/X2m30M4ZXKZ44OO0iaJuIgS0LvSSFN5mzoI5Dkrb5fyuDj3GdQedTVQb2rfr7H9m/SOvspVuxZPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5PqPSVL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5PqPSVL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d5862bc921so5790615ad.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063375; x=1787668175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwa35nuSoG/2eGYsft3L6cCp2RsoUxnaTuzWFFhRxOA=;
        b=k5PqPSVLyyYH1xsLakWQzA4rWS4P8582oVCP/+2auRdnIjLAJxPiz5pffEM+sY+Mof
         l9cTf6RUPK5qHHfLPIofWG64HJo8IuNy6Ex5R1trMgBUi+mgG/eDe+0Yhcv1JqRz2JuT
         pGKbHvW7CP6RQwK76uHIzWI8IY2oQpYAZcBNaE38MGID+88+vaSx0nUq7YV0Xtx3g42X
         T7U3ARwcSdvzCXoI/solBUuubKhp3KXqLLp5fdZxoAoG0MmkzzssvlDQs+1ONTEiQWMQ
         43l8aaW4q4lQUKfiVJNXOP5w9CIDarxDyaMWdrj8PRVi69plaLHk1Pf2dizsam043u7x
         Ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063375; x=1787668175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwa35nuSoG/2eGYsft3L6cCp2RsoUxnaTuzWFFhRxOA=;
        b=eNBcyPQQHzbzsJI8ZI21UzgHszR2Mb70gZ6uqO8eOOQDhQKU5eqv/lioY2pAhwf673
         ynJL6UoanG6lj88UyZ6goCI8a5fphfwWkZwW0Vz9PQw9kyNt/tXIRPsFaS2cQ7f8/Puw
         aBl5ANca4c79Vh0cTUXULOtBbVtCVlRBIg3eZRzHBd7PdHN49yN1M6vEe3i1n5gDbB91
         7mB8Jwb31uESh9zH03ZaGh1IPheWSzmUo6Qv6yehWG4iPJvtWAcEt7xkQYFfEZ29xPim
         QhS7ehrGvoCrMrf6Zp2kXjsW/5ROJUeY7uL8DJ+A17tTZaj0j7IAL4G2UlcOUGnsp4t2
         N0Bw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2a/uVVLHXupcrMVRo76yVy9BbnHpGF47PqpB43s5AAlenXY0jNgecB0UjZh9svk0+pSWHxr+BhREF@vger.kernel.org
X-Gm-Message-State: AOJu0YwohDMYxJ7hA2ufEpCi0Rx+V1t4aUynIY1E91XKaER9jGjCZ2o7
	maU55ozE1DuV+xcpopsLEhNu9cuQIbjG7OpyiPfWr/Dva8YxZ44/jZSI
X-Gm-Gg: AR+sD11apv7IWsCAuItCGKNE2ynRu7VNxE54hGDHh6C7rllGTTuBp8ozv2qZf60BHuA
	1EzbYANQ1nE7h60euME8vf98X9fZS6wqJtIJPrEKOR5R5BBM8Tsxi7dknILMUJJhGAhiP2btkSn
	iTDyxjzI4/DhzgAgiKQYbsAE8BoXldVei3ZMHGDm68TBqKKOY75WuIJ+cw/on5Im/ahx5ar7owu
	FSj8+80ZVghOmUPL3ogp3Tq7dp62FzRZLwSgJUayqHQ7lMMPpGZkMyqmUzzTweXY30Qyjgz1TOE
	nQiE9IK4aM8fc4OYT2+oRCY6LOUsQNz7ohP9ixQpIHGtH/VOYSfRyttdHBXLdunpVoZkXQ2fQZu
	o0E5pf1EWBgM1MxPNivlW1kDAo8MfRZE0Qc7ahOc/a9ma5rGX/pAWs2Lkulx5CM4SBjj5RSPFXA
	zbQgFU5DZD9AJc++SaAJQtW4xXqrK23XjBIw9CRw0OOJAR/LFdDCzbaETnQMU16hK5FJBaaGOq
X-Received: by 2002:a17:903:4585:b0:2cf:9e90:8be with SMTP id d9443c01a7336-2d3b0cd96a6mr307749475ad.4.1787063374733;
        Tue, 18 Aug 2026 07:29:34 -0700 (PDT)
Received: from [10.90.163.252] ([2409:40c2:501a:6e15:dc3f:c23f:e55e:d03d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327b43d488dsm9043527eec.29.2026.08.18.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:29:34 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 18 Aug 2026 19:58:43 +0530
Subject: [PATCH v2 1/7] dt-bindings: dma: ti,cppi41: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-ti-am33-usb-v2-1-66fd44d66824@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787063337; l=5446;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=GN8OC0qmWePc65/nVwGP+m4XJ9TN93CBwZAGUXRbCQA=;
 b=/ICcEratZ3o2rpqEdLfMo+aQDlLKJjcSt5vgcEdD+6hRQzXd+n584IbHXRbjb3nvO6Zd16Afc
 gyQClNz1JY3AIE+fwrKHNSLQmXV0KSnbXKrPyKXfsHd7uaHpIO+dQOx
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert TI CPPI 4.1 DMA controller text bindings to DT schema. Add
ti,am3359-cppi41 and ti,da830-cppi41 into single schema since they share
the same hardware IP block and driver. Add undocumented #dma-requests
and power-domains properties to match existing DTS usage.

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

