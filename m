From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/7] Integrate the twl4030 power code into new twl4030 mfd
Date: Mon, 13 Oct 2008 18:44:05 +0300
Message-ID: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39487 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbYJMPo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 11:44:29 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9DFi3VF003901
	for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 10:44:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset integrates the twl4030 power code into the new twl4030 mfd framework. The scripts will be moved to the board specific data.

Peter 'p2' De Schrijver (7):
  Remove existing twl4030 power script code.
  Add defines and data types for twl4030.
  Twl4030 power code updated for new twl4030 core
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
 drivers/mfd/Kconfig                           |    7 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/twl4030-core.c                    |   11 +
 drivers/mfd/twl4030-power.c                   |  270 +++++++++++++++++++
 include/linux/i2c/twl4030.h                   |   64 +++++
 15 files changed, 620 insertions(+), 353 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-generic-scripts.c
 create mode 100644 arch/arm/mach-omap2/twl4030-generic-scripts.h
 delete mode 100644 drivers/i2c/chips/twl4030-power.c
 create mode 100644 drivers/mfd/twl4030-power.c

