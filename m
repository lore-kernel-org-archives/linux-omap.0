Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A723E5ED7
	for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472659; cv=none; b=nYIqhSV374vFb0yTMQgy7iVMw+BMnaa5jpeHQZtWO57AVW/umEpA4CoP0j6U9OFaYKc3k/sg621uRUJxWDcaKbK3GIkGFUVTjkzAPl8hN2DaUT9XqBXl4rhD9FQvywGltI9ca00RLr8I4jiVnro132ZtokRejscDLFqNp2DJky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472659; c=relaxed/simple;
	bh=sXMzf+dpY3Gf1vgo6uwCENPhglBybMN0rS0lqrqI3X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uV68/yk8o88msoyR3hXCG105VWUfBcdONxdi5WlkDTLLbHxFwKqwy4HeBaOpXGrRSjy99/5dKjFc3fjhojWCeZt0f0GDxjeGawxZiY6rWHuvez+tO6iU1cpXgc9VSUue9hqbDV+L1oJqwu6cVM2bm8FeztHEOk40cMfSAHrwHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKJRpoQq; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKJRpoQq"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c6874d295so542370eec.1
        for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2026 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782472658; x=1783077458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvBLBJx+kT93NTleCT7dpiOIClkWaZ9So3A0zf5NePU=;
        b=iKJRpoQqRzfpeQ+zAGvYSRanajTPEQ4FNs/K9Lr0I7vEfLNKFviZ0grNa/kJ/XmuQO
         a10xKw0JVV37eMqwG1kBaRGK89lz5PKjIICLpuURwes77+IDcZ78FIa0VzY/zsYGdMf5
         76QcXbl1OnaH3R9rHEUcptb5RWV/lzcrpAiS4WnzOY0EXGHnjtmlGC0ecXSs+TkgMvtT
         reCZPiRQx2/dnOsMLActszjzX4xHEDe9qAaPDBPmYh7Bu36GA5lVumGDg4S82NwOYpod
         64ltA8SErVRx6bXIwHuyHlu5GOH/obUqDMuUd2IhDrKNKAZ4q7hb0J/wVH+a5NoKTWOo
         qVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472658; x=1783077458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvBLBJx+kT93NTleCT7dpiOIClkWaZ9So3A0zf5NePU=;
        b=UTs0RSsltPEHJShD+KWImoMwDw1NBsqIGPuRA+mWPHk+kVcpJWDszgQx9lZMOWx2TF
         yD90guwqoHUMswYu7emdrHHi89izQwGKWZX7wBiJSUts9uy2OqPhokqxagZu938jhO8p
         bLZA6bKIQ8rs4NJf8tN/SVXXpqAQ78WJAc5cS0XmvPYixKVhk2hEnctkquEYfUI9i9G8
         6bUPiqLr90223t+f/OYQl6r72ydt66a8UcsX4luGLeMIvFpHk3Kfi+pTQ2DujjUbzoP+
         jzoe/HQhAmpifn5wHWMknnUAhc1P5f5mVfLL4GpO9VxvvdSOKRd0Sr93SJ23lFEEIkv8
         kXEg==
X-Forwarded-Encrypted: i=1; AHgh+Roxm500lj4Wgm674pdBd61luav4L9uGFgD2JA9NWFBZRUY26vH6GzACs5d3KNFkAbn6PMH2RXqi/GZp@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxZjPGUilBHVpWVV2iozq2TzGACNiOuDQa0C5BS/AbPaOUgcc
	CCWFbp/Ho0vkhvGVaLERC2qEzGb3FGmoX/n6UEeNF43kzskfDuS8aF8b
X-Gm-Gg: AfdE7ckpW2ot0LGPNUUOb92JtZzSRehP7gEcbZ3YSnIxla4dVtNrmaSNzMBJGLJnGJM
	1J1aktcxm/Ojwy+8owyo0ZFrEk63J2cyGprx9gT8iTwuAV8zlICvmatH0BndvzZugct8z1IUKSD
	5jtg24UDtRwuSu2iJj27R3ytzwIDkSVzOvS7ygE0V7FpWm4j6KQkiie/OmgDMbU8adeg28Bsg19
	RdG3klsxbW+RKi/fOmG88DScr7HAVagJnfgcISVmGZcKP/doYyVYeerzyHQw7h1ajTUcXF2nM40
	SaCh6SWhF9UyPLXDAJX1Pe22H3Fw1xfDeSqd2hYqI661PFLc1L9CfgjNrMs4dI9GPOUe0WMKt2z
	Hu/kRU9ElMd+vKeH2/DDA2bKSIslbl9bv2mccAKjIS+bSji2Dj+nYTjywBwVZkjeq6QP5W7r6e/
	pS/mbGjuBYR+q3v0AHwBuuRyExHB6GK/cPqcWJcRKB
X-Received: by 2002:a05:7300:a485:b0:30b:8878:9c8e with SMTP id 5a478bee46e88-30c85468412mr5529542eec.2.1782472657813;
        Fri, 26 Jun 2026 04:17:37 -0700 (PDT)
Received: from primary ([223.181.21.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cac87dcsm19391852eec.31.2026.06.26.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:17:37 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH] ARM: dts: ti: Fix typos in comments
Date: Fri, 26 Jun 2026 16:47:20 +0530
Message-ID: <20260626111720.56688-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix comment typos found with codespell across DaVinci and OMAP
board files:

  limitaion   -> limitation
  swithes     -> switches
  converstion -> conversion
  differnet   -> different

Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 arch/arm/boot/dts/ti/davinci/da850-lcdk.dts       | 2 +-
 arch/arm/boot/dts/ti/omap/am3517-evm.dts          | 2 +-
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 2 +-
 arch/arm/boot/dts/ti/omap/omap4-panda-es.dts      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/davinci/da850-lcdk.dts b/arch/arm/boot/dts/ti/davinci/da850-lcdk.dts
index 8390d71b000a..e70edd5274fe 100644
--- a/arch/arm/boot/dts/ti/davinci/da850-lcdk.dts
+++ b/arch/arm/boot/dts/ti/davinci/da850-lcdk.dts
@@ -366,7 +366,7 @@ nand@2000000,0 {
 			 * to NAND block 1 (NAND block 0 is not used by default)".
 			 * The same doc mentions that for ROM "Silicon Revision 2.1",
 			 * "Updated NAND boot mode to offer boot from block 0 or block 1".
-			 * However the limitaion is left here by default for compatibility
+			 * However the limitation is left here by default for compatibility
 			 * with older silicon and because it needs new boot pin settings
 			 * not possible in stock LCDK.
 			 */
diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
index 40f15da81043..a4357fa9f006 100644
--- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
@@ -213,7 +213,7 @@ &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
-	/* User DIP swithes [1:8] / User LEDS [1:2] */
+	/* User DIP switches [1:8] / User LEDS [1:2] */
 	tca6416: gpio@21 {
 		compatible = "ti,tca6416";
 		reg = <0x21>;
diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 43cf4ade950b..76bfb364777e 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -420,7 +420,7 @@ stmpe811@41 {
 		st,mod-12b = <1>; /* 12-bit ADC */
 		st,ref-sel = <0>; /* internal ADC reference */
 		st,adc-freq = <1>; /* 3.25 MHz ADC clock speed */
-		st,sample-time = <4>; /* ADC converstion time: 80 clocks */
+		st,sample-time = <4>; /* ADC conversion time: 80 clocks */
 
 		stmpe_adc {
 			compatible = "st,stmpe-adc";
diff --git a/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts b/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts
index a933fe560834..70c609811d11 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "ti,omap4-panda-es", "ti,omap4-panda", "ti,omap4460", "ti,omap4430", "ti,omap4";
 };
 
-/* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
+/* Audio routing is different between PandaBoard4430 and PandaBoardES */
 &sound {
 	ti,model = "PandaBoardES";
 
-- 
2.53.0

