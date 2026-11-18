Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035188;
	b=fx48AQVWqk0s20o1I0i7zMRDCapDl2RzjXXtQ3+pmOQZgiVz6VDtUcJZoajieonqgbjQ
	 9AY0lbf6WsTw6qZjseF+74jvy0CJHOYalWrQR+nJbCNU0M1rYU8tmgP8vU4/Jok7mGYLZ
	 W4H/T9MR48jRvypiv2Nvz/9I407gscqHSTjx797OB3Qk3tL0rwkcVJjNdyJwqKxaTADpR
	 rY1oZRr6PO+35zQZ/SCIuhsCd8NSXOCQPn2yhT5+75Y7YsH4xzT2h/0A4J2zLxwK1JVIE
	 yW+FfRl1QcBEx/RSbD7YRrRHX72qGDyiMkKXs5IwcCfUHJaHjQ4IsynLE9blesGoXBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
	b=i7kZhrvzqvfrYEIKmpwo61gGUcHaveD5lFq9xX+E7Vf0DEc9M1AZy+yamzTkCqwoKxFI
	 O4SunEakaZGsTmVGHR/uAt5ityX4vL3EKMhdSTNAyxIX8yxrqRcJgm8TRoLVOUMOqYZ9O
	 iQpXilZul3//WLPwqEQOXIU0H9S9Ayi+oz33vS3mfCH8qt0gov0CfT94NF1gfnuwJyZ1R
	 jY1tUasJJcLlNIksWm0a37WOZ1cUv7RSrg9uOyfwWPGDaj8vmHiZZfx2C9i6HkiLY4vGS
	 zxtZC9ifx/hEMDURo8NQInbxYtL7KXJ1qrJEGZLDTNHTRS5rcDgc3S9IIXV7jnZMxjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnuOCiw+;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036D606A32A
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 20:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6036D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnuOCiw+
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5127c7abd5so25060566b.3
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035187; x=1795639987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=mnuOCiw+XVWApfJrSVasj2ZwbRaCZD5TnFi3wMHnkk89jysXAwnStHMDwJduYhvMWM
         Q2PvQAilIlElLPf/ESHCmtguPGq6fcjQYD80EbW5p6p0h9w58qWo0WoNsgOv87jk2XBu
         /6WscvhGjJen+7AUTwNMx5B6jyDT3P35kUvp6+OsGBq9ckOPsugUbOhRIAiTbbo1yvHz
         wNA72pMm0g/h4/82Wy7xLDShzDOW8g2rwWHflod5hXoYXdjbsupIWjr48douNVW96rIp
         +LuAqYmahyoe/zpNI7SmwNshZxmL0DXh/aB86mxWTk2jaz3aYAfN2sO2aQ9Kc/bzhEZt
         dADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035187; x=1795639987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=OvqGjSmnJUPv/kj631N7dmO+I89hCiCRLrVndaWhHucKczoxyefxhkU/Db/sZozhj+
         Cogid6cD8VaLHhvtJCAWHP6F9XDMAbMFkHXlfCvZenP4yAu3vY7XZYTPQAizG+l/BVS3
         HbxZRmm6nIKj/9+EkT1P/FvHUTkDTuddfpRVUtOgmKWHI3tfvkNSa3LA30H/Q23DeE0q
         eqPtsSi3xVJ+LVQXSbCigvLu49KNdlgzLVlDZrfhNDaXF74QuOoxaamA8iPI6vOmRAwn
         wihp21wYZ6XSq9wlp0CV5HN+G5/e2oqmv2wN88ctt538/ov4f4Ms2WVfAr1Nqh4t6vmK
         CiIA==
X-Gm-Message-State: APuU4Z9efwMIckAZphLAeGSDqq+r6QE9oZjgskBL/ODz6nUwAaTbldSu
	FjpKhzCS+naqyTFfQ+N4RkdUR0+uG9k+u3RipT0b9bnaH9273pMuyM79
X-Gm-Gg: AYBFou09ZsrRMAopiKWrhF7QJnXd/KZBqskWhP2l3La4jrR+cNbYH+BuKtcWuvdB9qe
	delOf5txSuF+LMDd5V1h8aeps1EPbTmN46jcKsN6sLSxRyzARg7rH1Iqyh3Y0g7b7OGem8Ml5Ig
	nKTRSEQjJRuFqIxr2SUSm+E/Wta2K3tvcDJGD2mOo9WX00wKyK2V/pTjbPAylQsq/WmoTkZLKKu
	Li2rWU/43sY9pcGQ3TfimCpZeXNAL2vwiJlk2WXWOOeuEhWmldKknTTV7vXPB5OFRxfqFmdCCTr
	uAmq+QuQMdrBSvEeF2c5gK7/N/B+IEHNgJRwpgU5H2sv/kxt7rhwxe7VfYUsj9r6MamNRHsMiny
	P6eCdUGpd+X7gzK44nrCKGSOSQo1atbO2zTr4BWveW4QTaZ+pQ40qal2LIQsfmJC1vMLas7xtUr
	TdY+eSLk9j35Mpnb5++6U08CmsXGhKF7+tj0D1gj9/j8iBYoJR8P+WfNFZa6FOOKiwgzSxfOmi8
	QjXsNEMLKpk7i45hpv9RXL1dpcBnjGfr14MlsC92zPYoi3O24A4wqZ/UnxPvLvMolkjNef4td2h
	GFNCj7DDGdZaTDGOdN2HHEcYnPOwG7YGWemmtoF7PkVkhasSgwCRrF1RfN7EtQ==
X-Received: by 2002:a17:907:6d1b:b0:c51:691:c76e with SMTP id a640c23a62f3a-c510e35c6camr355946066b.36.1795035186781;
        Wed, 18 Nov 2026 12:53:06 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:53:06 -0800 (PST)
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
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/4] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Wed, 18 Nov 2026 21:52:05 +0100
Message-ID: <20261118205213.88778-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.1

