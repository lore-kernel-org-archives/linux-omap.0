From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/3] ARM: AM33xx: Add RNG module data
Date: Tue, 6 Aug 2013 14:03:01 +0530
Message-ID: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57933 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435Ab3HFIde (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 04:33:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, devicetree@vger.kernel.org, rob@landley.net, rnayak@ti.com, benoit.cousson@linaro.org, lokeshvutla@ti.com

This patch series adds HWMOD, CLOCK and DT data for
RNG module.

Lokesh Vutla (3):
  ARM: AM33XX: hwmod: Add rng module data
  ARM: AM33xx: Add rng clock data
  ARM: dts: AM33xx: Add RNG node

 .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |    4 +++
 arch/arm/boot/dts/am335x-evm.dts                   |    4 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |    4 +++
 arch/arm/boot/dts/am33xx.dtsi                      |    8 +++++
 arch/arm/mach-omap2/cclock33xx_data.c              |    5 +++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   35 ++++++++++++++++++++
 7 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt

-- 
1.7.9.5

