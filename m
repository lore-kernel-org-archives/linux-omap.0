Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C20329E4D
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541826; cv=none; b=G8XeMirIsdOAdgBFZM2jAC+78cRuZjtf5Dgh+G0ePmC8iYa6e79mztkkWmjdHAPmJjuEA1FrMAUqz6kBJP5jv+95JT4p7UUoVJqPCgKNGUmXscbXlBEzpUYkiE0lb1l4Ml1F8bmDEtlVB9+nLJ8XS1Q4c+WhnYAsF7ZDc7TJpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541826; c=relaxed/simple;
	bh=mpJry5/Zhp349aXY4Z+Qf4qWE6oGnFoIFcFr+KEvUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlCkTWxMBe1SwOXuB2Iby8XdWBlJ1QgfyWzAYfIa8wsvnZOxlzndRdwpFXW2ad+3KiE2BN7+YTX/NCHXt8LLcZlDfeO2Y3BLDqq7sXCTyv0H6EOuWA1NRf2g/QCCanG0S+aOqTLU/RD2HuR6rkYetyDL0eY6fC3QTgjkgKdobSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcdRalKL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcdRalKL"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8947e6ffd20so16029596d6.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 14:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771541824; x=1772146624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9I+l8JKaYFDa++mBuTeNScEkxOOej9+crJSALb0DLU=;
        b=CcdRalKLRMwm+CrinLu0vtp5rYtJiPUE93TVSPYWEiiYesZkbLJQX1ZLvgFoKRA/fm
         R+ZEGE8ZcLnmeoLkn3CPSGFdSwoRWbo+KEHzLY49IWrGPl/+SNNAehocXVmcdrZifMEE
         1LcSSSMq+FhoLmQ8bsF7rPAxCyCZKK2vXv564hOe4INdF+2+cu1mbGv7Iex+EQrgqSJY
         Hm8iKGQGV336fSiWqsEtnmXIyHD5wwc4tht0GACxK2RQoDAPaAQJBeCrq61KOhGdtB/N
         Xw9ZVp89dVbZTrHOq93D2rwRhCkrlKm0XO7VHB36N9XivvtTQYIWEh7HKLrYN/MsUGuF
         5ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771541824; x=1772146624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9I+l8JKaYFDa++mBuTeNScEkxOOej9+crJSALb0DLU=;
        b=jznlqifywIQ3kzlOTnc9CiuS1y69Yj6mXYgX6pGUKbGdemvU/rTV09JSN3z55rw4O0
         Q4Eh56/RbpgYTYtFXxO6aKDFqtVb3jgnDH0M41hZpgp12iuQ+gm05N4IbYRUP6fF4lAh
         JAUZyqnwEfEEo6iO+1Ju6e6OuZkVNUdj7EfOy0G01VCo4FrxouVbgy09AKul1975majL
         B2+nVbP2A9zMkJdYsoP69WDvF2ng1wYnkiVISpo5rxGVPu5RrdO3S3po7gZ7JZp6npK8
         LPyOsaFQTmZWHeXP6OnSbVpwCYQXC6S9eQp1xcgX4RBFzbExD1xciPmkcqivhEiSSVY8
         X13g==
X-Forwarded-Encrypted: i=1; AJvYcCWRpxgbfPExmPC8yJkR/r7+cm4hBczFx+CXspFhkgoqjcdZyME35tB4E7RlhDW2BZ8vRtNg2A0rB5wX@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVTm/ccbdvRAHwvlCTgtS+vUvjCL98eTcTmSVa8HKgcSOuxlc
	bDRqkrznN0DRV+j44lZ6x8ZHgXBF6u6k7pmaFQXT08iZAPwqbB9ON4G0
X-Gm-Gg: AZuq6aKutPGu3jQEVeizvLnM9Ag+TXb2ZMHC8qJtyVZIlBCCoZEl2EnvCucXqbJM558
	7thrKcDCAk4gJrF3qBcOrpLP8F3+hHkdFZzEr1iAmRKQSlIK1tet96MUcrXRVYChl/A3hUQvJzA
	+NBlFX/5OD14WGqKG0KeM/ZNoiwgAtZBtU+E2Edtgiwf0lLl0amtvqayxs7cQ8BnaUCYxHEvro6
	aCoOdVj2ceSuH9mB8l/htpWBhx2X4XCiSD1ZlK3953jUG7pq69Kyuh1yrMa10boor7obv5qos0+
	RvqN7EmrXE8xzlfDSKvRrqL4uYvjzFf+euPUYt6+HIYE79HkvDuQYPrqtzKY1EYNp+Y/+PkL7S8
	aLyIn8YoqcRadx9hY1czyKaTuQGtwuLr0GHtFXp+r1GOXNagOn6pZ3lUV6PzwecyqqvrMBrDMKB
	RWAlmMC4os4iq8XwvC2luxfW0S2sAk4lZgBozyebLKzA3As5t/rZfv3eVuwa1QFz9sxGIjwUc0C
	NpGQNWk/Rk=
X-Received: by 2002:a05:622a:14c7:b0:4f1:ddda:9a26 with SMTP id d75a77b69052e-506a82b7bb7mr246585801cf.35.1771535055304;
        Thu, 19 Feb 2026 13:04:15 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:14 -0800 (PST)
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
Subject: [PATCH v6 0/8] Initial support for Samsung Galaxy Tab 2 series
Date: Thu, 19 Feb 2026 16:03:59 -0500
Message-ID: <20260219210408.5451-1-bavishimithil@gmail.com>
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
 .../omap/omap4-samsung-espresso-common.dtsi   | 753 ++++++++++++++++++
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 +++
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |  70 ++
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |  77 ++
 9 files changed, 1015 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

-- 
2.43.0

