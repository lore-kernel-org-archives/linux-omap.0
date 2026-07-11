Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA623CB8EF
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788517; cv=none; b=h7uDlyOxt7CHQHV6J+F60C8trElpJibf+cup/UIHccrz7rgJ8tHv4tm+Qu+21yocP3j74Gdo+KbYXh8rle/NR5vKJw7ITvLCYBLOUs9KjqxFuwCaQZHQzHbDBHUMCpO3MdqfdN6v1xGlg1FgWoeuSSYI3VfAGPPwG9Br1t4LUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788517; c=relaxed/simple;
	bh=8gu660Q0u7C0W8t7xo2+vLeynZsPh27OtCchUb5pAFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5NOxblriMij11yt9PcXJOA2/qFE6S3YQPkJOTkD9k74F0e6E2PjJaU0LqyrupoA+G80tMxDrjReuPC5nUP9xip4Abhx8UXGeG1mXKnj7L00pruZ+Ij9jkpb4+DH0e0jSM1UvW7OIm87Z7w/NoSQwKyJaQiEw+1EoqXly/SDDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJZXCd52; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJZXCd52"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493ec555a26so13013755e9.0
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788514; x=1784393314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhreuQjpg77ctdkAec2a78pglE74GvXVMC9BSorqz4I=;
        b=ZJZXCd526PBGcsE275x8ElVB5+6uBnUiTv3kfpyHPiijdrzPAx48m6xnrLoysjOu8B
         CP35OhHD4nHawYQ2f1pBtMWeO99FknQCV8GUERmnQQZ1xqPSp7A8ijJ6MZXIK4KdeS2d
         kWwSEc4kOwG2x9cS4SO20/YWls86G2DOY5BqRgB3ERlDCcSd0St2dA4JnpZA0eaucKor
         NzSL1othtzt2aPKwKhVChHHy/4josABg1EAfSmVTKxDoDx/QvF5GZLqTpIkmon6Hsp8L
         Td9BhysOGZ3PL2Ikr2Rb3YGoozgbokUWpY83R1PvvYCHl8f9GjzmJYkUlTPzRYq8HpcQ
         L5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788514; x=1784393314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhreuQjpg77ctdkAec2a78pglE74GvXVMC9BSorqz4I=;
        b=TEz6+JNOexyIwMZcThBx+zyRdjE69i8z5UoMKgXHnbt3Hw6citL+0FPwmMa9fuGixg
         2nMXBBAXgnFC0WenF2yGiBA4JK+52xFFCUuY+UOkjoyRuVbsAz7bwN5qPDI+M0oiBrsJ
         4uaZqsn+TUQhEFdwiiFWdjMEbgdo4YL9A5aXhjlachds34RkhK1a3HPWkrwGfy2QPL6l
         rWFcDQK62CUDRcxq2XkQZQ8QKY4O4KzGDo9rVmaKHAFLdcufSc4hiBKu0Na2WAiI/XWZ
         8MwdA/DMnX7Wucxdw8mrWemVWSILt25DYqLMU/4jibqrLjWUJG3LtWT0hrc204v4fvjV
         yaHg==
X-Forwarded-Encrypted: i=1; AHgh+RopK2bDsx62DlBLNJEziYe5joGcD/zJrXpugBoF09INOncsjBOMWOmKwpCzLkGNRRYYH3SMg5uz6Qw3@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2WeIkeX2+Ih9L6id28ZTIVjv5p4c9Ik/eXwadcizHrwMRAxa
	2cqDbt4GDyvmwXFAmjcOU0nh43OHu/PAnvVZ8Qy3d2hn5O8lLKtJxCnDNkMSeA==
X-Gm-Gg: AfdE7cmJGksIxi+HT9dMNJWe9ZiVJFvqTwSTSS5kenrAyWzTkzslqnKcmoR44hzzmsa
	GeXcgQ/hpm8aaAU5pAL7XFkdZIDmZ6xVHcaXGv/JrFOZI4y5eyQL6FoAQmFyQ1TmEqKs1UCIT2j
	pvu/aX6mkHfYXcoB8Rj8qR4inxjxg0yvXz9PXVRP96fo7wGLUisWkuFRrUoFoOrcEOtWC++PH4I
	YkYW8+lkKvzbR4rhs94vf+sqJerfsiP7oVmakH41sP4ipQ5NJf9opDalxjvnnLHjKkIIkT1CsfD
	pUELciwp1yFflWOw1DgHVcGKqBLySztB854FnCDtuKlDjEF4s92bE/LXVH2mG/v5hRqj2aRH/Kj
	P0wNk5Byiz6CMkTvRbel1CDz/7kzTnMI10S4kqaDtrh5pXV4a5DDRPtd2PifK5Plsy9VBCHVgVs
	1H/E+b8JfqMPdO00f5G5jxuYkf2pXjUcSvsy9I1K207I31
X-Received: by 2002:a05:600c:19c7:b0:493:fa7d:56a0 with SMTP id 5b1f17b1804b1-493fa7d589cmr22554885e9.13.1783788514279;
        Sat, 11 Jul 2026 09:48:34 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:33 -0700 (PDT)
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
Subject: [PATCH v4 5/6] ARM: dts: ti: cpcap-mapphone: add charger detection interrupt for CPCAP USB PHY
Date: Sat, 11 Jul 2026 19:47:53 +0300
Message-Id: <20260711164754.185565-6-ivo.g.dimitrov.75@gmail.com>
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

Update the CPCAP USB PHY interrupt mapping to use the charger
detection interrupt and corresponding "chrg_det" interrupt name.

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

