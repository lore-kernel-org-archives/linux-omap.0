Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E63ACA4A
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003318; cv=none; b=r++0l2bTeiSGLZv8tZMWjEnWXMhgQ8LZy3+NQJgq4m2+iEskLTxoVREZ92/nHNRtjgH5nqDectSadQ+QKGRQ68Gmu8O/Kwbpt4oiDvcXWS0zkC0Ag49g5V3CdV/LDpjkGh5AbhHbx0+P5DQVp5kDtdq4/pDid24aWX0lxjq3FHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003318; c=relaxed/simple;
	bh=vrwv1Mg7Vr8WAjda7g0Qmipd7F0KReKrluJL/Sq2pp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODwI1ULnutzH/e/yXUufMMsERaEcbZC916lB5DksBFgsfi+0HFlwipfnsoE1tmkFaZpsVVWEXH8QngMHMhXuzTuiTHbw3rgPFXkVoO4m2f9RCJg/Usv8ek6TWKbUAd81qUuu5zevwyE10v8CfEHCqzFLt1SUNAs2uYI99QZiZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2y0xtli; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2y0xtli"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf110997efso11703425ad.2
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2026 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003315; x=1787608115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBKpudphPlbxUGeo34jNMtpBUnC6d5V3mo4+9YrfHwY=;
        b=f2y0xtlifJXhUmJD3BZSfnbloEBhdjI0dUCs+npWVJ+AWv42tsj6AQF/HUK4o1RqXy
         3I/YFx8ZvDabm8NdNGyOZxXsj/l6da1C4NsJsQWKA/JnMFGAcDbONjvQIpr/s7iq1WkH
         jOZA0gQ/3QSocHCgmwIUMAIAdU8WEeZn23P8aoONYNTp87K2fsWyzau4PbLvuHpPM/q3
         tCez3VAYp9zgTlYMGXrULVkmGTch6+pbFV4QL6/oYBqzlCmqn9QKFxrKxArOoymLjYHY
         BHjtiyhTkmRV91zUDC2b1tKejqp4+3GzRLPsAMcmfCF+Gnzzsi9SriLM8bxHlH5FrHzj
         DMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003315; x=1787608115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBKpudphPlbxUGeo34jNMtpBUnC6d5V3mo4+9YrfHwY=;
        b=V6Ut/qJIOn0dyIekyglYr1iDYoOvNDqrW+8ijDgbIXzR3N06+OQQ2AFRLiQ9Rj8U3J
         w5ba5z5nDKS9jBnkyUdO06CInl49JRlxRHciOOj5U8S5L6V0qclfXLd4RTOTRMApKI40
         EnMRbBw1y95SVoq7K0tqKMU9pt1Eqy0eZ5S0jaL9W/dkW1zvIfr6UUbL7caW5tBcgrBi
         M+A4Nf+J4vkzaqTUtSJoznx85QV9rPUNveFdPNdbfKZC9B1MncY8/w2cTU14l8SRk2+2
         cV8nbcZxNaulQOLQcPzdzamJVnFvDer1DGeFGG93KVjVMJGz+xufMUB9iKU7movPpDre
         knNA==
X-Forwarded-Encrypted: i=1; AHgh+RpKUR/2P3EPI9/4FdQ859R666nkzl4A+tJapdTAWG6F20c2bODU6CLC45ySUbHDYI7u57mW4YCkjx3Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4/HwhVr5GDuvHluZZZoOV3ISihCL6s0/lUmt1f9CEO2A8ynK
	c/LVhCU2+EPT9W3FjrQE24C8L95gb9fWKuGMzLfVk1M/Dht9+Dl3yNzd
X-Gm-Gg: AR+sD127G5tCbPWJIEBgXCDkHjzTka2iD07d/B1lI0w4jpHzFi8HRaw8Jk8W1ro3Cxi
	EVQ2gaK1K/5B63AtdIRc7RgzNrnmlqVluM6GDIzCA8CxIjkiY41DMyVwKOmga8ofEWrJKLqT4AL
	PD6gJxoGck/Iczut2MWK1teKFwli+tIoPRTgfhWgIB9HxHY4Bw6z9K13KbVpS2/i29UAOezBaRG
	3q+NoYekULR1RxALDELJu1QP658vL9OVcw0f0wdgpewXAAuIeB+vBjwZWnX6o//pjflwQ8hXGNC
	nv3AmO5jOfnnuRXEqqxTmim+OF/IkL1FDRsME14EG0HYpR6+pAaBjlW/iPkD+Uxf36XVxzuf/n4
	h9kCZMbKDrACeIqfW7UF+93WeB9FSybC/rGup6Uev3rusnap2KaKD+zjYzTmlCynD76kN8jJZCe
	a9mNlomAoOqoMnqQvua238uQDlN6uLMbkBlgoIB1qN0pHlW8x6YqS9TKI+k8Xj4iisss1bhZdIY
	w==
X-Received: by 2002:a17:902:c944:b0:2d2:a952:2628 with SMTP id d9443c01a7336-2d3b0e152e0mr211801725ad.2.1787003315509;
        Mon, 17 Aug 2026 14:48:35 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:5053:3384:1c8f:aa2d:e07e:6d3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e3csm10153024eec.21.2026.08.17.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:48:35 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 18 Aug 2026 03:16:35 +0530
Subject: [PATCH 5/7] dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert
 to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ti-am33-usb-v1-5-69ac5f92df45@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787003201; l=2481;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=vrwv1Mg7Vr8WAjda7g0Qmipd7F0KReKrluJL/Sq2pp0=;
 b=5cdVO5grvNtj7pSZ3l35JvsZZXzjIlCUGf7WP0sk5fc/QuBlbz2cGsDRvjcd3Mf3kAErZuM3b
 w4kZuLmbQK8AfhA1iKqoyTRn67UautFydPH1F1rD5x9k29gvuHotrn2
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the TI AM335x USB Control Module text bindings to DT schema. No
functional changes.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/usb/am33xx-usb.txt         |  9 -----
 .../bindings/usb/ti,am335x-usb-ctrl-module.yaml    | 38 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 5973f88bcc65..94312ad8ec8c 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -8,15 +8,6 @@ The glue layer contains multiple child nodes. It is required to have
 at least a control module node, USB node and a PHY node. The second USB
 node and its PHY node are optional. The DMA node is also optional.
 
-Reset module
-~~~~~~~~~~~~
-- compatible: ti,am335x-usb-ctrl-module
-- reg: offset and length of the "USB control registers" in the "Control
-  Module" block. A second offset and length for the USB wake up control
-  in the same memory block.
-- reg-names: "phy_ctrl" for the "USB control registers" and "wakeup" for
-  the USB wake up control register.
-
 Example:
 ~~~~~~~~
 The following example contains all the nodes as used on am335x-evm:
diff --git a/Documentation/devicetree/bindings/usb/ti,am335x-usb-ctrl-module.yaml b/Documentation/devicetree/bindings/usb/ti,am335x-usb-ctrl-module.yaml
new file mode 100644
index 000000000000..f8ac0af745c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,am335x-usb-ctrl-module.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,am335x-usb-ctrl-module.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM335x USB Control Module
+
+maintainers:
+  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+properties:
+  compatible:
+    const: ti,am335x-usb-ctrl-module
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: phy_ctrl
+      - const: wakeup
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    control@44e10000 {
+        compatible = "ti,am335x-usb-ctrl-module";
+        reg = <0x44e10620 0x10>,
+              <0x44e10648 0x4>;
+        reg-names = "phy_ctrl", "wakeup";
+    };

-- 
2.55.0

