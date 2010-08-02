From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/5] HTC Herald various device support
Date: Mon,  2 Aug 2010 08:23:51 -0700
Message-ID: <1280762636-17206-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50102 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0HBPYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 11:24:06 -0400
Received: by pwi5 with SMTP id 5so1382803pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Aug 2010 08:24:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This patch set is an updated version of a series of patches I submitted
a while ago.  It's built against the latest linux-omap master branch, and
removes all defconfig updates.  Other comments were put in place as well.

This patch set implements the following drivers and support for them into
the HTC Herald:

 * MMC card support
 * I2C and HTCPLD drivers
 * TSC2046 touchscreen support
 * Serial port fixes for omap7xx
 * Bluetooth common code for HTC omap7xx smartphones

The bluetooth drivers are implemented with the expectation that they will
be used by other devices once the board files are submitted (Elf/Elfin,
Opal, etc).

Cory Maccarrone (5):
  [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related devices
  [OMAP] htcherald: SPI register config, TSC2046 touchscreen
  [omap1] omap7xx clocks, mux, serial fixes
  [omap1] Bluetooth device code common to HTC smartphones
  [htcherald] Add board support for UARTs, bluetooth

 arch/arm/mach-omap1/Kconfig               |    2 +
 arch/arm/mach-omap1/Makefile              |    2 +-
 arch/arm/mach-omap1/board-htcherald.c     |  346 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap1/clock_data.c          |   20 ++
 arch/arm/mach-omap1/htc-bt.c              |  183 +++++++++++++++
 arch/arm/mach-omap1/include/mach/htc-bt.h |   22 ++
 arch/arm/mach-omap1/mux.c                 |    4 +
 arch/arm/mach-omap1/serial.c              |    7 +
 arch/arm/plat-omap/include/plat/mux.h     |    4 +
 9 files changed, 583 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-omap1/htc-bt.c
 create mode 100644 arch/arm/mach-omap1/include/mach/htc-bt.h

