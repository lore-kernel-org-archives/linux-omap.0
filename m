Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E83126C2
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802563; cv=none; b=kwm2nODIw/D70siWmRq/Zddril+5T08CaI3wyYnDx0+CTeoS7xIK/V9u/1zrV66n45mIbfkF1j+FmcRq7EQJ/2YWiJ4riZ/MJc1vAnA1zklMnSVj/m40lUNPQTuEqNtCCKfDcaHku1HNx9R/6rXUUv0DcMrrd+mw3rXHBYngEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802563; c=relaxed/simple;
	bh=rrLo2METxAPvW/Kvl+v935lLmIy60Gg/5rsQY3LkAQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvosMhkEkj+xaCxka7cukoN1UFRCBZpRyUHZrIviocUuRVFxqF0KM6LJmLIhZSWES+hbW7NKedJdk+VBWRIYto2JvJZDKqBgYZDxg7m+kUJT8jxLXljnpgh3RIzd8FcQ14esoIkoRvRVPLxeaH3qICHvsDIYHn9M4jhKd3QxefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH1+HJlu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH1+HJlu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so17981035e9.0
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802560; x=1784407360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovaR5Pw/la2QK7dtVGwmXlwaYYgjdR7NRcQLElGlwYM=;
        b=ZH1+HJluLYVdZL5sYy0OaU5R1KkHaCN6IQNnn4Y80YEFDuSCjt1sgUXBtEKO431vJt
         a9MYF8nunimMvItseqbjS1a5ixCFCiiq+7j3LNn77hYp5+ZYci6Jj0stJO4uUn7MlQVQ
         qLxFc+IIWzLhGD8fs/ajD4kIVhlvyKOg28EO6HdQ+42MAf+U8PXCUyNRRm/MNna92ZW5
         Ra90O5KHtd4pqT3t1DY0xgKWPvD6KTcpi4DKx7zZLysnfjAJyEMYOyxNN70MrshG6+Lc
         mIdRAevoJ8ifeH62J708oQcU9bXtp5pJrRunWIUDzLeMkv/i5TTc01U2RO6kdaMy6hKU
         TcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802560; x=1784407360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ovaR5Pw/la2QK7dtVGwmXlwaYYgjdR7NRcQLElGlwYM=;
        b=Am9prCrHhQWd1X98IKsJK0UgCFZw+uVr70cYyPLD0+bovZqEFACIP/RL6EKJvjjyDT
         FPs9dxwg0J3F24s861VXaWUPYNnjKhCq1uxuuSmlOfCuXdn5Bhy42rDK34l9nhstVLzw
         ZO7Il8hTCHWEXpgmQFnWvwPUAQKFIsmv4LIaQWJYHtpFocIv8oBBsQbpkEfkmLflDSiQ
         RFA6fGnNPtEuBfv0CNcCrr6GJWt+bMr3t27AHJc6HvUmoqmSBPdWvuuXA2fCOoiakMIO
         m/0JCIoJ2wUoUcEZz2BqQcu2Yb0Dv/vSC/JN71XqdF2iunrAlPL3kPrtq06+OKlTiLgd
         ID3w==
X-Forwarded-Encrypted: i=1; AHgh+RrR3APtfeeRbQw+McFKSrLiSExWCEiIS9uCESqMuxr0F3gDBcSOlzLjvKmpPzROz4g1CkA//SmHiUA0@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYr9QV/XW02lWjabcVcuj5mmVeQvNapzF2MrQjE7YEb4RFMj2
	h3rvC6I23qGq++rxX/MguoLfcBN6oXbGdsKO4nFii/qgWTRLVkVR/4x8
X-Gm-Gg: AfdE7clxJqlkhP+T3OhwtgMdtBzzLtXnEygDSzPaKn2bM9ROR6TYQP6yGYvaZr3zOps
	QfGc82k5j8q9piejtU6MOa58hMyVAoce1wVYQkisG5hUJwy32oizGDKTcjIhysEP5qeL2dTJ4wU
	6jnO3seoF1zzdUppVNs4a793E46+vw6WUnKNAF9pV+cRoYsS9mHhYlUjBzmN0ceWQQoMPSq76is
	ZFSKeSAdSDcGCBt2beq/x9d7WKnuBUMZBByOkuYXa6GUAPI/kqmMjz60AKjU8WPz5BowBu8qZBw
	U5qyeSR53ay0aDTc0rcyI51J4GSAUn4PAthRFd+4GnE2QjaTsngnUePDttmvW4guQpPqHX73Rkb
	IBC5y1oPzVxB4Gc0pW6UUUQtrXwJ6Q5vx6xjtVjlZXLzEe+JtwdXxrixLkm8WK7T5XvljKmVq69
	EAVgf3jHYcVl84kFBrDVT1rNg4y+AVBDcoyg==
X-Received: by 2002:a05:600c:310f:b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-493f87d5d1amr31985415e9.5.1783802560352;
        Sat, 11 Jul 2026 13:42:40 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:39 -0700 (PDT)
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
Subject: [PATCH v5 1/7] dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
Date: Sat, 11 Jul 2026 23:42:04 +0300
Message-Id: <20260711204210.197144-2-ivo.g.dimitrov.75@gmail.com>
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

Document the optional CPCAP charger detection interrupt in the USB PHY
binding.

Update the example DTS to include the corresponding "chrg_det" interrupt
name.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
index 0febd04a61f4..d6d52d21280c 100644
--- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
@@ -20,6 +20,7 @@ properties:
 
   interrupts:
     description: CPCAP PMIC interrupts used by the USB PHY
+    minItems: 9
     items:
       - description: id_ground interrupt
       - description: id_float interrupt
@@ -30,9 +31,11 @@ properties:
       - description: se1 interrupt
       - description: dm interrupt
       - description: dp interrupt
+      - description: charger detection interrupt
 
   interrupt-names:
     description: Interrupt names
+    minItems: 9
     items:
       - const: id_ground
       - const: id_float
@@ -43,6 +46,7 @@ properties:
       - const: se1
       - const: dm
       - const: dp
+      - const: chrg_det
 
   io-channels:
     description: IIO ADC channels used by the USB PHY
@@ -91,10 +95,10 @@ examples:
         interrupts-extended = <
             &cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
             &cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
-            &cpcap 48 1
+            &cpcap 48 1 &cpcap 13 0
         >;
         interrupt-names = "id_ground", "id_float", "se0conn", "vbusvld",
-                          "sessvld", "sessend", "se1", "dm", "dp";
+                          "sessvld", "sessend", "se1", "dm", "dp", "chrg_det";
         io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
         io-channel-names = "vbus", "id";
         vusb-supply = <&vusb>;
-- 
2.39.5

