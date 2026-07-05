Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8718859B
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238320; cv=none; b=usML83IuHC6OkjaNQK3HHCoZOFDrdo0lQoHmZ9LQLgTwtD5RiiET5dr9ed6pEZUVGvdUgVK7MUwpB8UnGiqgUCcwrUyXfdsBON2AtgycCmDtHYuUQftUo5BVO9zg+E53uDbmF1s3vNkPDYiRKhXmZwrLeZe7GPE3CIyrbU1AI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238320; c=relaxed/simple;
	bh=Gd6MlDdTQsHXKAXfnYEwmqafYU5uT6MkwvCo5cd4Z9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rxx/jdfz/emjkHdNyzTi3ek53cT4bnztI/AQsV6Di9mTXFTpaDtjAwSBpx/+3WmQydb7Rsazk4psW2Dil6jYYgzXq6yidM/urGXaDHI5Cks2E9VifIYG+yG1dZ3AkTeE5RuYmhzEJv3xSafqV2L+X/nl+wLYrtF03+HGDkcD/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrHF7ezA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrHF7ezA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d3135f62so3693795e9.2
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783238316; x=1783843116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHxxISw9/eUoh0glcJjvTPDJ3DTP4w24ytxN3iIm2gE=;
        b=QrHF7ezA6qaAE+sQV9O+OXZe2PHBsV8mFHQxxSYejLdc2j9ic+aqC2En84lWgmSmiL
         GpWHx1kNUTfTIU1ZHvmUkfRsH3jih36bSBwDaqES+R9bvkHKp1bcQy6uHjs2jDWIqCJJ
         BHQZuOOVXV14oGCr4hec+7efU5JbrOTKJgSvIwZ5JkKfGbld9k6c4PqcRQ7O5T94C7TU
         IVH/bT/+/AvjZLQHZMvIP3hEPO3r7tVLkw5we659eD6joGBNiqpkYPkuo0vIEX8VU7Qj
         ZEv6Klk9FVbwboCw4EJckoUGTB3lB94Q0LYvrDbrdlfYEgIzcvVvoxJ55+zxZCVDTsK1
         EdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238316; x=1783843116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHxxISw9/eUoh0glcJjvTPDJ3DTP4w24ytxN3iIm2gE=;
        b=Tjw3nvoUIGu0IH/6sjR8v4A4iIuutaAjuO3rxHsANT8hlqCEmYAsB7Z2yy8IIetiAO
         CCKck3y8/KJe9uNsbv34QEfFGfIWQ9wRUP3Y90rxwuvCe8nnBhRavnKg6INUzWNNhDcI
         zSjdvg5bAkCfX5TgsXqPk2VsFebWQ5lIHYNrT9Kw9+6Qnztsv4PsIgXC5RbhjOZum1T8
         VY/JSeTA5C6TDxpiOMAFXA4sT33/vYtuTxbGII5lJkhEMK8DfOi8JVokpBvl0hZGR2Gd
         +yk/VeKZZ3MszQhzqNq/fwOId2Z5JIyNB5X3lFEOiB2ewnsfEpmJy9l5VYxf7s/XCY7s
         0erQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cDZNlEGAozPVVfFTF5djHci/p8JXYi72owCkJP9lNpnPcvWsN3ZW5pVwIOnKLvQgBCRWfBAEbz06s@vger.kernel.org
X-Gm-Message-State: AOJu0YyvftgnBWzwRKpIVQXEdfuQugIt7QQi0phV6jiNVEv3ptgezZ54
	FcA1ZDEKV2u/Je1hs+0X7HrSOve4+TQa4DtPfZLLzktFClzzwd9QMWry
X-Gm-Gg: AfdE7cmUiyim55N58iKyTFsSG2HDZNmQQVe1wv6Xb8zIunStYiOUI8UpH0OYayWDmKS
	GCOlRmTc2PXN7eO2HAn9LIJMTwmmOPGQ9F7E0r5AqoizLY3fhugsZr/7vlnBo3M0C0hyAJef5fK
	vUaq//PhYqy7jH6Zj8b/kk/uS41BILzS7QNDXXOXRKpFtSS2Lmne0uuUcFLrOvw3keVitjTc9uM
	9Pp7g9Y23iIkh45npMwr6diQ3IwKJQ5fzysiKxD+1gvy7mXb1mA9fX1J7HUYkfLFfiHRTAjM2+J
	5onz4sYOTlugIGVKqzmoD7Oa61t1ZYg3IYg12d99CWgNFP/heEWuYUZN6qJKwwbrkCnatBKm7mk
	73pdn6y135H/caV7qxqd8mzi616UdinlODOXGwUDl7YYKEohXg4brXpiG8aCdVr/99l/DHwCwLv
	SZGC7OzxatJL/x/V77U9yHoYQmuPjDewVG0w==
X-Received: by 2002:a05:600c:3551:b0:492:4714:2d7e with SMTP id 5b1f17b1804b1-493d11fe2f2mr68174165e9.36.1783238315894;
        Sun, 05 Jul 2026 00:58:35 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm305769765e9.15.2026.07.05.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 00:58:35 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2 0/5] phy: cpcap-usb: improve charger detection and export cable state
Date: Sun,  5 Jul 2026 10:58:04 +0300
Message-Id: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorola CPCAP USB PHY contains the hardware state machine used for
USB cable detection. Besides distinguishing USB peripheral and host
connections, it can also detect dedicated charging ports (DCP).

This series starts with a fix to prevent spurious SysRq events when
switching between USB and UART modes. It then adds DCP detection support
to the CPCAP USB PHY, updates the Device Tree binding and corresponding
mapphone Device Tree to use the charger detection interrupt, and finally
exports the detected cable state through the Extcon framework.

The existing driver already interprets the CPCAP USB detection state
machine to determine the attached cable type. This series extends that
logic to distinguish DCP connections and exposes the detected cable state
through Extcon using a standard kernel interface. It also makes the idle
UART mode optional, allowing the PHY to remain in its default USB
detection configuration unless UART support is explicitly requested.

The series has been tested on Motorola Droid 4 hardware.

Changes in v2:
- add chrg_det interrupt instead of replacing se1
- Fix remove() race by cancelling detect_work before hardware teardown
- Restore SysRq state on all error paths
- Introduce CPCAP_UNKNOWN initial mode
- Snapshot enable_uart module parameter

Ivaylo Dimitrov (5):
  phy: cpcap-usb: Prevent line glitches from triggering sysrq
  dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
  ARM: dts: ti: cpcap-mapphone: use charger detection interrupt for
    CPCAP USB PHY
  phy: cpcap-usb: add DCP detection and make UART idle mode optional
  phy: cpcap-usb: add extcon support

 .../bindings/phy/motorola,cpcap-usb-phy.yaml  |   6 +-
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |   6 +-
 drivers/phy/motorola/phy-cpcap-usb.c          | 334 +++++++++++++++---
 3 files changed, 290 insertions(+), 56 deletions(-)

-- 
2.39.5

