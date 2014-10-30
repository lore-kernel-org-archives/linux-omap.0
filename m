From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] omap gpmc and board clean-up for v3.19 merge window
Date: Wed, 29 Oct 2014 17:28:58 -0700
Message-ID: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51939 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757285AbaJ3AaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Here are few patches to fix and clean up some GPMC issues
and remove two board files that are no longer needed.

Regards,

Tony


Tony Lindgren (10):
  ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x
    pins
  ARM: dts: Fix wrong GPMC size mappings for omaps
  ARM: dts: Add smc91x GPMC configuration for 2430sdp
  ARM: dts: Add GPMC timings for omap zoom serial port
  ARM: OMAP2+: Fix support for multiple devices on a GPMC chip select
  ARM: OMAP2+: Show bootloader GPMC timings to allow configuring the
    .dts file
  ARM: OMAP2+: Require proper GPMC timings for devices
  ARM: OMAP2+: Drop legacy code for gpmc-smc91x.c
  ARM: OMAP2+: Drop board file for ti8168evm
  ARM: omap2plus: Drop board file for 3430sdp

 arch/arm/boot/dts/am335x-evm.dts             |   4 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi       |   4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts         |   4 +-
 arch/arm/boot/dts/omap-zoom-common.dtsi      |  62 ++-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi  |   4 +-
 arch/arm/boot/dts/omap2430-sdp.dts           |  28 +-
 arch/arm/boot/dts/omap3-devkit8000.dts       |   4 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts         |   4 +-
 arch/arm/boot/dts/omap3-gta04.dtsi           |   4 +-
 arch/arm/boot/dts/omap3-igep0020.dts         |   4 +-
 arch/arm/boot/dts/omap3-igep0030.dts         |   4 +-
 arch/arm/boot/dts/omap3-ldp.dts              |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi      |   2 +-
 arch/arm/boot/dts/omap3-n900.dts             |  35 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi         |   4 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi         |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts           |   8 +-
 arch/arm/mach-omap2/Kconfig                  |  16 -
 arch/arm/mach-omap2/Makefile                 |   6 -
 arch/arm/mach-omap2/board-3430sdp.c          | 632 ---------------------------
 arch/arm/mach-omap2/board-rx51-peripherals.c |  29 --
 arch/arm/mach-omap2/board-ti8168evm.c        |  62 ---
 arch/arm/mach-omap2/gpmc-smc91x.c            | 186 --------
 arch/arm/mach-omap2/gpmc-smc91x.h            |  42 --
 arch/arm/mach-omap2/gpmc.c                   | 206 +++++++--
 25 files changed, 324 insertions(+), 1034 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-3430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h

-- 
2.1.1

