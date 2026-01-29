Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C46306D26
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665680; cv=none; b=qQgsaKPZZYyWmcdtw0DHwXD0q2i8mZBb7wk5UFXydxt9qyyaT9XAeiD8G8qwazGMBJlMFhDZqlDjy/5KiWroDLtLZj6c0QmV163I9X8AOL1XsmqBGT/AUD+Sy4caHdbdcrRyZGSI0mWqb+6WP887QtokIMdXjjGj3gRX8NC17Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665680; c=relaxed/simple;
	bh=S2kYng34pyN/wX/EOplOpxbzEXHZ5N9BsJv+d0hNUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtpJlMGOL5yU8S0U8VF2m80jGhB+MUHL26kELd4bfzJWaeMJZvpci+vQKsizGLjRk/oiI2B4GLeH+yDcbaevz+bFDJazLuUPC6jJVTySGwHdCpH36e/PypnqFgaHesblWcLkPosCPHpF7GLCcvsQJdWwYFGE5QFJE+68WMbGixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxTk63RJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxTk63RJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c531473fdcso78791885a.3
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 21:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665678; x=1770270478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=CxTk63RJwNexj1dlTJJXZUv7rOLhJW3woKuFvpHRNnWFOIw6iy+CDK1vV7S0or4C1L
         KXZV3EtNqWc5B43XJXB3uiVfLbR8/c7lHjphJN8rTSW1FNA4raV5tmRpHtKqeY1G5ibe
         4uNZ8CIoHZhm9OWbFGV5Pj8AXXhxvSxZvdpyf/OApCgfbypRJWnk0E4ndCbA2fTQWa54
         VtlcDNbY/oBANKtEFstyDjd4716JOSw/4dLqdwiFzzeysfEpT8GjhLQc/1v+YFuf/ntl
         PYtqB9d9E74uYwG8RlrQVTWC+4TDJ2cmnv42/0uCWW8wZHWucBrp3jPcXvXjQzmK4i6S
         r5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665678; x=1770270478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=BGpTAg9HmZh8IdnGcxHA3wRhgJwO3TLiKiAH2nM5gpplhwbGVE02iNB562C+bz5J4r
         dbQjkqn/QzuYXU1S5rFlMbUd1szysNw7uZuyxQWGC5KSLww1BhhzFb5tltrLO6h4rMWR
         8Faal3vdMMaAM1qO1c3io/zpBV6MnTZuZtVHxKLzjwQ2RM/5SwQ4YnVz5CzFfQoD+1/4
         f59NGxn/tA0t7UZBC7yuRMkqYZHwegC5jzEfM+g4Z5lI7UjrBtkbiNznYR06HmFZq8n4
         m+ZBjpmAAVTdLm/+W66q5YcQLhXeu4gCLn0TcILIbdB55iXYTNoP4cIpb9tajIv2SQhC
         SuIA==
X-Forwarded-Encrypted: i=1; AJvYcCUPIQ90c9e4DuZd/4CE9pvhXPHmYUNlO1w0tepf+uzjqDSeaO28gKpqddFvM/dgmpdRMURUIiPJ3+aX@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrdhryRlD5M93AASxaa4gVZWvscGLZWKL7PXu2QoPYtXGSc2o
	by9eIPfzkWG/6uaalfldQ/JDniRrWMbVzajMXYqy+txUFeXZ+cugkDHS
X-Gm-Gg: AZuq6aLaQU/wCZzTEuP6SDt69gfKe8EPajkOlauSd6uK8dpRJIt03dnFbJrVC0+Sszb
	zQshaZQ8YSunobAHKYiFeyoHwXxRCDCJgtRKXow/Y64Zq5eveTQ6V127y8v6E//N35c6k5em3iP
	fHrmTP1do6dquCgQFS04Y6c08IRECt1vJTZXNHqmDDPxzA43ZI8SbRPz5rXZfr1sYuUXf9zDY+f
	giuc5uUIw8saHxAFlUAyZLujBXHIDAEQ+Zv9d3vGqiSCDFQAgYBm30tAKI92WWuBvQExXi3ixFW
	ci5jUY7pimRXtz7Vf5QZEq1xzW5FrQqxd7BkQlBMncHB5rrwfSC8eFCgm8hvaIigKrJF3IykBct
	suuv2oG55zPKrxD505ivpcpzIAD87AIO6AnVZAiJVn0cxyWMa+sfS4XF6fX8CjdIgZJXdHYl5q0
	ZfFxmMd86KAJQvonHvsH7yP4A9suvrT/lWx6zXexbdyP7343Sdk1lIYU5rUtTVXHTKcuWy8ho=
X-Received: by 2002:a05:620a:5d9a:b0:8c7:155a:6d03 with SMTP id af79cd13be357-8c7155a71b6mr401340185a.58.1769665677768;
        Wed, 28 Jan 2026 21:47:57 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:57 -0800 (PST)
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
Subject: [PATCH v5 7/8] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
Date: Thu, 29 Jan 2026 00:47:08 -0500
Message-ID: <20260129054709.3878-8-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129054709.3878-1-bavishimithil@gmail.com>
References: <20260129054709.3878-1-bavishimithil@gmail.com>
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

