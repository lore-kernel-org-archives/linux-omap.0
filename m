Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29305361DA1
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569829; cv=none; b=lQTm/7hgjQyS8H5Rlyzqi09H9GL001Da9Q1jFEnuohvS9BxvCKncVnnNFgLKwQqPOQ2L+errZMFrFMrh7OG3dyCEPMIFzIXXpgKjmAiaQsjCH7CzZ1tbgOg4OiT7xIf8m0T9yib1uwaCSyTD+0awA61fxrx2eCqtsTv3Awckd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569829; c=relaxed/simple;
	bh=KAvlbY0yYL9PaaTueRuO9yIwL2QGgENhM1iet7MXCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uovP09JtXDqeL6ALZFUDA1JKrHagfWTZMdk5r0k3L8KU2jJG9yxrgOFb6KrwiuhdMAWnO48kPj7EbK/oBMugfRxlC6Jh8Yjc3cAw6/43qNNcrcmdNrYyanOfSOMJKrxdW4Hd/msapZ+sC86zPO87cxSFjMcJEnrHaIyYMLPwjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsMugjWX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsMugjWX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3e22435fso577125885a.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569827; x=1773174627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=nsMugjWXJJeXW8KaA7wQtHGvd1qQaYhLcv3g1UgU0vlV9v02eXpCP4Dx55U0GJFKWY
         bWwGjunI0qhBv7qV8qV/shiYuz3Vkzj0SiYv/Of3cw7hibCboKnggvxEMYqT2e3V42c9
         Pzbt84m+o49EjjksEM02mLedRjhyA/0M48GHV9Tbp7cINEj/jprE4jKtNdeJ7xpq5T7P
         mBaFvjlQBQc0GywqE5tMFHHeQx6/+LqwfLP63qdFbtQq4sBTmNywMOpiwNzE/Tfvr7C0
         FU8er4TPkFnCdLLzEzKNQ3ON4votFwflb4o4ifJ3pCrq4UUtkdgNwvCjo+E7IY47yHTg
         uQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569827; x=1773174627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=SGVL3fmi8H5cqCUj1Yx9Ss0D+rN7o88VJcNKKtOSiuBG8TZF0YTuoBFSmttQ6JCFHy
         4zgtNFOH8T2JfnKZK1acReInQlPy9fOn940QH2ZFeIGGbfJsf+l4EcGr/SGPlhGWc/nd
         nZpPf7nI4I2mNVdFRg5vjNSIPwndOkED9wyvVxLBadYEJ+aJlISczLHgOq8OwTQ82D43
         0N26YO7h0wxR1oZBrpS/gBZ5JpoWp7lqWPCHIk98pMYXuyGBlmw9T3KYTXr1uHD+M9EZ
         Hba5O2iQF/ElTFmwnTYgyMn62wyz2u+xVui7ldRERRXW9jgMLAUJ0lEE/yZTksAIZ54Y
         a/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv6OVgvzImlBlvwx0sCUel8M72O6E02Np7dPmvNtslemHMkSf2RhcDt2pEVTM7rUm7wF+ou4ZiGn6l@vger.kernel.org
X-Gm-Message-State: AOJu0YyozOYZBlzX+BKWAbqrh8sYgnRCR+fQI5PsgreR2zMGnyF0hx0+
	pd1xelfcCme52Sx1M3a38XD1G9220/ZbXpMLgRkWZdCyuEBRYVTSm0EV
X-Gm-Gg: ATEYQzyOmQAxmUyjnJ4WbTKe+L1NmE+Imes//FkNSkvfdQd6enP7BWn/GH/k0ufZTU5
	w6WUvXpOb5W6dxDeqHex1tgxIP89yxuFyfREo4EElslJLlUqhutujtIG2nhQGvgMZgo1GMXqAmg
	/6WaJ0dhdOsTnhIV1VtLoLIkq3D/KsgTNJDdab4SHbOvfKKrNqM0DG1y0uWhX+QSii/+ajIIulK
	3IAonuunr5YmZ9S8yc+/P9NYdLIxmctM2mxZmwcFE1l1fubkwinvierHAEoM63nQt0Eiwaghv01
	X1eZlUVo8gGIMgUTpX8CFrOmNViBOGNp0Ci4VV0XmwjDd3fhVDk21FBNPcNJj2RZg/M5xXEWXKT
	GHDiJQUt0n33WL/EvHphu9e/5fkKsNoqRdoFwku5Ru8AmMZ04JXu0s72ht2ZL5KSxelUQWuLn1h
	4Y4nvuWMRR738VP3tKb1h81zJm3Wr7J+MEC4Dmp0HayqozbrtsikRqebYCbko+zptnwdzBP1aCn
	Cpu4G8DeIJNt/dpe+h4rA==
X-Received: by 2002:a05:620a:1a9b:b0:8c9:eee0:dbb7 with SMTP id af79cd13be357-8cd509c3187mr382434085a.23.1772569826932;
        Tue, 03 Mar 2026 12:30:26 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:26 -0800 (PST)
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
Subject: [PATCH v9 1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Date: Tue,  3 Mar 2026 15:30:10 -0500
Message-ID: <20260303203017.511-2-bavishimithil@gmail.com>
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

