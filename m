From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/4] MMC, I2C, HTCPLD for HTC Herald
Date: Fri, 28 May 2010 22:28:03 -0700
Message-ID: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0E2F22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 01:28:28 -0400
Received: by iwn6 with SMTP id 6so160874iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 22:28:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

This patch set implements the functionality necessary to add in
MMC card support, I2C/HTCPLD support, and related functionality.

The first patch adds a set of common routines that all OMAP850-related
HTC smartphone devices can make use of (in my kernel tree, there's
at least a dozen boards that make use of the same MMC code; these
haven't been submitted yet).

The second and third patches implement the ability for omap1 devices
to extend their GPIO and IRQ space by 64 or 128, similar to some omap2
devices.

The extended GPIO/IRQ space is required for the fourth patch, which
adds in board support for the HTCPLD chip on the HTC Herald.  This
chip is a GPIO/IRQ extender, and with the additional GPIOs and IRQs,
the normal default maximum is exceeded, necessitating the expansion.
Additionally, this fourth patch adds in MMC and I2C support for the
herald, in addition to tying gpio-keys and led-gpio support to various
pins on the HTCPLD.

With all of these changes in place, it is possible to boot a linux
distribution installed on SD card and make use of all the keys on the
device.

Cory Maccarrone (4):
  [OMAP1] Add MMC board code common to HTC devices
  [OMAP] gpio: Allow for extended GPIO space
  [OMAP] Add allowance for extra IRQ space
  [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related devices

 arch/arm/configs/htcherald_defconfig   |  376 ++++++++++++++++++++++++++++----
 arch/arm/mach-omap1/Kconfig            |    2 +
 arch/arm/mach-omap1/Makefile           |    2 +-
 arch/arm/mach-omap1/board-htcherald.c  |  267 ++++++++++++++++++++++-
 arch/arm/mach-omap1/htc-mmc.c          |  104 +++++++++
 arch/arm/mach-omap1/htc-mmc.h          |   26 +++
 arch/arm/plat-omap/Kconfig             |   36 +++
 arch/arm/plat-omap/include/plat/gpio.h |    7 +
 arch/arm/plat-omap/include/plat/irqs.h |    6 +-
 9 files changed, 778 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/mach-omap1/htc-mmc.c
 create mode 100644 arch/arm/mach-omap1/htc-mmc.h

