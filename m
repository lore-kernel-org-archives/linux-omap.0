From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/3] OMAP4+: Get rid of internal SRAM handling
Date: Thu, 29 Aug 2013 16:53:08 +0530
Message-ID: <1377775391-13103-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42803 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab3H2LXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 07:23:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, nsekhar@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

v2:
Removed the static iotable mapping for sram done to handle
errata I688, and used gen_pool instead.

Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
use drivers/misc/sram.c driver instead of the omap internal
implementation for SRAM handling.

Rajendra Nayak (3):
  ARM: AM335x: Get rid of unused sram init function
  ARM: OMAP4+: Move SRAM data to DT
  ARM: OMAP4+: Remove static iotable mappings for SRAM

 Documentation/devicetree/bindings/arm/omap/mpu.txt |    5 ++-
 arch/arm/boot/dts/am33xx.dtsi                      |    5 +--
 arch/arm/boot/dts/am4372.dtsi                      |    5 +++
 arch/arm/boot/dts/omap4.dtsi                       |    6 +++
 arch/arm/boot/dts/omap5.dtsi                       |    8 +++-
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap2/io.c                           |   17 ---------
 arch/arm/mach-omap2/omap4-common.c                 |   17 ++++++++-
 arch/arm/mach-omap2/sram.c                         |   39 +-------------------
 arch/arm/mach-omap2/sram.h                         |    7 ----
 10 files changed, 42 insertions(+), 68 deletions(-)

-- 
1.7.9.5

