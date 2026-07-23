Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337443BDD2
	for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801189; cv=none; b=Msw3QUD09cWg4MEmJppLDeeO0QiEh1G0zzjDFUX0jvuu7haCZitpko1v2g/wA4OEUbY8axfAvSgI+I01DeF/JN7qFxMIQD3bH7ndpDK7lcvgKOysIWg3S6cjOMzVpn4+wIgVU3DbpXpdQsT+TMsC25d3F7RAbRQtX5mq3zThKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801189; c=relaxed/simple;
	bh=yi1L0OaPBYwYferLA/S3gjy5fRutjBcgYUBGWpiPzVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpFOZ35fq/dUNZsKLIDYJCo+af4gHO37UvTtKso5NrOBtdsG5cJNdgtAsuGyI5pgZHiSgnZn4Nz1pZgfj4mAA6kbJKg+wiNCuxSbT5yzzLVDh0ztz9OSwUlevIibHli+yuXqPshbQibrvafG+ZwYGPacb+KcbSTXYAV5lQjMcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpyYdCaE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpyYdCaE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de008b020so263021f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801185; x=1785405985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPl3pwlOAjDCJEiarN+UR1ZW+s5HzR452XUHV7AUK2A=;
        b=JpyYdCaEfDeKoz2vy+hGZ3MT0wBGxveKx5zP7jnbEv4maSwLfLO3S7T8jmKtQ0QOab
         aGS+N7mTEvtEoFoe4ujUjpWRVzvxx7mLqgkRUZvjRD5Q6YNyVXybLCVRvsuO5IZCjn5P
         +jsRHIKBmKBe4bdg+84tvr2EJNBczogYCBb6kiS8yxYEaM10Ugq1SJTm2sq1EUv3L7/c
         hb8L8QIIEI6g0IqiH29DG6lEsLbtDfMM5vyIzsgKz4ZKdG12iBbAGybUwhqIopqCyBgz
         LIqC/5qUcg91lFNb6GxpF9eK9guChvphoPlpQgBvOfzY5vkgBbiABJU/pmzlnoBchA/e
         nj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801185; x=1785405985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gPl3pwlOAjDCJEiarN+UR1ZW+s5HzR452XUHV7AUK2A=;
        b=arrf3FMF29Fhoqh2+CdpalWhLNjU+jXcJqhXNOJUE1wt0u4kPs5Q/9ImbX31NqFmjC
         l5M2qVuJrYgTRxMy0avF10r8JIlprsTNhEGpWkv1eLqz6dCi5FSrWueoDJeNAp17QrMQ
         Fim1RzDukAmO4tC+OqZ3v76zV5k3pVtG4AtJg25uXqd6fNZDOou+MR6Jtu3g3VV7xdzi
         +j3tLHZOAPhY/H887s0pj7qhbK9KQHzCXs/zaq9WD3K3j6A6MKs/IPPr95fRMvl30XcF
         az8Chq6i12J2rTvH3hDPSu4XvPt//La49K706+Exm4gFA3Bi029kcOZ1v+oh+od8zvwP
         8Dhg==
X-Forwarded-Encrypted: i=1; AHgh+RqBLDUYBPejqgVrPFtZ37p9DH2a3P0izxRy3wgHecTHo4alMhwWJfqVgPBtzDfYN5yOP5Fr24iMbxzL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqg14+3LnVP9fDdR+/ERwYCseAo408OIx0U1/+imm0PAjpLhPp
	pHD2pEGX7zFadOT8HgVepkEbzzKFUH6zFHBvpdHP3JMce+6Jj/iWQ5lj
X-Gm-Gg: AR+sD100O05bJgpU/gTmnoNfVsf7jZ0XY9tC21DakwXl4OP+LyGvWmoVJ8w8ggnA7Y1
	tKjJMc/oLrOpKOBhbg04OCBR0eQHJ/HZqXQTWJ+JMCHcDeELXrtJZ6U4q+TBZPpNbhVmuvniR+E
	9NKqhfCBA1R2oO+rSMarva20R4c3oR5RSkmzTVnYkITjclTeIwyQ/KjkqrwMr1+4Uh5+nwKOo7H
	R2njDcnny7vkZ75oMr+9qBOLoCFE8s2utFQ0AYN6JaMS9pUVsn95jZnADQA1BKsAqTbimTKAvnm
	pj+IPKhfp7iJ+V/ZDBLNds+UzN4ukzrI/HZqp/AYhh6W4vu5pSjxUbWqRvNtOcNwWom51zYZk6I
	mZfciL+0hiNgCG/rPsSzcf4cI137RIRgkOISQ0enKCJKs3o5EXnGPfd5oZI0p9keo5e0KbbyzJd
	QBYUKEt7QTP7b/CUv4z2DQThXxA/HXtnKriVzvxn7kFsZI
X-Received: by 2002:a05:6000:2606:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-47f91586a18mr1946794f8f.9.1784801184791;
        Thu, 23 Jul 2026 03:06:24 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:06:24 -0700 (PDT)
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
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS65217 to DT schema
Date: Thu, 23 Jul 2026 10:06:02 +0000
Message-ID: <20260723100605.628882-5-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723100605.628882-1-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
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

The regulator/tps65217.txt binding documented the same 'ti,tps65217'
compatible and is superseded by this schema, so remove it as well.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../bindings/regulator/tps65217.txt           |  78 --------
 3 files changed, 170 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps65217.txt

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
diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
deleted file mode 100644
index 4f05d208c95c..000000000000
--- a/Documentation/devicetree/bindings/regulator/tps65217.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-TPS65217 family of regulators
-
-Required properties:
-- compatible: "ti,tps65217"
-- reg: I2C slave address
-- regulators: list of regulators provided by this controller, must be named
-  after their hardware counterparts: dcdc[1-3] and ldo[1-4]
-- regulators: This is the list of child nodes that specify the regulator
-  initialization data for defined regulators. Not all regulators for the given
-  device need to be present. The definition for each of these nodes is defined
-  using the standard binding for regulators found at
-  Documentation/devicetree/bindings/regulator/regulator.txt.
-
-Optional properties:
-- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
-
-  The valid names for regulators are:
-  tps65217: dcdc1, dcdc2, dcdc3, ldo1, ldo2, ldo3 and ldo4
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-	tps: tps@24 {
-		compatible = "ti,tps65217";
-		ti,pmic-shutdown-controller;
-
-		regulators {
-			dcdc1_reg: dcdc1 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			dcdc2_reg: dcdc2 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			dcdc3_reg: dcc3 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: ldo1 {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: ldo2 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: ldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: ldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-- 
2.43.0

