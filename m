Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA83168E6
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802564; cv=none; b=qxGVkdoNzzieCvuBjOp4YTp08pKyFF+VyX1uewtSbXJf2qEelLluW3ICanDVMzSGhA3l7992HHU1VKL2RoUS3Yp02jIunJUClBrYvn8oalxZfmL8G2Fmr6JqHw17/M+SLy0TO46IesTKN3PG27DDMX4LeTZ5FTJKHJlJgBgJQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802564; c=relaxed/simple;
	bh=2WBH7acSpS1buhG5UF6DDL20aRHFmpdt5Bv97S7dCpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXWFjjm8Hk3LHbPR/KLaUzb3A3jBNxzpfk77tHbp0fPK490uJ6eLlAqNrL8R7e07F+l4uXe2vfeCwYUgzqJM/AlfPy+IBYZPMqJGCadlNdnOgcUqEQRVlbTw1s2sT5+NE+RSWRK0k17A+AhavHaf0Ik2JWROAg1JiyJ7Ig3NgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg2Cs4z+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg2Cs4z+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso18521245e9.3
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802562; x=1784407362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4Wlb7YHseLBpG9ALxYAV8hvXubKFh0TjzQy9FHDQQY=;
        b=lg2Cs4z+D2eL+7PH0ehzPge8Gbz45/Kw5NYgNhr9JVOAqHsWqHbkCBATieYNOYceOL
         2obR1dpz0WwZvfMKelubluBULLbqbW9vePBrPOYnBOA0QvWZu0hMlUKFqrk5nixDed7+
         MUNK86vH6r2JOnvPSJ+6D4u773Yml/LBuqaUXnV/hyIE7NIWJVtj/HqaZfZzYsZrtmqF
         /DQZQTXlELRzp0sm+VVjMVCixkuaqiZWvZbcAFiaspUZaflbNIgmmxi3wqW3E0+q5bSZ
         xxM2K8WFwGvBqCFCLYp7bwS6qgl0McO2TdC/iQGp+A0zfw8zJoZwf+zxlYYKzHP/cz8d
         pZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802562; x=1784407362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4Wlb7YHseLBpG9ALxYAV8hvXubKFh0TjzQy9FHDQQY=;
        b=Dw5x4unQ+TbvdUUKGmy7ejdeRVK7hqijRihLOLUKeP7CVOU/M2RQsU4OS82owxuxNS
         PuaTnXxCoZVp7LyWkVwQRFDYJKWmZS3nLVH0I/UdVo7DZn3FHl+3H6M2am7CNjGzI3/a
         dILm+s/S13kwo/OxkeTSNb25oPcreaPW+3umAsMdJ1pdZkrINZ/ygFRVmKpDSHgcDkQ+
         eP9Fo/QPGeQbb1odxZBxF0FHteSMcKI0Ti9D5Gok6tMSqrWcTEKHC5gZOZb8RC1Wh6e2
         JbBuIKh+3s6pvEjtLml5X5Hd9DH9reHXhaJXrR0LY3h6fTC9Zsxh9YGmIYU8Ofn5//dc
         +nUg==
X-Forwarded-Encrypted: i=1; AHgh+RpyjgaGlR3C/f69LE4X1wXqaLrU05ClsrPQSN49xj4Rjf5AqAwi8/+fwFfvMyAuV7LBpwNVMyTma6Ne@vger.kernel.org
X-Gm-Message-State: AOJu0YytU+Pdf/vo98UoUyKsZ34PBqsiVf7LVOQ6IC5zHVoRNFwVrfcq
	T4HWaL3pxK15dQJkK29AM5DrV0h+PZ0GUo240XJ9Tke/6dVnLhuBuGDs
X-Gm-Gg: AfdE7ck/fGj6wEalgiV6SiAsIHTYM3CRmdL1A8ZxG0ml7S8bbBsEg8WK4GCAOqBU+5N
	CA1LcYNsLhuvw3NsCPy5gIIR4D+UO0EohQJYmyOZaeBTMm6cVFDEINIF0ydEE7zOW05EYY3mTMD
	J1eiIl3nz2+In2XUUVaip5Ue/1xY4i4m4jcWoAjAW0+a9YSkhwp/t7pdR+x5EVw/Der+3JMBiti
	089eJABh3UBHG/jFLoOITudkvGADaHYPQSSHCkTBMzREo+CFmUC5Adp10lmzHX7KYR20r/twQuD
	5LDk0Th2dai843xjWM5PHUJAmazgLW2EElPbxw13xLgelrg32DWeIAbMwuR4zggZWI/wzHm1F/l
	00WP4utBr2ej33HNmtsD2+WZCmU0LuzR2ErMXaHsmexYcqEwN8QoTlPbY51BoqcLVJrzh1cgGNm
	VzuWWCxZGyD/bzzGC31rJlLB72bxYdw5jUMA==
X-Received: by 2002:a05:600c:6d48:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-493f88389c0mr25978355e9.33.1783802561934;
        Sat, 11 Jul 2026 13:42:41 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:41 -0700 (PDT)
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
Subject: [PATCH v5 2/7] dt-bindings: phy: motorola,cpcap-usb-phy: add optional safe pinctrl state
Date: Sat, 11 Jul 2026 23:42:05 +0300
Message-Id: <20260711204210.197144-3-ivo.g.dimitrov.75@gmail.com>
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

Document the optional "safe" pinctrl state for the CPCAP USB PHY.

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

