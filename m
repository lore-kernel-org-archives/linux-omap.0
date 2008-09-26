From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 14:19:47 +0300
Message-ID: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37403 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbYIZLUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 07:20:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Resending the series with madc conversion done and
another updates that I missed previously from Dave's
comments.

*** NOTE: I didn't test the madc changes (besides compile testing)
since I don't have code for testing that.

Maybe Mikko Ylinen could help us with that.

David Brownell (2):
  twl4030 gpio platform data
  twl4030 uses gpiolib

Felipe Balbi (6):
  twl4030: fix potential null pointer dereference
  i2c: clean add_children a bit
  i2c: move twl4030_keypad to new style registration
  i2c: move twl4030-usb to platform_device
  i2c: twl4030-usb: add 'vbus' sysfs file
  i2c: move twl4030-madc to new registration style

Jagadeesh Bhaskar Pakaravoor (1):
  twl4030-gpio: Remove default pullup enable/disable of GPIO

 arch/arm/mach-omap2/board-2430sdp.c         |   33 ++-
 arch/arm/mach-omap2/board-3430sdp.c         |   32 ++-
 arch/arm/mach-omap2/board-ldp.c             |   20 ++
 arch/arm/mach-omap2/board-omap2evm.c        |   34 ++-
 arch/arm/mach-omap2/board-omap3beagle.c     |   25 ++
 arch/arm/mach-omap2/board-omap3evm.c        |   86 ++++---
 arch/arm/mach-omap2/board-overo.c           |   13 +
 drivers/i2c/chips/Kconfig                   |   18 +--
 drivers/i2c/chips/twl4030-core.c            |  186 ++++++++++++--
 drivers/i2c/chips/twl4030-gpio.c            |  278 ++++++++++++++------
 drivers/i2c/chips/twl4030-madc.c            |  243 +++++++++++-------
 drivers/i2c/chips/twl4030-usb.c             |  373 ++++++++++++++-------------
 drivers/input/keyboard/omap-twl4030keypad.c |    8 +-
 include/linux/i2c/twl4030.h                 |   46 ++++-
 14 files changed, 922 insertions(+), 473 deletions(-)

