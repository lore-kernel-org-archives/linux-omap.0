From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/2] twl4030-bci fixes
Date: Mon, 29 Sep 2008 17:44:59 +0300
Message-ID: <1222699501-15100-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17243 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYI2Opr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 10:45:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Madhusudhan Chikkature <madhu.cr@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

The following patches cleanup and move bci to
new style registration method.

I'd like to ask people who have hw to test these
patches.

It's important to say these patches depend on the
twl4030 22-patches series sent earlier by me.

Felipe Balbi (2):
  twl4030: minor cleanups to twl4030_bci_battery.c
  twl4030-bci: move to new style registration method

 arch/arm/mach-omap2/Makefile          |    4 +-
 arch/arm/mach-omap2/bci.c             |   57 ----------
 arch/arm/mach-omap2/board-3430sdp.c   |   18 +++-
 arch/arm/mach-omap2/board-ldp.c       |   18 +++-
 arch/arm/plat-omap/include/mach/bci.h |   17 ---
 drivers/i2c/chips/twl4030-core.c      |   50 +++++++++
 drivers/power/twl4030_bci_battery.c   |  184 ++++++++++++++++-----------------
 include/linux/i2c/twl4030.h           |    5 +
 8 files changed, 179 insertions(+), 174 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/bci.c
 delete mode 100644 arch/arm/plat-omap/include/mach/bci.h

