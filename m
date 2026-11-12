Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509681;
	b=vlvapoRZWHkdNE19q50HHU6OYHcPpNZB/HnAIHNBnq3inLVVKB62UpjzDYD2G2c/CvbD
	 JC7y3V5dsAvFS3VR7kRpkYGPYzZEnbMIkqPjzWP6J0VuZB7F4A01WUNWIfn5OpUqSnz5a
	 FimSS29gvhp/BRNzcDxW9jbZQpDDQ3edXyxvSNqZkyUOVF4xUQwk+WwRPjMdlod29AKb3
	 /OYWoa6NmJoHwu4AwYiZr7m3lsVxm1mkK73b4zSsp5KLtCe8ht6fx2qgWGWZlQ4oUNX6K
	 rYA1Kxjqq5837Ra0/W9oD934c0UV0WJvYACqQS6p4spbk0iUHMEMTKf8XZFNrcIDlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fWLnRTHzq44+Vxh7KKtStPCPVQVw0PPt5S1VYLelmew=;
	b=2OnAJSF4uJ6x43vvc6scyrG4o40gVtJ7+C229DH6bhEtKrDFKKBRtFKPBKSZav9LICjh
	 BBGUYQtAJl1UckyxB7VU3FIPxRgZlAq/omWHOUNRzC631K9sR9lov5QtgqftFgOpkBfc0
	 /pGiPwVhxwkRjyBpPXzE6sJs6IQ3T02RVv4gGurvU4PPsNDZwdFyr1UhGHSF3DqS7BweL
	 8iQAUHNSfQEKIr2p/OrUZgPz4bmdsydfPCVQzuQKbEgCF5AxSkcHbp2xBBCuChq6OaVZ7
	 A9dyqgYzzMxyDeNEbE9XiDeSwxLSmCs3zcWaOUkXrr0w/UvDwpjOXVGPE5QV+m6nXQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iSSuklZK;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF25606A332
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 18:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF25606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iSSuklZK
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-378915168c7so28408eec.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509680; x=1795114480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fWLnRTHzq44+Vxh7KKtStPCPVQVw0PPt5S1VYLelmew=;
        b=iSSuklZKuBtT8njwpKc001LaXfFN+vhWrgJUEUcHcG/nJIYuWQaqz3eNp/YZcosj/u
         WYs5H+eJFwsZ7t3OraTGERkr/UOUGJXWAq3Mibl1GuKOjhjOs/MgViuKiDovLKt/kSD/
         tJSSKQ3dDjAyfVpzryYrPk9Ry3mXpgcZGEV5twYfZhPn7YM8l1/fDgftEg+0DL22iuTX
         tQbG7MnEI/ZkM+E8LATUfwg72KnahVu/UeojFPXf0++g3zb4uZnC6GQAquc+eAY/c6kO
         bWcFg0WJdI62l63QTUmomSHkDKE/GcAgb2tMSc6mMi99uXjEkseM3ZtpAvT1iXk/P56P
         dc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509680; x=1795114480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWLnRTHzq44+Vxh7KKtStPCPVQVw0PPt5S1VYLelmew=;
        b=2vzoK4fA93waJpo5YjzFDIB90nU6pKMQrz0BIeklpjlxTzGC5wNqOXefMWXIc7AV8D
         apmDtjvdiE9RZSXDZgZ4GUVXnBTAD4A9Jft5mBlkCLCIlY7N80vUhBZsVgVCj/3s61/z
         OZd37WwaZWUu0jr2r9yiI42nuCt2ePakhGJXZ2vrNs74ObhBD3BhbBH+HKNhsAVj7row
         T5e8EJ1Zz9qr81DxSzGrz3ub7CJ3BAB2/Cml5/MWON958aAqKZrMGjvtSG1BJMxDOL2Z
         17xGRDzWIVuL0ZwTTW9+tByCCF8BVqaGSNixPPUs84kC3MivdwwrwD6p8FTCKT3cusgV
         8wbA==
X-Forwarded-Encrypted: i=1; AL+hErHsDmRJEAT/GRQpPUWdG81WqcvLVsG+tptH8Si3VLCX+0QELaechAhpoPdNe21G3piL33NmHxwyPxYJ@vger.kernel.org
X-Gm-Message-State: APuU4Z8oS2Vr8BE7evI4I7a2LsJaX7T2ivzixjXN8PLnHg9MZgrRWGr8
	SS5TgSpRukEDdngC1xCWB+7ipBC8rn/gWl9JwKT5p6Cyb6yI8SMHo+j6U5U0LA==
X-Gm-Gg: AYBFou2HhEkxmly9rO0zO3xEkvWVDvY4rW9a73JSet0nIR6fmYt1z5/0aPKLHQ14iRX
	cGMpOhC6mDZ5js8nbJBMzYTFam+lZHMukBAiV+4O75bAVOkcVgcvHFM6Lcdws9Wqv7PRURu874F
	V1WKQwpduU+FwW5BuUfD0v68jBNsjQNCi/5m8H4eK/VBDtFx6bMOCUNhz0BR6IcPiOsedlZkJYS
	GTJ93OCO9kMWkEyFORQb0gLxT1/FaEpZEJoXyPIGV04ManSn3aGS42YmoObimEtz8mqolWvklp0
	duEERfJdCTmLuUO5d33MkdZoa2vGHbG+5XvcnEP2MxzYooCw520rgNT/A+uiEWyNbTivzyPRno4
	ysHftgj6fFZsGvOEZUltOp1evBSZkOYn2m9NLQxXmYfozeF9oAHWKulOpH2CqakuqZDRvD5AM/2
	hE7zWfQrMiL0CwSoLWmQqHM4oe7agllv2HmwYFytlouOBOSvU/6nTq9BTa0O/BkqLuvRvgCinRE
	AqIp7kAyEX4se82hjCp+BMZv2DlwahaZMybYqnoGu0QJSVizw3wNGadWz3SzgyDm/Sb0pCz8l9O
	/nWIDu3zwbn33+bOTNJzU6IO+05pugnsw/fE/w==
X-Received: by 2002:a05:7300:6da8:b0:36a:e7a:e89 with SMTP id 5a478bee46e88-379659c6815mr96217eec.2.1794509679625;
        Thu, 12 Nov 2026 10:54:39 -0800 (PST)
Received: from [192.168.1.4] ([2401:4900:881d:321d:eb39:71d3:15f6:5fe0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm339008eec.22.2026.11.12.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:54:39 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 13 Nov 2026 00:24:04 +0530
Subject: [PATCH v4 3/3] dt-bindings: bus: ti,omap-l3-noc: Convert to DT
 schema
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ti-l3-noc-v4-3-5084dcf4ffb4@gmail.com>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
In-Reply-To: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com, linux-omap@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794509656; l=3333;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=WKKUN2jQjfC7QZp1fenPy2OkomRsdptL4bsEgub5sUs=;
 b=5D5VKA3cRIKqxXzxuLlHYsOud0dxvXQ0hWDcOveXaGCvjS6IyWuXgLxqo1dqKWAi+5aEr7rmP
 Dq9LpAQ013uAi4wmvJUv4KNEQd0w8X5IOd9ef4WNucRWkYReGyt2fQE
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the TI OMAP L3 NoC binding from text to DT schema. Drop
deprecated ti,hwmods as it is not used anymore.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        | 22 -------
 .../devicetree/bindings/bus/ti,omap-l3-noc.yaml    | 71 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
deleted file mode 100644
index 66548395fbdeb..0000000000000
--- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* TI - L3 Network On Chip (NoC)
-
-This version is an implementation of the generic NoC IP
-provided by Arteris.
-
-Required properties:
-- compatible : Should be "ti,omap4-l3-noc" for OMAP4 family
-               Should be "ti,omap5-l3-noc" for OMAP5 family
-	           Should be "ti,dra7-l3-noc" for DRA7 family
-               Should be "ti,am4372-l3-noc" for AM43 family
-- reg:	Contains L3 register address range for each noc domain.
-- ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
-
-Examples:
-
-ocp {
-	compatible = "ti,omap4-l3-noc", "simple-bus";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
-};
diff --git a/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml b/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml
new file mode 100644
index 0000000000000..85f314f177379
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/ti,omap-l3-noc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI OMAP L3 Network On Chip (NoC) Interconnect
+
+maintainers:
+  - Santosh Shilimkar <santosh.shilimkar@ti.com>
+  - Sricharan R <r.sricharan@ti.com>
+
+description:
+  The L3 interconnect is an implementation of the generic NoC IP provided by
+  Arteris.
+
+properties:
+  compatible:
+    enum:
+      - ti,omap4-l3-noc
+      - ti,omap5-l3-noc
+      - ti,dra7-l3-noc
+      - ti,am4372-l3-noc
+
+  reg:
+    minItems: 2
+    items:
+      - description: L3_MAIN_1 / L3F
+      - description: L3_MAIN_2 / L3S
+      - description: L3_MAIN_3
+
+  interrupts:
+    items:
+      - description: l3-dbg-irq
+      - description: l3-app-irq
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,omap4-l3-noc
+              - ti,omap5-l3-noc
+    then:
+      properties:
+        reg:
+          minItems: 3
+    else:
+      properties:
+        reg:
+          maxItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    l3-noc@44000000 {
+        compatible = "ti,omap4-l3-noc";
+        reg = <0x44000000 0x1000>,
+              <0x44800000 0x2000>,
+              <0x45000000 0x1000>;
+        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.56.0

