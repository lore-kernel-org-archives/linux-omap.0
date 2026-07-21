Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444C3BC68A
	for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2026 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632912; cv=none; b=PenMZUN6kX6yTb0LeID78WHXuZFUBmVjLFrpgZ1ow/MAg6lLCSSv972pF2tQYle1OoaCTADeCMtpZ5n7rrI62x0D41WdQDPhPbKeRQSBOxcdocEZ0HEANkrK1CGpHGJwrGGRYa5xPrxRf+l789V9W0BHibwSQHB4xozscx6Bgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632912; c=relaxed/simple;
	bh=l2oWuNbkfPshmy4Ddiv5gsVVb/Q/E74UzOiY5dBWPok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWQordiZPqJqTgoW78j64s2znosFs/TO7Ah81hdvCP+cm5JMYwdtGOoDqiCEm6SCrV8uSCezt3UzgABbNH0ydmHr71Wke8NY5l30DQT9nN7EMnMfbGssunlkbz3zjKA6ItnGIRQGRxvXsyq65UoL/okyz8aP2Zmwvenlor4PIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhUTYF/a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhUTYF/a"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4758bd3731bso3890526f8f.0
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2026 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632909; x=1785237709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ikqaFqi2XTyE0Rfx1PdMI6um6f8LdCqdvY0N94xYl4Q=;
        b=VhUTYF/ayuWx8rdmBUj5WwmwW2Pgah0NNHDO8K4Eglia3IoUWyNBpUwbJuYNOadYfk
         7KR3lBmETMpzP4h7dC5DyBsxjdqvyNXIrG2aAxwGcVojEUkqkrwHUcu5ZP/hT/2BsFu4
         Cc5fFGZDOpHI7sV4n2P/SiEOkY2y372/DhZcQw4cgLtaJkrQr+hbJ9podZHx+gB743Hx
         nEhOq+sYYBK3zR3/B1KD2N9pDiONeKUOGP4tV5/ETXL3TAGp9q0ddG/8cGf5eTgiXTtF
         WIxGNOTrXtDdUw7wRAUtVxb/FKTqjV1swaBB4DH9a53d7EoMejJHdl6Oggy4U5qKXD+R
         kxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632909; x=1785237709;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikqaFqi2XTyE0Rfx1PdMI6um6f8LdCqdvY0N94xYl4Q=;
        b=ifqEHoWRQwEBpCm/2g6e7iMLBUDJV4azHcy6Tw2qFLjfTW8SV8CX8Kl8tNrGeaSutU
         TpvNz5Fr5l0lJJU4SFE4duNW2JtWU8Y7Ipvpt9GXZ9iSzgQ39f8qSlTgtQ9wywxrgTcO
         kziUZBbGWts7lwHKKz380MKGNdCv7QR18g63fY96ss8L9ZUok5A31jNFQ6SC6EMymoX7
         YGfqiqyUaAZl8jOWqsNM4M1BVVb2A8y0pRs4RtwH+KJRw5yVfnUbDrA3jSgH8gXoF1S4
         2xynEkrv8M0QKUQjNTz2nFkDG55IePPmdwl1eV6iAnupZJMynpq83fnQBQzaE3/JXUeL
         rn+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrO9hu+YWzTRfVIVOWG8rSLEAzocdrOPGX4GWDCzJ/YqulnW599ieElevoRAhmfhAekmHtJ6sJzWVj5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AVGLFnuz9GN+N+nV/0Bz+AoqoIERlR7juP11Bl3KEzn6O13R
	FqFtzeVU3zOQ+7zijSdHEvQ/CvGH6e626HiD+TlbGewaECt9bMLlrvjy
X-Gm-Gg: AR+sD11IY5Bo4doiGaFB/p8eNvGcvn0R095/nnd2V1lXguzImoRl3W1REQnUQqDUPgF
	egihcqZmQsexibIZK8h4t8gOELWAX8nTnI6G5mAJM4vOIe+8p08hvXKco/7eeRz6OZyuZoYojgu
	xceKLhialnz1nQ+iITQ2lf6oKwzvSfOSozAx0Fr40E/CJAN/UIve5GqTWOLW3xO5YtGaHtbevi4
	cal/79HGopnU3HVb6R63HnWYR8qKzgByASKt+VCw4O4p465/ZDl7omF1cRoMIVNVuhMojgSVc5u
	8x3eXYc8ewYLgdC0BHCiTfjWh6jGNxWiRW6clJeThlylBjGGO0QxVwOSEOaRkrLAMxvzyViR7Hi
	RRkEHAgaHcZFquv7JjkAmxaieZ/jGTmvBQIS65nbyfUJQoLV99DxMEXwYJsOz1DHjg1Wxn0EpvE
	zs0twuiBvQCKnSfPIdTxAQLCvfGFHPO+Oktr3AjGEpwvHW
X-Received: by 2002:a5d:5f91:0:b0:47f:4e42:675 with SMTP id ffacd0b85a97d-47f623ae0e9mr21326221f8f.1.1784632908660;
        Tue, 21 Jul 2026 04:21:48 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:21:48 -0700 (PDT)
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
Subject: [PATCH v3 2/4] ARM: dts: Rename the TPS65217 regulator nodes
Date: Tue, 21 Jul 2026 11:21:26 +0000
Message-ID: <20260721112133.70382-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721112133.70382-1-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
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
regulators must be named dcdc[1-3] and ldo[1-4].

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

