Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6837C909
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569843; cv=none; b=j1Mhc8G2p+3N3tZPg2SXF2veJlKXD7MT8vEJhlgDSpqIDBNLdGf6Nb+/3FLU1VXLKozgXjV/by1y4SEkN2ZqtuAAy/Fj07zcl/Dnm+a+c/80HC0vJDzV4Sh6MJRn9nO9ihOMrn4v+MVRZTMfOxUUcAcloYOuCmER/L9atGjSn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569843; c=relaxed/simple;
	bh=T/FjvdGM7OD6Yjn2fdSSsnX2CArQ46QvxueAlbps8EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZzKGb+4YwsutxA3wjFLbAWiPZYZRcMZVgn0THD0JlaG/bBFasCCHDH9pFXWy+lKTRbcssRa+oFx3o1arkOxcr/NBj9mdkGSkotFS//190CH5BY3tV9YcZ5XBQ75LggkL0T0SDcsXBTJ+cgwImxZRS5k1on1xFjDE78S6AAxV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+nYX8h2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+nYX8h2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cbae8f69cbso631070685a.0
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569841; x=1773174641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INGbKjO0pPud5pCmrtXsYBpEWemfrnA7TW8P4kAQQH4=;
        b=E+nYX8h2+KAlixcWVSbRKcDW8mvqZrg3N/Qo0CqUDUQCZNWRAzFVyJ8ddNXd7CX0PY
         U+RGJAmeILMdmRtMr/mfu53qYhLjqjMPpMmriqBIRnZCGtghJakZaulqtZEBNzWSwxZ/
         j8bgQbvA13K497Ju9L7FZo3EZeFr2Ynr4ZNSoYGChlkpP++ayZJP14u11f6nlOICtSuq
         Xce6CpRPQSdivyzBLKXV5cXePogOc6rdFqt4eVqC+XXfOg3RyGMVbxBuqAF0Ga3W+H0O
         qYzCPBVP3I5rhcp8patduxCAVOQXkx4EaDlufFSYEo/0SjCJLFI18oJ6yvZIygPIyQxV
         /+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569841; x=1773174641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INGbKjO0pPud5pCmrtXsYBpEWemfrnA7TW8P4kAQQH4=;
        b=Wfb5v5RsrvOsE6skCcdluJ/sQySXjdCctvyxo27pCJ8Fb47Zy50rbjJVRF3i3zSPFT
         Txz3f1LNVhacuGQ4/c0VqgPzgWJQixE5SXZgd+J+ebFK67nbB8H/PnAEnfsAqU7JvHzt
         v6vd/VbS4kgjzpaczGNKzRu1UCXYYOQHpruFILxKt+pE+pRjoI166tvXNjWIovK7tQkH
         7qQ0/z+lRrdSLJqJJpI9kfQrKYEsacgeD4nDBwBWt1XyMHqqlbYoBWZp0JpGIxxUm1ln
         zn6aBIEnXXlF2qBXeNh5VzktGAXOxF3iI9u2XE4iCUgMRFdqfggg7xM4uF0nLgXLzaGZ
         GxEw==
X-Forwarded-Encrypted: i=1; AJvYcCVondQ6sv56z+1MSP62Xmev24u6L0knzu4o+/OHJWygYHAhJnZ/HNjlzZhD1Yjj4W2He3A8fFUnErtq@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBdysDL/NNO3DOZf963u/DFQiKuYmeAO9xRcd3QQlrN7akEZo
	piutpd0VgPWvak8HNgvZdfjufCSRQ+8eRE3PRgawhlGVbBbbujswq2U3
X-Gm-Gg: ATEYQzyyVyKluVB/YMR4ZqpzKsygIBiPqz1jJOR74E0Ct9sdYwwnJhreAHBNu9i8LNC
	azsGUSYgvul5NtqD6Qbo9Lm8lukbMyZydD6epQL2L8P12KGhr3AgzalvCa5ve4XXJfYg5cPO9yE
	kMKjyWqwbENMDzu54Pno5QyHGkCMOqfjjw84QTulG7x1hN1hgmql2i0oTmXe3+r8Ikqxi+1Zub8
	P+aoqz0lAZ6GnixphFLzdDY2/lnMUCbG4fVTIJGQPKMjMX9zgG6bnHRxq8/EBX4ngXrjySwQiTI
	2ka44p/zjbRSxvjzjxaDcaXIjl2NvT2hT/VasJVfawUwLpeUHc61verrGYak3tNwG6hKPeIVGPk
	nLhTLdWQLM9AeEmx8anw5RJbpdY4hJDE+Ky+yi+IVsLh/9ULdKZ1j/7oNbugAyeGZim6d7mqSde
	4mEa2zqtaPulTAkNkMwj8IvDXPGoqXwN6ieePT1qTlom0lkEnA2JIjSUfpHWD8cwWF4UdeYXPny
	NmPlQWC7BBPX/DNYherNg==
X-Received: by 2002:a05:620a:28d1:b0:8cb:3fca:2f9 with SMTP id af79cd13be357-8cd508e279cmr429991285a.4.1772569840704;
        Tue, 03 Mar 2026 12:30:40 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:40 -0800 (PST)
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
Subject: [PATCH v9 8/8] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
Date: Tue,  3 Mar 2026 15:30:17 -0500
Message-ID: <20260303203017.511-9-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303203017.511-1-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
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
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 101 ++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 1fd426204..be992910f 100644
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
index 000000000..558dc3c02
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
@@ -0,0 +1,101 @@
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

