From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] Fixes and clean-up in preparation for booting ti81xx
Date: Tue, 13 Jan 2015 15:13:50 -0800
Message-ID: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28945 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbbAMXRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:17:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

The ti81xx support has been in a sorry half-merged state for
past few years in the mainline kernel. Let's get it working
by first fixing the issues.

Note that another series of patches is needed to add the 81xx
related data files.

Regards,

Tony

Tony Lindgren (7):
  ARM: OMAP2+: Remove unused ti81xx platform init code
  ARM: OMAP2+: Fix error handling for omap2_clk_enable_init_clocks
  ARM: OMAP2+: Fix ti81xx devtype
  ARM: OMAP2+: Fix ti81xx class type
  ARM: OMAP2+: Fix dm814 and dm816 for clocks and timer init
  ARM: OMAP2+: Fix reboot for 81xx
  ARM: OMAP2+: Disable omap3 PM init for ti81xx

 arch/arm/mach-omap2/Makefile                |  1 +
 arch/arm/mach-omap2/cclock3xxx_data.c       |  6 +----
 arch/arm/mach-omap2/clock.c                 |  5 +++++
 arch/arm/mach-omap2/common.h                | 11 ++++++++-
 arch/arm/mach-omap2/control.h               |  4 ++++
 arch/arm/mach-omap2/id.c                    |  2 ++
 arch/arm/mach-omap2/io.c                    | 26 ++++++++++++++++-----
 arch/arm/mach-omap2/omap_phy_internal.c     | 35 -----------------------------
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  2 +-
 arch/arm/mach-omap2/prm_common.c            |  4 ++++
 arch/arm/mach-omap2/soc.h                   |  4 ++--
 arch/arm/mach-omap2/ti81xx-restart.c        | 31 +++++++++++++++++++++++++
 arch/arm/mach-omap2/timer.c                 |  2 ++
 arch/arm/mach-omap2/usb-musb.c              | 12 ++--------
 arch/arm/mach-omap2/usb.h                   |  2 --
 15 files changed, 86 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/mach-omap2/ti81xx-restart.c

-- 
2.1.4

