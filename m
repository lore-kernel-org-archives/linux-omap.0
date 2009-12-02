From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 00/10] cleanups, compile fix, cbus
Date: Thu,  3 Dec 2009 00:35:42 +0200
Message-ID: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60596 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbZLBWgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

on the following we have section mismatch fixes,
compile fix to board-nokia770.c, compile fix to sossi.c,
compile fix to hwa742.c, compile fix to tahvo-usb.c
and a few cleanups to cbus driver.

It's compile tested only as I don't have 770s or n8x0 with
the development jig available right now, so please, if you
have any of those boards dusting around, test the following
patches.

(looks like everything is compiling fine now)

Felipe Balbi (10):
  arm: omap1: clock: fix section mismatch
  arm: omap: n770: make it build again
  video: omap: sossi: make it build again
  video: omap: hwa742: make it build again
  cbus: tahvo-usb: make it build again
  cbus: switch to kzalloc
  cbus: move EXPORT_SYMBOL close to its exported symbols
  cbus: separate into several MODULE_AUTHOR entries
  cbus: move to platform_driver
  cbus: add platform_data to pass gpios

 arch/arm/mach-omap1/board-nokia770.c   |   18 +++++++-
 arch/arm/mach-omap1/clock.c            |    2 +-
 arch/arm/mach-omap2/board-n8x0.c       |   18 +++++++
 arch/arm/plat-omap/include/plat/cbus.h |   31 +++++++++++++
 drivers/cbus/cbus.c                    |   77 ++++++++++++++++++--------------
 drivers/cbus/tahvo-usb.c               |   12 +++---
 drivers/video/omap/hwa742.c            |    1 +
 drivers/video/omap/sossi.c             |    1 +
 8 files changed, 119 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/cbus.h

