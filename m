Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49E30F7FB
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802574; cv=none; b=V6jSTI7Fu53NEvU4cNfu/XW5wK9mgZWC5GjnKoXrzU+sziIXJH8op0GXfHD6BX4VUJev23GNXsWBv2wYqpa0f1SkAXXmGtRsqt6G5EvI7+e2iKverQCnRseC+0Rt/pFYeccQtAhRRdX7Dxt3kGtgnOwY7TAZubYpFt1dfDlEPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802574; c=relaxed/simple;
	bh=8gu660Q0u7C0W8t7xo2+vLeynZsPh27OtCchUb5pAFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l83+Td7BXhD9WJETgVcm1/PhERupvDllDC96RDMfm7Bx/459ZsJuOPj0eheabgNMhx0Kt/kz91+debyXxno33i+q2Jy0dx4qUSJWlEjy/dJWT2Kkma6pSeMbdrJdkcStCMuCow1LwL6AKTTdv3YjPUIvgg0eJfYGpWux2FmNCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS96HQZy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS96HQZy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso6972635e9.1
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802570; x=1784407370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhreuQjpg77ctdkAec2a78pglE74GvXVMC9BSorqz4I=;
        b=iS96HQZyK9MD0DIMczLE88UgFLmh8RFub/m6jV8+7uQ17og/euMZEFinDx9d4tHl2P
         BtB2XQ1TBcSxf1oNIEvHR80BIE2fS4/YkIx0G9jA5ExGqGkDnq50I20j+mspbnI5Zro5
         KlKdaNAxFtCC6fhtgLfK+VGlQaHeJBWvmSF65wKo0/+t7mQb03nP3YCaGd8qtfkvB18S
         F19W+bDYQa6FI+/TzuXKwR9bOIdBuv3CRfB5Ut2s5sWnzdtHJmUgpMVOqjT3GOrRKaoH
         qXBCfcbMcZkYj1OknkknyEreOaFPKM8iOksbeklfuqG659LNDedp46y59hP462LF5905
         7SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802570; x=1784407370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhreuQjpg77ctdkAec2a78pglE74GvXVMC9BSorqz4I=;
        b=GMj6+9qx5/udCEphQEzXrTM0n5+w0KdkmyA4NiYJP2qg8al4FGdPiwyr6HeuALdAQx
         tutRiuaQxKkH9E8nKzqJUgV8QlGk5Mqws908/jx6vqWT7rxMCmN5kvGnZMVHX6JpYOdN
         h+yBsCuVEhZYpUMab8kO43Ax94GR3e/xfi2oYBfuisS6r/b59HZXr+j3HWXa/cly0vxQ
         G/hdmOu12I9mEnul7foXyWDPENHO1ZXL9wqTo+cc/qeA75bMTp8ZSLL3GRh+DlVdsU65
         UyN/05pwzcOMTw5k+9TdrlVMzuHkN3y55gaQEZt+NfMUMYPkLFWgjptneI5cqq8yrU1+
         yljQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJLJavk6m//n/KIDnguewpL2aiUFRfWTk5e7fsl3/UqetegzEsyZ4YYTaV6gbWXR4c3S0hIBcYug8+@vger.kernel.org
X-Gm-Message-State: AOJu0YyAL65yrSAuqI6txicvjfoaox7jWj2pIcyM5V9p4/xelmZcRWw6
	KhqQb153sez6MZot2unlhLlDe+zuYRMlHA6W6HOAjjWhgl6sk0ZZWhhN
X-Gm-Gg: AfdE7cmTHFABZkbQoZrjyQ0BFZThDTvtOKAvZI5JdoIqKZOhUHXnwpNbEhC0zwwxQh+
	Da6ljW18pE9YRZp4EPawx+HXJxqH70CDH5vKlzOrclGflZdnhrr6ZNicHOgxMCqCD+YuI5keAuj
	4r08QbtMymuwjNFip6tfHZCjYQIezv2uabQRRF/dW9Yk/U78SHdPAHSGP1Imp1g0V5lz4bRjTUT
	4DGy8Bylv8GVJXCuFnY8moYZMWNV7Xy9YXCG7l3HL8u9JtvlRGfHRoz1TEANOxWgnBUdqMweIzz
	MHD3ooAA8SFKpNKV80UFHt/AuOxSDrs03SpJPVCvnDAE6Vf/fX88TeieQk5/uDN1aHUeWvmd9zE
	2G1IWhDKwRcFJvthgYZYankZcNy2qeTOIaGSak2BgFGaaRYQbtKzqQwmO9ohPlAoQdswTxo9sHL
	xz3bPyzDFMhUUyKIODL+VWZRoSHJzWgsQjjw==
X-Received: by 2002:a05:600c:8b05:b0:493:e4cd:def1 with SMTP id 5b1f17b1804b1-493f87e9ba7mr41987295e9.11.1783802569796;
        Sat, 11 Jul 2026 13:42:49 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:49 -0700 (PDT)
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
Subject: [PATCH v5 6/7] ARM: dts: ti: cpcap-mapphone: add charger detection interrupt for CPCAP USB PHY
Date: Sat, 11 Jul 2026 23:42:09 +0300
Message-Id: <20260711204210.197144-7-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
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

