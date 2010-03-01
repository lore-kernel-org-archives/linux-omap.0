From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part2 v1][PATCH 0/4] omap2/3/4: Some more serial work
Date: Mon,  1 Mar 2010 12:55:50 -0600
Message-ID: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab0CASzj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 13:55:39 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o21ItcRJ002241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Mar 2010 12:55:38 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Hi,

This is some proposed cleanups I have been keeping in mind for serial
initialization.

I'm basically proposing:
 - Rename "omap_serial_init" -> "omap_serial_init_allports" to give more
   clarity to the function purpose.
 - Don't enable internal UARTs for Zoom2/3, since they aren't even
   physically reachable. As an end result, Zoom2/3 Default uart will be
   ttyS0.

As a side change, I'm doing a chmod to "644" of some "755" files.

IMPORTANT: This changes are meant to be applied on top of [1] and [2]

Please let me know your comments and thoughts.

Regards,
Sergio

Detailed changelog:

Sergio Aguirre (4):
  omap2/3/4: serial: rename omap_serial_init
  omap3: zoom2/3 / 3630sdp: Don't init always all uarts
  omap3: 3630sdp: Explicitly enable all UARTs
  omap3: zoom 2/3: Change debugboard serial port id

 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c          |    1 +
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c        |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-generic.c          |    2 +-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-ldp.c              |    2 +-
 arch/arm/mach-omap2/board-n8x0.c             |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-rx51.c             |    2 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
 arch/arm/mach-omap2/serial.c                 |    8 ++++----
 arch/arm/plat-omap/include/plat/serial.h     |    2 +-
 23 files changed, 25 insertions(+), 25 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c

[1] http://marc.info/?l=linux-omap&m=126730356232287&w=2
[2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2

