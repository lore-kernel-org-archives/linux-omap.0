From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/3] my pending patches
Date: Wed, 13 Aug 2008 20:36:14 +0300
Message-ID: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33714 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbYHMRfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 13:35:53 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7DHZfK6023723
	for <linux-omap@vger.kernel.org>; Wed, 13 Aug 2008 12:35:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Hi tony,

following are my three pending patches since last merge.
At least patch #2 for musb should be applied before
next merge with mainline. Another version of that
patch (without board-file changes) is already in
Greg's queue and without this version of that patch
in l-o, musb will be broken.

It's also a good idea to apply this before you format
omap2/3 patches to mainline since I'm getting rid of
hdrc_conf.h file, so we don't polute mailine with an
extra unused file.

ps: I'm on vacations until next week and I don't have
devices with me to test them on. The patches were working
last time I tried, but after merge I only rebased them and
made sure they build. So, please, give it a try before
applying.

Felipe Balbi (3):
  input: keypad: General fixes to omap-twl4030keypad.c
  usb: musb: pass configuration specifics via pdata
  input: add more error checks to lm8323 driver

 arch/arm/mach-omap2/board-2430sdp.c         |    5 +-
 arch/arm/mach-omap2/board-3430sdp.c         |    5 +-
 arch/arm/mach-omap2/board-n800-usb.c        |   46 ++++++-
 arch/arm/mach-omap2/usb-musb.c              |   51 +++++++-
 arch/arm/mach-omap2/usb-tusb6010.c          |    1 -
 drivers/input/keyboard/lm8323.c             |   42 ++++--
 drivers/input/keyboard/omap-twl4030keypad.c |  204 ++++++++++++++++-----------
 drivers/usb/musb/musb_core.c                |   37 ++---
 drivers/usb/musb/musb_core.h                |   14 +--
 drivers/usb/musb/tusb6010.h                 |  169 ----------------------
 include/asm-arm/arch-omap/hdrc_cnf.h        |  177 -----------------------
 include/asm-arm/arch-omap/keypad.h          |    1 +
 include/linux/usb/musb.h                    |   38 +++++-
 13 files changed, 305 insertions(+), 485 deletions(-)
 delete mode 100644 include/asm-arm/arch-omap/hdrc_cnf.h

