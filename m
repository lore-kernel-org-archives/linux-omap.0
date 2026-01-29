Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60131ED6B
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672983; cv=none; b=TPtBVVtKR5/2l0yxAWOaixJfnALQok5V36Lo5bCJIXeRdJf+jOT1B4ARjxgo2BXEEBao/uRqo0VgT9XkNAqZJX5OmVJOYtIN2mVKdS0eAPAXnQnqTYYjkO8i2teYQXSP0JCEw2KQpV18huHX20e3ktZB/UciEdhKXPwUH8mARds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672983; c=relaxed/simple;
	bh=tiDKCQasqj5b/+PbBSiZ7+LhhpTaudNsP3Y109mLQ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOUeU8DL2T3oNMr3V8TJvV4qB709R+/lRTNhJE7KjluVER1sAoAuujjQNmypC7z8VnJN1VhNOUA4GQu2blZq2/Qe1Wmf7RagrlM4pUJLzW3dpS00nvSO8+kH7LATe22RxTUSiluZCy/ToQzIDe35luxWmlhyAJdeI2263Fwc4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdLsrlU/; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdLsrlU/"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b740872a01so292520eec.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 23:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769672981; x=1770277781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucryCuFvG8BETVJFMHSqACBtDXZ973dX+aGPcHODNIM=;
        b=AdLsrlU/GbvNVMzsU/U3QgBUe03xYwnfIrwaTZyeqcFuyIQHdj+A4NXPAlL5qeqjd9
         fq1ejfd0xzZvkK5OmjY2qRXfSZh7FTsCJcl0Gpnn/39iTzoBgk06kpejQQjqP0fq1Q5J
         lYBxw69lxX5RZ6RjUzwiBnUsQxM5LuSgNwm9apM8BGLbIr7p0w64hVgDPj0cSMUT6Lpn
         +UdQEvPRZETkPZIYNnNugtv3wucTvUk5cnqeoT9z4r4lfm9iOQ0FPqJ5g4TlBWKn+CYW
         VUDRZ3UU84gN40Q3TPYQrrw0QZJhKNSO4YXHnvrZn16sOPgAZzB9mDNIhs2W6ANl+EvY
         salA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769672981; x=1770277781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucryCuFvG8BETVJFMHSqACBtDXZ973dX+aGPcHODNIM=;
        b=hN8JPAGldKERU/6CGTZKnm/GLmPOoZPYFBPfSUE4yGotISA2PPe9b8MQQPsXKwPRie
         3vknBv+E1B421oOI8OZZU2Ev5XE90aqXpGBv+v6I8JHXWPcn6MYH6Wkyg4OUe4AxRlRY
         JGPWG78Jr8zLN//Q+i8XX7t101OewFB4coVfke9EGoLUIkl8vSzoRgV1z8DI9+/fhQ0m
         CyrmQeySvTZM/RSBVS37FaiZiITBgn7NyR4tANc9si2hbRjuvTdRMZoSXuCRGiZlqlBd
         xo6gI7LT/UZ8c9Ej8MPN3QF6v/wjmqa2IwaBb//Dgb0ojLCg/Em2DAWTI9j/k0WijhYD
         3PNw==
X-Forwarded-Encrypted: i=1; AJvYcCXq/txrgEPbGbv+6fi0vb1OJtszDxFOO6JOzjiXFuUfd8/CuMaCxT9mytjx9L7k7KIoSIRE+IiBGNjG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0ZvtqiUvtigcSj7tcGIoWI51WK09JzD99Rg0gq4KPhD+2k1A
	0KwrzPqfeKC0yEwvp4Ns9vPkmUvRhwdn/eBINnk6RzppQpyKmwkhY13d0OUBhA==
X-Gm-Gg: AZuq6aJ652E2ykWL5K34x/nrtwDErUj5+8j6nNjcETstkvbC8uKzcy3SQiA2PeuG5fr
	noBKND9RH9UKIJORv/dw1vwrF9BUoKJbmYPEhKCdKA5enK7VV/PIigBbT8gtSD8BETUAqe6UW98
	kqQFuoBoOwL4nOpHnShAqFMI4PMyFg8won4N1HYs/ome8vy3iQoLvC7D6LssCKtvLvArkQ0wujU
	rbu8yRZEyHYM8MhiLi6xrXNI5yhN3r6m8dxH2mQEzMcHr3zPcZpgjcDvA7iZvYfJN9w8fBwZ8ax
	HOsOIygAPeQ2DpvQpmUOgzVtsWTWUwN0I+ABDFT6lLn2rtv5w2vGgKz9oHVsCrvZjMwp2QDNyT4
	4i5zXMzEU/eb6Bbu6ezObAhCzoErL9o09qmJHAi0uIWe3hif8QQUuFYqA0lD9+05n/cJV52d3bm
	9M6hjO3vFJUz2jB3mwOQlF6D2Eq4qS+QAOaqzlQ70vt38cil0pM5WUihOEd3FfUgr75QmGbTg=
X-Received: by 2002:a05:620a:bc3:b0:8c6:af59:5e1b with SMTP id af79cd13be357-8c70b926324mr972584385a.77.1769665652113;
        Wed, 28 Jan 2026 21:47:32 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:31 -0800 (PST)
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
Subject: [PATCH v5 0/8] Initial support for Samsung Galaxy Tab 2 series
Date: Thu, 29 Jan 2026 00:47:01 -0500
Message-ID: <20260129054709.3878-1-bavishimithil@gmail.com>
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
 .../omap/omap4-samsung-espresso-common.dtsi   | 762 ++++++++++++++++++
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 +++
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |  70 ++
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |  77 ++
 9 files changed, 1024 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

-- 
2.43.0

