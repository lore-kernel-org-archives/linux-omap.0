Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4D3491C4
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771825894; cv=none; b=qs8yGp60HQugvtRHCuu0sXZQkDF5G9vm25NBB9J9i1FsCXkI8R2nD+Fxypvri1pTqnJ99YbyODS6edvpYmc/av8aOmplQ60rHLD/26tq79wNADAREnGKAW9AI0zfMz4JKPXtjoEra2p8vvVKfWRJDoqpDcu35vRBxAraSVYYJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771825894; c=relaxed/simple;
	bh=S2kYng34pyN/wX/EOplOpxbzEXHZ5N9BsJv+d0hNUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+xWkV6cJeEjUaoOiIEaVZN0bvJgvA5RiSFNWb4uk+xWQ9BIQ+2QZdUP32SHBRZGLZwDY/+LLhRp9pIBq0R2DXYSD+GDMIe7D0oOjAXskMFwjC/mqjRM+hMTfeEqB7X5xaWx4r8DUqEmYfkHL7MIcrT20XWcagHlqOY1lyAeyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyq7uKzD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyq7uKzD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506bad34f51so33276211cf.2
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 21:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771825892; x=1772430692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=Qyq7uKzDI+eKsKln6hCk7WBU9/8WENvl7bq6SC6KrwE9xP4rFnMQixDvOOp+se9jMU
         8HDVeA0eTdOFsAL2EDSfB8bBjsgNI/FlogeArC9EmGXx1UwamLnazaJw9s16PkvhsfCB
         wcof0/dJdXmZ2CdbG2xmfrUW6+2ODdgMwvY57z1rEamqdOSuQdAL5pIbHCgBzLDWbeBW
         6oZdMegZ6/BqGL7nCSbf5sC1Too6Ji83aH9QNwoUt18lIl+dAwYrQJ/b1Lx8OizkOeVl
         9w2qKCsAO8SiOp2NwP7txeZU2vz9Q2yAalTWS703SxNqRPsQGQN21D7d6tcCE527XbHT
         jsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771825892; x=1772430692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfxr03p7S9Rer87uRm31FU2g8xU+t3fSe3azXAHj5IA=;
        b=eexS7lmtvIkHWXshcr97GMygfVqqXM0cay7gqAByBP2ZapKdogRKZWtpOYW4WSFQdG
         yrEsrN8FpypChXjoKL97+Y347dmd2F3oFrW86oIeSscCUATrrpQkK8uu6OVYdiE74LKZ
         PqTD0l81XjIe2GMoKDk/RrSZdwB7siAsK284sdlfVB4P3WDNS8Q/r39eOf7obWr70IaG
         lLLsoF6MBDV4Leg5QxYdo/V+pVooqK6XA4Z69+9z/fVFfrDN9t+ypG1e9YIDWDa+Vk5g
         ajk7wGvk+HXL+nnWirbpEDNn0HzQy6u+TK92Z296W4F6VzrPUjwWy2BfzMvUJZmLyh4J
         adkw==
X-Forwarded-Encrypted: i=1; AJvYcCVIyCxA/1QpWhb4dm67LjOBdVQ+CG9CmUJTU3kuDCkPxVFrYMRafb0fiX64hNTNX+1u80L1uMb4Zdjd@vger.kernel.org
X-Gm-Message-State: AOJu0YymXtR1nB9qCPL2XzaYEbih6W1HMpWo+F+PGZQx0IO2+PoWzEdn
	t3JoLCCAGrlUk2E2AN+f8jxkM7xGmkvJXbIJC1OHBNSKlYcFubvLzdx/
X-Gm-Gg: AZuq6aLfBGKclbewe26QLtf+pdyjhtNwBYXlQfHDs8psJChwXGV5EJegnY7y/XR4YIp
	jpYJZqeY6IFsL0txVOBDjH0re3Tqq6/1cydrmeP8GlRVhU/XnLyQku6+YQv4qm1aqXpqKjE9gk1
	R2f9+wvKYcmQ6bfQo1vGLmX1uT6riodI/vaXYj5lI0gnN2ggZyyCw6y1CrXdGAlmgFPFJNQl7L3
	lG6jDiNOPfonjLiTsXqep+wZTwTVS7BS9xH4S2Sy5TC7b7DsQPCapr2K1BSrVBqjan6E9oz2zwi
	DgIV+N9/yzN9UXrTgUBcc0pwGTTqyXqO+/0iQ9DOdFyb7GoUFk4r2dIogtU3Z0wLjP5FUi7P3Zr
	c6AYy2mbwUZ2cUvdhoyMUad/Ggo57XsA8S3ShubjbIbhb1fUENJh/NJSz8Nf5BubzP5jzOzXM3M
	fp3TsaNi7tSkpgspwg4PWxnldGjWjrlLcZIH6OX2v1W5Dkdyd270LDup9s2V+U1f+08bd56FYlW
	iDO4zY1PCM=
X-Received: by 2002:a05:622a:181b:b0:501:4534:8c8a with SMTP id d75a77b69052e-5070bbcd811mr98992181cf.17.1771825891958;
        Sun, 22 Feb 2026 21:51:31 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:31 -0800 (PST)
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
Subject: [PATCH v7 7/8] ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy Tab 2 7.0
Date: Mon, 23 Feb 2026 00:51:12 -0500
Message-ID: <20260223055113.1288-8-bavishimithil@gmail.com>
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

