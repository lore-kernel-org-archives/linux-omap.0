From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/7] HTC Herald various device support
Date: Mon, 19 Jul 2010 21:05:34 -0700
Message-ID: <1279598741-18607-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58346 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab0GTEGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 00:06:07 -0400
Received: by iwn7 with SMTP id 7so5352423iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Jul 2010 21:06:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
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

Cory Maccarrone (7):
  [OMAP] gpio: Allow for extended GPIO space
  [OMAP] Add allowance for extra IRQ space
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
 arch/arm/plat-omap/Kconfig                |   36 +++
 arch/arm/plat-omap/include/plat/gpio.h    |    7 +
 arch/arm/plat-omap/include/plat/irqs.h    |    6 +-
 arch/arm/plat-omap/include/plat/mux.h     |    4 +
 12 files changed, 631 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-omap1/htc-bt.c
 create mode 100644 arch/arm/mach-omap1/include/mach/htc-bt.h

