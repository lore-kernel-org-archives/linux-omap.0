Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419A325486
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535076; cv=none; b=jsJY71e9YyA+HJoOPctL0jV5vaf5U7oH/HMm+q3J86KV8UpHcQLyjuGR3wfrjNGFj0nWsRM9buzhbAZzpEhPx+Ko23iEB2Kd3DGxczxfod4Qr2wwWKM37t9W8FXg69JnZqy9xXkPWg6/zX73bYSFduEVzyzeTicFktmWeqzhon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535076; c=relaxed/simple;
	bh=S2kYng34pyN/wX/EOplOpxbzEXHZ5N9BsJv+d0hNUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7oY65Ay6UsEcT7OJksdQ4KnlGDEPViS/I6G5j/+xUMKkYuCkNTi0WSJatve7LUQb/A+pCdxaYPAXkqVrxS2UQFGx7FokRMRpK4Ue0RwX6VXEprba+KagkhcflsyYMSO6ViyPrOpntwfev3v0PiDvODm/bPWnEGCMWcwzG3Tevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0mv6g0O; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0mv6g0O"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5069b3e0c66so28069581cf.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535074; x=1772139874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=O0mv6g0O9Jnyb4+H2bbEXs4ZgXLvFrR5ogvE+pZ4lk+awzcx+2cjPRqqBFwgSKzmLW
         Gs+F00SPmSTSvTotmqUJMTi066BFb9C08ogd+UIbmsP8oVmKl0oX55bFJgfmwirgRDyg
         E8spzWBlWs7fa7ulcBLApkpDocxGdOZtq1KZmut4CC53QkVNXlsurEDYnfAIRsCUE5/J
         7vV5OZQI7SSsm0Rt+T6fz1y9x3zYHge90AxXnjkkVjX3zcj6v807OjoGPSdrMA6H5N58
         AK22azo2awsKgPHRKvxlnRGQx1iLj0gAUS+fDQJpVlQx6WtnHLc2SV+slrYElAU/q2is
         cMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535074; x=1772139874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=U1z6QBYK9b2PNvAUYUnylCPTsULfFRMJsusNxdKhriA+88xZTskUY9XCqiFcv5xCP3
         d5S8S2y9vgI/2Simqa4R6BPv04+z4J/dg07LcQ+fUaC6ued4an/rN0t3PMj6zEuhc6xY
         qvwb7mhTujWa/zLz/ZBIIRPSIhrbJkKCuVl1mCX2v0fW8rx9HkLsgZC1SyvdMHgmPAMh
         ZKlPexBPUoOArVtwwYuDnsFYclRQKOsRdjwE5H9UfCjNk+cjqYLDz6cWaN9saiwBa6Sx
         gFu4M3/4IZmhKMnHusLCZ91FEMTASnMaI59roosqPXgKtOPjO+ua4itw4AputRIY91gz
         rihw==
X-Forwarded-Encrypted: i=1; AJvYcCX+TvCzPhAVhvT+6wkLqOevpzwEbUFO0aACOjhQdoAj7cBCZUCv74kjwyW3bmSMzJW0U80xH3cua+5m@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9qMNTbUf0Wr93Nm0cDMlflVOtznZ1IKdqUo37Y7VS2NhJXMj
	2YnJkQ07RQelzKt0+wRYEaBF7JTgA63tnDJBKygV4sI0hyY+k3jEnaHm
X-Gm-Gg: AZuq6aKzeH/mbTFt67p+sOf2U0L5zHUXS59v08kU/WNVSSlv9GZ3iOJ/D1zWKp/7KLk
	0xKbs7Y35h5LlPT5Sq3dwxokKgAnLJNs8v45YKoUYKGQdVUD8MlAZTzMk7oo0KfSgF5cVLAsGyx
	9DsdLEiraNzbaZ5Kq5VzstYRWhQ47ta5FouIpotHQi6i2HUsiNkPltS1uQfBSDISTiTk200EytX
	jChYAt2mF+9NddR5ifUcsSO1hysaItClipadDCzs5G8CFeIBdA1Wj2vBvKjAHlhY9EppxPP6c0D
	hhwmUC7CP2aw7NuN4z41uSp6AcYtcjAylcrPZvzew+UJcSfWb5clSjGGC5Eajl1MDJM6AiRkjwj
	dtvenkgagXvIiuVxmv98LbfcxCDsj0f4Wd5HuC1EtdkbYMyyC2eQOqpnw9UjXaYCc6dyNs0XisN
	/4/GoiH583W+2LACDE+g7lNfekLbsVfwgef/Eh05erY0TvELNUunxZ3CxsplAvWoWDEolwMVaLv
	cUlpx8gxlppYj92JUOdTg==
X-Received: by 2002:a05:622a:178c:b0:506:6d1b:6e88 with SMTP id d75a77b69052e-506f33a6063mr38594521cf.27.1771535073953;
        Thu, 19 Feb 2026 13:04:33 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:33 -0800 (PST)
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
Subject: [PATCH v6 7/8] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
Date: Thu, 19 Feb 2026 16:04:06 -0500
Message-ID: <20260219210408.5451-8-bavishimithil@gmail.com>
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

Create a device tree for the 7 inch variants (P3100, P3110, P3113)

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |  1 +
 .../dts/ti/omap/omap4-samsung-espresso7.dts   | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 14e500846..d24f13efd 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-sdp-es23plus.dtb \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb \
+	omap4-samsung-espresso7.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
new file mode 100644
index 000000000..cae37ff06
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+
+#include "omap4-samsung-espresso-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 2 (7 inch)";
+	compatible = "samsung,espresso7", "ti,omap4430", "ti,omap4";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		pwms = <&pwm10 0 1200 0>;
+		power-supply = <&reg_lcd>;
+		enable-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <2>;
+	};
+
+	panel {
+		compatible = "samsung,ltn070nl01", "panel-lvds";
+		power-supply = <&reg_lcd>;
+		width-mm = <154>;
+		height-mm = <90>;
+		data-mapping = "vesa-24";
+		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <47255554>;
+
+			hback-porch = <210>;
+			hactive = <1024>;
+			hfront-porch = <186>;
+			hsync-len = <50>;
+
+			vback-porch = <11>;
+			vactive = <600>;
+			vfront-porch = <24>;
+			vsync-len = <10>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+			syncclk-active = <0>;
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
+	touchscreen@48 {
+		compatible = "melfas,mms136";
+		reg = <0x48>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+		avdd-supply = <&reg_touch_ldo_en>;
+		vdd-supply = <&ldo6>;
+	};
+};
-- 
2.43.0

