Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909235;
	b=Pkzo1Q1PRwYmPFemZzmcxHJvsDXKQPAQpaKQW23eua8/w5MIGgtgYs2Lwh9Y9gShPDbb
	 y8xnsSnh7QtSTp5wWwSLg2D8hdJgV1NG4saKbkk6eXJr29I7Y94igOtJhjIy06r20QpBz
	 465iBw3p/0taTbxgzqEs0rGs+jWV3tRSmBwculr4CGd2JOw3GJLGCJKcDJR5gepruOtCu
	 362kW9opvxzCTAOzo3u+O2cLVbz+0041GNYoOqD/+igq6lmO8+G3yQjdOfusjqSpepSsU
	 QuNRhA6ovpEZlZVyqYDFflpUQOL/rxWThmPEyYuzd4t+1k6o4POdHxwnh4rZHFP5P0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
	b=tbiI2bGR6GVuq6SP+bKa24aK85cQoEHZ76htV1Si4VvTJ7VQzhIY8dXyRjzFlUq1jFws
	 XS6TALaEvMIFfeIk+ZP7F+vNZyYDFAuLVo0UP1iQJ6km5fwFZFSoyr1b8/1+TnzjpiPH0
	 zW3ex2UDFXUxvKg4ta5HyAa5NoZTkJbvk2LZfmzy3YQXNs2sJY/L8GtWNlE6YrE2meOqy
	 zwBk5gOm4MsDQkXXoKzVnIxkjJttJ6C6cCD/qxVKSzoCengL3Pu6sa5Woz+fl3xdEFLt7
	 V7+8780YKQUnS4agOefJ+sKoj1N+GAdAPTem0u3/HIDMdRauCn2tKzAnchjunpdwlgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NdL4j/Sf";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CA606D815
	for <linux-omap@vger.kernel.org>; Thu,  5 Nov 2026 20:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7CA606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NdL4j/Sf
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so14373795e9.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2026 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909233; x=1794514033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
        b=NdL4j/Sf2euHzhcOElIVGfgvu2LhDvenH5bjqq2qaHGaLaIrdyqsOm9TpNX6ft8WhM
         8NKw4opLm/USQ/0OAmiYO/NLb42AVD0JtX68uwzpOHYajR8dsA3ekVp/nvz2T+mFA+Q+
         EoQzAuYrldZcrCCfET5NNuGy3OQ2/6TjKivZN5TAdW7jsmy1T1OQnWV1y7wTr59/qosA
         I8syR2ByaOSihh+UAI31e5TJPH58LGuTTt+qckBr1oAntXuGGIGWmYSPzdkGui4QHCFf
         a1G4ifcX9f0eILhcRlA/hA5aE9cn18E/zl3GBXib0bSdw0fw2XZQVPSa3AYLsKr1xHsK
         Yknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909233; x=1794514033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
        b=AWr79lTX7FA4PghlXVb7DkIDO/fCoiBac7xXWGK6d8sD8eRLdUdgyz2i7HzEoF9mhO
         01KmqmqcqO6QuoOnBrYQC1wM7o5PMR9/khVMujYn+PyAoO7FaLFoW3MPwkSjy2DHXR7g
         wRp3/R5ZbYABkUOO7XSzxEyWuhiISAJQaVkjJus/ZYSGmluVqjIZiT7e9+9n5QCzeeM/
         x5vtJqV+q2SSMq++CufMTRLFL05BoT5SEng0wMSgYevOKnCLD9tGt0FiKW27DqPbcop4
         uJ5dPjCEnBAWe06y0Bbvly7krSaFjnmUys+KYzwP+V/WXpXRGNlMrbRdB2stevYAKIig
         GtRQ==
X-Gm-Message-State: APuU4Z+FI9+csuboZcRN753rKSCZW3AJeIVRkBL5vKPID/BsfkOFxqc9
	A8pMTzobAG5hZ85Keg109JO1yu8JR07lw+3tcRY0Xuca8SYn4cm90/NG
X-Gm-Gg: AYBFou0hiV6VwA41N60vHUysXi0CPrQeg0JG+k5VwH5Sm/UrEMgV1ZEGiJDBYs2r5Hb
	FNqOh3fU/NIJamvye3mE4U37jkcg6x2nUiJAU2H4Zf90FSlIQbAZqlvvkmFkgSFBEKTOXHt7AxB
	uHyj1N/YUQ1f7Ksm3HPE16/y9tgATfcyowzCfQMkplxdAcUihWPlBBJ1hgf4cECF0maF+Q8gvky
	3pPtcATODw5PffZ2tShwXpRLdvOBHcyRwwVOPCmqM+3P6LiQLMnKLW+Mrl761b1MAF2fxjn417p
	r1uHlZScSdIZsc11FGp1650zsIiRIOci1s39SNj3cdvjutacx6GPvv/a+U/B9paDno0U+sTBCRc
	dmuGSxk82PVfyiaprWm9tle5aYPoWG4tNTRZ94pI5kFSEZUbkZdVlfPcFxzUR4q2BgVQVgKw/ac
	g8sWknfXYXOyhN9sWbg+xNOfL57O2Ouj/y7RG8DCPocWZI3Uh8Gz620zPGm2Dm8kl1Uui32eCgH
	B4T/YbOo5aq0BYRwkjA4mwhWhTh37NW4a4Vt2bCVUSMuiVtHKcPPazt1RPevrNKqZC+hMKQyTFf
	Vn8kUyMV5RqZze+IZBQjLSZOPjCf3d2neS3cBcn1HGUu0pzD4tOZ9/bHRaU=
X-Received: by 2002:a05:600c:1d26:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4b6dff86444mr3062505e9.34.1793909232668;
        Thu, 05 Nov 2026 12:07:12 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:12 -0800 (PST)
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
Subject: [PATCH 0/3] i2c: omap: add support for DMA
Date: Thu,  5 Nov 2026 21:05:51 +0100
Message-ID: <20261105200556.34240-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hello,
This patchset introduces support for the TX & RX DMA transfers in the
am335x/omap I2C controller. I tested this implementation on AM335x 
(Beaglebone Black) and things seem to work fine.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (3):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 291 +++++++++++++++++-
 3 files changed, 303 insertions(+), 4 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

