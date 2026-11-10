Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340385;
	b=uG332kxfWb67CQqZ2fZvB/BwMlBQdH96+ecc3pbyJKJ1hRtkopHCKlmn9j1NKzNAnyu2
	 GR6ZhHL8oTJu3uug5QivogjQcA8vXCB+qRJp5d+oFav127cXkgtf8RWvJJXrecuZ5RBt/
	 SSxrpcxVJQs3dNmrCSb/EzsHJnPy/3OqPRyX5paTRqQ9B2zgfZblvZXlFjpKUT/g482Dg
	 GUt1ynir9uoaFpQeK9tFLrUq9F+Mk1NN3ZaxiOJ9A90eimxIKOMUvWSytY5ZCFFLA8nDF
	 42QAvwK66uJ/7NZB29AZdkDBF1vw6d1m+RaH010jVmIhb9iTT3DioaX2njVeIDKaF0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pSRzgKFdhSIQOnswvBYG/q417XF3w0gkP44gTgkrKbo=;
	b=GFPTqdyfnKx4s2dlWZHYd2El3x/ZnyBEZfVJmrjTe88IbyS1KSwulRC6/ZblsLZvYe1X
	 KnibSkBeLHJnZHfZj1sJdlPldvdlwLdTQyGA8j33KlExZVGkponoELWortFQfj0/ujfUZ
	 AkERCuGUqPtVpTjY+DYmfwUUM/dFvhaLlXz6EDOXo8Z+Bqq0HxbPraD2jtDGXIQ+GCXlx
	 9KwF5SHblmUT5f8jtAHpev2BVoODHU2siT5VinN1kc3QegPQx+x7JKvk185imNd9rgTGP
	 XqbqjSqGYryYFH1HJ/Sch+tnP2gAVaaRFhHyUBELnAjP84CmwEGXyQ89sioTJaCy2KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fDVKvpLw;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA660A2606
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00FA660A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fDVKvpLw
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36d1b3b9974so217261eec.2
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794340384; x=1794945184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSRzgKFdhSIQOnswvBYG/q417XF3w0gkP44gTgkrKbo=;
        b=fDVKvpLwZtAwE0mpwItjhoI6qViFk+Y3n+QXg2xZ6GC1zOMNjgj6OvJwjO9m2LIGIB
         CYrc0d/taO7KEkcPBEaWt1imYx7Q+fFLH5BK8ajULilV84MpFVlmdI7zrhG/fvB4Sm3z
         T5f39ufBvYGLQ74ALGso8RP7d3bvfo+XtzudOHrWeTF/YzTcS93AqY/O0uzWxAz+SZCI
         goqDtOdDnTyn7QrBTbHM+N2FeueEFJXhlp5CYTDSytxIEoLA49RZZi0QumwSzMyKx7+J
         h4rj8ypjczkph7nuLemFL05NrYvyM644zkrU3fUOGBqSMd8OGQ6WWv31MJ8sR58Ef5tj
         yBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340384; x=1794945184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSRzgKFdhSIQOnswvBYG/q417XF3w0gkP44gTgkrKbo=;
        b=a/6PcSWCbYpA2UI6vFmKksxEd/uvnT2XHOrhqEA9ujW0eqkVTYe1p2AmdWkuPdTkp5
         VKszFpNzn00phnOQWH2l7QRmEcR+3W+CwMrVn5WIlkCw7SZ0y6D+l0jJnG2scp/GqQLJ
         cUE2IkHMmPdoZzNQ4ISJ3R3XDRh1zAabkRo0pQV9AdIV92njf1Lr+fMsf29dDn5QuoX+
         Obmg0Xq+PyOewvbnKP2sDmt39mDs/xUX9uk24Bmn70VQ/j+u5Q/b9fd4WLst0SVzqzjz
         bVY6vmiyg6NMQN9PNR1kHp977D5q9RjL5L4DIRSRCb/eyQZ+TPpEd5ywCk+1cBtvhdpv
         Ih0Q==
X-Forwarded-Encrypted: i=1; AL+hErFoI3JQm520ft5VugUoEvjvFBZtQqfzSwSYoi2uL6aAemqElhFTkD8iWTutE2J864jpvVs6kR8oTzAE@vger.kernel.org
X-Gm-Message-State: APuU4Z/yeaRku4zLhO81kSib64jhXlnnXSS1cAcZO8ljStxAik8X32o/
	S3N3SVipl1iAkRaSl/qLfPNR6LEdWB9OZBU2SjgpJmow7+PyZe6hxHoU
X-Gm-Gg: AYBFou2xBZQqmk0thpEH0/BJVi9uRkrtJZdIm/BBT+m5O6xl4MXePGHRr+9X3B3QIAh
	sgrQmuJMBncn8YNPBgrkvcWQq+0m2CkaEIxK1dvAHn1DCYebEdJfeWPTaRJOV329GQ/M39CfcxG
	gP5CF+ZyrbfplQgLdmCK7XOmAqbGklm+4l2BrRQNGG5E2FlgAxgIfiHhHAPOOfjDCqtcn98Lwnw
	rZL2mDbdzszy+3nu7Uy9k+u/pr0rrVbyPxaJsjBLWeB0BcTkZ88LWPHNOmC3t54QCFOQaNmQanR
	bpC14qkAO3WI7LTT4T9v/dypKjFiC8B0Nn9lJuFCcQ2JQzaOF+kAQd/l2Rshm1vU5yZUdDoUPMP
	GKd8KREtM61Sp4XGkhYfSxqIefVq5zfIzF6ZXXMEUPCWmSEtSdWHEyTUqlSrg3cEMqEnPrI/UfG
	GHEtS+WgkAtI9RSaiy61md4URy0sTVqX2+/uUEj4wxW6LLGtbeWMP9m211l0zR64w1HDjgYv1VU
	LnKTYZNjhW1HwM8wNnGvWc9vsITEq1PrUxCkm/ryPhImzKpw6RhEgxSnLGXidRZ12Rd7tBVj+6p
	+fwtSe1eLtXbC/IEGGckBF7Rh21zmj5ZBX7VgI6felzy430sAGLjqBhyMz+O
X-Received: by 2002:a05:693c:8113:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-37684ceea1emr616995eec.2.1794340383613;
        Tue, 10 Nov 2026 11:53:03 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881f:d9bc:11f3:620a:3333:518d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm8834225eec.11.2026.11.10.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:53:03 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 11 Nov 2026 01:22:34 +0530
Subject: [PATCH 4/7] dt-bindings: arm: omap: document missing OMAP3, AM35,
 and OMAP5 boards
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
Message-Id: <20261111-ti-omap-dts-fix-v1-4-19022d1ff4b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794340358; l=4346;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=qHEkUUAoB617xwq/cQFfugK+/I80z/YbgdFdobeassY=;
 b=gKWgWqO1KWiTlb7NXwfQgrBk8K0mYi3ZaFAh4n/F22I9WnCufA/3VBWx4XAw/r3IwZNZGhje6
 rBQ/0AQnU8uCUqrpbx96ots2p3Qwq9izV1onMXy+nxahadmq5o9cNKM
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Several in-tree OMAP3, AM3517, and OMAP5 devicetrees fail dtbs_check
root node validation because their compatible tuples are missing or
incomplete in omap.yaml.
- Add missing "ti,omap3" const to the Gumstix Overo block.
- Document the IGEP OMAP3630 boards.
- Document CompuLab (CM-T3530, CM-T3730, CM-T3517, CM-T54), TechNexion
  TAO3530 and Incostartec LILLY-A83X based platforms.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 56 +++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index e0af554388669..86c68f118c5a8 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -50,6 +50,24 @@ properties:
           - const: ti,omap3430
           - const: ti,omap3
 
+      - description: Compulab board variants based on TI OMAP3430
+        items:
+          - enum:
+              - compulab,omap3-sbc-t3530
+          - const: compulab,omap3-cm-t3530
+          - const: ti,omap3430
+          - const: ti,omap3
+
+      - description: TechNexion TAO3530 boards based on TI OMAP3430
+        items:
+          - enum:
+              - headacoustics,omap3-ha
+              - headacoustics,omap3-ha-lcd
+              - technexion,omap3-thunder
+          - const: technexion,omap3-tao3530
+          - const: ti,omap3430
+          - const: ti,omap3
+
       - description: Early BeagleBoard revisions A to B4 with a timer quirk
         items:
           - const: ti,omap3-beagle-ab4
@@ -72,6 +90,7 @@ properties:
           - enum:
               - ti,omap3430
               - ti,omap3630
+          - const: ti,omap3
 
       - description: TI OMAP3630 SoC based platforms
         items:
@@ -79,6 +98,10 @@ properties:
               - amazon,omap3-echo             # Amazon Echo (first generation)
               - compulab,omap3-cm-t3730
               - goldelico,gta04
+              - isee,omap3-igep0020
+              - isee,omap3-igep0020-rev-f
+              - isee,omap3-igep0030
+              - isee,omap3-igep0030-rev-g
               - lg,omap3-sniper               # LG Optimus Black
               - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom DM3730 SOM-LV Development Kit
               - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 Torpedo + Wireless Development Kit
@@ -91,16 +114,40 @@ properties:
           - const: ti,omap3630
           - const: ti,omap3
 
+      - description: Compulab board variants based on TI OMAP3630
+        items:
+          - enum:
+              - compulab,omap3-sbc-t3730
+          - const: compulab,omap3-cm-t3730
+          - const: ti,omap3630
+          - const: ti,omap3
+
+      - description: Incostartec board variants based on TI OMAP3630
+        items:
+          - enum:
+              - incostartec,omap3-lilly-dbb056
+          - const: incostartec,omap3-lilly-a83x
+          - const: ti,omap3630
+          - const: ti,omap3
+
       - description: TI AM35 SoC based platforms
         items:
           - enum:
-              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with CM-T3517
+              - compulab,omap3-cm-t3517
               - teejet,mt_ventoux
               - ti,am3517-craneboard     # TI AM3517 CraneBoard (TMDSEVM3517)
               - ti,am3517-evm            # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
           - const: ti,am3517
           - const: ti,omap3
 
+      - description: Compulab board variants based on TI AM35
+        items:
+          - enum:
+              - compulab,omap3-sbc-t3517
+          - const: compulab,omap3-cm-t3517
+          - const: ti,am3517
+          - const: ti,omap3
+
       - description: TI AM33 based platform
         items:
           - enum:
@@ -241,6 +288,13 @@ properties:
               - ti,omap5-uevm
           - const: ti,omap5
 
+      - description: Compulab board variants based on TI OMAP5
+        items:
+          - enum:
+              - compulab,omap5-sbc-t54
+          - const: compulab,omap5-cm-t54
+          - const: ti,omap5
+
 additionalProperties: true
 
 ...

-- 
2.56.0

