Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A3218EB1
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831787; cv=none; b=RU54tPo2trM7iNXtwZXRWvGovM5edsuzI/SUJ2bR/pTud4NYnR6PdVnSjQyWtMZbvDuQDddP1TBKgIW2AsLjp56erSkzVIt6sxAGjQBx3e/JOxSLo/ZMaJp4j+33w47K+wBQbJvfr4tJLQVN4+A2c9qEE9/C0Kwq1UsfdDZEjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831787; c=relaxed/simple;
	bh=Ba9zxackObDbMCZ2mlH57/NOBt3YGhnL48fUr0tnyrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIP9bZL9sK9bx0hAhbo1RFEOWbeLg3M1ng7ePuzQQ9nI5vYmdeabIUpQ7pNwlGm6qDJgJE2zXEpdN7s6hpaOcOtwC6/wPXGSuD11EFx4/nqN3BUfYpWgZg7eepj+pBvn7DHQGmjiKwHmYTfJC/q3CsBYDxaksTotY6D9U3qSfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl2Zddu7; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl2Zddu7"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463967f35d7so2525321b6e.1
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 23:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771831785; x=1772436585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJJXdok9+FUakR4+4YGKa7V5rpMzXNyNvVO7Mm3dh3s=;
        b=Zl2Zddu7AzVHxc5g4nJRZGiYqC37Ao3AQCKV7rAvUi9VJiEh9tMc3EWHS6iV9JfifB
         De7EE7YL4oJJyG90Cwo9RieygXEiF0M/RVDuboZ2evS1rIACdWwIgzJDvqQwXZxJy0do
         Ygz9SsJ8EoDYHYHqcuimGwba99Q+N2yb95LtDgFzcqqksz8NKyM3dr6/6CNhrmswKAH+
         oO5ZU9P4fZcYJ55o1QqyiAJoVLsBVggyyWS+i8bdMVB5ItGWhG6sdIAhhf+OfcbK8fZJ
         dCltT5/Dx6iBtjz5GBr1EGifS1yjmq9g1CNM2uUfr5rqpuPU55QJ5O/Boc+mYHoy9mKV
         4UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831785; x=1772436585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJJXdok9+FUakR4+4YGKa7V5rpMzXNyNvVO7Mm3dh3s=;
        b=rBGaWVAirzbvn06GQEhdzXyi+9Q9m6sg7Kcwga6WmwBozHOnmWhxNXAUHYofbgyvMH
         XmOUs/Wp4QeYn6sxtWFitT++yMh0EinL10OfgAtETZHsds7Fijm07Ox3ma9ku7n/mn/6
         XOwDu9GEZha/B6UpQMpwLw62bYGvsUNWc1iEUP+eUNiu5GNpxGywh28J5KbZseqC8lvx
         ZLgWMMVKQXr3cTFGS/zIlVHGjxF6gKyfQPSfSb2VJIMvpC81k4LJ6OOueaG2Gp7LXPca
         fo1aoQxGkygUYblCHpVvX3aUBezaXUiXnnoxtI2IdUo86ZHlT11e7SKqAYxROf8bg6cc
         MSPA==
X-Forwarded-Encrypted: i=1; AJvYcCU5VIZgS526oECCMJxvSxVnHEVROTJfLZ5WptSSDAHJU/UR5GOG1V8e29pmHXQrf119FgZYO1Poxxs4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqkhfx4wyq+QtVoL2AO4ULSgFENu3YL3AAUSGxlDYvJ7Llf5fu
	8J4JSDuaiH68OF8cJgRI6w4Yvy31QuQSMhhc6QK/39EFVYXF5ZlZs+dQwXqfChe9
X-Gm-Gg: AZuq6aI/viUnuoB5tLnnBCUwfGVAsKZux1KWdFsvmbISz72pPS4+F7pjZzbpTTowb+Y
	1Th18bcbbo0//FhnAme+u4fXXCxA3mfwoiVWOhsgxnp10aiBfDwOrGwaX/Vq2jDI9d2lz/Bg/Na
	MU/4YKBf8y4xILAcCYSiFJwchWapDtQ7YKD1coqA3oh1XisgTdnPYatv1RfSoi3cAVQjR7tFx6y
	d3f3Skj3isEiiQggvyGuuhshxw2VpIRtHQNQqie83HrqpyhdT2enXIdOI4qX3LxyVdNcjjXvVP5
	oi4XVgIHX6oMmfa/i3s5OGiMOUEUgksAKIMUXFO8T0lUo4tgQTYOYF+cmPw/FloT/kdPTgKBbLU
	nrrLbXbGukV9gmLxAsYHKFhG6K06VGbZCeNwKykuqtN82zNb+Gzq9xOF23gfSNDwBcy8oPhdfna
	po0qkgC6kjh0nLN+a7NEQDr7fqndlPT4AfKuU17/1CXrfMpXU1WuGIw6TUOvTFCPtc6mq8kkrrW
	0LOhuKfmpo=
X-Received: by 2002:a05:6214:400c:b0:882:4be6:9ab9 with SMTP id 6a1803df08f44-89979f3491amr98922476d6.54.1771825877439;
        Sun, 22 Feb 2026 21:51:17 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:17 -0800 (PST)
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
Subject: [PATCH v7 0/8] Initial support for Samsung Galaxy Tab 2 series
Date: Mon, 23 Feb 2026 00:51:05 -0500
Message-ID: <20260223055113.1288-1-bavishimithil@gmail.com>
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
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 +++
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |  70 ++
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |  77 ++
 9 files changed, 1006 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

-- 
2.43.0

