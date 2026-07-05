Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A2392824
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246290; cv=none; b=eEvVDUoMdbWOJ0PhhzDk3YBuS6a7y+nQwlIAXp6JxTL9cINvKT/KZr6Y71YzohlvspDsqjssptXmM36EhxfJ56BP3PTmGVAqW7DNW4XupDDJNG1lVkQysxzm4QaGnO5gXJnywuc35YEvloOyEbDMpLMPkpPWN6duTbVJZ/JiW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246290; c=relaxed/simple;
	bh=Xsqlm+rF7jIXTcXnCSKMaVUBX15NQaxokCbcRbwJDbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bo6XIw7sjexv4e2WwNAEm5CodRgbk/0Gd0w8lrm6lBzDVhkHbao9FvPWpt5CU7BrzPgu+ihuM7D76kABf9AyTe06XCoBXJ8wgwDWNAVGOYTOWj+53dqyqDpegi/Dy49sOxtv+vEZoWf+LV6qJtyqEL549bNog57pVSzODQHWOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1NLJkIS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1NLJkIS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so12467135e9.1
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783246284; x=1783851084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UY6T/viKs724YCtcNe87O9J53G3jzdQBIfSFXtvLiY=;
        b=a1NLJkIS8n1xjhVOy5lYXcSxfeWUQbO4dPt8XKHTYwJL3QmyzS3X5FsW8LacxHXOMb
         URmcwDIfMgG54oyiULOIoTvg9vpeUnNEwOhavFkRw/55A4U3aZ8wpPENkrEvnRD8D/F6
         cWuEtjFl5kVYQxCeKdIm7LijNCbyBmPqmX3K1X+eKpl9JBOjl+X1w6VRO6j0iISCx0so
         K4d9fdF1yw7ai1T0gRfcytQLuss8+D4qKtXHR4U+HjE2Ic14SQGoUF8+Wg+jXwJf9lhB
         XR6HnqkMOozn9ek9TRuKBtBoi3XbZzEkGTqQmfUNrop2K+gd1oq915lzcxSy5da3tQJz
         mrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783246284; x=1783851084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7UY6T/viKs724YCtcNe87O9J53G3jzdQBIfSFXtvLiY=;
        b=iDmMY0WGT2aa9w4qwEY3VcY1dIBQR2qH5Sz81nWm+C4PTSahGO6l0gDS8JVdlC5K1C
         M66h435bleRGc8f3GUxqzdiu6Zl7u9cUq7PDmEe97Lb0tyODaJeprz+a37e/HFVcmM+g
         k/OIe3F9f824qgYe0c7k2hdD0g4ig+vpSSpc1HLJIri9r3VNRsYw67NweQ/P6SiuLHG/
         h9A2Lk0Du2hLvP1Z6ivF0xokcPKb8fAdyIYD/tD5SjTNaIslogFgfUAgNmyLt4IZk8us
         2l/bDorCoj7oWeZzSbMZAPRnQq/PQUOFFOJFffWiJDuuEpNs7i5bu/MEWtFQqwZ8e+8D
         yj/A==
X-Forwarded-Encrypted: i=1; AFNElJ/jaBbzA3yRj5XcdxRP+F5/S6wwfDpyDrKtTZK+O/lVPChc8AlufnE3n3h0g0YS365agiuwdGaQaqxX@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvkRt3nCG+/nT8zBgvYyfgN86oo2lGzGfRYRIiA3LqxzgF+RS
	bIiZR936+Vf6Do3aUlnYYxhcbBlJB/naYj3HtL5fiiY7cDRttH92fBsS
X-Gm-Gg: AfdE7cmM4L2/kMYWopAkWdaz2h7yyzg3d6yOYHZuJlpmEZ7Ehdz4LXAMI5s2YMwF2YH
	4KcX6MUqePERcAj+Talp7O5/tgZntPt5HPM+tn60p1gh1ue2mJQcTPOvnPoMmsQKxZt5umVEY+u
	aDtFXK0qvMMXkTNLCEL+njhiiEASAxpQNb4QmIZO4qijcCWgMHZ6Xq8l9qLkku1ACHO/evuGDsy
	d/6UW3wpOskFwuzve4mjAJ9nw/aEP7cuWCS/XUiCHSys4iVJnu7T8CbeSD2K5k6XplUOKxNsHVj
	XOnE82P0w/nkU01uZKW/pzn8O9+7713hg+oz+VMyMeN7M6aod7KTjC9uMPCaV2U+hkFtk79tVfG
	xyqbEzaY2Yv7AxJ76AVrQR37AxZjp0fEYyrBYlu5+BSl8KU9nU2Qc1EOvbvM3bn5X2wU0fLqVvx
	sn3Nwn2fWeIOemq7jSL6rKtQUt5QTUQAsf0g==
X-Received: by 2002:a05:600c:8b85:b0:493:bcef:5646 with SMTP id 5b1f17b1804b1-493d11db32emr69992255e9.12.1783246284252;
        Sun, 05 Jul 2026 03:11:24 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm261382715e9.6.2026.07.05.03.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 03:11:23 -0700 (PDT)
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
Subject: [PATCH v3 2/4] ARM: dts: ti: cpcap-mapphone: use charger detection interrupt for CPCAP USB PHY
Date: Sun,  5 Jul 2026 13:11:03 +0300
Message-Id: <20260705101105.1798069-3-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
References: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
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

