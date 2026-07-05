Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CF367B94
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246285; cv=none; b=az7cli3OOJTMqfkceKKWh9v5fVjO0DDtypCSUYRsCmEFlboraEJ2g68gaP4xfov343CDDhfUEEsE1XYy8/N419YRwI4DoB22lMJasfA+f832i+HpUHhAlWciwSnijgeShLHJUR0Y/HA2ycVNZw51Yt6nhlKGda7Rk417NB1AE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246285; c=relaxed/simple;
	bh=1+urWhTzQMUH0oiAjedVIldEW714w2feNRJ/RVDNWTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpjmOeBs/XJS1aRzgV0K1foCLsYrFjga6rdvwuPqwr8HJ7R8BFC3ozGTN3cWuOZioA6T4i2q1RzDoZLqUnbcFJnWyPqCe7saPoI8L0L+lZYVivntFajQp/uUo6lAqTDD7H5Hn+AQueFSlrzIupRxSWMLBAHMgwLa2G94/j7uEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff1qHjLG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff1qHjLG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c83474ddso19393095e9.3
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783246281; x=1783851081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KosFoYH7JPzJbGxiLDLiAcfUT9wevKTSADbKnE7NxIU=;
        b=Ff1qHjLGsmFKCgVdZOH+PEgrUAHHONaG+X8cOYDTZWd1IIvjCqj0nMr8FVE2Lh5B5c
         Hn9JAfvq6tkblvQR3gbbonHpaSCsUsK76QVYWj87PXTbx2QfmySMwm7F6E/cxqTkUMxQ
         RLDB0Tk0JRoGU2cteJt0TImzAMpfNd27K4eOI8RDom1oBg9YnkfICxDXBcFH8J3brmZH
         sZBJtd7YtubI7LyeMWmakotpABKpYCCVX8Bx/IrKeT0uqqi7CunO1lAcd2DAfYCZVg3g
         M8ssymFrwr9Hs0GBL9cngdSHnJxEF+FTw3EDcwy37TdX7PKbCSRs5tIEuonKAlnz0NMi
         0EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783246281; x=1783851081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KosFoYH7JPzJbGxiLDLiAcfUT9wevKTSADbKnE7NxIU=;
        b=Zuh0ufkY+cwrGOfWZCTutC95hmo2mnPImww86jwpRTEy1UuJI99K2DU7HE36dex2kI
         bbIAOq0k+QZ29iuWkqlqOh3XF4GeeH7Vb3NC/c+CT3lTW7Mjp6+vgF8vc2aNgFcw8DGx
         HPmyLztyZZkboAB7IekIh2x2cXbddV0KRXb+0mOSJ235T4I5ccGAPLEyJwwnCMbYlNEy
         PugqKxuimjv+/IYL3XXmp7BR6oX17HhukC/sIPqNvORQqLTGbJxa1O5P+Za2vlWOUkmQ
         x2FHKLI0Sxzo4PvTrzFHPHdLpMDKwPF7BQx/mqX271At6MVT6Qi4z09asP9/FgptL8vw
         wQnQ==
X-Forwarded-Encrypted: i=1; AFNElJ95xn5JyQvDYheBY6rdKc8V6fFBZjs9jXRV3+a1Dir8KAqKz3pB3gcgJImct6FIw7SXM93ZF9Pf00k9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk9Hquwr8i2yGqyTEDkPMsFJkTmmRYvdrRwGaZL8uLGDv56Yb
	iUDXUbxIlm0YgtfCZo+tRwSKxMxgEDZOrVeaTiTwvhlhULmKGpojs/nQ
X-Gm-Gg: AfdE7cli/Ip6P+sdx/z+K0dtD3ajm3FjgDH88aoMt2JZEg7EqHTDscQec0DOhG2wO0z
	phmLV+X0qhJ2xAxdmLrBNsUHDQysV7a+29ZrdkvvDdMoeo0+d/eAiUyJ/nFkk+7QUXhtssQ9M84
	0qZiChTr9NAIWl4xss6MZJiV3jmPTPow/hjENHR7dmZU7JTDX3Z1kfjmlIXhvI0jP/f4X/pc3PB
	isnBsJFhjLJ7wwe2kFFKgzXOXtRThltqgxiLPWyIryKq4fqDiRar92bo579wdQ4iVu2P5vhB781
	AW0j3DXttYMtTFoKBEkHKnBTGKHPDuxnKa35hm+e6wdRRtrruyhqcXysfi7+1oNOUmKqVN0ZgKA
	4X4oLg4HVEYFoQXBtlGMiHq/CrTKiBmXyAcZgrAV3vONCFgqGvwLFeshR6CGP67uyGKhmWDr3tl
	tPpWGor3jH5yeFQ19/Kyl98uoq99Y5RfkIjg==
X-Received: by 2002:a05:600c:3493:b0:493:d115:d835 with SMTP id 5b1f17b1804b1-493d22abbd8mr58420125e9.8.1783246281032;
        Sun, 05 Jul 2026 03:11:21 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm261382715e9.6.2026.07.05.03.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 03:11:20 -0700 (PDT)
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
Subject: [PATCH v3 0/4] phy: cpcap-usb: improve charger detection and export cable state
Date: Sun,  5 Jul 2026 13:11:01 +0300
Message-Id: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
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

This series updates the Device Tree binding and corresponding mapphone
Device Tree to use the charger detection interrupt, adds DCP detection
support to the CPCAP USB PHY and finally exports the detected cable state
through the Extcon framework.

The existing driver already interprets the CPCAP USB detection state
machine to determine the attached cable type. This series extends that
logic to distinguish DCP connections and exposes the detected cable state
through Extcon using a standard kernel interface. It also makes the idle
UART mode optional, allowing the PHY to remain in its default USB
detection configuration unless UART support is explicitly requested.

The series has been tested on Motorola Droid 4 hardware.

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

Ivaylo Dimitrov (4):
  dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
  ARM: dts: ti: cpcap-mapphone: use charger detection interrupt for
    CPCAP USB PHY
  phy: cpcap-usb: add DCP detection and make UART idle mode optional
  phy: cpcap-usb: add extcon support

 .../bindings/phy/motorola,cpcap-usb-phy.yaml  |   6 +-
 .../dts/ti/omap/motorola-cpcap-mapphone.dtsi  |   6 +-
 drivers/phy/motorola/phy-cpcap-usb.c          | 320 +++++++++++++++---
 3 files changed, 279 insertions(+), 53 deletions(-)

-- 
2.39.5

