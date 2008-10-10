From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/7] Integrate the twl4030 power code into new twl4030 mfd
Date: Fri, 10 Oct 2008 19:56:09 +0300
Message-ID: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56021 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761626AbYJJQ44 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 12:56:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9AGu9KS000850
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 11:56:54 -0500
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
  omap3 evm beagle and overo use the generic twl4030 script

 arch/arm/mach-omap2/Makefile                  |    9 +-
 arch/arm/mach-omap2/board-3430sdp.c           |   61 +++++
 arch/arm/mach-omap2/board-ldp.c               |   62 +++++
 arch/arm/mach-omap2/board-omap3beagle.c       |    3 +
 arch/arm/mach-omap2/board-omap3evm.c          |    3 +
 arch/arm/mach-omap2/board-overo.c             |    3 +
 arch/arm/mach-omap2/twl4030-generic-scripts.c |   78 ++++++
 drivers/i2c/chips/twl4030-power.c             |  343 -------------------------
 drivers/mfd/twl4030-core.c                    |   11 +
 drivers/mfd/twl4030-power.c                   |  270 +++++++++++++++++++
 include/linux/i2c/twl4030.h                   |   64 +++++
 11 files changed, 561 insertions(+), 346 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl4030-generic-scripts.c
 delete mode 100644 drivers/i2c/chips/twl4030-power.c
 create mode 100644 drivers/mfd/twl4030-power.c

