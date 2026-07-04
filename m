Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649931F993
	for <linux-omap@vger.kernel.org>; Sat,  4 Jul 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150776; cv=none; b=pTq72BUWFb1Bir/qQi2cDZt0zPf0fYxRBtQ3xkppfqDamS+Euo8yVmEiCW9ggpyPkZvuukWXzEW4zWYGCcYxBCGKBVQz6q0zWSE1+66q7u72vgcxVYPuLjfFwP8b0636mcNShgmyV6KIAJJBQs8PU7Roi70NozbxgeNqkkulu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150776; c=relaxed/simple;
	bh=g1VqSh/+rz77BebTdDSvcjUILqmP0rSso+fqRMDRhDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWEYhr0yTa5yz9vTWsJh4xpR+7+OYVUzan3imjA2NgHQAToC9AGEG4KON9Rn9qDX7ugJHbvX8xU50M7xcT8EWh3j0vkmxshRwCb0cl0CgqHseDny3EJKtB0JWoxRt6gyHmjAEXSH/Dyr02dDC7XCjCl82OJXOtu5cre8hzQsOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H++nUGkQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H++nUGkQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so13554285e9.0
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783150761; x=1783755561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCU57h1AQhpc1p/9qZeN2ZrfUbMLmuZ03JO7I6z1Jug=;
        b=H++nUGkQM/mRkkmW8x0gzyZ2zJhufQ6bYgk/5qAI6hZS9q9X5YrY8R8/bhriajnHSZ
         OsSnLWkAlbQv5pblLYORPNYNFMRL6lZYsnEj4DjixQoAq7Rbw6r691fS//cJ9bHDDwRe
         vyXlbR8qnKp1y7YylVbL6gW6RqVlkfxj7xzNuLFVg+NOFjakLLum5KiVVLmTs5RI+GjM
         QimPmilJ1w1lQ+jNwykOf2Dt+EAmiBnAKRXsNMknZSvOgoVMLPpLpzKgLgWFqeglntym
         1Qgt0kWRz+uXUOLuToekqWaCjJzxzVG7zHNilWiytaDVqpS8ZfYG5tfGEHtHJJPiVk5Q
         AQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150761; x=1783755561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCU57h1AQhpc1p/9qZeN2ZrfUbMLmuZ03JO7I6z1Jug=;
        b=RLf+g2bH+yCJ/dRzCbNTIRKzNweu9+a+VSh+XCrqcv45WxT4irpYsziA9BcXQFkqhg
         IPbZm34FqYG+2kTnDOE0I1eCWlr7w+teASOD//OW4i/cGQjZSYpHVUKhhjbbnPiYuX3m
         +h3D6EYDdBisgTn+gf21BxElBFS32vh36SD4LGGPB0qt+IP+ZDW9yDUtBcYSTCkRoc44
         xexGRFm1zQc31kBt9C5Rv2lEAMuH/D8u+4dGX3OkPVbaZRp1I4c74+MMFbKtND+b332B
         6bg/7NKzyqTYd2Li3W2dXRNLZtVnx8DXcxWPFAHWe7RArbSP9Ab35jlAE1kG0ETZk149
         QM7A==
X-Forwarded-Encrypted: i=1; AFNElJ93JtC60cVD9cqBlffd5UhjDXtaRSoohFMSDeyta14JG8rlpbOCuAJqiySbfPKVR+RgI9vtTllR9lAB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cPQalwl5rZOhHekexVIvrPVinMU7tLBtjAmpruuhRfxpCVBW
	iHd0S9dJQaQtW8yQnUqLJ0x7+6FWkFApBfTF73eFrsRrg24Hc0KZbwbJ
X-Gm-Gg: AfdE7cmQ44qG7NN4Cc6+F2o3QK7RF/1Xhr/fndShr4CR151h9MQSSv5FWSlKcf+dD7v
	ghV2TY3OIO6gvPEtwNIFZj0A75LikteT4ulKMxl7g/B30Iie4zxYoOWlkpZVPWdZ4Kztqrev9De
	NEvw4yhs/vSbEfcdlGXKXTcK+0cR3Z/zBDk8w1tRU1fExwBry9KVNEjtO18D/VgrKrjo79pz03w
	OLtRT2ihjHdghbnwxwSIAgwrtWclHKWqQ8ufvRGIGN+wSWZyFkgPwS+yaCarsVsJnnAtrK5ddwT
	1Ugqox1aRNsCiLnosdnKhzmR7lFgOYsf981cCNb5Hhd/MzUILUKaCAFjrQxKGrwXDErbmjpGYag
	OXBA3VbZxvJWpAsoIxM8N5l1pyxfblye1deIMMHp93N+ZzjzQvSEplw4CRozuvqtpGhtH1Ubmcb
	BfBPPd5AE8Xgxbzd4CrXa1Gc5Aeug/EWhehg==
X-Received: by 2002:a05:600c:4e13:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493d11f577amr25900125e9.27.1783150761434;
        Sat, 04 Jul 2026 00:39:21 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm6565488f8f.7.2026.07.04.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:39:21 -0700 (PDT)
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
Subject: [PATCH 4/5] ARM: dts: ti: cpcap-mapphone: use charger detection interrupt for CPCAP USB PHY
Date: Sat,  4 Jul 2026 10:38:42 +0300
Message-Id: <20260704073843.1750458-5-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
References: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
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
 arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
index 6b1195c2a768..b75a327caf1f 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
@@ -125,11 +125,11 @@ cpcap_usb2_phy: phy {
 			interrupts-extended =
 				<&cpcap 15 0>, <&cpcap 14 0>, <&cpcap 28 0>,
 				<&cpcap 19 0>, <&cpcap 18 0>, <&cpcap 17 0>,
-				<&cpcap 16 0>, <&cpcap 49 0>, <&cpcap 48 0>;
+				<&cpcap 13 0>, <&cpcap 49 0>, <&cpcap 48 0>;
 			interrupt-names =
 				"id_ground", "id_float", "se0conn",
 				"vbusvld", "sessvld", "sessend",
-				"se1", "dm", "dp";
+				"chrg_det", "dm", "dp";
 			mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,
 				     <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
-- 
2.25.1

