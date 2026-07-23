Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9643B49F
	for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801185; cv=none; b=AxHVpQJGYyBbzgZhz6ecSQKtegyrdJR2irWjuG/eTx48b2pnsW8+K+28r+5ddX7tzIO67GWzOOt1IlHoj2ugRTwiJXqEw7f5MZL9Mk+XNbSNPM4XSag4c0WJy0tpUM1HVBBm7D7UsiDY2UkuNVbw0gfPSvxAw7RSfMr+5tI3Vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801185; c=relaxed/simple;
	bh=663EE6043TD1T8mogiFdsiWLMBTKlwmyx3z0Ky5gDsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UScEIvn+nqLnWh0zp/jTFVEj63VFsDEC+FPO6t7PbGe/jhRvpnycT6Sh/JWFhHbH37HqwKCxV7wDsO4ncK2tDCEL+b74tc5MIaOw+cgm6pU0LKvbp7k+Xn1y4w14GW0HffNaf47g7cz4ZmHrTzsWSzL/R0iPmBi9uJEXvURKU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh4AkeKG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh4AkeKG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49550ec592cso1953875e9.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801180; x=1785405980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OkrjSwuUycBg+RRlfYmBdI9gqjZZ1EenX4uhPobHFtc=;
        b=mh4AkeKG/2uf0Spgn9mDIv5eqSzB1+XWv3Mua17KXF4Had1z24GX0eKAEhQqBTBVxC
         zmLi0bQWPArCNiAS2JkIrFI5H55LricfkhTFGM4mcIdNvDbMOGWGRQEiUf8lq2ZZ8Uvf
         0lqemt7oCmMcSLrPst9W6ILyD++eCZ/r8SZAvKiHidsbk+46YWZi6EvISEDXZ88oPtfP
         kjwKuKzoEEgiTiab3D+090gEbyVJCgP1Eov6JSfQT71FPZ+Gak86kvUTsK5V/xXwDKYB
         d/dhyhpwfSXWhCtZ6I8GCGIpb4CJ1TSg6+dN+TFQkHD6yUuTzRqWMPDzdQzGPiiSVB4n
         GGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801180; x=1785405980;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkrjSwuUycBg+RRlfYmBdI9gqjZZ1EenX4uhPobHFtc=;
        b=HdXfXiv9Pl1Qn1gu+Pht+osMTRLjXWvSO181UdphV6ZD11p6vX+Xw58yBNt2/NNCYU
         B78LZ3w37j1GS7OhvgDt0Ty4IS8+kyqbKmsJdJQ9Ji8LPYxyQ17gztpIU0bKWSuWmWWM
         794yu38coJl/VtIW5w1T3CKrlhK8rFDwwbJ6k8RekPJT2IVcF/ffbApX3xTjHLCG640v
         mMXS/ZNXBI21xAlnPQdLXcwiR0oZu0qBQjH6Agh88Xe1n7GAhMngMTrrX84ADSjvtZ4f
         meMl+izSnfQMhwg4jRs4kTuK5HShGYv6iit9wDFxOA5xWg8XOF7BDcnNBNwyH6Bodo7e
         Cfxw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6KQTTQMv4D6MOkz5Ka9Sg28n/sUfQmLqVKxj3FO/I1hxIwpRVNoC5TyZNExFfmjs8+j4q2q+anyL+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2iUUFjU+eQx3vt8C7pykvDdvQ5lEU7e4ghKZKKWH38ATVbBCp
	SODVIT3ryAfkGaw54lZ1V/zQCMylg3tBtAwAdCUZKSgy1fcmVA6NHtKP
X-Gm-Gg: AR+sD13MsaMjnBJn3uUW0KmP41auN7cLalQANDqnq9/AxBKYnS9joT102PqKkx0f5W1
	r7/mk3U/9hDOdJeK7TUG5oRnfWVjgTHQ7+Aveab2yRWf3IXmqfMoZi3ajfVUc5CiSCmW25GHmX7
	OCoayEgcu+niav+fM/qdx7WHpiUgU1dcAjLBIDz/3Usb2FWdBQceZwAJ/5OJ99H3z+SFjvrgb0b
	IQLGv7GRwmTdIlBgCOke+5dFvUHzTXE365YjYRcbEPbXc21oIJbB7iVi4RZen9sI/rDPC6hYg0r
	Tdg4nXJCYc5AR24M2awGwwl30VhdjTP6/hxphX6A4M29tIWR2dpqa3X+pU27iF1knfxUlvQzxgY
	Ph1Qcp0vPJsGtVhSWDRo7Fvodi9v0cy7gAHDni6hk5iPYGvwLcVk4An2ZglsHUcA0kGbS0nrjCI
	4lD9wd6rzpEzPFcSBkY6QWIHCkNmtx3+qs6QIUU1IIL3Ql
X-Received: by 2002:a05:6000:2309:b0:47f:9208:9e4 with SMTP id ffacd0b85a97d-47f92080a4cmr1526100f8f.31.1784801180254;
        Thu, 23 Jul 2026 03:06:20 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:06:19 -0700 (PDT)
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
Subject: [PATCH v4 2/4] ARM: dts: Rename the TPS65217 regulator nodes
Date: Thu, 23 Jul 2026 10:06:00 +0000
Message-ID: <20260723100605.628882-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723100605.628882-1-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TPS65217 regulator nodes are named regulator@0 to regulator@6 and
rely on the deprecated 'regulator-compatible' property to be matched
against the driver, which looks for "dcdc1" to "ldo4".

Documentation/devicetree/bindings/regulator/tps65217.txt states the
regulators must be named after their hardware counterparts, dcdc[1-3]
and ldo[1-4].

Rename the nodes accordingly and drop 'regulator-compatible' along with
the unit addresses it made necessary.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  | 14 ++++-----
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     | 14 ++++-----
 .../dts/ti/omap/am335x-osd335x-common.dtsi    | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   | 14 ++++-----
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      | 31 +++++--------------
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     | 14 ++++-----
 arch/arm/boot/dts/tps65217.dtsi               | 31 +++++--------------
 9 files changed, 63 insertions(+), 97 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 1d83fc116b66..e5ca2bd65736 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -337,12 +337,12 @@ pwrbutton {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -351,7 +351,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -360,22 +360,22 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi b/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi
index bd43da6356b6..9ee6d6d4a9c1 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-chilisom.dtsi
@@ -70,12 +70,12 @@ tps: tps@24 {
 
 &tps {
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -84,7 +84,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -93,25 +93,25 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3d";
 			regulator-boot-on;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index d595e79d6b05..fecfe12e1349 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -323,12 +323,12 @@ backlight {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -337,7 +337,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -346,24 +346,24 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-nano.dts b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
index d51cdd6e1ab4..c1143f0a3356 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-nano.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
@@ -431,7 +431,7 @@ &usb0 {
 
 &tps {
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			/* +1.5V voltage with ±4% tolerance */
 			regulator-min-microvolt = <1450000>;
 			regulator-max-microvolt = <1550000>;
@@ -439,7 +439,7 @@ dcdc1_reg: regulator@0 {
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.1V with ±4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <915000>;
@@ -448,7 +448,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with ±4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <915000>;
@@ -457,7 +457,7 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			/* +1.8V voltage with ±4% tolerance */
 			regulator-min-microvolt = <1750000>;
 			regulator-max-microvolt = <1870000>;
@@ -465,7 +465,7 @@ ldo1_reg: regulator@3 {
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			/* +3.3V voltage with ±4% tolerance */
 			regulator-min-microvolt = <3175000>;
 			regulator-max-microvolt = <3430000>;
@@ -473,7 +473,7 @@ ldo2_reg: regulator@4 {
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			/* +1.8V voltage with ±4% tolerance */
 			regulator-min-microvolt = <1750000>;
 			regulator-max-microvolt = <1870000>;
@@ -481,7 +481,7 @@ ldo3_reg: regulator@5 {
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			/* +3.3V voltage with ±4% tolerance */
 			regulator-min-microvolt = <3175000>;
 			regulator-max-microvolt = <3430000>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
index 93a3af83feac..021cf5cbbb96 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-osd335x-common.dtsi
@@ -69,12 +69,12 @@ pwrbutton {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -83,7 +83,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -92,24 +92,24 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index 10d54e0ad15a..363638e74719 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
@@ -433,12 +433,12 @@ backlight {
 	};
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			/* VDD_1V8 system supply */
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -447,7 +447,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -456,26 +456,26 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			/* VRTC 1.8V always-on supply */
 			regulator-name = "vrtc,vdds";
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			/* 3.3V rail */
 			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			/* VDD_3V3A 3.3V rail */
 			regulator-name = "vdd_3v3a";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			/* VDD_3V3B 3.3V rail */
 			regulator-name = "vdd_3v3b";
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-shc.dts b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
index 597482822608..473058584691 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-shc.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
@@ -254,26 +254,19 @@ &tps {
 	ti,pmic-shutdown-controller;
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dcdc1_reg: regulator@0 {
-			reg = <0>;
+		dcdc1_reg: dcdc1 {
 			regulator-name = "vdds_dpr";
-			regulator-compatible = "dcdc1";
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1450000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
-			reg = <1>;
+		dcdc2_reg: dcdc2 {
 			/*
 			 * VDD_MPU voltage limits 0.95V - 1.26V with
 			 * +/-4% tolerance
 			 */
-			regulator-compatible = "dcdc2";
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1375000>;
@@ -282,51 +275,41 @@ dcdc2_reg: regulator@1 {
 			regulator-ramp-delay = <70000>;
 		};
 
-		dcdc3_reg: regulator@2 {
-			reg = <2>;
+		dcdc3_reg: dcdc3 {
 			/*
 			 * VDD_CORE voltage limits 0.95V - 1.1V with
 			 * +/-4% tolerance
 			 */
 			regulator-name = "vdd_core";
-			regulator-compatible = "dcdc3";
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1125000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
-			reg = <3>;
+		ldo1_reg: ldo1 {
 			regulator-name = "vio,vrtc,vdds";
-			regulator-compatible = "ldo1";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo2_reg: regulator@4 {
-			reg = <4>;
+		ldo2_reg: ldo2 {
 			regulator-name = "vdd_3v3aux";
-			regulator-compatible = "ldo2";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
 
-		ldo3_reg: regulator@5 {
-			reg = <5>;
+		ldo3_reg: ldo3 {
 			regulator-name = "vdd_1v8";
-			regulator-compatible = "ldo3";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
-			reg = <6>;
+		ldo4_reg: ldo4 {
 			regulator-name = "vdd_3v3a";
-			regulator-compatible = "ldo4";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
index c5259eb7d21c..0cc9289c752b 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
@@ -607,14 +607,14 @@ &tps {
 	interrupts = <7>;	/* NNMI */
 
 	regulators {
-		dcdc1_reg: regulator@0 {
+		dcdc1_reg: dcdc1 {
 			/* VDDS_DDR */
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
 			regulator-always-on;
 		};
 
-		dcdc2_reg: regulator@1 {
+		dcdc2_reg: dcdc2 {
 			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
@@ -623,7 +623,7 @@ dcdc2_reg: regulator@1 {
 			regulator-always-on;
 		};
 
-		dcdc3_reg: regulator@2 {
+		dcdc3_reg: dcdc3 {
 			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
@@ -632,28 +632,28 @@ dcdc3_reg: regulator@2 {
 			regulator-always-on;
 		};
 
-		ldo1_reg: regulator@3 {
+		ldo1_reg: ldo1 {
 			/* VRTC / VIO / VDDS*/
 			regulator-always-on;
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
 
-		ldo2_reg: regulator@4 {
+		ldo2_reg: ldo2 {
 			/* VDD_3V3AUX */
 			regulator-always-on;
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
-		ldo3_reg: regulator@5 {
+		ldo3_reg: ldo3 {
 			/* VDD_1V8 */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-always-on;
 		};
 
-		ldo4_reg: regulator@6 {
+		ldo4_reg: ldo4 {
 			/* VDD_3V3A */
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 0d463de5650f..e7db105b3657 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -27,42 +27,25 @@ pwrbutton {
 	};
 
 	regulators {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dcdc1_reg: regulator@0 {
-			reg = <0>;
-			regulator-compatible = "dcdc1";
+		dcdc1_reg: dcdc1 {
 		};
 
-		dcdc2_reg: regulator@1 {
-			reg = <1>;
-			regulator-compatible = "dcdc2";
+		dcdc2_reg: dcdc2 {
 		};
 
-		dcdc3_reg: regulator@2 {
-			reg = <2>;
-			regulator-compatible = "dcdc3";
+		dcdc3_reg: dcdc3 {
 		};
 
-		ldo1_reg: regulator@3 {
-			reg = <3>;
-			regulator-compatible = "ldo1";
+		ldo1_reg: ldo1 {
 		};
 
-		ldo2_reg: regulator@4 {
-			reg = <4>;
-			regulator-compatible = "ldo2";
+		ldo2_reg: ldo2 {
 		};
 
-		ldo3_reg: regulator@5 {
-			reg = <5>;
-			regulator-compatible = "ldo3";
+		ldo3_reg: ldo3 {
 		};
 
-		ldo4_reg: regulator@6 {
-			reg = <6>;
-			regulator-compatible = "ldo4";
+		ldo4_reg: ldo4 {
 		};
 	};
 };
-- 
2.43.0

