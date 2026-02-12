Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66421B9E2;
	Thu, 12 Feb 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910071; cv=none; b=P3Fy17NPz+7RJY2fBl4/c85dHGE5bKHwtlwJPfBnmcDw81YQmuDQ+24s7Mtc2x0zxfNJIqVyqBQG+recdQljgbl33oCNbvgLjrkNfoj5cvlwNQKexbCXfSYyhW/bCdvkfkl+jqLAmv7xvve9GVSAAbgTPUNNJ86nRs2O+bAE6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910071; c=relaxed/simple;
	bh=1DzUWPOgjLvu5fGldGym/cmrtxG/LTiARhhTrxb40ac=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rWalQesOuMxmNCE6L2Q++iCUOeLIBrUwYVELF0iRSTOMnu+GlOx/Vsb5mqEvnV6Ot6L6ADp1JoY6zAQsa1FgKiizf4cLNzGiaAIWCJBV9kkW7uzFiuBxziThkbn7F3wR9PhuB7yBuxiOkGzFlmPZHdLPJI/kMmwW/Tdu2vHTaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ty5AZIWr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ty5AZIWr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 256164E40CE3;
	Thu, 12 Feb 2026 15:27:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E52B1606CA;
	Thu, 12 Feb 2026 15:27:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B93211971B05;
	Thu, 12 Feb 2026 16:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770910061; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=dHvyyUWufcDUYZZiGp+OreXyUiQERICvMqjauxJsIBk=;
	b=ty5AZIWryFiAUKJgZh1PETyZ8lFIYeqVUbpKQhtDJxPHr/JwgpMbPPcB53R8n/K6KZjwS8
	ninJ9z0cWJeqAbqDof4AO4YOPwe0yeRvKZ+PQTxU1Wc779c1SKTSiJhR8NlyR16UIBEaWK
	N39q7624FEF6agoGTyQX3WqUBvVxdyNzfE7zMAcj8OP0aflhhotMdegJRUJgV2h253MOin
	ZX3QJ2jdjnnYV1iMM2fvrEgG+VMIXHgieid02uwD6urvC++cY19tvgoZKjuIt6/IlE7bQ5
	wFJ4RK99iQG8I2xmpHibRFgW64xPwInIqSxdg2tSX9Hy+OY81cs88Y0R9tyEIw==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Subject: [PATCH 0/5] Add support for Seeed Studio BeagleBone HDMI cape
 overlay
Date: Thu, 12 Feb 2026 16:26:14 +0100
Message-Id: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABbxjWkC/x2MWwqAIBAAryL7XaAbPa8SEZlr7Y+FVgTi3ZM+h
 2EmQiDPFGAQETw9HPhwGVQhYN0Xt1HJJjOgxEaiwtLSct2eZq2z6yvsWqmRjK0hJ6cny++/G6e
 UPjBq33NeAAAA
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
Kory Maincent (TI) (5):
      ARM: dts: ti: Enable overlays for all DTB files
      ARM: multi_v7_defconfig: Enable TILCDC DRM driver
      ARM: omap2plus_defconfig: Enable ITE IT66121 driver
      ARM: multi_v7_defconfig: Enable ITE IT66121 driver
      ARM: dts: am335x: Add Seeed Studio BeagleBone HDMI cape overlay

 arch/arm/boot/dts/ti/omap/Makefile                 |   8 ++
 .../boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso    | 157 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/configs/omap2plus_defconfig               |   1 +
 4 files changed, 168 insertions(+)
---
base-commit: 40c1ccc1a3b86259e455a9a5082d5c8e0f944d62
change-id: 20260212-feature_bbge-932870b2edf5

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

