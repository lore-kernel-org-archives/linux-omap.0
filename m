From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC][PATCH 0/2] musb init generalization
Date: Thu, 24 Apr 2008 16:46:24 +0300
Message-ID: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37014 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYDXNro (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 09:47:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, khasim@ti.com, Felipe Balbi <felipe.balbi@nokia.com>

The following two patches allow us to use a common
board file for usb initialization on omap2430 and omap3
boards.

First we introduce cpu_class_is_omap3() and use it to change
resource offsets.

It's should be ok adding cpu_class_is_omap3() now since soon we
already have omap35xx chips and sooner or later we're gonna
have patches for it in linux-omap (??)

Both patches are RFC but they're working on omap3430sdp.

Maybe someone could try on omap2430.

Comments are always welcome.

Felipe Balbi (2):
  OMAP: Introduce cpu_class_is_omap3()
  USB: Generalize usb initialization for omap hw

 arch/arm/mach-omap2/Makefile                       |    4 +-
 arch/arm/mach-omap2/board-2430sdp-usb.c            |   96 --------------------
 arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
 .../mach-omap2/{board-3430sdp-usb.c => usb-musb.c} |   32 ++++---
 arch/arm/plat-omap/common.c                        |    2 +-
 arch/arm/plat-omap/dma.c                           |   58 ++++++------
 arch/arm/plat-omap/dmtimer.c                       |   10 +-
 arch/arm/plat-omap/gpio.c                          |   14 ++--
 arch/arm/plat-omap/sram.c                          |    4 +-
 arch/arm/plat-omap/usb.c                           |    2 +-
 include/asm-arm/arch-omap/cpu.h                    |    3 +-
 include/asm-arm/arch-omap/usb-musb.h               |   35 +++++++
 13 files changed, 108 insertions(+), 158 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c
 rename arch/arm/mach-omap2/{board-3430sdp-usb.c => usb-musb.c} (91%)
 create mode 100644 include/asm-arm/arch-omap/usb-musb.h

