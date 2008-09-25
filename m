From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/4] twl4030 driver changes
Date: Thu, 25 Sep 2008 17:48:49 +0300
Message-ID: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22007 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYIYOtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:49:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Move twl4030 keypad and usb to new style of
registration for twl4030 driver introduced
by David Brownell.

This is how the device tree looks now:

$ find /sys | grep twl4030
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/uevent
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/modalias
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/subsystem
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/bus
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/power
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/power/wakeup
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/driver
/sys/class/i2c-adapter/i2c-1/1-0048/twl4030_usb/vbus

/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/uevent
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/modalias
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/subsystem
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/bus
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/power
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/power/wakeup
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/driver
/sys/class/i2c-adapter/i2c-1/1-004a/twl4030_keypad/input:input1

/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/uevent
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/modalias
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/subsystem
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/bus
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/power
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/power/wakeup
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/driver
/sys/class/i2c-adapter/i2c-1/1-004b/twl4030_rtc/rtc:rtc0

Felipe Balbi (4):
  i2c: clean add_children a bit
  i2c: move twl4030_keypad to new style registration
  i2c: move twl4030-usb to platform_device
  i2c: twl4030-usb: add 'vbus' sysfs file

 arch/arm/mach-omap2/board-2430sdp.c         |   20 +-
 arch/arm/mach-omap2/board-3430sdp.c         |   19 +-
 arch/arm/mach-omap2/board-omap2evm.c        |   21 +-
 arch/arm/mach-omap2/board-omap3evm.c        |   20 +-
 drivers/i2c/chips/Kconfig                   |   16 --
 drivers/i2c/chips/twl4030-core.c            |  100 ++++++--
 drivers/i2c/chips/twl4030-usb.c             |  373 ++++++++++++++-------------
 drivers/input/keyboard/omap-twl4030keypad.c |    6 +-
 include/linux/i2c/twl4030.h                 |   38 +++
 9 files changed, 344 insertions(+), 269 deletions(-)

