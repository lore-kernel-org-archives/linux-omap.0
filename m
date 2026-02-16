Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227E2D3A93;
	Mon, 16 Feb 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260982; cv=none; b=sDbHRRHqcBcGq3MPRZibWg5mRZCqTFjANpAnl+dRZZKoN5vRpvyzXkyiC+NmG8UjTgpTQgJZOgI/L+wFxE+FpmRwEhjGpANa9DDNnQioc7p9jh/B8gb1Tz/A7mHZX8vPv4mQl8ukjUkEH2+89Q2/wgSP7t+yhylCWKq/FaQ9BV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260982; c=relaxed/simple;
	bh=fbNdoihFr9FkkJ9cHnW0O7g6A92QHEroSwGVHY99SmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oj9aip5RhLyRHZk/w0M6ejc9cwCr7b46UFpx8ZFyUp6vwslQxIrzYXWx256vN9kDdEAFyFLKAP2/CDXpFCDea5E/8yzkm4yMHQ37Sy8ffwptiD+XVvok9GF7L49u2QTS5JUEscmhdEUKdvUUw/iEoUJhZnG71dnh9PW8w1EIIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bz5zSQV3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bz5zSQV3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B12BE4E40E77;
	Mon, 16 Feb 2026 16:56:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7EAB0606CF;
	Mon, 16 Feb 2026 16:56:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 519E110368016;
	Mon, 16 Feb 2026 17:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771260976; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rk33jShkc5GyZhH4ODiSXr2qkDwH0lTssejEJ6ovQ6U=;
	b=bz5zSQV3pLrKKxR0fLQsaBJAvoAvaUGQzTK+LpxUzlhx+i180FBz/iFwzA3caeM7gbmbkU
	izBSorum1pxK4fcOoH9EFdpsH/etwbJ860KKT+z4LaIpsSKxK0HvJjPZKkM/xGkEkwJJoL
	vpH0IzssWWlGxu76/KzjCuW+cd07Ed+aVTycQk/15TrIrFr/XjzL+zD2Frn+KQHQUNX8Cc
	dU5hfQD9/avEq2h5iLwBemuJjQwTODdJBbK73R43iiXcSssyb0/sspuRI1ZLMlwIGFOc9O
	Q3LIzh4H5i4RM48NGlc/fIVT1gw/4tQiHX5oz9U4B9cb8Z5sdw9BATfJgsM/Kg==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Subject: [PATCH v2 0/3] Add support for Seeed Studio BeagleBone HDMI cape
 overlay
Date: Mon, 16 Feb 2026 17:55:51 +0100
Message-Id: <20260216-feature_bbge-v2-0-22805cfdbf62@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABdMk2kC/3WMQQ7CIBBFr9LMWgxMrVpX3sM0BtrBTqJgAImm4
 e5i9y7ff/lvgUiBKcKpWSBQ5sjeVcBNA+Os3Y0ET5UBJe4lKhSWdHoFuhpTXd/i8SAN0mQ7qJd
 nIMvvNXcZKs8ckw+ftZ7Vb/0TykpIgb1UO12dbbuz8T7d2W1H/4ChlPIFmoudV6oAAAA=
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 "Kory Maincent (TI)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3

Add devicetree overlay for the Seeed Studio BeagleBone HDMI cape, which
provides HDMI output via an ITE IT66121 HDMI bridge and audio support
through McASP.

https://www.seeedstudio.com/Seeed-Studio-BeagleBoner-Green-HDMI-Cape.html

This overlay requires the recent tilcdc cleanup patch series that was merged
to drm-misc-next to function properly:
https://lore.kernel.org/lkml/20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com/

With this DRM tree dependency I don't know if this series should land in
DRM tree or in OMAP tree.

Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
Changes in v2:
- Enable overlays only for am335x BeagleBoard boards.
- Squash defconfig changes in one patch.
- Link to v1: https://lore.kernel.org/r/20260212-feature_bbge-v1-0-29014a212f35@bootlin.com

---
Kory Maincent (TI) (3):
      ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
      ARM: multi_v7_defconfig: omap2plus_defconfig: Enable ITE IT66121 driver
      ARM: dts: am335x: Add Seeed Studio BeagleBone HDMI cape overlay

 arch/arm/boot/dts/ti/omap/Makefile                 |  13 ++
 .../boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso    | 157 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/configs/omap2plus_defconfig               |   1 +
 4 files changed, 173 insertions(+)
---
base-commit: 40c1ccc1a3b86259e455a9a5082d5c8e0f944d62
change-id: 20260212-feature_bbge-932870b2edf5

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

