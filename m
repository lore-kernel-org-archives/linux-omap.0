Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E13644A1
	for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632908; cv=none; b=u2M17YJxZfvVsH7mNBTzjPIUT8PzWmchIlPEoOTdA08nfeb2SU0BOkUkJTUvVhNR0iqeJbVrVa04x0ggCS2L1OJmKJDx6FxoOpU6fpBoZ57wDhd/af2Z0gEaHS4ckxkcwjLCWrb6KTj6rLHMZOli1zxepCd543I2ylpdcC7NRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632908; c=relaxed/simple;
	bh=LjMm0PBKh/Bx+amzkvhuyIeZuvgi3gtmnabaArRttWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWwnOHrh7hPdrGtmRNb2sP4P/rZXATSMRF64i2KO9GHg419lJF5T28cbim5oOGPfjSBh1FmmPGisJHca5p6ZPuJkHaRqNg8ggEtemeekXFXPk+lUKNQmh/ZAA0Ihb9XU+mVsPebvM0tjQvHhqPz8FKllaHoQbXmwOu7QsKASeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuiw0QoH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuiw0QoH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954aff6088so26160545e9.3
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2026 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632905; x=1785237705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2+LKseJXzKxktbUWoc1WNBTZXl1F3xYy2w48c5tdQY=;
        b=kuiw0QoHi8Zx+wZjfBeqtNiwArvcCHxpM/BijsuDWkLzdkpqLsQxbrsG8rGlqhKTmK
         qkxxN4PXkd6GLz23JPBxmsmaDoFIUHsmndpfnTvgY/wTS+FA8XAWz3q6GylsEVvS75hc
         pvw7VpJ0Jz7rTwX05aU8SpA+pVLackhWi81/I69irt/rglgkeBYzSjsAtLwDa20lIZib
         48RvdYeZX4Cw2ZJNR5h9qQLHLAwt8ryixzfmO259CNHXF3XD5F1EgHQcQ4V5GT2cDso9
         IdGBiTNP0xavNjIRfV/uTBPz7k1lpXMe35NbjL3wSw9ODGLSHSHivyNa9AmZ5b67e4IF
         ShEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632905; x=1785237705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2+LKseJXzKxktbUWoc1WNBTZXl1F3xYy2w48c5tdQY=;
        b=LB+qaEIqP81aib47M0lcBMGk8JDnLOXLGaTCq4THsbieZ9n7dVszwKO5Rskxl6EpdI
         46UuLiUaClv3vNZ1kAXta5r8jfNZboG4Wlh6gTwgDO5IqawVNhfz7LYPzX4qPgNDzgaO
         kJuvrB0nocqbp+5RrjQYD5wBtxbFFGEbQeQYH86bPIDbmfDJWsTRx0eg63XgYcUugcK3
         3xZ2cccYn1rP0Kn+ih/xJSbni0goesfwegDXr+eRss4lsVVok3akIbkcchhc+W2w1wnN
         qXhXgTLy5+1F2rQvBuacI89v0e/fb6SXYqRUXUfyTxeEOtxYl7X8BRQ8AVsI6fAiNF2n
         SL6g==
X-Forwarded-Encrypted: i=1; AHgh+RonnawZu7pdgYzMUyxmjpvP9hHinAzxz0q+9rUjTIImXayoJELMs2+Oytj4M//nm0qc23yes+zWNgjN@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvOTK+0wIcaA+5f0ijqCds30jL0hINmDfDXiLVV4NUFJxPklv
	QmL1nJxLy9Nw5xWfklofTwl8+VrHLLDvgV2QfFlY5TBsIz7B9utBL8ob
X-Gm-Gg: AfdE7cm0FKt3+putEABND4cztz08+oBd4Fct0qW8Z+iBOII1foFNv4LdZm18wiGuxZN
	7r5s7A+XhwPexhp75ECiZy6PJT7UqB7n5qdELLK6zMidSUDLTbfmKQeX6rAiBHYfJN+jyO1LskN
	71iDf2JHEFx19SHFZyp/h0tjaTD/A1577hHh24fJegEhbeiSOUx9zVl6XINKCBgRJgbIh36fZN/
	+z/lvllBdXSg3WLPAauOJE+711wEUEYGkOE9++VvwcfyVLaJfVls/4VbsmKBCfwpw+lUswhUSPn
	qDvv333SltIjcvsfaCmjyenTYcJT5wDg7+7TQlVvg465ZRuIOWsloPUTaWJgF2zxxMnyv1Mu56Q
	aBbr5W9f7PpLWxzqWkEGC6BYh0AlCSFpluNLVxIW6UvKTW52AGvV1FtbrsNIkKIxUfhgGItWgG6
	osIvyfM4yyiAuoU5eRv6WbS1g2AlUdETOlvuv/uGhpGfzP
X-Received: by 2002:a05:600c:4504:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-4954a3d09c8mr194922355e9.3.1784632904451;
        Tue, 21 Jul 2026 04:21:44 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:21:43 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v3 0/4] dt-bindings: Convert TI TPS65217 to DT schema
Date: Tue, 21 Jul 2026 11:21:24 +0000
Message-ID: <20260721112133.70382-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Texas Instruments TPS65217 PMIC bindings to DT
schema.

Changes in v3:
- Added 'unevaluatedProperties' to the 'charger' and 'pwrbutton' nodes.
- Renamed the example node to 'pmic@24' and added the rest of the
  properties and nodes to it.
- Dropped 'regulator-compatible' from the schema. The property is
  deprecated, so the regulator nodes are now named after the strings the
  driver matches on and the DTS is updated accordingly.

Link to v2:
https://lore.kernel.org/all/20260718215632.3295049-1-egbostina@gmail.com/

Eduard Bostina (4):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  ARM: dts: Rename the TPS65217 regulator nodes
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 +++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 ----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  |  14 +-
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |  17 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  14 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      |  31 +---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     |  14 +-
 arch/arm/boot/dts/tps65217.dtsi               |  31 +---
 13 files changed, 275 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

-- 
2.43.0

