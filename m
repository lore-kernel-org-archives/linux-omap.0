From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] OMAP1: UART / Bluetooth Support
Date: Tue,  1 Jun 2010 15:32:48 -0700
Message-ID: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47672 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab0FAWdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 18:33:00 -0400
Received: by gye5 with SMTP id 5so1624258gye.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 15:32:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

This set of changes is specifically geared towards enabling bluetooth
support on the HTC Herald.  To do that, several things were done:

 * I added in the necessary clock and mux configuration to enable
   both UARTs to operate.

 * I modified the omap1 serial code to only initialize two UARTs if
   the CPU type is omap7xx.  These chips don't have 3 UARTs, and trying
   to initialize the third one causes deadlock.

 * I created a common bluetooth-handling driver for HTC smartphones
   like the herald.  This will be used later by other similar boards,
   such as the wizard and the opal.  The driver itself only implements
   an RFKILL switch to enable/disable the GPIO pins that control the
   bluetooth on these devices.

 * I added the new bluetooth driver and serial port init code to the
   herald board.

 * Finally, I updated the htcherald_defconfig both to add in bluetooth
   support, and to remove old unneeded cruft.

The on-board chip is a TI BRF6150 attached to the first UART.  Rather
than write (or port) a driver for this chip, this method was chosen because
bluez supports the chip over a UART with hciattach.  So, rather than
implement a full brf6150 driver, I expose and configure the serial
port it's attached to.

Cory Maccarrone (3):
  [omap1] omap7xx clocks, mux, serial fixes
  [omap1] Bluetooth device code common to HTC smartphones
  [htcherald] Add board support for UARTs, bluetooth

 arch/arm/configs/htcherald_defconfig      |  159 ++++++++-----------------
 arch/arm/mach-omap1/Makefile              |    2 +-
 arch/arm/mach-omap1/board-htcherald.c     |   23 ++++
 arch/arm/mach-omap1/clock_data.c          |   20 +++
 arch/arm/mach-omap1/htc-bt.c              |  183 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/htc-bt.h |   22 ++++
 arch/arm/mach-omap1/mux.c                 |    4 +
 arch/arm/mach-omap1/serial.c              |    7 +
 arch/arm/plat-omap/include/plat/mux.h     |    4 +
 9 files changed, 315 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm/mach-omap1/htc-bt.c
 create mode 100644 arch/arm/mach-omap1/include/mach/htc-bt.h

