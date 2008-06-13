From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/4] more musb/i2c patches
Date: Fri, 13 Jun 2008 13:03:59 +0300
Message-ID: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35990 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbYFMKFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 06:05:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

Basically adding module_alias and allowing
some twl drivers to be dynamically linked.

There's also one patch to make hdrc_cnf.h
more "omap3-compliant" based on the musb
configuration for musb ip core on omap3.

Please, comment them out.

Felipe Balbi (4):
  usb: musb: musb on omap3 has 32 endpoints
  usb: musb: add MODULE_ALIAS for udev module loading
  i2c: allow twl modules to be built as modules
  i2c: add MODULE_ALIAS to twl4030 drivers

 drivers/i2c/chips/Kconfig                   |    6 +++---
 drivers/i2c/chips/twl4030-core.c            |    1 +
 drivers/i2c/chips/twl4030-gpio.c            |    1 +
 drivers/i2c/chips/twl4030-madc.c            |    1 +
 drivers/i2c/chips/twl4030-poweroff.c        |    1 +
 drivers/i2c/chips/twl4030-pwrbutton.c       |    1 +
 drivers/i2c/chips/twl4030-pwrirq.c          |    1 +
 drivers/i2c/chips/twl4030-usb.c             |    1 +
 drivers/input/keyboard/omap-twl4030keypad.c |    1 +
 drivers/rtc/rtc-twl4030.c                   |    1 +
 drivers/usb/musb/musb_core.c                |    4 +++-
 include/asm-arm/arch-omap/hdrc_cnf.h        |    6 +++---
 12 files changed, 18 insertions(+), 7 deletions(-)

