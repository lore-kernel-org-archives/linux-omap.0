Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632500;
	b=vo4adxhA9XgdiGng/56JNlHsRkyx9qCrMlsjj0D4IKWQ471rGhwk8wWV2ISoGw4yV9qJ
	 VUjmzMo7oh54fqBUt1wJcGiuMp9it7taN9zl+JPGu70eVq1vrka7vBkTQLIuJkB0XShjp
	 s+EGfYcLNP+aXOVdry2axKtj2mo3KrIXq+CTYx/9mTJt/rHOaMaw6mzv8T2IROkbljIho
	 2JF7FwWrYL1Lb4XOg7qq7BY81VWmSX1yhD3hwBMRqHyFVQCVRAVo+k21fn6nZXWjUsuvK
	 mvSQSgI9ImkPRErB0UoIH6XHBXC7OGo30BVUxpG11UtMK5sCP5InguLNm6zVbGATBZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
	b=J55iguzC2qv6YuxzhZ0pX92P12XczYxswbVx2gTirjrxrqs4ehRbZqjEiuDaadr6cXKL
	 4fgKd7XMeGnINNl6F/9JPAZpWhub9p7++p+yD44V2GIEIXLkT8gSHCHPln8KuEqoXvN8e
	 XwtGr2rOMBvhVsvuINphfuryELmMign0CXRU807d89NlV+pzR0bLObN0J5lTG8zrtDvMZ
	 KqSKutPunB806J0xG79/sYZitOvYGKtWL+WoPmVNFJaf49yvFzL1LuGR7iOshqt+x/fUh
	 4jOTq5/3fpEV1JW37NsQ9T3aQEVLRfzhybqeTJVDdGTYP0O8dbsfxGFXgw/352GRHJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lM6jPvTR;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36737606A681
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 18:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36737606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lM6jPvTR
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c515369b627so641406766b.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632498; x=1796237298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=lM6jPvTRh8qC2tVEZxJ68Vw2DXnOsWAPa/Hxyo3vQhA2zAFe/MejY0hAD0zdt/076P
         FRh1bvwBu2AMN0W9nu0BQy3ySoAq7UjjWTuteT5cGjB5LQfTcDnDidmoBlJBCbWVQi0H
         U8RkDKgN1kbmwcXHqPweWxaMcn9IErDkmuE8kCSBog3R+w77Ml3s8pXsI8RTvXeATNNK
         foTTKZwypSgexu8jk9H1TcGqgQq/kEUeYS2i6OO6Zsn4SjEECE1JypvAdZbuI8Tj2v0i
         YShrmZYhrR53MZHuohEChrnpTslc2OFjcXWzQ7BwquGlMo94uuGZ1iiNFsAj7u++Y57q
         VXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632498; x=1796237298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=N5ojBU5zhaVjVqYvgt5hVFU/pJePaXRnPXXm/FndVIQIzsraukOAXj27qSyOaKK+3R
         7kaULV+zNXIUWuK67Y4OezBhjEaFxn8On6lPJv/usGf7u7NN15d3/KMHjIQe8eL/MoAg
         /M7jkpMxStmGXOJyWsD0bczWAuVoVaBBmGSKSt9r1887de9qsE4sA0KzRCmMHW4p6sYK
         bTLhcqhPDR6TvMUVYvDJEfyqf2mV8LonUYEAAedNYcBPse6F8bMGeZX9PPEAfr5X+8OH
         dlBmNKjcexqpp1V5ruUuk1gbTDogH+mtfL5u/gAi3OERP2gbaS6mtC8y9XyGzPuXxcoU
         b9bg==
X-Gm-Message-State: APuU4Z9mvnGCroyTICU6SOAW9KgESe7i1ja0dfxnAr+TIorZAFJ4bAuz
	O66uhdb172mgkY5CZZaXJ5/67jgyGFQWYwTTMS4n9orRFJCszIqIEnl/
X-Gm-Gg: AZFdTZfsmluecFLpRMNkkDIlZf6F2q+dA632+8uyvMlStFM+zGvehPlbbanhF0Lgh8D
	n9FEsVGTbM12z9eFI+JEKG/SfGPvm7kTtTvLmm63hvMDZd/UrPv1GOWqtfrM+c3gTltT9Fg1fsN
	vmDTYCoZR9eNonDcTn8E0vXXLqszZM/Ng9kElptLdNhntUcI8MFu/j7gu/SBT6m+167R/K3QP5X
	nBBl4NvxtG8ME+LXwg8EtbnrltqJ8qo7wsU5SN7ibvWeD3IVRdStUkLz2lc9dlON0qPJum6qvnZ
	LzoG16V9pdvGnrOlFQwCL/p1JbFh8tz9di2LwFgV+WpN2rBQNT43JdWSuohwuPUC2dK85ufO0UA
	4Uxeo8Jt2PrZFdx2COtGNk7drEDmHERquyXyq/MRHAzOaIwVhJPo0OJACHO2Lo74kc2c+uc8rHI
	hXRGJZOanJpPitUJMfYureYV4eakEizFHSyTvIsBWv+iu+4IzCbsoxEU7y572z/fvvmBbgSr1O7
	+kKU+lcHESusLeEIDOWSU+43UEt34VC4hwALIHwPUHpDBO9cdx3pwOOgMyHMYd/8Wz9zyM5PnbI
	/xyorDtL5su1J3R06TzBKlw9l9mO+q0aRF1+3ml8xtvyA21KuqqpzsKp4naBQeGwVqzWfmMj6Zb
	OpVm7
X-Received: by 2002:a17:906:5492:b0:c51:caa:607 with SMTP id a640c23a62f3a-c513ab0c394mr1129231566b.19.1795632498494;
        Wed, 25 Nov 2026 10:48:18 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:48:18 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Wed, 25 Nov 2026 19:47:46 +0100
Message-ID: <20261125184750.57866-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125184750.57866-1-apokusinski01@gmail.com>
References: <20261125184750.57866-1-apokusinski01@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the TX and RX DMA request channels featured
by the OMAP I2C controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
index 58d32ceeacfc..ff946fdfaad3 100644
--- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   clock-names:
     const: fck
 
+  dmas:
+    items:
+      - description: TX DMA channel phandle
+      - description: RX DMA channel phandle
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   power-domains: true
 
   ti,hwmods:
@@ -93,4 +103,6 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         mux-states = <&i2c_mux 1>;
+        dmas = <&edma 58 0>, <&edma 59 0>;
+        dma-names = "tx", "rx";
     };
-- 
2.56.1

