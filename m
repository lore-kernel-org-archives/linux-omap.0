Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3F3672AF
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238328; cv=none; b=JZ6cBqqn95UJ0iOIxpF2DSdQSG/JLY5fJ5bVn1iF0A38+i5dzJ6iiGvC5NlHuoAqOh/GwDRZdfIGokaggv/Waq/qQkSqovk/Ze8YXKcr/TaIp5Yr9rib88tetBeub6IIKZ0zbbOuQZJVYo6uqZu4yaI/n13aHDuzLANPhkwGS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238328; c=relaxed/simple;
	bh=Xsqlm+rF7jIXTcXnCSKMaVUBX15NQaxokCbcRbwJDbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpBrPvuv0GoIDPfsSlQrsESyvDWN0s9Kt2i1jOS3XlKCpfAoeoemVTegHbDNZBQ8FGjNZ0ByAB7s4f9Kgc6e6Tx6lDPtJDxh9aLnsjCEmIbTGspTuR4nfG0gw5iRrxw+rgVljClfzxF5fZKankYLiBEMsOybdBwjD9GU0sqUJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYGdJLAR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYGdJLAR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c1950518so14459295e9.1
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783238325; x=1783843125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UY6T/viKs724YCtcNe87O9J53G3jzdQBIfSFXtvLiY=;
        b=hYGdJLARmwxCbLPEIWM2rTWsbsaHXjiAF6n9sxu6oR9+ZmVlcAQhb0H8gAE8/xSpw6
         4d/ZgTzE4FG3VQrZnSixkuVxv1A8rICCKEEVnhecWRYPlhlJ67ECL4GewCi/y8Y2kA2+
         xUkGXVv9402JLEn7qJ3hTjfBgjNr2/wrbIMk3q2LfapAWghiL59zPPO+ElaAgE1+CJcy
         bs964wiwxz2eVDQPqO52lpWHqEWya7Bzyj8zlnotqOwXobWjDmDm4WWraIOrqDs+muzC
         5KBlX3TJSHTAIFsBvuzatpJsbYrnsPRIY+X97xFZCOhBmtHXrdzc/nJ9o1n11BBQLbyo
         D+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238325; x=1783843125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7UY6T/viKs724YCtcNe87O9J53G3jzdQBIfSFXtvLiY=;
        b=BqzvP99ndtEYyWa9tSVWkfZQ98bYCFVBrpW+Hpn7fKT/0zzyh7GhvNdshMkAgiIEJw
         JALLCanILK90tiqHEiP3bf2qYcBxtd9DQJLwH20z2S4hRld63r8ztbmwCg+BXK8urTOl
         NEXxz3j0lFM77wa+U7WVd0w7sSvcUcPFWroeCjfcnjQ4MbrJaqrAk7mja4oq7g8/YTdM
         EguvEXu7GdVQLhw/1Ms4KmLCmGe8twCV7rMHesq5Uqum+6N4SNFvMEQV2bEmeOZdSW0K
         WRfza5W0M/qYlRzpV3cbP//gtpDuAeVmWNPZiDs1snZSgveTtxICVe93yR2akFhQwAFy
         ElwQ==
X-Forwarded-Encrypted: i=1; AFNElJ81cKc6u59bq9bDz+gzz6D0G7l/z68CN1lTM1aJEBtNiIUB1wOuoUPfTB6hmRI7vki8WYqGIDOZzwHI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0qVDF/pfH1KBpi+wnMtaoq+OlfBUZ8iLitO0EXGcmJlhZGMN
	YW9Ves5zeg2dIQQPv1bA2yMS8tJZXn9ZGYlkTbiE86aaHt77QhPgO4ER
X-Gm-Gg: AfdE7cmF0pJcMrsWIocXPLrzCkGARVmcY97QrtRz/FHaXZhJli10R+nOgT2yADfo/EE
	luL3HeTB5LCa5yp7xb2SRow4DNiW3noGdmrzKumVGWcGmU5SR8OGlaMVuxJFBt64ZcZ8ZMEUPDg
	OrgyQEZS1/0JS82b3ueXf2kESumFYN4LVNy61KHCEAiX3egaJdSFWHfMFP7cMeEcZBJm15aVIAh
	lw+P/hj0/ieVYOFBiREZOO1Oq0sdI5+x6CocvdinCVSOu0Bh/NBqk1V+YZJCXcj/cykuh5VMEM1
	KnFAKWiQukgSt/p6FuYhf5+G10HnoONDwIH3Y5X2YFQw+bETqPTBTkgZXr8iEdZ9Ev8ah8H2vYb
	KRGHTPsI4RHItG/ETn85BNaAbMbM7nk8NLbiUMlq+4zw33H1X1QrJvhsjlIKq18qIcOidvSsO+R
	V5fK85G2pp0/ftCL2k1vzxCRssmHB0AgPKwA==
X-Received: by 2002:a05:600d:8444:10b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-493d159bae7mr37777895e9.18.1783238325038;
        Sun, 05 Jul 2026 00:58:45 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm305769765e9.15.2026.07.05.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 00:58:43 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2 3/5] ARM: dts: ti: cpcap-mapphone: use charger detection interrupt for CPCAP USB PHY
Date: Sun,  5 Jul 2026 10:58:07 +0300
Message-Id: <20260705075809.1793784-4-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
References: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the CPCAP USB PHY interrupt mapping to use the charger
detection interrupt and corresponding "chrg_det" interrupt name.

This matches the driver and binding updates for DCP detection.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
index 6b1195c2a768..51a858021541 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
@@ -125,11 +125,13 @@ cpcap_usb2_phy: phy {
 			interrupts-extended =
 				<&cpcap 15 0>, <&cpcap 14 0>, <&cpcap 28 0>,
 				<&cpcap 19 0>, <&cpcap 18 0>, <&cpcap 17 0>,
-				<&cpcap 16 0>, <&cpcap 49 0>, <&cpcap 48 0>;
+				<&cpcap 16 0>, <&cpcap 49 0>, <&cpcap 48 0>,
+				<&cpcap 13 0>;
 			interrupt-names =
 				"id_ground", "id_float", "se0conn",
 				"vbusvld", "sessvld", "sessend",
-				"se1", "dm", "dp";
+				"se1", "dm", "dp",
+				"chrg_det";
 			mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,
 				     <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
-- 
2.39.5

