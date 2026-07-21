Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323D3EDAD8
	for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2026 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632916; cv=none; b=k8kLifU9pLR7VDIjayRp6s+ZNrmT+oNMUGjgFoyRqSXBhdRWmx56Yg7wA7Efy9C1ly7abvV2tQWF5g8BenLiYCf0IyH8w8qPKe6ddInFTpBb9p+kF1n4U7cDBEGcdhENNpoihrolHqyfErn41l6uykiwizGjP8VaQaWHxV2JHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632916; c=relaxed/simple;
	bh=A3H58nqM3Kq/iHa/j46nX7OSLl/NZ6iynhithF/jPI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtaPn03Kb3DHflqiAul5bys0wv4rb7ZW2f3jzQHgMuza9ATGGES3pB+Ngx5nr7b6FJlXfJJbRmMOFddVr+247a1/zUZ3GiNDaproNzmkuVJbjiteYQwvB8kPqYdogB8rWyC4fUzaM/giz8YW/VkJJO7dX9wu3PNheKk6Dlp0g30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhF4KTOP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhF4KTOP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso6277087f8f.1
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2026 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632913; x=1785237713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1PAaVR5Z5zVp+95Hj/mS4w8//PYU8SfwiS6uW9lwBB8=;
        b=PhF4KTOPBkpy7O2tQaAQeiuFA5A9siAP09oMmVRB56n2aXYIIfogEWFIf3FrO/vZDl
         xWPY0BoAjZXqPlY7HVlYzZ/pZPb6jicxXEBda1AKoYj/Y+m3dHSjfAVz2qQZdIVssk4k
         /Is40Nd8dgwebUlfu+HKp/Cg/RbjgpkncU1gwe2KYCL0fPOeIJAdNEhleMIqBihMkd76
         gozIdnzS4pBL17uSWAEpJZ9ZPJIo7eKNFpSZaEFGBHa6Ure2R/Q7Og0pqIN3iRfHGadR
         su/4X1zMpIexR+AssIh9wlI9k0XcwaSeiGBxpYdtTq9WQaVf9VLSV4toiNvDz9d3WSGO
         eqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632913; x=1785237713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1PAaVR5Z5zVp+95Hj/mS4w8//PYU8SfwiS6uW9lwBB8=;
        b=K59kS6SXMgamf2e9PBWOQC+m9XZBeJgW9nfL6UKXOgXkFuEo7x8wuhglum1M/G3RAe
         L3v7qckovk5nivhT6NiNyi1+suJTBVOOJwb536kXPwXHJe8VfinLwBOVBok9YMLD84/k
         kJUVmLYan1TvMJnnybuTXkMfVZsH2S4abk1YyEU9Aru4VAmEI2q8HFzMVxnvQUhlXdYg
         4O6ys/rZKG1qR2pDzgtSZHuQj9foDK2KJ95TtwRSDw1J57QLKlazAssPl0CEhHEwa4mI
         oBJVnpHz67klVBf1EQHygEKoR2cfTxl2bNjMSsxabIHTxSmpuU4QS9rMPjJf79CWEJ+X
         a4jg==
X-Forwarded-Encrypted: i=1; AHgh+RoDG9RnGWFP4uCpxPQERAObJ8vWFvsnuQSV5y5YY6cYCJcsEXsYz/+yIDoaxu6rI6liwZBnrN/J/xdG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1uItjFQm48Ypi50FI+tkS3KsJhXSQjxzjr6FNUB6xbzLCvLQ
	113wTJcv1IpXQa2kOM4BzoL49P3bDTIoj/vf0t3fWh5W24362/BT6Me+
X-Gm-Gg: AR+sD126nROhGJ1ZU+tAJykqUkGQkBXVDOIJf3t48l5lk1pXNd6Ng23YMXPEm5YnQwJ
	sRcEgBN1lMpDx0NDLhstV8DcP/ZXNVLytX5PHLrCCKIiITVLIg3Z/9jLygcNvSPxdY4Ct3B071S
	q91iroC6TKEoS/LiZXTdlMvNcQgjMGLGiikOPoxo96ZSKugun80c6oOynKqbGTc8eMgQrzU3jcD
	ypvb6HJgiXeb0qF3qAWi5pC80FUWQ0Ef6hfQQs6A2Ly+ETRzSbSH7Dx0SIQvIe4SUHSS0h3hGZO
	O0aPHnQoWhujBIOly3vVcpKjXLGPOeonGK+RU1Kj+69eDYHjZx6592gQ1s/aqpu2NYWhfQybZKc
	yWXIHPQFbnXuEELpZQg6OfPtp3wS5TzZR18Z+5CbnbLHNiqBZbxIHYL9+AzEAMiEY7RbHENCpTa
	jrazKs0PxLOGi4CJiSt+Ym+T4inN2QT0xLtoxzuqX2zEK4P/3KRcZ6Y9o=
X-Received: by 2002:a05:6000:298e:20b0:47f:6d4e:4cdf with SMTP id ffacd0b85a97d-47f6d4e4e09mr10976170f8f.58.1784632912886;
        Tue, 21 Jul 2026 04:21:52 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:21:52 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217 to DT schema
Date: Tue, 21 Jul 2026 11:21:28 +0000
Message-ID: <20260721112133.70382-5-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721112133.70382-1-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments TPS65217 bindings to DT schema.

During the conversion, the following updates were made:
- Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
  which are used by the boards but were missing from the old txt
  binding.
- Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
  and 'ti,pmic-shutdown-controller' properties, which are used by the
  am335x boards and read by the driver.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 2 files changed, 170 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
new file mode 100644
index 000000000000..4d2f4dbd2d52
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPS65217 family of regulators
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  The TPS65217 chip contains a boost converter and current sinks which can be
+  used to drive LEDs for use as backlights.
+
+properties:
+  compatible:
+    const: ti,tps65217
+
+  reg:
+    maxItems: 1
+    description: I2C slave address
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  ti,pmic-shutdown-controller:
+    type: boolean
+    description:
+      Set the PMIC to shutdown on PWR_EN toggle.
+
+  backlight:
+    type: object
+    additionalProperties: false
+    description:
+      Node for specifying WLED1 and WLED2 lines in TPS65217.
+
+    properties:
+      isel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+        description: |
+          Selection bit. Valid values:
+            1 - ISEL1 (low-level)
+            2 - ISEL2 (high-level)
+
+      fdim:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [100, 200, 500, 1000]
+        description:
+          PWM dimming frequency in Hz.
+
+      default-brightness:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 100
+
+    required:
+      - isel
+      - fdim
+      - default-brightness
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      List of child nodes that specify the regulator initialization data.
+      Not all regulators for the given device need to be present.
+
+    patternProperties:
+      "^(dcdc[1-3]|ldo[1-4])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+  charger:
+    $ref: /schemas/power/supply/tps65217-charger.yaml#
+    unevaluatedProperties: false
+
+  pwrbutton:
+    $ref: /schemas/input/ti,tps65217-pwrbutton.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@24 {
+            compatible = "ti,tps65217";
+            reg = <0x24>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+            ti,pmic-shutdown-controller;
+
+            backlight {
+                isel = <1>;   /* 1 - ISET1, 2 ISET2 */
+                fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
+                default-brightness = <50>;
+            };
+
+            charger {
+                compatible = "ti,tps65217-charger";
+                interrupts = <0>, <1>;
+                interrupt-names = "USB", "AC";
+            };
+
+            pwrbutton {
+                compatible = "ti,tps65217-pwrbutton";
+                interrupts = <2>;
+            };
+
+            regulators {
+                dcdc1 {
+                    regulator-name = "vdds_dpr";
+                    regulator-always-on;
+                };
+
+                dcdc2 {
+                    regulator-name = "vdd_mpu";
+                    regulator-min-microvolt = <925000>;
+                    regulator-max-microvolt = <1351500>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                dcdc3 {
+                    regulator-name = "vdd_core";
+                    regulator-min-microvolt = <925000>;
+                    regulator-max-microvolt = <1150000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo1 {
+                    regulator-name = "vio,vrtc,vdds";
+                    regulator-always-on;
+                };
+
+                ldo2 {
+                    regulator-name = "vdd_3v3aux";
+                    regulator-always-on;
+                };
+
+                ldo3 {
+                    regulator-name = "vdd_1v8";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                };
+
+                ldo4 {
+                    regulator-name = "vdd_3v3a";
+                    regulator-always-on;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
deleted file mode 100644
index 5fb9279ac287..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-TPS65217 family of regulators
-
-The TPS65217 chip contains a boost converter and current sinks which can be
-used to drive LEDs for use as backlights.
-
-Required properties:
-- compatible: "ti,tps65217"
-- reg: I2C slave address
-- backlight: node for specifying WLED1 and WLED2 lines in TPS65217
-- isel: selection bit, valid values: 1 for ISEL1 (low-level) and 2 for ISEL2 (high-level)
-- fdim: PWM dimming frequency, valid values: 100, 200, 500, 1000
-- default-brightness: valid values: 0-100
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-	tps: tps@24 {
-		reg = <0x24>;
-		compatible = "ti,tps65217";
-		backlight {
-			isel = <1>;  /* 1 - ISET1, 2 ISET2 */
-			fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
-			default-brightness = <50>;
-		};
-	};
-
-- 
2.43.0

