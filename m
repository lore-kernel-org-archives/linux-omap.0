From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5] OMAP2+: trivial sparse fixes
Date: Tue,  4 Jan 2011 14:07:09 -0600
Message-ID: <1294171634-13943-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40696 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab1ADUIX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 15:08:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Source: git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch: omap-for-linus (dc69d1a omap2: Make OMAP2PLUS select OMAP_DM_TIMER)

Building for sparse warnings result in the following warnings:
http://pastebin.mozilla.org/907954

This is series 2 of the sparse fixes
(series 1:
 http://marc.info/?t=129408118000003&r=1&w=2
 and
 http://marc.info/?t=129408352700002&r=1&w=2)

Nishanth Menon (5):
  omap3|4: mux: make local structures static
  omap3: zoom: use static for pointer passing
  omap3: igep3: make igep3_flash_init static
  omap2+: wdt: trivial sparse fixes
  omap2+: pm_bus: make functions used as pointers as static

 arch/arm/mach-omap2/board-igep0030.c         |    4 ++--
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++--
 arch/arm/mach-omap2/devices.c                |    2 +-
 arch/arm/mach-omap2/mux34xx.c                |    4 ++--
 arch/arm/mach-omap2/mux44xx.c                |    6 +++---
 arch/arm/mach-omap2/pm_bus.c                 |    4 ++--
 arch/arm/mach-omap2/wd_timer.c               |    2 ++
 7 files changed, 14 insertions(+), 12 deletions(-)

---
Regards,
Nishanth Menon
