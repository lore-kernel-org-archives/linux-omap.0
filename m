Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612025CC63
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854602; cv=none; b=rUuR+LYmks9ZBNSng60YNRzacVRJG8/Nk6J6tgHG7N8TW7cOrnsUWtSk5ynWDIIlgRl0vH1OjN6mbliHWX1xg6vyig3ZW0NniPmbJTx5UqpIqZOabuypxq8yFpUuFwpuz0tAhTYazv+vJW1DrDYqUvgmyDVDw5aAgjgIGfxYEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854602; c=relaxed/simple;
	bh=S2kYng34pyN/wX/EOplOpxbzEXHZ5N9BsJv+d0hNUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfGXR7MlgZ3Nh0a3Xc8M01Rd9OVT3+WEaNrh8SASqPNUPwt4AUzZTEaPidkR2vbmrnuAWa7nsEdLK4xmaR4/EYCVWgoKbhT/sJIys8zk8sGFBXSIMaD2ppzcPQ4wveLTVeG7dKVKmj9NYLDbIAVVKBl4sgIjTdzJ9Arif3hEAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJfWafl2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJfWafl2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb4081e82aso552187685a.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854597; x=1772459397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=jJfWafl29nGTSzplbt9Ph211z6kMNkVrx3wP3+CEjeUUt/+qvPlkAWjNGD5lEBNmPa
         zPAGBqUgxH8cRYFX9fLavcGYM45zzELTejPZhp9+gR6VqWNJelIJKj5IiVpKDIJ06Nvy
         WpgWqsQrymPdX3/DkLyEU309TibR7KGCPZHCJqImzxuvqULo1SCxqOO1mkihK/lMRcNB
         VNVj/rz7gEUAISUGy/OuU+bH/7amzPFfqgO8we0A0ZJ5aSDHYjjKOIenZfsZEZOTyXOs
         pI3vEqQoXbL50mYTjYi6stlLFX9PBqYMqJJePlLwy50zK+MYNZd5e1pmyPqi6hIWqqKj
         6oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854597; x=1772459397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=bgki+VJq56jYyzwzGGkwThHU8TPD1WYuCeA0i8R32fk6iyDIekoqaHxK7XWIv5a+Yf
         JUCAzvDWGjgcGNuB1TA5WF17i+9WgbHxZJvBOcsdhu+UujMM8OISnDC1Acii4oPcocLf
         wQtoYpr9JHhKhM8r4Ti+J4796KcAeLklqhFJ/mcJXHeNm4927mv9YFkOj+zoUjpRe16H
         Cu+DD93hvRyWBbbJX7u6GfD0shgZr/ytOjkH5PXfu18Sw022XrVTlekQpAWAJmOd6v0r
         CcJMy9DnyOmjXShzj5cI+ICA6odwqcnc238/wS5B8ZYuw8kmDzl4mX7vmI1jVUkIXJgA
         ef5g==
X-Forwarded-Encrypted: i=1; AJvYcCXZoIWizxKDk92GV0Kflourta0uPwOqCYSe0+Zjie1gklOlDgAnII8U9ZgaoFNePapSn3JgC73sjVwx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Xl+bLfDKCxc602DCCtnHNlaaPcDNLzj4FFKj3atyl1m9w4Ms
	iDgPTfTQQpSfUwnPCCYEFjZrliy/1jMpgULCRYAZpB7V24saSaVoa1ob
X-Gm-Gg: AZuq6aLrBzn00uxbK15Qc8ZIn/dxupurvxv6pNs+2RL3+LBUPGVp/lGYl0tmnvSQInt
	4WfKlV/l+rVWsF5B905UtdSetFSRJi+qrA7Vg6kon0FTQsDA62K6m4W2bCH7Vidkk5QcKyAH9Ry
	TQ7HKdlRwbnGwQACM2aMoHQoqjfeSlKiFwsOwaVCh0ya6hdYhIarJqcKaNuZc8RuHTkbDDkBAO4
	Meg9u5eBQft3ldjNetnY7AH1//V4Urdh7EDByuiFPIuSHqo6/oEBIFs0fyTwDqYpSQDBTE/WaIZ
	Ok06cs0LBTwb+uzvNbY/TlHHAx7LQWYH0vvIi8wOq6uPytqzWxmPzZguWX1E1Xze2WWNQMUekA/
	HPz/eIk5IpIQA8+qT6n1fsfL26qf4QY5N6AugAEoUeDP2G9P59D0+0gifpLAZpWjxGRkHEfbQwD
	NRjBuhAthAh04DlSnBF14dxmTXx0l7MV4TK31waoGYjiL9biHEuqtte4rNPutO9ShxY44B0ypmB
	LxoDT1Idig=
X-Received: by 2002:a05:620a:390a:b0:8cb:7b27:9336 with SMTP id af79cd13be357-8cb8c9cf508mr1053185585a.5.1771854596762;
        Mon, 23 Feb 2026 05:49:56 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:56 -0800 (PST)
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
Subject: [PATCH v8 7/8] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
Date: Mon, 23 Feb 2026 08:49:39 -0500
Message-ID: <20260223134941.427-8-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223134941.427-1-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
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

