Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BB208D0
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861134; cv=none; b=k9DEXC+ZYEmkIkgZ0qDvkdZA+9v49IwIeyAKabqBbwJA9S7OxikSaU3GeHej3ghj7F85gk8BaKctrbcG/fs1EJxmAFAUtJvwJu24v8hBiApMZp3MF8enWzueCm45xMdAKwPpm/z+0oMRIb6Mz740fokL/v8OEuGvQv8FYBMpaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861134; c=relaxed/simple;
	bh=KAvlbY0yYL9PaaTueRuO9yIwL2QGgENhM1iet7MXCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdhy7P8HX76SSzXyJALh+m/LrlmRIoi94pyufOEUg51CRj0YScE0+Pw2I8AGTNvCOqJE7EEiAFTOOiC7dzl+pAZBNNaOAAKGmnT+blieOZxdirnPMH+RCR8e0TH1Y4y3F8mX+fUD5iviHVdp63lGXbQcD9sZbqSjGG3hZBfuVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez53YNsv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez53YNsv"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4bc6a8021so3349892a34.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771861132; x=1772465932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=ez53YNsvNq1F2YSeFLA0ksRJJZzvvDzQXCpIjNn+qEIlGC65tOE/hSGVUrFT6YFw3m
         bE9YiyGpAfqTmgoiBz1js5CNaF2gcWUSFgCwZoGC2iKVY1BfC3ziL2lLP8vWjPzcg5nT
         gAE3lNLlgo4FBXnLTTVZvC+PAgY4XI+qo8cqDK4pQumHaAiRLrxiHRjMPJDn6qmE1EWb
         iO1JLzcDax2xjHWd3lYMGrT3NknG38Vyy2I68pA9eGQsRBtr23IvGo0QC8H7Sjo66Uq8
         iSvXyWpaevD6Z7AhEecYfNZEU+kVLndvZvSEi/HWzFxJqV9oSaOlFPtjZrLWuPzqWO2+
         nZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861132; x=1772465932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfQfBaf9AAlms3smQ5+Ri25UHHgHjEr008f22TiaTqo=;
        b=rCUATd7P/nx/1G6yJk9UgUpp0JVw7ENkTuhL1KbV0MEzglYl3bVgp9RhQlepmI/N7n
         iSdeqW8rJNHv6xYneu3dmBV8Fsm+rKO0dVj53yLZYb/+qwYQE1Z6t2V1c6H2icsOT9OB
         2sHIGTiosAs4qT26GeiTj46CQq8qYRJoPw3MNumbZNHYJ0sESLpBE0je94kbtn0yz42v
         MaHTVKW1p/UYXtFmsubdwz/ArQmz8YlAOOH2g6MQpb5w8JWu3kBZB6oA+PiyjCYqINJN
         i8DRv78MfTd5P2AbES2tWlNRQbqGwSKzwRdVKSHlT/bw9tX0veXFaqLoC+PQBPjss8ID
         +law==
X-Forwarded-Encrypted: i=1; AJvYcCXLc/KweatRCS1asdIR88DAJqIR+mp0GFaIVnA4E3z2hnz/Bkn1OvJbmMIypXz3ghFRs6sMIaegrzYk@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzdbuxhg+pl23Wlj/SRRlwz6fobFVow/PpddXzEPSL1FfHAZ5
	ikgmG/4cp40sRx+knoZqngBDdxrlxTuZI/pwIeA3Uj/qmJEDK/oCHYzD+S3Vv6eg
X-Gm-Gg: AZuq6aLaDlr/kkrCKpMasdIX9nDNyA8sHT9WW/XLVBVcc7o/zSc9jrqrj29ATNRPXPm
	5/b1UQ++dTeYy8ULcQu7M4M8zrPakMwU5nkLPgWKpBTR3z85zGcDpgQOti0sB8yhdsWWeVD1nLe
	Nx6YU5BGvaHtCKU7ddjlZ/rvvzC0r/tF6vyQWSO04zCcw1oayD/Orq1iYE4WX8EeXcx+rtR9HSn
	1u6ZYVUxLq1zMsbhPkFXhOJBzweRBBVKbS2PkQ1eBxJMWcqWqWuxB/k/xRBiIP2S6XtqHvYzB4a
	6+bYF1dvxoxqJxSdyuWL7TDgyG+y54ECU9sNErnWXoeyjmAforCQlurzL8gjUyfXXK9UX8mnENK
	W+KNdUgrLu7HDGyyEeQ5x+4NMtxbLKvUcxsmn67tcV4i3x9OTXin5IwJzHCx+1KJAQUeBTRdAVE
	plm+j97sYdhtOXJ9cAl3BG9dpN1hbVZmOrmENuaHa1QNjUExeNbTRF+RWHbxcm/6MlYX7KgSATJ
	Uqu2S/5zP0=
X-Received: by 2002:a05:6214:1c49:b0:896:fea0:cd05 with SMTP id 6a1803df08f44-89979c84074mr137002196d6.16.1771854586510;
        Mon, 23 Feb 2026 05:49:46 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:46 -0800 (PST)
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
Subject: [PATCH v8 1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Date: Mon, 23 Feb 2026 08:49:33 -0500
Message-ID: <20260223134941.427-2-bavishimithil@gmail.com>
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

