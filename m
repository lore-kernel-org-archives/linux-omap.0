Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4F25CC40
	for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278178; cv=none; b=GJhytOY65R39Ov3PPWtBc2RHoFSRqjOQQ/JVeGzAPWyJoVmL7I0ajHIIMxN46yC5jxeB6jKvinfYo5f4g+075zSyrly5SQkrmiWTsQ0QA1h1iPYj7xUwiSjJ9ISyBPEve1skcyhzN+L2FHTG0q+A0r6rn+9hnZH8hIKB4DsxhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278178; c=relaxed/simple;
	bh=SLYqpmDIV+f9bzTuf9T3OkQYZPNxGp6TyMFrpw6oF2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yh+lAJARCR0NRO8/s6XV9NVu3HYhH5mjAhxGR/5nizCy5jSh/I8tzDOatSmsQMdYBOnLRKdNUC7yg/R0SnAg3AmK8wKpGUWxki/Dp/vc9BT9215Qt9d8qpmnY9inrp4sBlZzkrIronFW/RXV3h7L8zmSc4h3X15cmHnCPXCnf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hhv/vIZK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hhv/vIZK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 649C24E427B0;
	Mon, 23 Mar 2026 15:02:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 387835FEF6;
	Mon, 23 Mar 2026 15:02:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F9E410450FFD;
	Mon, 23 Mar 2026 16:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=YwzArtu2KzPlcOy9KTAZG6fMEMJKoN02L1UiMbwFVKY=;
	b=Hhv/vIZKshZXlrG2Ou9sF19aKIXAO88ELD9yXG4xqDNREpFZGwdcNIr5Va/WtHFtM89Lu4
	z9IZw5KTrsfthaf5yv9+2uJKNEBSqRj471iTcQPUwBbElsVCtZjx2Pz/ZgXgr+t8FWsE4n
	LxWpS5E+J+gA7hxn6FM0kfA1AeEaZWa6wld/0xVquEhnB6/gwec944CtYRzSrdQfuYJJXf
	2oU7eQHrpRFy5WvMzLKokbiyb/mG8LIlwD1b1T8eOdLrh/8DU2+RHxLX4WqqGqv9ivKLbF
	BUUB6+COmcbaYOjfwRsThJ2RLJO3xdVsy7oCGezn5xpDlerdpqaRGlmwBml6oQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/8] Add SIM pbias regulator support for USB on OMAP4
Date: Mon, 23 Mar 2026 16:02:41 +0100
Message-Id: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABFWwWkC/x2Myw5AMBAAf0X2bJN6RPEr4lC12ANtuioS8e8ax
 0lm5gGhwCTQZw8EuljYHQmKPAO7mWMl5DkxlKpsVFVodLvxNS58Y5QJJXrvwol2Nm1ltdLdpCG
 1PlBS/u8wvu8HnZeDxWcAAAA=
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
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

To get USB working on OMAP4, pbias shall be configured to enable
SIM_VDDS and unlock I/O cells. Until now this was done by the bootloader.

The goal of this series is to add SIM pbias support to handle this in the
kernel ensuring correct operation regardless of the bootloader. The
vsim_pbias regulator (defined in pbias-regulator driver) will be handled by
the omap-usb-host driver.

Also I took the opportunity to do a bit of cleanup in the omap-usb-host
driver, and to convert the OMAP HS USB Host binding to DT schema.

This series has been tested on VAR-SOM-OM44.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (8):
      regulator: pbias: Add pbias SIM regulator for OMAP4
      ARM: dts: ti: omap4: Add pbias SIM regulator
      mfd: omap-usb-host: Cleanup header includes
      mfd: omap-usb-host: Sanitize error path in the probe()
      dt-bindings: mfd: ti,omap-usb-host: Convert to DT schema
      dt-bindings: mfd: ti,omap-usb-host: Add 'pbias-supply' property
      mfd: omap-usb-host: Add pbias regulator support
      ARM: dts: ti: omap4: Add pbias regulator to the HS USB Host

 .../devicetree/bindings/mfd/omap-usb-host.txt      | 103 ----------------
 .../devicetree/bindings/mfd/ti,omap-usb-host.yaml  | 136 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |   7 ++
 drivers/mfd/omap-usb-host.c                        | 132 +++++++++++---------
 drivers/regulator/pbias-regulator.c                |  11 ++
 6 files changed, 232 insertions(+), 158 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260317-omap4-fix-usb-support-cda83c7079b7

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

