Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A811713
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832317; cv=none; b=RJrz5yMIJ6JgEKeD/zWWiab9T17v9XuLvNqX3o0x55WN2cBltPnkqMhS/waX/TeNipnjYTsGprSL8cwGh5RQHxEEQOzP6XWEJtTL7lIfE3aTa72HOYOvVRBZ3jmYTpmunyvN3O4zPsB9czdvWEPqoCzfQaTn1aQHkPgsMGNQG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832317; c=relaxed/simple;
	bh=KAvlbY0yYL9PaaTueRuO9yIwL2QGgENhM1iet7MXCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qA/j3TbzdJn+ZShJDYzCh3V4vDUKf6Uj9HAjOd/+tvT99GVrYR5kvlESdMQwZdjM7SI/F276urpX7pC7oMyV/W3nKf26ULqaRIgPug0bSBBlrYQYNfhZmXWD/SewLHrO+bO6V+GOFLfSEv0XfMkjYyeXD4IT2jgwWYbvxdL7hDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc+bz90+; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc+bz90+"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so2079480241.3
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771832315; x=1772437115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=Vc+bz90+YM2U0FrUeLkEUSkptw35x29Wr6nqNjKLy0Yf6++xgT3fiE/oL5FpaNn5Ff
         i/9E3jsKnB1KFkdF11pf62TAX5BLeCX1EVba0j6YQ4obZ4g1i2zazeGkaR0O1ynHPbWb
         p40ADdAqpu0RdfZFGJemt0lp4XzSUWEMf7n3VgXL7oW2BJmVY5T84Ppd68+he4mW0g50
         Slab+r8LsOQ6IfTIJGG6h96iX0eADw09W8LBSDWGPOvXWlS1kFFjCq3OBEY/zbRLxWxZ
         nJBmjFXuF0vf+e6j6Q7HHEWjfAlG6KFLIZinkYymMF2fSXfuM1Xsokhd4/AVJrI9phQm
         ctOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832315; x=1772437115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=rxv7bH00u2cl6mfKg3l2WzfJ+OLmjzP/cknTS28SetPJWXjtZ2JTXG4BuAmHdINC/e
         Di3HOyldf8lsVVck2BTLZseSU530e0o0/P9baFsiXc8wTXeebXfJqbAZ1Ltl16HCQPhp
         vOaTZDDN99fwH+LwY5Zoax0eyEAeO1pjALlpJKCCPi53vKYiT8hpF3lLooTfh5Vzs5Wj
         Vb5M3cs171CXGg3+qGbucAH98Wi0XwjWsaLORM5zS++vymm5b2d7qB1BDnrGqEhgT8JT
         wO24sbWG/1lV8s159e2ZKzS3AH8vWvbeX2fPEIDexG6uVszOilGKsAtadB6Ni+9VCU6B
         7VXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhGhdPA7DEzCfuafu9Jetr7M6GzmlYCJnyOEhHOzhYQRTtZZZ8bcD2QdY5/piZJrjojqzOlSYUDfe8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nt/3Kraf1hEmNkN5a9OXnTqn7SrgH1DWWwjfqBBKKfCh4Qnb
	4mwYLNqiG/VuLYPlNCBpBoMzCUEx2MCoyC61PyfJxJmiKtF3z0Fz8SVA
X-Gm-Gg: AZuq6aK+DeieTYCDLru4xky4NefYFx9JMml1dOSxeN59yyV0/h0IyTG3rlN5i9PK0qr
	K2hSxea3HLY5TG7mT9ddbudyg1XYzw2zzaHej2K4RhAGJ9Y/sHpya9lKBKIhxqO7UN8GbS8NmBO
	RVeT0pEKYfkO51OUslexkw2H6KIAxDATZRq2juq/AzKqdhrOb53qllch9hZLYn+93ep3eGzHACG
	kteLJ2WvsJze0EUfcQKSgIMaNXFyL9I7w5SrlDITk8Wk47MUNpUMQ2x5AkSnb6iFvt9VKHYqAU7
	NcJd1aojPP6m1HMD/kp7rQJaYuyv52dWQmlaB0WVpTw5NmBU66EZzeCAzpcJwoxSsUtu0jPUzUd
	fBovtZwGet4L6lxr0Xn7Hsq/tp5GZvZOMQztPO3dv9NrwuiwdGgmUYvl+EyzpjmzAmkmToL5tYN
	JHQZQHEsq6uEabSLd6g/B4ymCJqtBwEAq2+c7ojYtFSt4LzygTeMoJekK0j8lF1RKH6WuMKofc/
	nxMXZw+wdY=
X-Received: by 2002:a05:6214:301a:b0:786:8f81:42f with SMTP id 6a1803df08f44-89979d3f785mr103660256d6.39.1771825879381;
        Sun, 22 Feb 2026 21:51:19 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:19 -0800 (PST)
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
Subject: [PATCH v7 1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Date: Mon, 23 Feb 2026 00:51:06 -0500
Message-ID: <20260223055113.1288-2-bavishimithil@gmail.com>
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

