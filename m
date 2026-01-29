Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C137AA92
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671641; cv=none; b=kX6Mr32yn6+uwdUdMSbgu7reQ09t4/1TdNFa+6ML1QD0UWWEbb5c6bQFeUbgAYDSh9nAt2XqOn8SZ7IiWmALKXo8n23qKfHmC9oaqqUjjpsOWwATSvEluT3ALyeBQ4t/PKi1cauhEqOFxDoMr7T2LigKQYhTsC86S1O6GNtci0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671641; c=relaxed/simple;
	bh=KAvlbY0yYL9PaaTueRuO9yIwL2QGgENhM1iet7MXCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/zdjG1A6vlznJPwxny9O4ZYgrbJ3UTIVgo3Qxz0a3Ox26vrVoUCW4jepOC8PPG9GarAPcSnMTlrSrkoNuyYUQHkn6YpqxKHLGnDcdhDy7z38vBu0Qi0mNZIedZHyIPziAwXQ+e3cTED+DzktPUMzMtHUkHqhzsswjHFaIaA+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv+RbB/A; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv+RbB/A"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8231061d234so593171b3a.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769671639; x=1770276439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=iv+RbB/AVo4r9hsgwmf6XZNmRTyq4mBXnSzV77mkbWwLQGCbm9aTgDm5UshX5Wo+bu
         45T6xqxv69XS5wCzEOUdtHUpWSBhJh2PD6JwYKngnK0BhgJgeMDBH3kUyGr/yKTXNC0X
         CGrOako6aHkaAHervzkIVAGuE3g8MaVpI/iQccbVGpIFaq6O5nwTvXw07WltGeu1kynw
         yGQrVUz3ogFWSR4lhax7ftMsvjkuCpDz55aM7ouOGM59e+pC419CChNCRIpr/6mjAX3j
         Ynv0HMlfTWSlTiNK0R3gRBkpicguIS2hDSabGyfzgdiNv+vFiHDRWkk1CIdZoqm4CTHy
         iXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769671639; x=1770276439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=hT10pNDFzeAOEvyugjpUjw8mB6QygO+OOYk1ayt6519SZy3xBwnfZh5cVeQrbnAVlH
         W7XlHjcMoFfIOlZ/kB86UuluwfdzSc4+qWH45iuO1kdjSXrKPaRlAn7r67H4PoZl0cPh
         XUG9Ne3hK12hgMs32GJ5a2IDc95bqVJjxbJlMLeUoJgeMY64gSwbx1w4J4ahUci0GBfq
         CBP78F9NRcueiJOn1lpA7qQswJVn8/QYXYdfFCspQ7jGOg18lnizkuJqtiZ7nw9ebyos
         oFjdqjNYsjJxXWuQtKjaUnSSnZAfmLoYsE2cxNc8LwECMxXam/fKmkQKWd3WgEKMjJk/
         5N9w==
X-Forwarded-Encrypted: i=1; AJvYcCUjY/O+gFbH7rBT+VgWNQweroc185XONWXUDj0EsHV25gpxwSt5/IR8IMiC+NBfZUtdzIKl57YOVa/e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5erW0Sj8sKpocjVeQsxEdCDwZ/3uHBV1n86X/tKAlaHxYwISa
	oiw06YwnBiP4yvV336rOPmBYll4YjoHV/kFEuroJHrB4bn4qwhwLXcfiQI88q3/2
X-Gm-Gg: AZuq6aIU3r0zveXiLEMVPY9Pg6JxW9eEIwXnpvzc7CAwG9wKjbkK3+EEIPJcQHVTuIM
	Fi4I43cL58qqr4hoefG1MVpl27QKnN2rAZJxRnEpqPT0BAXG//0v9WuVrfkn7OsjqCiOkOYJtZe
	VvC0dbUp0v7MqUWqf42PhrMNkMVAHAK1LUeImm/1IZBM0YZ20ZaCzt3ZvyxY0savh3uWUJPw7sG
	yWVod58257mNHQnmL4ZWkRr5Enur/Dwo0+ijDSvGZyNpnqQEWVMrANt4B6tHx9x0S7xGkzJGyRU
	Xwupg7Yj9pXI68jVdEVC8ZjzdzBXSTSYajgtLop1SEstJhUQvdmpjp7LK/V031kZijhbMdQJTVb
	jGnSRvMU2NnyIgtMTBD58i0xexPGHnLGZGyRY3YQ1mmhfIawnC9DF1sGXX6vQvIjn5/+pOtxLhh
	q3G2X6Px0Kebd6EupJc+qL0rPpKk4SjPVhrcOhJxbxu+KitQ1AXeVnpkswE64zCjL62JbMT0o=
X-Received: by 2002:a05:6214:202d:b0:7f5:eda2:a54b with SMTP id 6a1803df08f44-894cc95cd40mr119052776d6.62.1769665662516;
        Wed, 28 Jan 2026 21:47:42 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:42 -0800 (PST)
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
Subject: [PATCH v5 1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Date: Thu, 29 Jan 2026 00:47:02 -0500
Message-ID: <20260129054709.3878-2-bavishimithil@gmail.com>
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

Add a dedicated DTS file for the TWL6032 PMIC (Phoenix Lite). Already
has driver support with TWL6030 (Phoenix) since both of them are so
similar, some nodes can be reused from TWL6030 as well

This can be included in the board files like twl6030
Example:
...
&i2c1 {
    twl: twl@48 {
        reg = <0x48>;
        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-controller;
        interrupt-parent = <&gic>;
    };
};

/include/ "twl6032.dtsi"
...

Used in devices like samsung-espresso, amazon-jem, epson-embt2ws etc

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/twl6032.dtsi | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

diff --git a/arch/arm/boot/dts/ti/omap/twl6032.dtsi b/arch/arm/boot/dts/ti/omap/twl6032.dtsi
new file mode 100644
index 000000000..d599a2ca6
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/twl6032.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Integrated Power Management Chip
+ * https://www.ti.com/lit/ds/symlink/twl6032.pdf
+ */
+
+&twl {
+	compatible = "ti,twl6032";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	rtc {
+		compatible = "ti,twl4030-rtc";
+		interrupts = <11>;
+	};
+
+	vio: regulator-vio {
+		compatible = "ti,twl6032-vio";
+	};
+
+	ldo1: regulator-ldo1 {
+		compatible = "ti,twl6032-ldo1";
+	};
+
+	ldo2: regulator-ldo2 {
+		compatible = "ti,twl6032-ldo2";
+	};
+
+	ldo3: regulator-ldo3 {
+		compatible = "ti,twl6032-ldo3";
+	};
+
+	ldo4: regulator-ldo4 {
+		compatible = "ti,twl6032-ldo4";
+	};
+
+	ldo5: regulator-ldo5 {
+		compatible = "ti,twl6032-ldo5";
+	};
+
+	ldo6: regulator-ldo6 {
+		compatible = "ti,twl6032-ldo6";
+	};
+
+	ldoln: regulator-ldoln {
+		compatible = "ti,twl6032-ldoln";
+	};
+
+	ldousb: regulator-ldousb {
+		compatible = "ti,twl6032-ldousb";
+	};
+
+	smps4: regulator-smps4 {
+		compatible = "ti,twl6032-smps4";
+	};
+
+	gpadc: gpadc {
+		compatible = "ti,twl6032-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
+
+	twl_usb_comparator: usb-comparator {
+		compatible = "ti,twl6030-usb";
+		interrupts = <4>, <10>;
+	};
+
+	twl_pwm: pwm {
+		compatible = "ti,twl6030-pwm";
+		#pwm-cells = <2>;
+	};
+
+	twl_pwmled: pwmled {
+		compatible = "ti,twl6030-pwmled";
+		#pwm-cells = <2>;
+	};
+};
-- 
2.43.0

