From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 0/2] regulator: tps65910: backup battery regulator
Date: Fri, 20 Dec 2013 12:43:26 +0100
Message-ID: <1387539808-24910-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43015 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab3LTLn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 06:43:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Hi,

backup battery charger regulator for tps65910.

Regards,

Markus


Changes in v2:
 - Seperate ops for vbb to reduce performance impact for other regulators on
   voltage mapping
 - Usage of switch statements

Markus Pargmann (2):
  regulator: tps65910: Add backup battery regulator
  ARM: dts: tps65910 backup battery regulator

 Documentation/devicetree/bindings/mfd/tps65910.txt |  4 +-
 arch/arm/boot/dts/tps65910.dtsi                    |  5 ++
 drivers/regulator/tps65910-regulator.c             | 56 +++++++++++++++++++++-
 include/linux/mfd/tps65910.h                       |  3 +-
 4 files changed, 64 insertions(+), 4 deletions(-)

-- 
1.8.5.1

