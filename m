Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201196;
	b=p37nVUvVziPwvddCPhWhiwgYUGf6veIT6pfzZM1zbqDNW3Gi8xn3j7UzkX0VhV01p+7F
	 EQbNhm8NcdpDNh+RoeIXsVZl83RNLHL8991gKIqghcPPAULS9OD0WvVjkte+TuqMF5U8H
	 DbJtXZx3cXdFz33zD/HBM9jj5EpCDdQQp4tHkuYS4INvuZOvRuG8xvg/aEeFNrkkF55G5
	 qIvkmnc9+43FrQe2lUW7uxPe70I7cc5gzhKNYFEEGANYkx3iLr5KTeqZgfrZCh073h1kB
	 FmzPVpewp14Fdqp48pGZ/A44M/sPoBrOwp32VBOxIzHFI70YEWC9untO6tfzegAr+yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
	b=VAOj1JrXY7T1WKUxuYh1y/YeRZMjoUc1WXgr8Cz/tiZ5r7ICS9wyVYhDwuNEIilCLGot
	 9MoQC7KuLQS3Dh6ryD0ZGptqTgeTHF5egOc5wbjjhp7ixUMA2/envoSP8LQ+fNQb5fGR0
	 9YLQTq+5H2v2F4j6jUjmzh23rbfadCK7IMPQrfm63Vh24Ck97chDgg5Ji6pNE8fvhB2CJ
	 2NJTnBRM53ZXA7CiKJQa3OfSTPUG5nxUchfT6eqJc3SfqVFEqkMjztfjWkgA357dza0Hj
	 J2tzgjjYbip3at4lHwhFS38nueVfpFSacwjaMfxsFIRQiarWJns5lUrRUP00oVmEFoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxkcDXGO;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91060A2639
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E91060A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxkcDXGO
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c51239b0e3bso209152266b.2
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201188; x=1795805988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
        b=yxkcDXGOasir3Qy6rymbwZ/6dJ/Um58rGBpB81H1qg5RNFLOoQ6GK2AsCGxDtL2CJo
         oJ/y2p/fqn3K01f0Y9rTNMQrS/undGrlx1eJJQaLIFC0tLdFy7wohnRbz+aPQ/fuZ4eh
         zMsVRxYMA67xJ99I6j43TSyT5zA0divNQF2ntlSUYeOqyUUyrC1gYRE5wBok9kkLan97
         Guui3O+gNwH2afkBdz1Qp6BXLpm4AVL+qwhTyQ0PTn0XyfFCN7QBQhO3t7wR5Fi671BE
         JZE+WjePQDzRUmsKlH3DVNkATh8GE1JYn2baRismgDLTBTYftBADchLio99oNKSHZGq7
         QDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201188; x=1795805988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
        b=NqgkR11DMERiGTQkanY7uicOG5Xta7nuKUzgC8wVffs8KRKnmO81vGP5BoIl/9QXmP
         cEaPn9ZLGahDGnSNoVRGr37eANyyb752SdHccvtN1tcA3DmzaF5/TzZtkwDupeLERwIJ
         8hbKykscyKLt0dB/w9BB0h4vyn/YmnfDKIABlZ0HHOJxHKVrpVdVRjnLSQ4EuyFRXKcm
         Ud4KjeqhTn077kGxfLesXLiz0+k7WVDVfYOAJmJDAYsbEXii5JLszORiG//sdUqw4YRM
         p6V8JF50rK1RQD5WudmTmr0Zea5VQmdUN9TqmCbl9vr9f70ABfYrfpQnw4L3JCVPYhsP
         GqYg==
X-Gm-Message-State: APuU4Z8OXRQs0g8r979aCbBSe8ApY/wXMP81UAdfujwwxf99nXxIxPgy
	H3fYmPwEFSgZwPreTt8y+vZk5IwzUQ0N/uuqmy5k4iKOrha8J+NYVjwg
X-Gm-Gg: AZFdTZfng+e/etO04HpXwl6n1XPBftQT27dP1QfUpGlpfN+pt0nwFwVOVmLj3QFEtuG
	UE1aGIN1Ri8s+9Nq8wEGAb041mmDyyGitWoQV6XOF+CCpl/8UoNuHGiukLn8fn6XbPfmc9L/qx2
	rOzSZfeNwoe0AAIVxO2CVCCJgBC2Dn8p36kxkNLPlM82Hi3zRM0EiAh6EnRHJDDqWiS7JL5oQwx
	kU6rt76KplEE3zjAOLVZjIFXEZ3SiONPCVtcdX5uEpW6xetgEtyhLsVmrTPnwUkeX/C2ncEux0o
	AmfX+SCMpStWX1MJkDTEDCzR94SY78JGULimaf9e9JJHTxJ9cCOYrN7RiZtcwdZ2PdI2Zzq7U/m
	xH6CVbHfTYEveRQAOxKqHcsBMmhtEV5JhfjnWTaSqwLjTufuylgyA/IZsH/4uo8hdlF8jSX8GW3
	xV+yja8+Scr5HkyLBhtU462rXJCXdYK9XnHA5LZfcyYir7X8NP124LxG7G5wupYutpvCTNqMxP1
	2E8uGYF45Ijys8lfYiTrQBg/ZgB07WHUbh726yGost5865JjQyggNJmnqV34LYC4y8BNrDIAKxG
	VlxJ20emWEsyCuK4n2RENU7FrPqKY6hiyT2EuZI0503qwFfI4kweL1zf/Hx74w==
X-Received: by 2002:a17:907:a890:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c513ab14a58mr450503366b.32.1795201187683;
        Fri, 20 Nov 2026 10:59:47 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:47 -0800 (PST)
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
Subject: [PATCH v3 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Fri, 20 Nov 2026 19:59:11 +0100
Message-ID: <20261120185915.150228-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120185915.150228-1-apokusinski01@gmail.com>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
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

