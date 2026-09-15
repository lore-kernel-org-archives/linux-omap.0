Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5B47F3DA
	for <linux-omap@vger.kernel.org>; Tue, 15 Sep 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506014; cv=none; b=qYSA1ppfWkbSKMbVC3lpujXCKYNxLsSktHGQ4EIVdq47+EpQTXdWnjRniJ01inYsYGCJpNODwXhk6drdpf3t5aflKUR2YyPD0V+ol1qjlN4dR/yA9ePOl/OhyJTghzctH2U9yZROIs43WYBMk1nd964jiuoNJqe0lfoonbztln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506014; c=relaxed/simple;
	bh=cBWOFBzMLsYPxfimfbKAlO8qMRXN7yX9hOB3gswKS8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTqbpxDtG3n7Zhlsis0tCkbPXJY6bXRKFI4SPChT3wKyEUCtOnThhyRtvVNa+qhu+Vuc1M4XOZ4DJRtfzHypi4RgorpxBCM6uCcT6ZZkvNEDshJGyph6DaUycgtA64mYD/ly4Azs/WgGAeJ5A4PdTuor01wDRJDyP8p6+WstP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/1C10UI; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/1C10UI"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4ca696d43so38281a12.0
        for <linux-omap@vger.kernel.org>; Tue, 15 Sep 2026 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506012; x=1790110812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yglg3Sys5hZqxYUDp81g8N0jGnQoqfRpeFpHtjkozQQ=;
        b=G/1C10UINK19mu8aOniYEMY+NFWgD6uvFrxIeBqMTqIe4ZYcd9WnT55ihVHuwLBcBC
         DILj4biEetaG88Mbze81gdoUFspZlxiIlUv2NrNDKBjq7RdyFcel52ukDF7c0/djkhrT
         O3z7ALfBWXE+MHofaYO24NFDF2kkuONyMgYUhb/kNpq0dxoh+I00PoVarDFnWEixW2hO
         z3Rbb/49NcVdVEhljZUYPoZpr49hdeoOwjMv8BRWrL4JzsGdc22i8ohQIuVe+fIisL+r
         29fKI56YFbfJ13st4W7ymFm9OG78xct/2NEWYyIf1g2imu19CWSI78vetO6pEOWiiJ4R
         WyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506012; x=1790110812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yglg3Sys5hZqxYUDp81g8N0jGnQoqfRpeFpHtjkozQQ=;
        b=L0AC84mbQME2v1pfNanyM8biM5KaIDmAgZPxk/iBM3tEdrXqP3YEkRhJZoQWZ9MFaM
         yobakPlcbg8lUGCOESvkosbyEJGLjKYcPQilVb9687Rn8boQI4K+0CI9RsRPGo7DHjiC
         mVAo1yfrVrm9EsmXdLkf4g+LfsJfmK1cnJO+isTM9+XUIlyGkyJ+DRWjgvLAUbRhEBhW
         dKaUwv3c8pp4/sowKT6WhGVusi8yFbico3l58Egf6CIzFli3aEQjDV8OTihXo7ocrMFp
         83pLLDMSfxRt0tU61pMzRitEumtQHH42wOSrGwqF1QDgXFiV+YWufxj9HaeSGo515IJA
         TIig==
X-Gm-Message-State: AFuF++nFXnSer5xGco1zfX58BlYDaOcASy+IDoVlSUjCf2ZWDw4tMfbX
	EZMWO4EixobICscjh8zDtStyVXEMgE4mlAbDv6/uw2C7Y1oQdsTj6ODl
X-Gm-Gg: AYBFou3PnPUpyuHoZpvNHhLJxbnfoQTFje5UA8+KMebsgpueWoI8l2sojRudsOON5d8
	3r1L787Myod0808YHIesRSuB4YHr8Y2Nxin3qGIUXc/r4XLzPaUfTx4Pp43uQkJmfojH/jfutYp
	wUCPZ5FW9YKJy2TafJdmYDEGeqVCNDvrwc9fcWnS7jhBLXwc3SqjcM1HBzeWXMzfh+anrqvw1Vg
	1KNH2c8/LZV3hUxHhvnNBCECFriC2lDJIRZ0ssBg3nfSVg0BLx33Fp635XUKjCtnGxhWQ7pAaRf
	6rr/gsMs2LyQaXnNv6R3sN/c7GwB2g90Gh0/yCVgVIHmp+2Jx1iUqET5rtncpYhaYLDCVIkq/WF
	HDnDZkucZXx/DYuQOrOnEu6PULTLn3DZCvVRsIO6Iqigo+aaTIHKdeGAIHo5eUizkDZVHJXTjHU
	MxYJ1kwBA2/cLVmd5Tu2uJNmrhHDyAvEJJq0A4rG1jZFNGTr/bKNpzdaNztIhQ6s1ZZ+qpP170h
	mtrUN8r+ZBh6hGZcNl4oA==
X-Received: by 2002:a05:6a20:549d:b0:3c3:7f50:fc39 with SMTP id adf61e73a8af0-3dd5f0808abmr272462637.0.1789506012429;
        Tue, 15 Sep 2026 14:00:12 -0700 (PDT)
Received: from [10.107.92.252] ([2409:40c2:5413:87f7:9fa7:eb18:a8e7:30a7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50abb1483sm465432a12.26.2026.09.15.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:00:11 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 16 Sep 2026 02:29:38 +0530
Subject: [PATCH v2 1/4] dt-bindings: crypto: ti,omap4-des: Remove redundant
 clock properties
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ti-dra7-omap-sham-fix-v2-1-4eadb60081e5@gmail.com>
References: <20260916-ti-dra7-omap-sham-fix-v2-0-4eadb60081e5@gmail.com>
In-Reply-To: <20260916-ti-dra7-omap-sham-fix-v2-0-4eadb60081e5@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
 j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789505986; l=1434;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=cBWOFBzMLsYPxfimfbKAlO8qMRXN7yX9hOB3gswKS8U=;
 b=KUd18yw5fwIIZ/7ECVBLSNjCwhgLFtTHojMC4oxj5+q+01W7orHCMx08MGwoSNxLANFWJmlkT
 fLwWG/npqVqBhSBM5U6Yo0q6F4/kTZpzwZYBAr0xhiXqZJ8GbR+xTsu
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The omap-des driver doesn't use the clocks and clock-names properties
because clock management is entirely handled by the parent ti-sysc
wrapper. files omap5-l4.dtsi, omap4-l4.dtsi, am4372.dtsi doesn't use
these properties either.

Remove these properties from the binding.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/crypto/ti,omap4-des.yaml | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/ti,omap4-des.yaml b/Documentation/devicetree/bindings/crypto/ti,omap4-des.yaml
index f02f1e141218..2ed6f77583d4 100644
--- a/Documentation/devicetree/bindings/crypto/ti,omap4-des.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,omap4-des.yaml
@@ -31,13 +31,6 @@ properties:
       - const: tx
       - const: rx
 
-  clocks:
-    maxItems: 1
-
-  clock-names:
-    items:
-      - const: fck
-
 dependencies:
   dmas: [ dma-names ]
 
@@ -45,8 +38,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
-  - clock-names
 
 additionalProperties: false
 
@@ -58,8 +49,6 @@ examples:
         compatible = "ti,omap4-des";
         reg = <0x480a5000 0xa0>;
         interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&l3_iclk_div>;
-        clock-names = "fck";
         dmas = <&sdma 117>, <&sdma 116>;
         dma-names = "tx", "rx";
     };

-- 
2.55.0

