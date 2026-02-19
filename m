Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0332695C
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535078; cv=none; b=ncYZj6YqMpABOBk7W28ASef+9owIXYJQkcjRrcFndbpjISNb5ledgBrBP81Kqzk81kHuZdmnG84yT2eNhRlyi0Ii3Iz9A6Z+u2LsNRxm5KU3jSDY2XkjPyWs9EFN32z0UIupf0gAcvj0sKiIQfoD45Q7heJwJkcv04b8x1J/oDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535078; c=relaxed/simple;
	bh=AUhhKwGaM9grtdftiWmb9K3MniiTndfrY7S51xLJzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkoN2xRoqGhbTuxsveQdqY51RaV6plaOxmB47cTzaAPwny+G8P/BAshuQSuAjIHsIlYP9oQH8FBFLsANls4tuE7x+JdPyGuDsWzz84j/dMiypyCzRCNp/U6SG9f4xg0L4U9HsUMEepgHSgnMRptMzjr7S0iL/BDXqR7pop1mhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQQe93VI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQQe93VI"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5033387c80aso31751571cf.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535076; x=1772139876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=kQQe93VIP5548TjxJfVwTI9xCLlx5ZA89cszLVTiY71kfL1Rv5eJnxePKf6D2lYUOu
         R3IHCG0/WcmVrliDZYsI9Z7ADfGdh+tM4c7MrD90QG2u0SdR+ipw8v+/69Jj/7NnIEef
         H/+JN3Lic93AV0jhSktTCZ5irmfSlUFf1enQbsung/N4JspR1gjvEJ/ioi/YHiuR4lxK
         AzIN8pgt4QJ3HjPv/TgbFmb84O7d7WX3i5qTWMIW02BTOWSdBFi6hvw81DoVtWTJLhCX
         aSFv9kcYNcmFSpeFrOLtFshQ6Z53PH7j+r0JDqgSUstcQUWg/jGs0fwHN3WqKgZWQd4t
         oGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535076; x=1772139876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=Uf+4D6uVAfkGCQ23GDbxn8Fx1bYcatJ8idyOyV3FSZBaTsBd6ZN4eq1vcxlS9EWPT8
         o1rAoShxSM4wcomhvYs60kXwzLuP2vOJ84PZeDebdW6+/j1J/rPqtCofsqb7l+Pt3hy2
         rJW+X2tTL+j5uqevC7yI5SnsM6Wg0uEtIBpn7PvyjffXP741MVmpjoIewsdHVyIctr8C
         F2F1lfFdwDXfwo9XN7o0p8aHfywFfJ2VKNBbJKGt5swgZaY1IIpOAofUUQSdD4O9hkSP
         WvLfEoGuVC8pupDtn/5LLVZg3Dkwar/E6U40/Ic+F6oc1h00mymSvFirdo/Ol/Rk2Bu0
         kK4A==
X-Forwarded-Encrypted: i=1; AJvYcCUrirDZSEllt64TCgAnSD29gTRDBXiSrQffmhxD0RCdX/3FKmsgbk3qzdz6kgHRWkV1m7aZHwLLv0H4@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXlP2tThrP8JH+5RFX3J3USH/FStvHDthaeFCYPxBRsnSpyHC
	wzFNBXh73dBFUJVHEeHDD6Hj9jiFvRK0xekXR6z6WG6BsvJU9h1v9e77
X-Gm-Gg: AZuq6aKeAI3VjvPpv1bSmVR2LBBpVVpiVH3378lR09G36QDYPZRkGQ/LTRWKGClZLzL
	vIeE8Zu1egh4t5cM07jQYf7SRNOV+X4/glkEWKX4sSnOdcN3f0o1pNPw3o1GAiGwxUcbck4GHU+
	2oA+wZsJS+PNkTzBB1b110ePBfZONNE+yaHhslQLp1GCh4cm04XsqlmS+qL9L7x+3fx1r1M3ZWQ
	/NB5glEKUfMTfmRMukPD8ytaNaLhIe/d7vll0vQk7DwEi3JmN+vmXgGXuqgBHusTtOtDeiiF5v8
	Fptx4IgjfqrjciMvILAGW1lrq2wugP/xRHFzFTCudRAwIT/DBzs+rxPtbg0WvX9S/NpBucTksGi
	lhVDwAtspOqeMMfgS7EJ27akHvz4iypfrgl/BbgGxriIcMDeZVSUwVK7jmCuW8pxf2wHCrRW3LN
	UE6P9MUtzvKbOiLJh1l6uS1f17bl28cOeHsXfz8GQQMN9k+GltXDgi+HZR6f1O/gAqN1Y30Po1J
	9V1KFuwwTM=
X-Received: by 2002:a05:622a:142:b0:4ee:232e:4950 with SMTP id d75a77b69052e-506f33285c4mr39123511cf.8.1771535076074;
        Thu, 19 Feb 2026 13:04:36 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:35 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	andreas@kemnade.info,
	conor+dt@kernel.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	jesszhan0024@gmail.com,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de,
	andrzej.hajda@intel.com,
	bavishimithil@gmail.com
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v6 8/8] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
Date: Thu, 19 Feb 2026 16:04:07 -0500
Message-ID: <20260219210408.5451-9-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219210408.5451-1-bavishimithil@gmail.com>
References: <20260219210408.5451-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a device tree for the 10 inch variants (P5100, P5110, P5113)

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |   1 +
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index d24f13efd..140ac39b3 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb \
 	omap4-samsung-espresso7.dtb \
+	omap4-samsung-espresso10.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
new file mode 100644
index 000000000..5c00d67ac
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+
+#include "omap4-samsung-espresso-common.dtsi"
+#include <dt-bindings/power/summit,smb347-charger.h>
+/ {
+	model = "Samsung Galaxy Tab 2 (10 inch)";
+	compatible = "samsung,espresso10", "ti,omap4430", "ti,omap4";
+
+	i2c-gpio5 {
+		smb347: charger@6 {
+			compatible = "summit,smb347";
+			reg = <0x6>; // 0x0C >> 1
+			interrupt-parent = <&gpio2>;
+			interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
+
+			summit,enable-usb-charging;
+			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+			summit,chip-temperature-threshold-celsius = <120>;
+			summit,usb-current-limit-microamp = <1800000>;
+		};
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		pwms = <&pwm10 0 1600 0>;
+		power-supply = <&reg_lcd>;
+		enable-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
+	panel {
+		compatible = "samsung,ltn101al03", "panel-lvds";
+		power-supply = <&reg_lcd>;
+		width-mm = <223>;
+		height-mm = <125>;
+		data-mapping = "vesa-24";
+		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <69818000>;
+
+			hback-porch = <64>;
+			hactive = <1280>;
+			hfront-porch = <16>;
+			hsync-len = <48>;
+
+			vback-porch = <11>;
+			vactive = <800>;
+			vfront-porch = <16>;
+			vsync-len = <3>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+
+		//avdd-supply = <&reg_touch_ldo_en>;
+		vdd-supply = <&ldo6>;
+
+		syna,reset-delay-ms = <200>;
+		syna,startup-delay-ms = <200>;
+
+		touchscreen-size-x = <1280>;
+		touchscreen-size-y = <800>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f11@11 {
+			reg = <0x11>;
+			touchscreen-size-x = <1280>;
+			touchscreen-size-y = <800>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
-- 
2.43.0

