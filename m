Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E943551B;
	Mon, 10 Aug 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385172; cv=none; b=k6EKQC8iodTOUlRuZn8ofyJABurWXZ+zNsuw0sb5hG7Y5GW5mXy326KiJxR5zNWPCUsvlSKexcC0s4QtVZy7GGDvJ81FdyGPXf8PQIwK+X35wXMgEXOwHgGOIWutZiEEh4qGkoB9oq2H3tIeNYj1R7lAHI887+BApWTKuK1msFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385172; c=relaxed/simple;
	bh=fZfGjCDyeRuGCB+CDHOTq5rehhGrNjqpUUeBXf/FSfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ratzJPYSf8WxWTJSWeEVEsc+OygArAUQV8u2ro+1qIaU/G9qrFcFjcskZBmT/qPxYFrGOBgOiGSbv9r9C5bHCXsNKUGtf5oNxoX34qqVmg+bOO2tnNWfucGGhUh6FxLZ5qN0Z/i/ksGTMDib3kAa9R9ttBntgKZQypXORKXBPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AAWos9AW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AAWos9AW"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E38B812F;
	Mon, 10 Aug 2026 20:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786385092;
	bh=fZfGjCDyeRuGCB+CDHOTq5rehhGrNjqpUUeBXf/FSfk=;
	h=From:To:Cc:Subject:Date:From;
	b=AAWos9AWJQYvy6XpYkoqKeAQHbbKmyySMG5nYa39G98fkWckp4bLHvPTb7BKsEKGG
	 M+qAJ675SM5Hr3M999dL328msOZETj09bLB6VNe6GP6mTNtBnKMIAnSA2nUz+d4Zg9
	 KglQculHqdN2L2RJw5PG8ih4b5Dof0+axbByzgPg=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>,
	Roger Quadros <rogerq@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	imx@lists.linux.dev,
	linux-omap@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 0/7] ARM: dts: Replace clock-frequency in camera sensor nodes
Date: Mon, 10 Aug 2026 21:05:57 +0300
Message-ID: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series contains the leftovers from "[PATCH v2 00/72] media:
i2c: Reduce cargo-cult" ([1]). All driver patches have been merged, but
DT changes for ARM platforms were postponed to the next kernel release
and ended up being forgotten.

To refresh everybody's memory, a large number of camera sensor drivers
directly use the "clock-frequency" property to retrieve the effective or
desired external clock rate. This is standard behaviour on ACPI
platforms that don't implement MIPI DisCo for Imaging, but usage of the
property has leaked to OF-based platforms, due to a combination of
historical reasons (using "clock-frequency" was initially considered
right until before the introduction of "assigned-clock-rates") and plain
cargo-cult.

Two series of driver patches that replace manual handling of the clock
frequency in camera sensor drivers have been merged. The clock-frequency
property is now deprecated, in favour of assigned-clock-rates. This
patch series replaces the last users of clock-frequency. This aligns the
DT bindings and device tree sources to the current recommended practice.

[1] https://lore.kernel.org/linux-media/20250812214620.30425-1-laurent.pinchart@ideasonboard.com

Laurent Pinchart (7):
  ARM: dts: samsung: exynos4210-i9100: Replace clock-frequency in camera
    sensor node
  ARM: dts: samsung: exynos4412-midas: Replace clock-frequency in camera
    sensor node
  ARM: dts: ti: omap3-n950: Replace clock-frequency in camera sensor
    node
  ARM: dts: ti: omap3-n9: Replace clock-frequency in camera sensor node
  ARM: dts: ti: omap3-n900: Replace clock-frequency in camera sensor
    node
  ARM: dts: nxp: imx6qdl-pico: Replace clock-frequency in camera sensor
    node
  ARM: dts: nxp: imx6qdl-wandboard: Replace clock-frequency in camera
    sensor node

 arch/arm/boot/dts/nxp/imx/imx6qdl-pico.dtsi      | 4 +++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard.dtsi | 4 +++-
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts   | 5 ++++-
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi  | 5 ++++-
 arch/arm/boot/dts/ti/omap/omap3-n9.dts           | 5 ++++-
 arch/arm/boot/dts/ti/omap/omap3-n900.dts         | 3 ++-
 arch/arm/boot/dts/ti/omap/omap3-n950.dts         | 5 ++++-
 7 files changed, 24 insertions(+), 7 deletions(-)


base-commit: 56c29fa3ee666197516a231e75aed789ae9c530d
-- 
Regards,

Laurent Pinchart

