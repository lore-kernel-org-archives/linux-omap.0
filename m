Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33A3C988F
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788512; cv=none; b=OjYs3YI8g8L2Q5HovzDLbtWmk1EVtPjdu/+8+KPR6V8DkwvjRWFxwvcSyYwUWQvDF7UUZXTw+e5qZAp3lGLvyodKClQdlnCmbBzfF1w3QQD90nS7Ak9sERpUEu/7QET+8LraevYZWRXXykl98uxnAUBHCxVAS79qJt7HJ9aaTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788512; c=relaxed/simple;
	bh=vctX9KwwqmloP7foTyQPo3feQK/oPWLbCvXEnlHxCHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBmTBLMAvLTcb5yKSy3u9gvK7jqAB9G/T49GBG1mUpfSsqBfYFcEdPMy+zE2g3xepaX5zJUADibGMSMCp6Gg3plTC59XKiOZI8eYq153MwhtSRzvS9w7E1XvV+of3AOWrOYyvd9bM534Ny6iVB/lICFppnxzmt9gArtMev43Baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp2nSyaK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp2nSyaK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47dec32798aso1953456f8f.1
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783788509; x=1784393309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UtuIacplhejTVgASevQDxobm7194RuV+jAzjBsHtT/s=;
        b=gp2nSyaK1Urp4iPvXDIhcr5FQouJFhgmM70xr/TgmRoQlcrJcsMekjFWtoBJgr/ZVq
         NwYM1oDBna6q9xR49ld2PZPMkdQLYfZHl4pnnTPP46PNY4Wft/yq6BJCC0fUj+sPrEdU
         co/yRYCPezsk6xUE6Kk+U7T9YVE0vT5PZvzK50CbR2nur+qUZB3tCPlf6ZKUf43wTUQG
         HYj6HfohoCQ98lz4KAddssPDJYMlYjhb2BmbOaj/ceMnkAZPxY0jkIVhaS0tBXpy2QHQ
         UWzqllmjtc6OTWHML4KOqNdatmhzdRWAe7ovt24Gc0Wf/M4+AKF2k3CDCLEm265L/Zgt
         GsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788509; x=1784393309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UtuIacplhejTVgASevQDxobm7194RuV+jAzjBsHtT/s=;
        b=cfroX37ZzMHTjEVp+GZC/deEZ/nFGt0YOQQKinrgvlYdI/2xIvh2ABz00gAeeYPqXt
         4drlqFWx0hBx48CRc3VNMyhs10HWcLxRe07ylHdxcq/SIEdNjrepmFpsV36vadJjM+go
         HNB7cUSL/QUBOS1n+MKxPbX5gxZx7OkgzCL09NWkqfq0PrJMPX33z/ZOG85PUmRnDLJT
         iyfqsQqhomdsXZeYNZin2qPBXxd1XA24RvOqqX18Bavkgr5vOuqY4M/vtSmpm50BH3F+
         YC8x0PqL9Bf09edh2fZu6zgL0SFDPRJRMSJB/7j/jLGIqHtK+9uABOK8o+cAWXv7treq
         Byvw==
X-Forwarded-Encrypted: i=1; AHgh+RrMNxHKqzdINYQnfJ0Ltbqt18txCUQxTDWGCcRpjEWnQxVItDUPc+0VI1UEnMnquWJy+lyuyaIOyJa0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QMWo30QCAgT2S1MiY3Fcr6adE8WrI37FZCAd1lzrUHUG1W98
	qlVTSxsIoGbJ2TGQUss7iC5HS5wDjC//ySApDVnCjmU8T1dEpjhFDmao
X-Gm-Gg: AfdE7cmkWyp71Ke8Yx1Vb4D706V6H7B+54aPsxnbdhhZqV7r7wmRxe34WInA99hK0KF
	J1Dq+uO9VQ6xYQzq224DvGQnq5YiAUoWNXwo7K1EZ7bHUNtk6nHLmILPAeFV7uW2RKu2NlPvy7p
	3rUL5snm6p6sPuXHvQjNLODt6NihatlKZs74l0RbiChnnILY8tIbNATYN73a9frqRF4ICztoHh5
	/d8w/lbcgCaFG/xW44828sX3/LIAaFSgFHyaTtVBiPiMiI4lXG8IcppYwiPvYtWCNgmuENIIki2
	YN/bbbvs3QKhQKm1RPbYtYhE/xFhdv1SDhg9muhLKZHfmf7Q/rVxtea9/OqyF4iDYWzTua1jnFd
	PmNOakG1oA7l3q2VrQECNlXEzoUIOi8VtRg2M3hkcV0zBMwf3VbJBe51G7mmy/1tKFrtuTrZsxu
	DqezerRSv5IJlDfaZSN+1hWS7HGYuTmqUusg==
X-Received: by 2002:a5d:5c84:0:b0:478:65a8:6305 with SMTP id ffacd0b85a97d-47f2dcebd30mr3684315f8f.49.1783788509108;
        Sat, 11 Jul 2026 09:48:29 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm69152875f8f.13.2026.07.11.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:28 -0700 (PDT)
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
Subject: [PATCH v4 2/6] dt-bindings: phy: motorola,cpcap-usb-phy: add optional safe pinctrl state
Date: Sat, 11 Jul 2026 19:47:50 +0300
Message-Id: <20260711164754.185565-3-ivo.g.dimitrov.75@gmail.com>
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

Document the optional "safe" pinctrl state used by the CPCAP USB PHY
driver.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
index d6d52d21280c..25c36138bf66 100644
--- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
@@ -62,11 +62,13 @@ properties:
   vusb-supply: true
 
   pinctrl-names:
+    minItems: 4
     items:
       - const: default
       - const: ulpi
       - const: utmi
       - const: uart
+      - const: safe
 
   mode-gpios:
     description: Optional GPIOs for configuring alternate modes
@@ -106,6 +108,7 @@ examples:
         pinctrl-1 = <&usb_ulpi_pins>;
         pinctrl-2 = <&usb_utmi_pins>;
         pinctrl-3 = <&uart3_pins>;
-        pinctrl-names = "default", "ulpi", "utmi", "uart";
+        pinctrl-4 = <&usb_safe_pins>;
+        pinctrl-names = "default", "ulpi", "utmi", "uart", "safe";
         mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>, <&gpio1 0 GPIO_ACTIVE_HIGH>;
     };
-- 
2.39.5

