From: Samreen <samreen@ti.com>
Subject: [PATCH v2 0/2] OMAP3: Display Support
Date: Tue, 26 Oct 2010 09:58:33 +0530
Message-ID: <1288067315-30492-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55989 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028Ab0JZEdy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 00:33:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Mukund Mittal <mmittal@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Samreen <samreen@ti.com>

This patch series adds the Display Support for OMAP3 platforms
and the corresponding changes in the board files.

Version2:
   - Optimised to configure INTBR from gpio to PWM1 mode setting and 
   enabling of the PWM1 mode only when its not in PWM1 mode.

Kishore Y (2):
  OMAP3: ZOOM2/3/3630SDP: Add display board file for OMAP3
  OMAP3: Enable display on ZOOM2/3/3630SDP

 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  167 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   49 +++++++-
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +
 7 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c

