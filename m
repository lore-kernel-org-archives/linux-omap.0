Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2923264DF
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926967; cv=none; b=T8ElsM61QXd7Clfcv9TF2qeBHRabAxze8fnqLwey/+FOQ5FbJQFcinDpv+vUy48GECNJPEDJE+UDv6stvDQ3K+8StNul+pFyHPbQpwm2fuolfLopQgHySdeQ930t6I0KzCvfnN0nnNUloWS1LiFzHfnz8PxRHb5yOf7j+zdqfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926967; c=relaxed/simple;
	bh=feFJ3cnlDn0we1JKyyNWJUXCpQraRyX9mGvDIYJLtQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgyNCliGPOQjc9QEYMFfsrs3rffOzVwhFGS9Y1S9OPP6yTHHY38IZDiAThbNCoMzAcmd+QBHzUC5X6Wnra9AhyR8GkxgXLOHuKCupxBlOCvbVrYLb591stoVr8QD2jy/fnmBdVpKY4A9PuG4zp+QIMM9CziYOaskyhx6WW54ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baO+mXuI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baO+mXuI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf110997efso1845925ad.2
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784926966; x=1785531766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUymi7vybYsUITiWRP9i1AvRbqP98AZnxVv3SrWE4AI=;
        b=baO+mXuICg6hPwSFj2wEF9IME9mxJsuC4de277RFTcRQTC2zwWUtkqDoOu/YDN0Woo
         ZkGJKE6z63+tsPiofxN/OKUPrApvZNv0Z1FmQZJr1CX5SOTQIS0S/qctkJNxuvEmEINv
         l//GJbrgRnPp4ACNJS9F17/TIalOFQUyAOxMoPslzSwmtUqO3XQI6GJThT4maSfCbmVK
         li1y1fTeAMXfE1kub+TsJYvPfgLE0KL1t7QSDgP581tZHZ1FOMcvyhgAEIxoXfL7s7We
         9QNVtbCs/G0aKzxhKlgkWGCCRy/WjlCm+fETtGmZADggnj/t0mmjP9SWxoxTOjUwflSW
         5HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926966; x=1785531766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUymi7vybYsUITiWRP9i1AvRbqP98AZnxVv3SrWE4AI=;
        b=Bs2kLkF7QxcvqVZ3uru02Af0qxEpaeMN0zmiSHIp4dR8QQrpDmW2QuDMDepmkp/OBE
         eShuF1UATIwSvG+Xmc1K3xlZ9NoNNHGJL3clMBDZ7BpI5dEoq/b3GjD0N9gHWG+tD0rU
         Epj5pEXd+77uWCkf24sUqOLL5mrDVpE6eDJUpx/c/sDhzlhV2lgtxYtI8wzhSkjX0xQw
         Zea6RZn/nsSguTOV/1VCImJxy087Vb0C0/KI78QLOejwGZBT2jBZdcq28h3ut4Hn9Vi8
         DNRYbP+6Sr+BBCBGeOR+h2qrCbEwKst+uGOvBDjkxcEAAcZC0dOOe2aajPCJ/eetNnDi
         h0+g==
X-Gm-Message-State: AOJu0Yyy38NO6wbg2jE8ZzFS3H1PrYQcLQpx0lcZhPqt0ezDR86zrynp
	Xwp0sLP80cz+VI/m1fVuZRvPVhtT0yyX5W5aXra0i+SoPYHS/QyxkhSJ
X-Gm-Gg: AR+sD136rEloH8Fyk7BaiGGhI1LKhBFfVkcn58tUQe+A2a7fFEiVuuXjzRDzw8fblKi
	swW9fKw5vCnlLDTLvJDdSiOTuKBTpDYUcuqkQgnK9sk7zUyR+dxloI65J2klWf6lbFReixM6Mqy
	8OaFqjnexuuQh4pX1omq9rs4kic0YkgbjlQZa+Rju8YwyzHEPWtqWfhR66r1qUbKSzjmuKLjeQ2
	g7xBJEY4Pw5FD66BBF/H+d4mKD7dQjqWQpbvf6cHvOcUdQmgTvSfjTTWnlHGf8s59WGjgioLBrU
	wcRQt2YduZ9irIYgDV0nr5iIKB2z48q4kS09BpOjXev2DI38VW65yp/S0uotWAi6iDxQlmX0Wg2
	6iCXBF8JzZRErlem1xMcqf7Yn2kee/iIrRxa3FiZvlblFsmQeRL9xnavJH8gqzgeDaX8fqqN/9d
	NNShiLtMiTb7wyNCY=
X-Received: by 2002:a17:903:26c4:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2cfde55d876mr944275ad.0.1784926965693;
        Fri, 24 Jul 2026 14:02:45 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:505f:3320:3d54:c6f0:368a:d94b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm2485324eec.19.2026.07.24.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:02:44 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 25 Jul 2026 02:31:58 +0530
Subject: [PATCH v2 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-ti-omap-rtc-v2-3-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
In-Reply-To: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784926923; l=6142;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=feFJ3cnlDn0we1JKyyNWJUXCpQraRyX9mGvDIYJLtQk=;
 b=/XPqdc3qnEZW3CFhFhPmHfTDyM/M/JDHyizi476SIJCcC/WbHn9iQ0xwGV3ARpDchXI/e2CyO
 t16uh5Y5p1bAWLnLK5eOBNRTzkS70yTcz9VyPq0rbKRJPsbJe3ukxx+
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
as it is no longer used, it is kept to support legacy boards.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 --------
 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 149 +++++++++++++++++++++
 2 files changed, 149 insertions(+), 53 deletions(-)

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
index 000000000000..326d5ad97292
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
@@ -0,0 +1,149 @@
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
+      - const: ti,am3352-rtc
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
+    oneOf:
+      - items:
+          - const: ext-clk
+          - const: int-clk
+      - items:
+          - const: ext-clk
+      - items:
+          - const: int-clk
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
+        enum:
+          - ext_wakeup0
+          - ext_wakeup1
+          - ext_wakeup2
+          - ext_wakeup3
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

