Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347A3CC323
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788529; cv=none; b=vB2NvxFeb0ZOjK9CXsS7YmtPkFnePB0ZQ3rnEFeRfk9pf6t0RJqPJti1Q/bgHyo173Rgd/3xb6vyjxr0ousRTTebiEIC1KI73U+RaXyriIUGq2xhQRdUxXLiMjFAVFnaEaN8O4OwYBBI7euPTkTiB3auZYa0ZkKRZTyxItTOe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788529; c=relaxed/simple;
	bh=yVMP8UAtXlu981/AZfXfuu6ntdCZq3l09RETxP3vnIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UB4ffSor47dlEIfXylWhDmvVkW9ghOsA2hXaTJkmKnwMS+psPSjjG+yuX8GBvXQ1GUyjkAWWfhfkYLtqC3NjHQd3w1tVjjPXqP2DXTTVtSgvSV3i2+ofiwu5UwqnW4BDN46u2vLbOxPOJ7moV99HeAEHM0IBgueJ0t620KzykBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnb2V/4B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnb2V/4B"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so16596215e9.1
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788516; x=1784393316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDpn6H9slILEKuaZA30ay5+GU6mS2ER9t41k8f7Sm/c=;
        b=qnb2V/4BHecTg/Bstd2nMyetg96JxjdqwwEPGpBQV5kC4m6oim5hvw2ownjnEQoxYH
         EM13pqUiExGCOUWveiovV5Pg48IAbgut8sqqnJT1ALmvnN2KD87IcZCFd9ImEvkfXxmn
         Doi5wQsapjWOtcNS9F8g1TKg8Pyi1wllbLirUo2oHlNM/nli0n97PJydxOhtrLmE8wed
         hdCSoFHJBZWA2Zo0IDzpfwIi9CgJStbrG4wfrHeYTtW3TPyYJbZhXEhJ5SJgWmChmn03
         II5dudICvCtO3WqRhour/Sp9RQ/Apou673hl1XN0cR7SJPXMEnuGTo9+3d/XHS4k/ZAi
         +G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788516; x=1784393316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VDpn6H9slILEKuaZA30ay5+GU6mS2ER9t41k8f7Sm/c=;
        b=PyND4rDUdsGRfbACphAClr/qL6I6AGXiDtb3ezNAAiC3/fcNTF1FXl6VUhp7iZTtQr
         bk/f1LCM4RCZ7rOf90jDej82jGpmAd6oB1URgRbCWOsDMmpPtAu4OJ1WrCSi3CV+ZjDb
         4VG0MMNeetHsmej4nVDsBx4DeUfg6J80tXCLmGZdUvWDcc+xp80AuvmxG/qHQzCfT9g5
         gviT7MtK26xq70V6xv/9ustXtrlgGjzxqwNGeI5rDVNLhpfxOd0EYGtp49K6ETXPSphS
         TG6zMVv3JZYuMaR/g3GVVqPTVv4v6khHC4LWN4xI/Fn12eA7A0NEXuPo8ajJKO6Lnd9+
         wbOA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl1hk+LgGxch4ZwupXrb6N6mr3mrkHpYcmHGmRCJI0vHhQvaGFGoGMFO257b0MeszYyHNA1o6V0nE+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7Q6EEUIry2lT4o2V1KODGfg5D7MzARLpvVGStHce9kKXNH4/
	CW+6JIe0h+3GFihYqGhl5Lhh0LePGOQCXHEuBN3Olo+dtYz6n3L8K9vD
X-Gm-Gg: AfdE7cligZP93DhxiLn2UkOm2DM1v8SNJZh9iud70rrIYzE0xZaTUDYPaY3YsKG9ywp
	2xLHb43Xna2i81SwkiS47XOauFvX+I65duURhJPDSZa9x8/rWkCX61Leob6QFyQ4POOfyRVTR+z
	nt5MIIY1IW6yCH5yKbPTfA52mFtB+clrrGheCTcbCwgx/fxvkJvLbNYypJXHwpkYH7+wTDgEtqc
	Cba3iiuDMw+8WXBrFwOmz1c+c696RczJVYBWFGXRswj22unOfi5KPlt4wzUeL9mh3npx/B5A8WC
	exJUdSe3b+sNzwKfWRM6vCoEDDy6hN5wGN9WW5/fbU3TgcuBp37ct/bA7592b9nA2dIaGPp1Br2
	uwIoEOKOV8V/oWpuWKnQ6JYhCh4jik5fgxwJu+UHW+7cXTor4Hg7AMuiHBAhCaJCurSoIxiUSCj
	n/9L4/tINMxZQzbIDUeq+ArAHgjca73MgmOA==
X-Received: by 2002:a5d:5c89:0:b0:476:cfa0:a976 with SMTP id ffacd0b85a97d-47f2dcb60fcmr3613474f8f.5.1783788515836;
        Sat, 11 Jul 2026 09:48:35 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:35 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v4 6/6] ARM: dts: ti: cpcap-mapphone: add USB safe pinctrl state
Date: Sat, 11 Jul 2026 19:47:54 +0300
Message-Id: <20260711164754.185565-7-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711164754.185565-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pinctrl state that configures the USB interface pins into a safe
GPIO configuration. This allows the CPCAP USB PHY driver to place the
pins into a defined state whenever the USB interface is not active.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |  3 ++-
 .../dts/ti/omap/motorola-mapphone-common.dtsi | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
index 51a858021541..368cb539997f 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
@@ -120,7 +120,8 @@ cpcap_usb2_phy: phy {
 			pinctrl-1 = <&usb_ulpi_pins>;
 			pinctrl-2 = <&usb_utmi_pins>;
 			pinctrl-3 = <&uart3_pins>;
-			pinctrl-names = "default", "ulpi", "utmi", "uart";
+			pinctrl-4 = <&usb_safe_pins>;
+			pinctrl-names = "default", "ulpi", "utmi", "uart", "safe";
 			#phy-cells = <0>;
 			interrupts-extended =
 				<&cpcap 15 0>, <&cpcap 14 0>, <&cpcap 28 0>,
diff --git a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
index acac3c243c7a..475ffe678e76 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
@@ -352,6 +352,25 @@ OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
 		>;
 	};
 
+	usb_safe_pins: usb-safe-pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x196, MUX_MODE7)
+		OMAP4_IOPAD(0x198, MUX_MODE7)
+		OMAP4_IOPAD(0x1b2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b8, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1ba, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1bc, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1be, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c0, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+
 	/*
 	 * Note that the v3.0.8 stock userspace dynamically remuxes uart1
 	 * rts pin probably for PM purposes to PIN_INPUT_PULLUP | MUX_MODE7
-- 
2.39.5

