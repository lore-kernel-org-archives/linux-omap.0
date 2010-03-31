From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 0/3] 32k timer patches
Date: Wed, 31 Mar 2010 14:13:12 +0300
Message-ID: <1270033995-12516-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46221 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756880Ab0CaLNv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 07:13:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

The following patches convert 32k-sync timer into a platform_driver
and also remove dead code from timer32k.c

If anyone has a good idea on how to fix-up timer-gp.c, I'll be
glad to hear. Currently I can't move it to platform_driver
because it's used the system timer during machine start so I can't
find a proper location to register the platform_device. If we don't
register a system timer, we will loop forever trying to calibrate
the delay loop.

The patches were boot tested on rx51 and compile tested with
omap_h2_1610_defconfig.

Aaro Koskinen (1):
  omap: fix clocksource_32k to start from zero

Felipe Balbi (2):
  arm: omap1: remove dead code from timer32k.c
  arm: omap1/2/3/4: convert clocksource to a platform_driver

 arch/arm/mach-omap1/devices.c        |   24 ++++
 arch/arm/mach-omap1/timer32k.c       |   15 --
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 arch/arm/mach-omap2/devices.c        |   38 +++++
 arch/arm/plat-omap/Makefile          |    4 +-
 arch/arm/plat-omap/common.c          |  149 --------------------
 arch/arm/plat-omap/timer-32k-sync.c  |  250 ++++++++++++++++++++++++++++++++++
 9 files changed, 317 insertions(+), 169 deletions(-)
 create mode 100644 arch/arm/plat-omap/timer-32k-sync.c

