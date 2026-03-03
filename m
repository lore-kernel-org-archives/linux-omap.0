Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC41DF75A
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569827; cv=none; b=d28W6aqdlcp60D2QKAnzLv4s9cuB6/05I/21eWPh1kd5DkUYtxUJgeuZYB/cCz4iRPw5uF/JeY3Q7B6AOnuolLgit9W2mfFTQ9Mh+vWGoX43zRv0hhP3WtU0GjBY2Wx+5no7owfMm+4OMdH2s8CbTYL6abL/CCLuFrtrhSGknY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569827; c=relaxed/simple;
	bh=nHiuIbDROmtvh9nozT7ptkItgTF5ym9bQo4UDPhFaEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blsMQVZtFo4YwrVFTiRJo0SHm/CZZuHTF/p1vDw9kdt6Y1BVdlv4V8avl1a5auPFFChmINdA3FlLa488hHISOrQowUZriaFY4kBuU4/PYiMbn1uQwx30aU5RAkz5HmBzG6WO51l4+js4nTGwbB3rpil5tziV418ab95HZbwhG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwIXmlMj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwIXmlMj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3dfb3461so608842885a.3
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569825; x=1773174625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=th+RyWrkXmCwE35QEKh1O6v7tT5++z/rbMX9nQqTjtk=;
        b=RwIXmlMjNG/EBm5pcLpVQlO+Qcfs5zvo+V335sd36sBLQvlq1qQ2Kiq1yTcnjrjAYG
         UfwCj4lERLemj/L3sfzvtAz6IFav2ORWU9Dxp6x8Ejow4cVKmCmy5l3RZVAXZQf64eN7
         gp1ElBOpyOMnseVQZ7ftvtqQnJvnv34cx0giBMo97lbmFUIuDnBVKOAQ1ymKDnJfx9KV
         bONKWR/iStk1blnN8k4TDYFK9GESSD3hg8Y+rhd4js5e3btf+AJ3NVP7qQRi+5cHnMbl
         GTYPYl9SVArCCsPtpvPJdJaQqJpuvWMBNPA0BtwfznEFVC+Z6qwnXWtj6KaowycxOrp1
         +U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569825; x=1773174625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th+RyWrkXmCwE35QEKh1O6v7tT5++z/rbMX9nQqTjtk=;
        b=VkuMsb5P6Eq2DvkOEp4W2rnA2KvN4p3NAhgrEhc+/mBW0Xt4wCmd1CK0WICE+Jf+hO
         WKPsAYPXu7y4ffPGf8Y/FecUTmClRTg8AQbYml4gIuES3vRrYOxoA68P3ivACHNJW2gn
         4bEhqv26zq37Biu2Ud9HZNMr0e2wg/TSmqrMnqG+Ty1GzzkUCV3AMPL99NohfwEq7o9J
         GFyPp/8xCSwqC2o0VVjy4o5qV2oB2wAghvDMWvjqmVZlAt1WWBY5SI/oFh0pP22/Zj52
         TkHMTYErSvX8iZa262h5VyrgqOFHRXjSKrzK4m4I1LrA4PnhRwv4fS51xAlYrV8jAlYp
         yxFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0iYpAltTQnLP4ae7KYSPsC5g8fxZo2m6No0UoFlo17Nk+9o2oARADShmUeRdTBF0EdImIULoVxHxM@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZi8zhu4X3JGqohwP0vy3EnRnRFIVTND7NMIyWULAG37+I6Td
	s+x11rEXhWdA0m+SGhP9bXwgoXxSYtBHwGr4HcGbB5Ro3mIbnPNgPlID
X-Gm-Gg: ATEYQzxwbj80d8qRZr99EmeMuhsew6GzQKLxEHwSm8DOijlCPNXOgfMn5RuuCVpt/bM
	4YwlgiugnZ9fl79yqeyN98ynBb486dsXVZ6VsBGlTTpfn2BFW4eJBX5W/+P4/oeKU7aEnb49w1j
	7NDCPe8DbWLpqcBdRpAVuFawVjYu9pZ9sZ1h3JJuufdkWY9UJgk+OdneMGwt2f8KkWgxZaJA1qw
	fy6aA9PekYCKVf4kMMy2wGRhBdmVj4wK7tH9GmLb0Z9Xn0kLia1pMlcEZfTmSA/I6fovCNT1eU1
	cpFID9+bbJYVoW82DPWzKaPV7EOmfW0fiNvGnRW9Ik2j3jyh0/5eyNZCPqnT/NRX6DwXkkGoptk
	xYPUtmX2dKStqrfVeJLY12OeLMHYL8NruJX+3ydZjLV//rmZ6hTiymW8n27rxuS7X1bB1Y0x5sp
	nV1+a+IvWbVuieKMod9avflqb7AdifXQ90ZD+LSemgNU17SSR2QawbXYEjq5Q8ji1uBHqjVjMGD
	hFt5o8Rwwc=
X-Received: by 2002:a05:620a:318f:b0:8cb:66dc:9fcd with SMTP id af79cd13be357-8cbc8e0f8c5mr1873153085a.56.1772569824958;
        Tue, 03 Mar 2026 12:30:24 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:24 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	andreas@kemnade.info,
	conor+dt@kernel.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	jesszhan0024@gmail.com,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de,
	andrzej.hajda@intel.com,
	bavishimithil@gmail.com
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v9 0/8] Initial support for Samsung Galaxy Tab 2 series
Date: Tue,  3 Mar 2026 15:30:09 -0500
Message-ID: <20260303203017.511-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for the Samsung Galaxy Tab 2
(samsung-espresso7/10) series of devices. It adds support for 6 variants
(P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
based on 3G and WiFi, but since they use different panel, touch
controllers, batteries, I decided to categorise them based on screen
size as espresso7 and espresso10.

It adds basic functionality for both the models including panel, drm,
sdcard, touchscreen, mmc, wifi, bluetooth, keys, battery, fuel gauge,
pmic, sensors.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changes in v9
- Removed stray |
- Rebased on latest commit
- Removed duplicate touchscreen parameters
- Link to v8: https://lore.kernel.org/linux-omap/20260223134941.427-1-bavishimithil@gmail.com/
Changes in v8
- Remove WAKEUP_EN from omap4_pmx_wkup
- Link to v7: https://lore.kernel.org/linux-omap/20260223055113.1288-1-bavishimithil@gmail.com/ 
Changes in v7
- Removed prox_irq
- Changed commit message
- Link to v6: https://lore.kernel.org/linux-omap/20260219210408.5451-1-bavishimithil@gmail.com/
Changes in v6
- Remove references to WAKEUP_EN (drivers dont support interrupts-extended)
- Remove gp2a_irq, it was for bh1721fvc not gp2a
- Remove mount-matrix
- Link to v5: https://lore.kernel.org/linux-omap/20260129054709.3878-1-bavishimithil@gmail.com/
Changes in v5
- Commit message length < 75
- Squash commits
- Link to v4: https://lore.kernel.org/linux-omap/20260119033035.57538-1-bavishimithil@gmail.com/
Changes in v4
- Fixed syntax in doestek vendor
- Changed - to _ in node names
- Removed address/size-cells in chosen
- Added pinmux for i2c-gpio5,6,7, irled
- Allow sdcard to poweroff (reg_espresso_external)
- Changed power to key-power
- Order alphabetically in omap4_pmx_wkup and omap4_pmx_core
- Use generic node names
- Added TODO for future nodes
- Fix touchscreen values in espresso7 and espresso10
- Add dts to Makefile
- Commit message length under 75
- Link to v3: https://lore.kernel.org/linux-omap/20241108200440.7562-1-bavishimithil@gmail.com/
Changes in v3
- Use device tree from the correct branch
- Fix commit subjects to matching the subsystem
- Add Doestek vendor
- Add compatible for LVDS encoder
- Add compatibles for 7 and 10 inch panels
- Clean up device tree using "make CHECK_DTBS=y"
- Link to v2: https://lore.kernel.org/all/20241030211215.347710-1-bavishimithil@gmail.com/
Changes in v2
- Fix node names in common dtsi to have - instead of _
- Removed import for twl6030.dtsi
- Edited dts to completely use twl6032 nodes
- Fixed typo ldosb -> ldousb
- Link to v1: https://lore.kernel.org/all/20241030194136.297648-1-bavishimithil@gmail.com/
--

Mithil Bavishi (8):
  ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
  dt-bindings: vendor-prefixes: Add Doestek
  dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
  dt-bindings: display: panel-lvds: Add compatibles for Samsung
    LTN070NL01 and LTN101AL03 panels
  ARM: dts: ti: omap: espresso-common: Add common device tree for
    Samsung Galaxy Tab 2 series
  dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
  ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy
    Tab 2 7.0
  ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy
    Tab 2 10.1

 .../devicetree/bindings/arm/ti/omap.yaml      |   2 +
 .../bindings/display/bridge/lvds-codec.yaml   |   1 +
 .../bindings/display/panel/panel-lvds.yaml    |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/ti/omap/Makefile            |   2 +
 .../omap/omap4-samsung-espresso-common.dtsi   | 744 ++++++++++++++++++
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 101 +++
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |  70 ++
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |  77 ++
 9 files changed, 1003 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

-- 
2.43.0

