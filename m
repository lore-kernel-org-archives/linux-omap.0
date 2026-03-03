Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6E35F160
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569841; cv=none; b=akjBt55usCEVSQ2qCm68TnOumj2X6Skq0/nHDA9H2BYNJqrCgxP8Q+OyEUV0mloQ0dCj2cf8Vsok/NiPHJ6jNB+62CGscuxMEVvrB9bWd1dD514XhNctBbeHIKE/0hzpn99bOhVELKQMuOuTkn6yZb8+qIX36QhX1X7a47rFVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569841; c=relaxed/simple;
	bh=pocmGKWkkKsOAaHqrDffBq8KuvMtZRSl1Ehwcy1nFxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK1wCBnNyHS0/sNaDaeQYshq84tWxjRJAiO6GF4pc9WobuE3MMeYZghGrtZPRqSupd1KBOdeHRgD6uo8opWNaRLqzjFPcNWjSrrepmHpJIHcKR9NRBW1d0DL+KdEQNWuvbs8WsJ2Wsm1rOZdWxC/3l/nws2oGMUZCZ6OOSNm4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXGvJ1nP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXGvJ1nP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3825b0fbso584823985a.0
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569839; x=1773174639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0aFuZEcswfY1n9DtzJQKfDnbrUdcO+CQnvBKx4RAuE=;
        b=DXGvJ1nPoLr3IqN8iGdneUDsHTaQJiTAXvJXt52TqqvLinbWcRubFwPT6VXF0eAhol
         yy2B9BVKMe9kpAM7cxjE+RWjo6NnlZTY83HOd0YeinwiUyS2KqthaV98KoFONaJGAx12
         vavw301kzxtqRt7VkDQPlbHcIycGa9m2Wc8/5iA/Hz8eQ2rA9Ixcc1VkarNWimOk/N0h
         lkS/7es4J4yCc5nsoeDbmy7dV/owbTq8cHlzpb5MBpBIazmdlhB69osYxllyjhCk5vwc
         446ERimpMcXh/gHcGxDWZTAMKFaDHIfOsRVJ1yHZ6RS3nv62Q2Xutujx9PrPRFOw+zNT
         22Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569839; x=1773174639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0aFuZEcswfY1n9DtzJQKfDnbrUdcO+CQnvBKx4RAuE=;
        b=JO709KzM+Y+/bdwgxZV3eabZGIwb6ZK3kLsQ5dUtUyP+FBzPvb1yvTKPqBhUT7S92h
         gKyQlJQFutqd4+JUKAP6YAqI8eSIoddMi66D3buD8oYbffUhlSBqcnYxWAOpdeC16rK7
         l+pzgnEpFnugEspbbmxdwr9Ex3hVGUfLB/hPKYPZ25hf1wUEmz8u3MiXeEhpqCOafVGF
         p848Aoe2eu1IFUtOnymjZFYRwdJ6MTQc5H0V+XFhg+Vjs6F9ntGqwSergW7QXlhSGCd7
         aytfNW9L3H18T0iiK2kfwH57nhtGtZjTEzJhYa2JF5c1/Xb8Kh2Q7SIyYx6yVSv/k0LO
         MydA==
X-Forwarded-Encrypted: i=1; AJvYcCX9GoM4MiofK9geHzjx9Oma4SWfN4T4tpG7mCJTglN6oAF994tH9hO8RIZlg++P/p0uhNuAGirYqYg3@vger.kernel.org
X-Gm-Message-State: AOJu0YznjrM7Tp76I0OXs3Fq2+HyR+JY9PFgrMx+pdFkwMZgBssHcygz
	WfgZ4FLwwXo5UPLCAAOg2TYWRKoJNO5SGIjltlR6Ol3tPO6kxy0urbkU3f4hP95Z
X-Gm-Gg: ATEYQzwz2g+Umk5lUqiBGRAMhxHnYSykrXzYMwW4pcGXHRwOFfrOj+I4TXdiXgUHLeF
	1ltdOabFiVWcTkbR9DFEDlerhdrjDt21+8cMs9IhKzXHIYmAar7mJUl6ddUM4NrL3xO3Uuki3WR
	O/HtsmYReeFBmJCJM/wNf5eELD213C4sddGsfGk/5jW/RegkxXfPfMNa/7JKEt4K0KAQa0WnuaQ
	5us0sj5AecxUbQLE5qLUotLGI0cMx72H8cKkqVsYBEHY5EZqs3PohhX1GoY6nRKFHwDmSluKTD8
	HmwMW/Ueo1m+ck0RPXyHo4gqAlaMq3O9Sh/Ul5M5ERLujr9BPfNNmQ5arDUmUiGuql5JpPHdjFU
	B+AElifOFq60XMt74l/yS4HDg7430FIesIEHvpA+w2Vy+2Z4Ji/U9qSI2nxJXZqCR9FXIJUhMQV
	kPl/OjhAAnX5IJQDhCH1VRGKdMACn2g+5L4jUxmosXrkuKBGUoQnF5AQYerhFVRQBzof7HninQr
	om6Ad0nhXk=
X-Received: by 2002:a05:620a:1aa2:b0:8c5:2ce6:db1 with SMTP id af79cd13be357-8cbc8d67d4dmr2185912885a.3.1772569838816;
        Tue, 03 Mar 2026 12:30:38 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:38 -0800 (PST)
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
Subject: [PATCH v9 7/8] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
Date: Tue,  3 Mar 2026 15:30:16 -0500
Message-ID: <20260303203017.511-8-bavishimithil@gmail.com>
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

Create a device tree for the 7 inch variants (P3100, P3110, P3113)

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |  1 +
 .../dts/ti/omap/omap4-samsung-espresso7.dts   | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 3f54b515c..1fd426204 100644
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

