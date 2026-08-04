Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC22488DA9
	for <linux-omap@vger.kernel.org>; Tue,  4 Aug 2026 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863216; cv=none; b=RK+e7ZBEvdJU7D1yzO415D/B2k5lUe2UVlmnSPMrN1t4efyyxFbCKfiQ155Q6l8RysnaGrMxA1ox6BmbRA9Dswxxsoj1DWmBlH39JBLYmNlSju+DaBUcSJd/0GcJvtBQ5Z45c/9AfdOwEj070+nxH+cXZ12y6udMOOE0lTE8tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863216; c=relaxed/simple;
	bh=VbB4Wil3UCJk1uCa8RVTSXImGevkwsTjzv2S+pJ7HVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6x2DXeDOZrGgxZc4ZLCvW0pJMB0dM67TM0+K9B6NO/HNZefYieoKF/DLap6Ib9pt5FEH9pC7XoQ/AM0Lj6o5DhbkydpBLKi8LuCFCPYfNQCy3UlzyFV93R6/+jhVwFvr95Ln4F3QdkdVDW3T+sTxhV4m7w8Lef4ci7Vc7uxojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfzIATKN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfzIATKN"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso8266a91.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863193; x=1786467993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYY+O4tPwhRgJZdDFD4Z3lnoHAwg4o64PZBS1DmAN5c=;
        b=dfzIATKN1Lw1QchjIA+KADYhFvMIiX8MG9B/itTFLVq0gFBWGqKJ9pNtKLGF75J87X
         mykm6uxak/72vIp6fmz/Zwm9c0bUxZ5VuARiyPnH65lg0+r4mofdVTxsyfDcqz8qyfZm
         5pR3B72/4bPo8KuuU7gWwUWdWiV1AHsigLfIE1SxzfmqNVTTMniQSwmecMfsu45p7pt3
         urQ+LVJg28eWwc5HbWD3t1mATtpG1fWRiUy7xsYAb2ARSw/7j6JTL4C/evTZ8yM/0vF5
         gP/6ePEEJ7GhXatOHB6dXxRpX8ZZmFvhpr2FZ5Glj4DDbgdY9YIjkC2TQ4wusnMWeskE
         d9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863193; x=1786467993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYY+O4tPwhRgJZdDFD4Z3lnoHAwg4o64PZBS1DmAN5c=;
        b=G9/voaK7D8HLz47Vlc/Fv9won39AkHXJePbQZsWwwHuC56DEPpVacRBEDQS2Q35a+S
         CSeVeH4cFQYj8Li7tnQLSFIRzvPmgJSp9XS5pwzzVVlQe951SsSVJZ4+wdpJLE97N/An
         JxWhwNhxh3HCaQE2QMsbOLKobua2iGVbDPvp4nI68s5OumV7YwyMxPhFVRbcID97LQRu
         0nSy7KCXxJj9vxctdAiZ4FBrZ6M3esnJyvhbiy5cIZUKYQ0qbSpscu468AejnCDxcaVZ
         io8EjTy9WwFFjuOOfQ5p9O+3t8cFqJiSt0j5FKkqizE2TlfG0O6uKSC/hOVLGKryYswW
         9Ocg==
X-Gm-Message-State: AOJu0YyzEzB3b2uvncbml4KVsjM891cp5HaUloEymxH8zf43VXPOIJjT
	RnI3kycfG+bI3DbSqwOtFhmvuXR0YHSME20gDVo8+JaPsUCOI+M4lPqm
X-Gm-Gg: AR+sD13S6ZcdSzktMdSuiAV5XoZd7eOerCBK55yQikuPEdygz8sX9GqQF8GbhT7OCAa
	vmY+cc9m7RBnyNCzUlMk0spInDlLK/eGvFyegIzgKhaD64w+rA6Q6Fr8eVotr2KCIi1/Deeyz6f
	bK0K9W3uEhgiDSllDRbp29SfdqiRR05NnM8yIVGDwa1RvZBq4nFbQuAXFFuGudyws+CF9B7psE+
	PPwndjqdQcU/KgRLH34clU7xu8N06vGH+ZgNPd1RPWfBFWiR8zzy1u+zwH/Kct5OX/QzLgP0lUH
	7qPD9U8/ufGSy4t6bDdBFdZPiYHJiXTyIG1pobP3unX2Buov6gbqLh37FP4gd+9bDxDmWfBtRi/
	ie2uuoY9bM7gqbYFknKPb4hzu9IGXp9xb1exc9zN5/wk0hpccSFsjxkEoJlb7AmtCMC4MA4NgZ2
	qac75zKBDZCzmYdz6CuzJvWQtuMnNhvXW2aT+jaot2pOCyqhmScjnSX59xe971wNBQ/AjM/8njQ
	7OBJ7TrTQ==
X-Received: by 2002:a17:90b:264b:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-3903c64c81cmr455190a91.3.1785863193378;
        Tue, 04 Aug 2026 10:06:33 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:32 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:08 +0530
Subject: [PATCH v3 4/4] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=5941;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=VbB4Wil3UCJk1uCa8RVTSXImGevkwsTjzv2S+pJ7HVg=;
 b=hK83DJtdql0s9fVh0pB1mN+aT5VcopcY4vEC3oE/GWqdpf61rbyaapMGXgY8nsB8zlSmT0CHu
 blXDB+X02dWAAIUK5xAgstu5LtMM1MuV3jlRiN16zVo+9IRzMTsk5tf
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
as it is no longer used, it is kept to support legacy boards.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 --------
 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 140 +++++++++++++++++++++
 2 files changed, 140 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
deleted file mode 100644
index 062ebb14cecf..000000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-TI Real Time Clock
-
-Required properties:
-- compatible:
-	- "ti,da830-rtc"  - for RTC IP used similar to that on DA8xx SoC family.
-	- "ti,am3352-rtc" - for RTC IP used similar to that on AM335x SoC family.
-			    This RTC IP has special WAKE-EN Register to enable
-			    Wakeup generation for event Alarm. It can also be
-			    used to control an external PMIC via the
-			    pmic_power_en pin.
-	- "ti,am4372-rtc" - for RTC IP used similar to that on AM437X SoC family.
-- reg: Address range of rtc register set
-- interrupts: rtc timer, alarm interrupts in order
-
-Optional properties:
-- system-power-controller: whether the rtc is controlling the system power
-  through pmic_power_en
-- clocks: Any internal or external clocks feeding in to rtc
-- clock-names: Corresponding names of the clocks
-- pinctrl-0: a phandle pointing to the pin settings for the device
-- pinctrl-names: should be "default"
-
-Optional subnodes:
-- generic pinctrl node
-
-Required pinctrl subnodes properties:
-- pins - Names of ext_wakeup pins to configure
-
-Optional pinctrl subnodes properties:
-- input-enable - Enables ext_wakeup
-- ti,active-high - Set input active high (by default active low)
-
-Example:
-
-rtc@1c23000 {
-	compatible = "ti,da830-rtc";
-	reg = <0x23000 0x1000>;
-	interrupts = <19
-		      19>;
-	interrupt-parent = <&intc>;
-	system-power-controller;
-	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
-	clock-names = "ext-clk", "int-clk";
-
-	pinctrl-0 = <&ext_wakeup>;
-	pinctrl-names = "default";
-
-	ext_wakeup: ext-wakeup {
-		pins = "ext_wakeup0";
-		input-enable;
-		ti,active-high;
-	};
-};
diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
new file mode 100644
index 000000000000..02b3c23cf435
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/ti,omap-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OMAP Real Time Clock
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+  - Afzal Mohammed <afzal@ti.com>
+
+description:
+  The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock with
+  century-range alarm matching, driven by the 32kHz clock.
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,da830-rtc
+      - items:
+          - const: ti,am3352-rtc
+          - const: ti,da830-rtc
+      - items:
+          - const: ti,am4372-rtc
+          - const: ti,am3352-rtc
+          - const: ti,da830-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  system-power-controller:
+    type: boolean
+    description:
+      Indicates that this RTC controls system power via the pmic_power_en pin.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - enum: [ext-clk, int-clk]
+      - const: int-clk
+
+  pinctrl-0:
+    description:
+      Phandle to pin configuration for the external wakeup pins.
+
+  pinctrl-names:
+    minItems: 1
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Name of the hwmod associated with the RTC.
+    const: rtc
+    deprecated: true
+
+patternProperties:
+  "^ext-wakeup(-[0-9]+)?$":
+    type: object
+
+    description:
+      Child node describing external wakeup pin configuration.
+
+    properties:
+      pins:
+        pattern: '^ext_wakeup[0-3]$'
+
+      input-enable:
+        type: boolean
+        description:
+          Enables the external wakeup input on the selected pin.
+
+      ti,active-high:
+        type: boolean
+        description:
+          Sets the wakeup input polarity to active high. By default the
+          input is active low.
+
+    required:
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ti,am3352-rtc
+    then:
+      properties:
+        system-power-controller: false
+      patternProperties:
+        "^ext-wakeup(-[0-9]+)?$": false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@23000 {
+        compatible = "ti,da830-rtc";
+        reg = <0x23000 0x1000>;
+        interrupts = <19>, <19>;
+        clocks = <&clk_32768_ck>;
+        clock-names = "int-clk";
+    };
+
+  - |
+    rtc@0 {
+        compatible = "ti,am3352-rtc", "ti,da830-rtc";
+        reg = <0x0 0x1000>;
+        interrupts = <75>, <76>;
+        system-power-controller;
+        clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+        clock-names = "ext-clk", "int-clk";
+
+        pinctrl-0 = <&ext_wakeup>;
+        pinctrl-names = "default";
+
+        ext-wakeup {
+            pins = "ext_wakeup0";
+            input-enable;
+            ti,active-high;
+        };
+    };

-- 
2.55.0

