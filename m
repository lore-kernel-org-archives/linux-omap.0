Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CC32C94D
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540722; cv=none; b=mfw+IJ29E4R5UjYVJDdiFXV9PcFcrSu3cilJoy39dhSuCHwN5f2bkHJC53tztAF8ZTlUYkt6QW5JqweUxyrtltGnGNQwqByKIIVkAaNG86abLJC5fNR+OAuQstIoZPtZg4cMQB8MjzOjO7QvEmJ9yZCalmEVjzAYgLDBlyov0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540722; c=relaxed/simple;
	bh=KAvlbY0yYL9PaaTueRuO9yIwL2QGgENhM1iet7MXCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFcRsIRDgX8AzofwBs0Z8fZ3DROF7+KkDu3+sgB8V2TRaf/d2SPUyaE7z6i82wYipaX+EVz1Lhv2O5v5CN0sXDTN6pvuZVAyMXQtujzwkhLfgbOWXoc4txXOB+TuoR9n8NuCA1jac+6oXOzT40VrMfXfHxy+kFlKZyEDRsKieAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adTqdO4W; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adTqdO4W"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-503347e8715so16534681cf.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 14:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771540720; x=1772145520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=adTqdO4WrN0U7cbaJLQBMiEJ89Lgi1kxu/V3TQnaeXwpB/JKhl22JRO+qJdmLP6RMr
         4wkEWh3B67VascBNGzvXHv0ZJWyb+LTVdFqABrgILxotOdpCWjyku+SlLUbePCJlQfbL
         FDwql38090yK3Odmaf3tyZlhmfs/FPWRDL3p5N7V8Cbn9D9miNwVGMPdScnqaqbQmdUY
         FFn/9tFI0AIDo2MiA3pId4oclYGgMW31plROG99BhUPBVxabY+iYuJ7BptJAG/9RFEUz
         ceZZq/a/WDXm4sZ76x2pXJnDwP745ROcWiQw0o45Kj3gB/WL57StAQHcLDY5xym43MiT
         KX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771540720; x=1772145520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=QthtWZ2ns1stkJrOWtHNSWHEFNEi8y2ur4ERA4ost24sOl3Y/TVQWGWoQofIQ7+J/T
         Ovqs3Y4NotqqwWj6C0CSKmidCOOesg/pSyTZxhKZIIJ0TFlBpDF5j7ICUsWOaaQC5ePx
         SO3gX36Bq3xJeCEej7ay0DUmGcu3wiJ9j75jfJ79FuXYcF/HeI2+DbI79+0Vt2vpRikQ
         q3n2S/Uw3ofxe9XeOqpyj2J7z9iv4G3gxs6Xtn84O4lek6ftWB3ZJFNNadr76hGyLHLa
         MyQo+s7yVRlNHObOTTjKr5VoAlAnShoKsXv2wD7kRV1p4tJHvHEVodia4Q1Zbk1Kp2Sk
         CQOw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Um4+2L2Zsn5c7JMOmdj4wZjLDnjMxdEmvMDVx2guu0TEkgzhYI4KQAqJU2BT4xg9F9odh1EH+rD1@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUr4U4Q16nGM2MQeMcu6MnLCxlznwFNRzNf4+6sJcZJtrQEhu
	Pc+Y8exd9hF+koBq8gLnBxu/WcLJ90lh+QdOfbEVxx+iry3eGyMxAHcoDKYsnxOC
X-Gm-Gg: AZuq6aJhO5c1LGf4u9RksTZBQu/zNaFS/InOWKhTMmsJLvmT4ZIKEzF73S/EirCfXj8
	1qKoXpgRSbzSNJy7S/tYVpGAkEYTBw7SqcLvd6KiTlBVUagKf4He2OHV4zPcZbyTa5DgdXi+Xpp
	FnEsJk0JeH3rlCMTeHlLb8apjkh0hY8/y3quJsD8nBkXtwGBEa7tS91djxv5f5S4XC0Pv2/RtLF
	0NfVhQbEAzoyWdnmzBGLbIssdiyxHF4X6znZx/WcTR2FcZuuE2Y70F49MSQvggcniFaqYrNjIqx
	T6laGUQ8h1nEuwvVha4dbcM3QWC1hR825isi5KCV9yfgcYjtcTBgcqM/a1Zwmwk9In2o0XEx8m1
	/Dt47J0och6TbOgDl/fqmLUn6h4HYC9isNmwjpoStxLh8qmokgWIwdI7eomDmPnDuNaXDLLsWO7
	UE1dNKcRBUkRUA7eDKh5PSawt/uzSkKeZNK2qO/9PmrtewZE5u5RGBAhjkMulss66qqft/blqva
	cVHtJwELwE=
X-Received: by 2002:a05:622a:613:b0:4f1:d85c:d7c3 with SMTP id d75a77b69052e-506b4020b97mr249828281cf.66.1771535059258;
        Thu, 19 Feb 2026 13:04:19 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:18 -0800 (PST)
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
Subject: [PATCH v6 1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Date: Thu, 19 Feb 2026 16:04:00 -0500
Message-ID: <20260219210408.5451-2-bavishimithil@gmail.com>
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

