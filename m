From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH 0/3] TWL4030: Add support for dynamic power switching
Date: Wed, 24 Jun 2009 12:06:30 +0300
Message-ID: <1245834390-7904-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49216 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZFXJGh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 05:06:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org

The TWL4030/5030 family of multifunction devices allow dynamic power
switching based on board-specific applications through power 'scripts'.

Add board-independent core support for this feature and add support for
the RX51 board based on OMAP3.

Amit Kucheria (3):
  TWL4030: power: Add support for TWL4030/5030 dynamic power switching
  TWL4030: power: print warning for out-of-order script loading
  TWL4030: power: OMAP: Board-specifc DPS scripts for RX51 board

 arch/arm/mach-omap2/board-rx51-peripherals.c |  120 ++++++++-
 drivers/mfd/Kconfig                          |   13 +
 drivers/mfd/Makefile                         |    1 +
 drivers/mfd/twl4030-core.c                   |   26 ++
 drivers/mfd/twl4030-power.c                  |  396 ++++++++++++++++++++++++++
 include/linux/i2c/twl4030.h                  |   91 ++++++-
 6 files changed, 636 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mfd/twl4030-power.c

