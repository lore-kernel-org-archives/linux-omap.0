From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/6] Integrate the twl4030 power code into new twl4030 mfd
Date: Wed, 15 Oct 2008 16:37:28 +0300
Message-ID: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56467 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbYJONhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 09:37:45 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FDbKDF015108
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 16:37:42 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset integrates the twl4030 power code into the new twl4030 mfd framework. The scripts will be moved to the board specific data.

Peter 'p2' De Schrijver (6):
  Add defines and data types for twl4030.
  Move existing TWL4030 code to drivers/mfd
  Hook twl4030 power code into twl4030 core.
  3430sdp and ldp use custom twl4030 power scripts.
  Generic twl4030 power script for 3430 based boards.
  omap3 evm, beagle and overo use the generic twl4030 script

 arch/arm/mach-omap2/Makefile                  |    9 +-
 arch/arm/mach-omap2/board-3430sdp.c           |   84 ++++++
 arch/arm/mach-omap2/board-ldp.c               |   84 ++++++
 arch/arm/mach-omap2/board-omap3beagle.c       |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    4 +-
 arch/arm/mach-omap2/board-overo.c             |    4 +-
 arch/arm/mach-omap2/twl4030-generic-scripts.c |   78 ++++++
 arch/arm/mach-omap2/twl4030-generic-scripts.h |    8 +
 drivers/i2c/chips/Makefile                    |    2 +-
 drivers/i2c/chips/twl4030-power.c             |  343 -------------------------
 drivers/mfd/Kconfig                           |    9 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/twl4030-core.c                    |   11 +
 drivers/mfd/twl4030-power.c                   |  270 +++++++++++++++++++
 include/linux/i2c/twl4030.h                   |   64 +++++
 15 files changed, 622 insertions(+), 353 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-generic-scripts.c
 create mode 100644 arch/arm/mach-omap2/twl4030-generic-scripts.h
 delete mode 100644 drivers/i2c/chips/twl4030-power.c
 create mode 100644 drivers/mfd/twl4030-power.c

