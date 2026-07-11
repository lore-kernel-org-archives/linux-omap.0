Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F7149DF1
	for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802561; cv=none; b=m4JZJklwycGyAxTMaU6BK4ZBV1xdU1INdy4JOc9K5zf/kjy14omgTOpkooFzOs5C4vZFdg/yydxwasJX6ZGrKXBlSrZVPYz585G/4h0OpxAQnInGO8/1EsmNTAdE8/kXi2gfkpFQXfUjiRgFmzJcyVlgTROhYg5niYor+/OCYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802561; c=relaxed/simple;
	bh=L2sb5cET0wjT1JgD/AHsjf7HpJ891Sy1hzT2Y5sI8FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bFIVLSA54OtcCJ28bpBYbWLcv6JPCfGIRAc6q7WDbHrl9g7hTXUUAVIy/4OyIbag9/jcAWtFTyf0g6q2aLhb1qlINRjhxGnI9terAsy243XW9RbiEev6AHzvMMBbTSPCAHFnkQ9GoWWQZYqCs3BZN4lPxrsouo9cbKyoBq1+LWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKFbcQyq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKFbcQyq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso18521035e9.3
        for <linux-omap@vger.kernel.org>; Sat, 11 Jul 2026 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802559; x=1784407359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PnttK4V5N2RbdGmmP/+gvD/lecbvQoerec0w3s7gRKw=;
        b=KKFbcQyqnwjTAexocsEcTztm2/hp9ai65jm8Du/U0VVFFxyzx8D9fTbOrNNFVho+eT
         laSFVCAd6tBbkLB3VbdNCltvmjWUbMizz1/RY0KlWnkVmMvPdvq5c8b++5HGkQig9+Hq
         u3vFgNWrU/vHNaeuJf/kV5T8dmK3aBq/qqmUC0iXR/8ETZfuiSXjni9bIraQKu2YqfV/
         ZdzZEeMf/8WW/7UZJUgdreXSCHsuSajGiRMSibV02Ysjq4f0K9x5s4f8ZxEUYm+7u9J+
         RmTs7uJ5Cgos4Vc2zuVWeU2b63vRW43ILTQU3n7mJRRpDOU7fjwp7WLjAm42bRB6Hs8G
         8vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802559; x=1784407359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PnttK4V5N2RbdGmmP/+gvD/lecbvQoerec0w3s7gRKw=;
        b=mJP1XVVBnKvla7TmDk0SUBuVNg+bcRcpSRecTahk+tC1HQa4ZifUk4bbvLUf/a1KSL
         Q0vJDT62DQ+V/73QZwY6usy1pRTuNXGgRo2zaspPivy5aij+KWauSlibcNr1WS0YHFJU
         84Ws8APgqrDCdwXZkLGbyIdxHIK2jxSSB6xGGjsldoXET/4+h654B6IznsO1UHUvQi14
         FS24mYwXfaiFl3BJhTWbyumVRE3gNXjcOTAooqLQqPpnPDMsS0q7tj8ZOSfoQ2/GoXEM
         IP29iu85B94MfnOUXFSroU6Xu7K0t8wahdaA70L1onDMyWEebxo964mPetAy2r0njZ6M
         UZEg==
X-Forwarded-Encrypted: i=1; AHgh+RqhEJietS1howrgS+q3W19LBk6J1RXQJ8EFn1d9JgrFGMl1gFh0Ny7PskexHvRFsoGL+200WmKllzDq@vger.kernel.org
X-Gm-Message-State: AOJu0YycwQn9I92ExtIzyrwGPlITFT6M9dL89tOaIK/ElZENN+tUXrK8
	PK+AUu9DqdFqXD3CqwJCgoylteqx5o3j3LSZJ7Pznic4ayW353cB+Ckx
X-Gm-Gg: AfdE7cmTaFU0wTxOyBNTm8MO0QjG1ahLxetjtwIVa07FJX8+E967CTN+TnQ19sOKZBQ
	wwmwaNvvwcu80g7085aMYhntQvbYhbB6lS98G4QX0PRtrzrUnP0mawEHwwKxYVyUggvjotgJgxG
	/Wvwx98XmT/OVbGrTop6gl+Zi2AEqtDN6UAVUidmX+AR+RgNrooJCThQDZ74s1D+iwBBzQ5mall
	uyLgu/nLYRNrvWrBy+SqbowPmZ7HCfZVFPgoUKp86dQMH0vRNF5taeRX2/cYGoiiM5oBuFzKajv
	dZ72CFcOX3VNSk/4mAhtNl4lsv+Gvaq3L3I1t1dklcGleMPrsrPN+dqL4r8WaKhZRi6JltrI5k4
	OMRJzGPmUa1F6Fm0Qmp07/exZAdSDCrCpysComZ01B9kpI4CDld2pe4209m9nCjlasw729GxULL
	59F+H6HRTikq3K8V59zm2xt0rDkMCiRedhxw==
X-Received: by 2002:a05:600c:608e:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-493f881f934mr35888195e9.19.1783802558744;
        Sat, 11 Jul 2026 13:42:38 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm172704725e9.2.2026.07.11.13.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:42:38 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v5 0/7] phy: cpcap-usb: improve charger detection and export cable state
Date: Sat, 11 Jul 2026 23:42:03 +0300
Message-Id: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
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

This series extends the CPCAP USB PHY driver to detect DCP connections
and export the detected cable state through the Extcon framework. It also
makes the idle UART mode optional, allowing the PHY to remain in its
default USB detection configuration unless UART support is explicitly
requested.

The series updates the Device Tree binding for the optional charger
detection interrupt and the optional "safe" pinctrl state. Corresponding
mapphone Device Tree entries are added to describe the charger detection
interrupt and enable the safe pinctrl state.

The charger detection interrupt is not currently used by the driver.
However, it is added to the binding and Device Tree because it describes
a hardware capability of the CPCAP USB PHY.

The series has been tested on Motorola Droid 4 hardware.

Changes in v5:
- fix race in remove()
- fix commit message of PATCH 2
- re-schedule detect_work if DCP/SDP modes cannot be reliably detected
- fully configure PHY registers in DCP mode
- fix extcon intermediate cable states

Changes in v4:
- make charger detection interrupt optional
- make driver functional without charger detection interrupt
- add bindings and Device Tree for 'safe' pinctrl mode
- use 'safe' pinctrl state before switching PHY modes

Changes in v3:
- Drop "phy: cpcap-usb: Prevent line glitches from triggering sysrq"
- Fix DT schema interrupts order
- Fix boot cable detection

Changes in v2:
- add chrg_det interrupt instead of replacing se1
- Fix remove() race by cancelling detect_work before hardware teardown
- Restore SysRq state on all error paths
- Introduce CPCAP_UNKNOWN initial mode
- Snapshot enable_uart module parameter

Ivaylo Dimitrov (7):
  dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
  dt-bindings: phy: motorola,cpcap-usb-phy: add optional safe pinctrl
    state
  phy: cpcap-usb: fix IRQ teardown race
  phy: cpcap-usb: add DCP detection and make UART idle mode optional
  phy: cpcap-usb: add extcon support
  ARM: dts: ti: cpcap-mapphone: add charger detection interrupt for
    CPCAP USB PHY
  ARM: dts: ti: cpcap-mapphone: add USB safe pinctrl state

 .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  13 +-
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |   9 +-
 .../dts/ti/omap/motorola-mapphone-common.dtsi |  19 +
 drivers/phy/motorola/phy-cpcap-usb.c          | 386 +++++++++++++++---
 4 files changed, 357 insertions(+), 70 deletions(-)

-- 
2.39.5

