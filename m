From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/8] twl4030 updates
Date: Fri, 26 Sep 2008 12:40:53 +0300
Message-ID: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38249 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbYIZJlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 05:41:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

The following series has a full set of fixes to
twl4030 drivers. This series was made of Jagadeesh's
pullup fix, my usb and keypad fixes and Dave's
gpio patches.

Dave's patches got a few failed HUNKs so Dave,
please check if I patched everything fine.

David Brownell (2):
  twl4030 gpio platform data
  twl4030 uses gpiolib

Felipe Balbi (5):
  twl4030: fix potential null pointer dereference
  i2c: clean add_children a bit
  i2c: move twl4030_keypad to new style registration
  i2c: move twl4030-usb to platform_device
  i2c: twl4030-usb: add 'vbus' sysfs file

Jagadeesh Bhaskar Pakaravoor (1):
  twl4030-gpio: Remove default pullup enable/disable of GPIO

 arch/arm/mach-omap2/board-2430sdp.c         |   27 ++-
 arch/arm/mach-omap2/board-3430sdp.c         |   26 ++-
 arch/arm/mach-omap2/board-ldp.c             |   14 +
 arch/arm/mach-omap2/board-omap2evm.c        |   28 ++-
 arch/arm/mach-omap2/board-omap3beagle.c     |   19 ++
 arch/arm/mach-omap2/board-omap3evm.c        |   80 +++---
 arch/arm/mach-omap2/board-overo.c           |    7 +
 drivers/i2c/chips/Kconfig                   |   18 +--
 drivers/i2c/chips/twl4030-core.c            |  159 ++++++++++--
 drivers/i2c/chips/twl4030-gpio.c            |  278 ++++++++++++++------
 drivers/i2c/chips/twl4030-usb.c             |  373 ++++++++++++++-------------
 drivers/input/keyboard/omap-twl4030keypad.c |    8 +-
 include/linux/i2c/twl4030.h                 |   40 +++-
 13 files changed, 695 insertions(+), 382 deletions(-)

