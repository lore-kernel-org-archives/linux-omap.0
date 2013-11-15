From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] Make omap24xx booting device tree based for v3.14 merge window
Date: Thu, 14 Nov 2013 16:09:47 -0800
Message-ID: <1384474198-20756-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42007 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab3KOAKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

Here are some early patches for the v3.14 merge window to make
omap2 booting device tree based before we make omap3 device
tree only. Otherwise we cannot remove the shared platform data
between omap2 and 3 for things like some hwmod entries.

I've added minimal support for 2430sdp to boot it to serial
console with ethernet working, and kept n8x0 support using
the legacy init for the drivers. Then the old H4 I have not
updated as I'm not using it.

Hopefully if there are still people using n8x0 they can
pick up the work from here on removing the rest of the legacy
platform data init as we're planning to drop those things
completely over next few merge cycles.

Note that these patches are against mainline commit 10d0c9705
as there are few device tree related fixes to stuff the resources.   
These also depend on the recently posted fixes series
"[PATCH 0/8] Various omap device tree usability fixes for v3.13
merge window"

Cheers,

Tony


Tony Lindgren (11):
  ARM: dts: Add basic device tree support for omap2430 sdp
  ARM: dts: Add basic Nokia N8X0 support
  ARM: OMAP2+: Add support for board specific auxdata quirks
  ARM: OMAP2+: Add device tree compatible revision checks for n8x0
  ARM: OMAP2+: Make n8x0 behave better with device tree based booting
  ARM: OMAP2+: Add quirks support for n8x0
  ARM: OMAP2+: Remove legacy booting support for n8x0
  ARM: OMAP2+: Remove board file for H4
  ARM: OMAP2+: Remove legacy board file for 2430sdp
  ARM: OMAP2+: Remove legacy mux code for omap2
  ARM: OMAP2+: Remove legacy hwmod entries for omap2

 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/omap2420-n800.dts                |   8 +
 arch/arm/boot/dts/omap2420-n810-wimax.dts          |   8 +
 arch/arm/boot/dts/omap2420-n810.dts                |   8 +
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  34 +
 arch/arm/boot/dts/omap2430-sdp.dts                 |  49 ++
 arch/arm/mach-omap2/Kconfig                        |  13 -
 arch/arm/mach-omap2/Makefile                       |   4 -
 arch/arm/mach-omap2/board-2430sdp.c                | 273 -------
 arch/arm/mach-omap2/board-h4.c                     | 365 ----------
 arch/arm/mach-omap2/board-n8x0.c                   | 190 ++---
 arch/arm/mach-omap2/common-board-devices.h         |   1 +
 arch/arm/mach-omap2/msdi.c                         |  69 --
 arch/arm/mach-omap2/mux.h                          |   2 -
 arch/arm/mach-omap2/mux2420.c                      | 690 ------------------
 arch/arm/mach-omap2/mux2420.h                      | 282 --------
 arch/arm/mach-omap2/mux2430.c                      | 793 ---------------------
 arch/arm/mach-omap2/mux2430.h                      | 370 ----------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         | 137 ----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         | 266 -------
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c | 155 ----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  68 --
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   5 -
 arch/arm/mach-omap2/pdata-quirks.c                 |  46 +-
 24 files changed, 200 insertions(+), 3640 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420-n800.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n810-wimax.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n810.dts
 create mode 100644 arch/arm/boot/dts/omap2420-n8x0-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430-sdp.dts
 delete mode 100644 arch/arm/mach-omap2/board-2430sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-h4.c
 delete mode 100644 arch/arm/mach-omap2/mux2420.c
 delete mode 100644 arch/arm/mach-omap2/mux2420.h
 delete mode 100644 arch/arm/mach-omap2/mux2430.c
 delete mode 100644 arch/arm/mach-omap2/mux2430.h

-- 
1.8.1.1

