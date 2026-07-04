Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450E1A0B0E
	for <linux-omap@vger.kernel.org>; Sat,  4 Jul 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150768; cv=none; b=tWe6oc5ov5YgnSodvhh1rz1ZJUmW5T+GWl6WhB2fuHz5GKyjaXme6eB7q9BGSFB/Rcjxjd7P5FSTMB76wyTjJJRYQ++lScRrMgPljwAcqCBiZkDL7Y84x+4w5cAdG89zKZDmGlOfALMHZ2XUo6oxckkAG7JTUoVz9V0kRfZFagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150768; c=relaxed/simple;
	bh=Vjk92yj5SDGwYHyFOT9M2fcaGNwel5+hRD7zUCCZF0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKEXNhnv+OH61So5Q6Yd36r6KbiJQYuEpHkfPK1pd2+V8J4KU7EE24bNkVcEsjWD4DaLZgQ7op5zpitxilUrXq5sRj/eMPtlKu4FgpygC/Mk45OchGUBXmtVfgikuROGaw3e44ge3m5N39bA/kH6nQx5bM0TAKHajWcUIvu8nDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErK/Q5cD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErK/Q5cD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso4667735e9.1
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2026 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783150755; x=1783755555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVufXZv3C9nTTbjjeAadD32Z+/uBgkpYSXQtGIeK46U=;
        b=ErK/Q5cDjePjjQ+3jJbWHqKVm2FdbCH8kCT1T6dAr8EfQxd0yNy0NWz8ATR6cH2x8w
         oTKbiEPe2ZruITE+0vY3nHSJQ097nL23HQklI04UgA4/AVAP1uJ6W/AGGPcyq2PAl+EH
         0VeWHfegRPJ+81ogUs5tM272IppDRoC/yrVbcV6NY9Bmp0XGo5PU3gAO0AFGSQybiWJM
         JLIubHiBPyOD8nRL5hNFbiP7mEqloJffr/Y16sJLqr4meANOICUlrEh/+Jm5X2mYGBxl
         Wh3/Huqp7ReU+QlEPSLjFLUF1y0YjgXent1EKgMtt/lVuAw7aqZuAsmmd38dmcWLsnnZ
         k23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150755; x=1783755555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVufXZv3C9nTTbjjeAadD32Z+/uBgkpYSXQtGIeK46U=;
        b=G6oLpS4uzs7K3f9ysQFYPROqqtOXvbKpxO6QaxdmFRXx1XS4/h7H/P04sXncKL9H/F
         XHaWeQgus99qVQfWjiOpfQo2wocFjGPEHk6P5bXcVKzhrCxr1T8s2yHMo5seFMRx3+zh
         4IvzjpvVIXgwcQqpgUOY9aYeYo9jEKCcRbzn7yYw88xvi6T8vrtAuGHx1k6jo+YdPz/T
         0tzT+m4HWy1QNnU0cWHOpEMeH7vJpT7FNY8CiCYjYSVxkS8telQDLylYoBYPvBZsCFs3
         zAVqyQS7FqGfsKPiJvwEagg56m0IaFLkx4/e/0qF+OCL8kjUGdbkou/cO/nPDBBmqFTB
         zvgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QNiX8/e0a6Ygw3JkV9++S7ZzCpgbw5Bl/ZHfGycp8s0fWHe85DnNA2TxyFMkJ74+nNMmItuFDHVc9@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhj5CBFggVEmUMnK+ldVmEeFFJsQBVu21/UdT8t0Rm7wcOjrj
	xe6jMWBNDLpV2N75YocgHFDs3XnUSMuRtciAAO0HeqzhK48mZNd+/TjV
X-Gm-Gg: AfdE7cnhFZrabxUL49dvvaSNLed3cRd2InO/T284XDHXUsMOf7lDT8LWSINIFXcKXsL
	zLZPM2Y0ubuTys0zpZBQZUj+zzzYKKOfezxLboQvL8WnpdNHJIMt/HT4Wpxp3qQc1ovWsBMdSGV
	PEZh808GSEhKgJuFeSCiGbHY5SHS20OpS+Nw68WvQfnoN1FOzrm8rQc50jEs6KIZq2zp9oFKkuu
	KuX9Wp5oENOQULtxIibrlROVOJ3kssU/GgCeXDfj0Ik4W1AhLdpYIFwfoVaVIpBkTNJhdtZEf5o
	/wX8YWKm6d49vgH8oN21Q01aV+W6ckFagKBbWtR1+MaKqhghTlCjfYCnMp9fZA7a/VfeSf128Ys
	YfkO61ylIF1hVEHUeGr+0W6jbh4lppEi64QYOjtB2CVYk6tuIa5Ncrwv1IDRiUQH9jdO7PVYwJQ
	gpGTxIMKWDsDGESMkuEiOBbQYI0wcfSHpnlw==
X-Received: by 2002:a05:600c:c166:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-493d11fe04cmr24840475e9.35.1783150755151;
        Sat, 04 Jul 2026 00:39:15 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm6565488f8f.7.2026.07.04.00.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:39:14 -0700 (PDT)
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
Subject: [PATCH 0/5] phy: cpcap-usb: improve charger detection and export cable state
Date: Sat,  4 Jul 2026 10:38:38 +0300
Message-Id: <20260704073843.1750458-1-ivo.g.dimitrov.75@gmail.com>
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

This series starts with a prerequisite fix from Tony Lindgren to prevent
spurious SysRq events when switching between USB and UART modes. It then
adds DCP detection support to the CPCAP USB PHY, updates the Device Tree
binding and corresponding mapphone Device Tree to use the charger
detection interrupt, and finally exports the detected cable state through
the Extcon framework.

The existing driver already interprets the CPCAP USB detection state
machine to determine the attached cable type. This series extends that
logic to distinguish DCP connections and exposes the detected cable state
through Extcon using a standard kernel interface. It also makes the idle
UART mode optional, allowing the PHY to remain in its default USB
detection configuration unless UART support is explicitly requested.

The series has been tested on Motorola Droid 4 hardware.

Ivaylo Dimitrov (4):
  phy: cpcap-usb: add DCP detection and make UART idle mode optional
  dt-bindings: phy: motorola,cpcap-usb: replace se1 interrupt with
    chrg_det
  ARM: dts: ti: cpcap-mapphone: use charger detection interrupt for
    CPCAP USB PHY
  phy: cpcap-usb: add extcon support

Tony Lindgren (1):
  phy: cpcap-usb: Prevent line glitches from triggering sysrq

 .../bindings/phy/motorola,cpcap-usb-phy.yaml  |   8 +-
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |   4 +-
 drivers/phy/motorola/phy-cpcap-usb.c          | 312 +++++++++++++++---
 3 files changed, 274 insertions(+), 50 deletions(-)

-- 
2.25.1

