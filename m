From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 0/3] OMAP4+: Get rid of internal SRAM handling
Date: Wed, 10 Sep 2014 11:04:01 -0500
Message-ID: <cover.1410362895.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59445 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbaIJQE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 12:04:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

v3:
Fix minor issue in last patch to check for null sram_pool if no sram
phandle is given in DT.

Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
use drivers/misc/sram.c driver instead of the omap internal
implementation for SRAM handling.

Previous discussion can be found at [1].

Regards,
Dave

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195588.html

Rajendra Nayak (3):
  ARM: AM335x: Get rid of unused sram init function
  ARM: OMAP4+: Move SRAM data to DT
  ARM: OMAP4+: Remove static iotable mappings for SRAM

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  3 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  5 ++-
 arch/arm/boot/dts/am4372.dtsi                      |  5 +++
 arch/arm/boot/dts/omap4.dtsi                       |  6 ++++
 arch/arm/boot/dts/omap5.dtsi                       |  8 ++++-
 arch/arm/configs/omap2plus_defconfig               |  1 +
 arch/arm/mach-omap2/io.c                           | 17 ----------
 arch/arm/mach-omap2/omap4-common.c                 | 22 +++++++++++-
 arch/arm/mach-omap2/sram.c                         | 39 +---------------------
 arch/arm/mach-omap2/sram.h                         |  7 ----
 10 files changed, 46 insertions(+), 67 deletions(-)

-- 
1.9.0

