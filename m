Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340380;
	b=SooQANU52ex65sQ1t7xAbWKRxCCuWtz0HOgXz1jBR93R+eIyomK6mkZWQm7EIdJJ2K+O
	 HiLA1wXJFYMk+SoH0rCs13/T9zjjzwscIbUUfjDUKP5rhCGd/ElBXZayxhyNMQmjdoltv
	 NTfyfaVe0PcNAgdbw0iRCTmLR1j3Ujau/UHb/luRwCOqN1TSHJKUvJQ9nNQBr+jZzzvl6
	 MGPH4oS/2nt3B+fpQIyBTutsNvNCOuUNCb+zt4NbFgRMmedKa7kdBRwmtV5HEvS0B5xWW
	 XsGmvd8ON2AkuMg4E7sK3Urc59na/2BjB9ZxGN5JRRxw2HXBDz/q19GggRyK9rkUWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=mBu26pyTeT9bETEg9HiE5XJ66rAa9mCFfqD+c+2OSIU=;
	b=MlMxkeH6aNqEhg9ScUGfB4ghcMyciWtpcVRDk55AYkG6gvRk/YUQcIdNfo6fyPW+rSTd
	 cVax/q3hAv+1UE8aqjw/q9VQoK5+tUhNCdjWS5XfJ5bBelYrvsxr8qQ1WmbQSt5jpcJmW
	 nRKHEZkEnijEcS8NSe+rXzKTtTayLRGeo/pctgXc1b7MOtw+WW7+1ViqgaEvHxTpgGplc
	 cCZ+i5+OB9MmJ6YoIvCMaAtsXphg3KxvOCYksnu2nA7Hkkdd8TbPmy4OAsuiX33offh23
	 rPMOZ7ibS8hxWtF/cqVQNoKYLYgpEb2XPzo46vQ102nVHL6Gshi3SJtWP2aa/a83K5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yxf+eg6a;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFB606A32D
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECFB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yxf+eg6a
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36ecc11bd26so287094eec.3
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794340379; x=1794945179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBu26pyTeT9bETEg9HiE5XJ66rAa9mCFfqD+c+2OSIU=;
        b=Yxf+eg6aCLVazkjeYAnLQAXiYKmoPEjlCBy7GqXizgRVvQRUN0Eh8hG8APhTHMXCpv
         fJPUdCCeVndvWT+k4iCNgAW25nB8CBI8bdCXA53n5knpT5XTXtwsAMkt2Glyuc5os2ve
         fbOmCa2YNQtFN4ZJhAPfEBmPHPHxkP1jcdNloq4HOPRHaChvQwQsbUHANZcTel3xcqVv
         cCS//yS7yzSEoylTqmCxV5pD3JAWtdfduOoR/IndH55U8k1Xj1LwOa2/KLuzOJLuStcZ
         ivG9tJSpThpW+FnTz80UqzYnqvW9OI3qzMSZSrFa+B0pfGNdv5n/IaMF/Kn7hzexcixJ
         dNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340379; x=1794945179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBu26pyTeT9bETEg9HiE5XJ66rAa9mCFfqD+c+2OSIU=;
        b=1e11jOTJj40L6et+n6EP1jaxKS+3in4F//FUC12B6eMrP8tWHQ/LW2uQ6S3DZIJYjS
         0CW743UrudCVScyDRMz/UVE8VQfenU9iuHHU8VWhQe6qEN5T3QeRd08XPpCM6rciU1v3
         A1GWnb6jfLkrU8VfRG+QV+2hBKQmbbL8yfjyffyJjxvSRCG8uCWUzwxc/IWLFQfEk0hp
         GYQLC3+pJVk8RE7CLxnRSYeOnwiMoi7lCjzQdMd+i6LRmRHiI9AfZyVB/QwMmwcPZbYB
         2vbxv2V+g+b7XrLj3Ccb0DK1G9D7xr5sJf/N8pVS0EHPkt2aZcJDHbF2n+6jWk14lHP8
         UhuQ==
X-Forwarded-Encrypted: i=1; AL+hErGhWSQwvkNEmYBCO4Jnmoov5eD85iBCT8x6ZcJu3NZ/hWpbwr5W61zzqzYQ3yZVounr1EWfZTu0Rzt2@vger.kernel.org
X-Gm-Message-State: APuU4Z8GcKZjPymzX1DZFWJivQEM+F+RjkqnfJBx6HEM/jGU/TFbzGeE
	MYlOnFcPHIRFokuC5v0NzI4KeQJc4NmOpQqqaE0NSlSrWnMZ3pxd6bvo
X-Gm-Gg: AYBFou29BOlNuWiZcz6Jqpw2E3Yd9yWqffWVwKYoDYlLmq3sdlce2pnAeo7udt/2oPH
	KX8uMn4qEqdvcou6fawGnapK3C9cL75jUKdaCGq5tIh4RROhv04nZRYVIYilCrRxRyJqxInIFLZ
	kHphdqgbmr+oyUhaeZtE7TidmY/UgWo2SlCVIB/qOEaNHCZp7AOcfovWGWrrge14W5ZjXQbrUwO
	DauvCLmP9HPvw7PpPb57zcDS8/SZUFmamuZJji2Ed6HI86fbSdhNAp9RzGSjKoshXB56ndfQQpM
	7OWU1EcIDiwa5sfhdfyKnY4MRI0/yjjfMVQAL7t/hBQZHYRmoN1yWbdz1dHMp8ZZyUdWgy7I9go
	HKX2RQtaRxkXU4btMmemui4QDvjI+vudrTfns8l+glcUj4jn03BdEi680VbgFjpeayF5K0RMTt2
	IALSoAoekLSm8yxW+1uEi5KSOM08n0ahqLmiSiTnrm+Oxen0E4tSX1J4RNl92qaf3RZ0Qj6iiH4
	YhI2e5fdifKlXdhmoIKhHGqNatV7eYqvLEktblni7/t7cchKtzeIPGMhZUiZVaT6qIJf2bzSxdM
	X5knuhnGxgxhBoW8ouvpv6p/LPHr+6xZieT75sQ=
X-Received: by 2002:a05:7300:7f01:b0:36c:a1bc:6114 with SMTP id 5a478bee46e88-3768076e52bmr664865eec.0.1794340378880;
        Tue, 10 Nov 2026 11:52:58 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881f:d9bc:11f3:620a:3333:518d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm8834225eec.11.2026.11.10.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:52:58 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 11 Nov 2026 01:22:33 +0530
Subject: [PATCH 3/7] dt-bindings: arm: omap: document BeagleBone family
 board compatibles
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-ti-omap-dts-fix-v1-3-19022d1ff4b4@gmail.com>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
In-Reply-To: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Jackson <mpfj@newflow.co.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Bhargav Joshi <j.bhargav.u@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794340358; l=2011;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=HFD7yxMISHUSRTOxRHCJ1DZNRBnsW4DxRdCeVpvA1IA=;
 b=KibNFDfdnzCmfgogghjKl7j+PawBFGlgfn5VQEmbtrmRm7DHebL62iSv+m8SOCRuWuKBHnKyR
 Z1WMw60HA2JCIUmp8yPwla4WC/hU1dvfp+/XhdSuMiyZBthF+Hk+4k7
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Several AM335x boards derive from the original BeagleBone or BeagleBone
Black and chain multiple board compatibles before "ti,am33xx", causing
dtbs_check warnings against omap.yaml.

Document BeagleBone family boards (BeagleBone Black, PocketBeagle, Bosch
SHC), BeagleBone Black variants (OSD3358-SM-RED, SanCloud BeagleBone
Enhanced, BeagleBone Black Wireless, BeagleBone Green), and BeagleBone
Green Wireless.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index c97eb4953ed25..e0af554388669 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -159,6 +159,34 @@ properties:
           - const: grinn,am335x-chilisom
           - const: ti,am33xx
 
+      - description: BeagleBone family boards
+        items:
+          - enum:
+              - ti,am335x-bone-black
+              - ti,am335x-pocketbeagle
+              - ti,am335x-shc
+          - const: ti,am335x-bone
+          - const: ti,am33xx
+
+      - description: BeagleBone Black based boards
+        items:
+          - enum:
+              - oct,osd3358-sm-refdesign
+              - sancloud,am335x-boneenhanced
+              - ti,am335x-bone-black-wireless
+              - ti,am335x-bone-green
+          - const: ti,am335x-bone-black
+          - const: ti,am335x-bone
+          - const: ti,am33xx
+
+      - description: BeagleBone Green Wireless
+        items:
+          - const: ti,am335x-bone-green-wireless
+          - const: ti,am335x-bone-green
+          - const: ti,am335x-bone-black
+          - const: ti,am335x-bone
+          - const: ti,am33xx
+
       - description: TI OMAP4430 SoC based platforms
         items:
           - enum:

-- 
2.56.0

