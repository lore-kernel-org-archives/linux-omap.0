Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7E3D5657
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878261; cv=none; b=m/AK69iZI5IZdtH/y1g1UuTfzDqQq4qwHdp+n/1cZzD6kQRrl7Qi7ihBIG1qOVjfMEbmr3In3AJqFV2j7K4Tvryzie4Cw7aJ0dW4Rs5oWvrjdMaaRm5Nraw/HlqxiAQeRKhJ3be98/jiXZIlEGAiUxcmCoz0bWCHlkhLckaSzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878261; c=relaxed/simple;
	bh=LWbpkfgOYG3eO49TWIvlQ7loTMS9Hfk1R7m6GLHz8vU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZNWuDBqC3u0f4nmwJbpFuXf38M+UrhJ36WA3Y/IrdmX3+IhyVmUYR8qwHiixg0k1ASf4GVVt5R6ckrgh8XaW1CUES8/fDE6VN0AzPbNJeZTCzjAYPeZRABmA9VmEQT8BDXwS4XlD0Su7vIxE5fdt1IJIEiijhGjmg13TZgNsnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sbj/Qzxb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sbj/Qzxb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2FC421A3037;
	Mon, 30 Mar 2026 13:44:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 029F45FFA8;
	Mon, 30 Mar 2026 13:44:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03C35104500D7;
	Mon, 30 Mar 2026 15:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878254; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JjVmML69Ah9mTKPWcFihyscyCX2F4nExIsj9CCysNLc=;
	b=sbj/QzxbGCZxi5rQf9qXvJqHkOKkAyxVL7mOL4VQUufDd7KXHqbLq/PHNYN6U6zzw5phay
	miGGNQiZwQ3pPTZoXPtiIJKL7dY00u0cQ7AiwqjdcBwmXIbxW6vtR2kth8M2sGfwQ9iQ0L
	+BE85dTmcJv04f4cngCgYHcl1KkKsZfdXK6ri66q0CQ6t+q3gCJU2AQ32yBLYQXWbyINIY
	5L7/h/kDbuyln+vya1b1vEvU3Bng/0fDHg30g8a14/oWdygE5bu/TVFNTfBXIt7Y7sLGto
	82MMwySKkGKnG/KuUzBMM32pqVhTu03Eg17L7HTfG77z6L9mquDIG+4UVeV1BQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v2 00/11] Add SIM pbias regulator support for USB on OMAP4
Date: Mon, 30 Mar 2026 15:43:57 +0200
Message-Id: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1+ymkC/3WNzQ6CMBCEX4Xs2TX9IRQ9+R6GQ1uqbCJs0wLRE
 N7darx6/CYz32yQQ6KQ4VxtkMJKmXgqoA4V+MFO94DUFwYlVCO0NMijjTXe6IlLdpiXGDnN6Hv
 bam+EOTkDZRtTKJWv99oVHijPnF7fm1V+0p9R6T/GVaJA1zSt1Eqq2vqLY54fNB09j9Dt+/4GR
 HayFLwAAAA=
X-Change-ID: 20260317-omap4-fix-usb-support-cda83c7079b7
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

To get USB working on OMAP4, pbias shall be configured to enable
SIM_VDDS and unlock I/O cells. Until now this was done by the bootloader.

The goal of this series is to add SIM pbias support to handle this in the
kernel ensuring correct operation regardless of the bootloader. The
vsim_pbias regulator (defined in pbias-regulator driver) will be handled by
the omap-usb-host driver.

In this second iteration I converted ti,pbias-regulator binding to DT
schema and documented the pbias_sim_omap4 regulator. The vmod bit
configuration for the pbias_sim_omap4 regulator has been fixed.
On omap-usb-host side, I fixed the binding file as requested by Conor. In
the driver I fixed the error path in suspend callback and now probe()
function gracefully handles cases where no pbias regulator is provided.

This series has been tested on VAR-SOM-OM44.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Changes in v2:
- bindings: regulator: convert ti,pbias-regulator binding to DT schema.
- bindings: regulator: document new pbias_sim_omap4 regulator.
- regulator: pbias: fix disable_val and vmod for pbias_sim_omap4.
- bindings: omap-usb-host: document missing clocks.
- bindings: omap-usb-host: add a ref to usb object.
- mfd: omap-usb-host: refactor suspend and resume callbacks.
- mfd: omap-usb-host: do not return an error if optional pbias regulator is
  not provided.
- Link to v1: https://lore.kernel.org/r/20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com

---
Thomas Richard (11):
      dt-bindings: regulator: ti,pbias-regulator: Convert to DT schema
      dt-bindings: regulator: ti,pbias-regulator: Add pbias_sim_omap4 regulator
      regulator: pbias: Add pbias SIM regulator for OMAP4
      ARM: dts: ti: omap4: Add pbias SIM regulator
      mfd: omap-usb-host: Cleanup header includes
      mfd: omap-usb-host: Sanitize error path in the probe()
      mfd: omap-usb-host: Refactor suspend and resume callbacks
      dt-bindings: mfd: ti,omap-usb-host: Convert to DT schema
      dt-bindings: mfd: ti,omap-usb-host: Add 'pbias-supply' property
      mfd: omap-usb-host: Add pbias regulator support
      ARM: dts: ti: omap4: Add pbias regulator to the HS USB Host

 .../devicetree/bindings/mfd/omap-usb-host.txt      | 103 ---------
 .../devicetree/bindings/mfd/ti,omap-usb-host.yaml  | 167 +++++++++++++++
 .../bindings/regulator/pbias-regulator.txt         |  32 ---
 .../bindings/regulator/ti,pbias-regulator.yaml     | 126 +++++++++++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |   7 +
 drivers/mfd/omap-usb-host.c                        | 236 ++++++++++++---------
 drivers/regulator/pbias-regulator.c                |  12 ++
 8 files changed, 449 insertions(+), 236 deletions(-)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260317-omap4-fix-usb-support-cda83c7079b7

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

