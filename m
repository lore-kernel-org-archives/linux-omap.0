Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8E34A3B1
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771825896; cv=none; b=oOv+VaOQBiDvBMP71ht8aNjelxFE017f/NWxX3T9PJeDAISiDMxcuaZ6gErETQw34qI9pCGB1AaXtJiskkJdQHnjYQ0MgDc3ayUQyfV51hiW1deiSqW9Eh5evfdT5auyxwdYEoNT79ss7791wYpcFYfW0Ju6E+CehwDB/N0GpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771825896; c=relaxed/simple;
	bh=AUhhKwGaM9grtdftiWmb9K3MniiTndfrY7S51xLJzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1Hb8830MmSGhLo9vt1ixncIzhb9nqto3WhgywOg5FrBXGKDSt9MyNHSNJ57ZY3+k+eL1Ezxl9tDacCto+hojBPbn5NWRQaffmnPWMv32pfd8m/O/4daw+ncMy9JQKU3cqSs3FtmtgkvH60G8YNdXQ5QrG+ERTrjrRuxvIfIspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ2k+0d6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ2k+0d6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3b3e643dso251692985a.2
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 21:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771825894; x=1772430694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=UZ2k+0d65DgPVBLV+eO4KubIVm4A5DqYYyiAbTq0PfdaADo3Dv+pB56ILjKJiIdRuP
         MWx+0CSzAzS633uh2oO9cJN5e9n6SfIwA4+GTDKdPO6PsrYgap7kvl+FTfxPPTRblmoN
         cF/I1U4dKkzxBI8E9prmjW0wEXFmdnxWFgLWgP/j52i8KUgU11o2fSu4H8FvVo8eKKvv
         wvPrUSrS4Lc42Yl9/Do5I3r4G6VkI0wQN9fZzqSDuv0Kgf2gSCSvp1L7oOls4aj34Qea
         uGx+pHqXiZi56sfDUItKko6IQ6XMPv6J+42f8g79e8/6ZiXl6exTfPMU5N6yqwQjpc0u
         hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771825894; x=1772430694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=a5h7F9qCpLorf3CUje+GBHzhnWBeJhOdu38f6+f6wbKfv/zxGR1SfayVVTl+rHoYwF
         0SvrYWj61Jsc3v4rVgllLSZ5+Fjlp2YrxJ8LS5KNiY+ST9x2ZT+0nzxT5apRD7b+1kvk
         i0SRXeZ2eyOeKjQoUBtMBUpZ/0jS1hoisacfJNlIxjq7aRvS2U44e32ut1dMfQ8lebpx
         l8d/BgQLDAtUhnsSgkIumdmdr/13oLQPrLxLRyfVAUp9QjEzqEh+NujcF8C3/jnq9/IK
         nNDqJLkbS4tCXoVtGJZvV8QlmhtL46UOGS9UU1MwcQH/Jk2uUogfabH3/pt6u1djtNlX
         hhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIPZVrmOyFSyBH87JQBweBl5Bw9rvB/KyPKLhMH015Tr8VAu+o8UAjdfYb5ARkhldz1Tt/lpTslQt5@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJ/g84O+Hh/U0xz6jeEUeq3dbjRFnl0dgYrX5LpTgTId08Cej
	/iF/8RKnH/cEuHu8cSylO5aFNiX931QiJhBnimEdyMqoSm7M2uroQ7ml
X-Gm-Gg: AZuq6aIS384y2V3F+4IFO9ve8mP8ZWpU41XlSnV6c++6InxNZmBiQ4naPKRrEepKlh/
	XqEP5hk9PCzEO8cYVbuSvoqxf3QEFeAYSV1ntd8+95+6I2tQD04XMT1fiNN/olhJ5YebzQU4Pxo
	3TASfuzYfPm+rn4ENiuIcsKV82hdiEuLw/WRuMIwoWjElJ0BRy+L2N3pI5nqtDWt4pJC0O3wqT6
	dEPOuq6JayClv4OIdymBasmoPBjGDnbgqFIor2AGAlVA1rai9P/DfIZsdmLuNGamSL2yBvdAX+s
	cfbliOUBoD0GAbLZkh0R+9XnVvxS4QCk9APvEW0KuApAn+ReG9ywtmvDXTqhZTtenWjMVkdo/2v
	NTMz+UIkY+4ThSBeeDRfzwk4ZZgNOAVxGhHPX51DymPKETNkX4+iXavkrpfC7fbC52uAhJpaUNk
	RoCK4e/X8mHMU0DskqfQnpZ6zsukDuMZSa7FyuBvEXZwSwcCJllKINH1lf+SWQVeOWazpVQxBhr
	DdZvQ3z0bg=
X-Received: by 2002:a05:620a:25ca:b0:8c9:f996:81fe with SMTP id af79cd13be357-8cb8c9cfea1mr846672785a.2.1771825893677;
        Sun, 22 Feb 2026 21:51:33 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:33 -0800 (PST)
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
Subject: [PATCH v7 8/8] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
Date: Mon, 23 Feb 2026 00:51:13 -0500
Message-ID: <20260223055113.1288-9-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223055113.1288-1-bavishimithil@gmail.com>
References: <20260223055113.1288-1-bavishimithil@gmail.com>
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

