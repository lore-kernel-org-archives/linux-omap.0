From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 00/12] ARM: OMAP: DMTIMER clean-up and fixes in preparation for device-tree
Date: Tue, 5 Jun 2012 12:34:48 -0500
Message-ID: <1338917700-29174-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44229 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979Ab2FERfF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 13:35:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

In order to migrate the dmtimer driver to support device-tree I found that it
was first necessary to clean-up the timer platform data. The goal of this
series is to simplify the timer platform data structure from ...

struct dmtimer_platform_data {
	int (*set_timer_src)(struct platform_device *pdev, int source);
	int timer_ip_version;
	u32 needs_manual_reset:1;
	bool reserved;
	bool loses_context;
	int (*get_context_loss_count)(struct device *dev);
};

to ...

struct dmtimer_platform_data {
	/* set_timer_src - Only used for OMAP1 devices */
	int (*set_timer_src)(struct platform_device *pdev, int source);
	u32 timer_capability;
};

... where timer_capability is a bit mask that indicates the timer features
supported and uses the HWMOD timer capabilities flags described in
plat/dmtimer.h. For OMAP2+ devices this allows us to read the timer
capabilities from the HWMOD data and for OMAP1 devices the flags are simply
populated by the timer initialisation code. Eventually, the aim is to read the
timer capabilities from the device tree blob.

This series includes some fixes as well as clean-up. For instance OMAP1 dmtimer
support is currently completely broken and so I have included a fix for this.
If it is preferred to split the series into fixes and clean-up I can do that.

This series is based upon the current linux-omap master branch (3.5-rc1).

Testing:
- I have built both omap1 and omap2plus configurations as well as booted the
  respective kernels on the omap5912 OSK (omap1), OMAP3430 Beagle and OMAP4430
  Blaze.
- On the above boards I have also verified that I can request a dmtimer and set
  the parent clock.

V4:
- Well this is embarrassing! Somehow the removal of "needs_manual_reset"
  variable got dropped during the rebase to 3.5-rc1.
- Re-ordered patches to avoid any compilation breaks.

V3:
- Unsquashed two patches (9 and 10) that I had previously managed to squash by
  accident :-(

V2:
- Fix OMAP1 dmtimer support which currently broken. Requesting a timer
  fails because clk_get() is called and this is not support for OMAP1
  devices.
- Only use "set_timer_src" function pointer for OMAP1 devices.

Jon Hunter (12):
  ARM: OMAP: Remove unnecessary clk structure
  ARM: OMAP2+: Remove unused max number of timers definition
  ARM: OMAP2+: Add dmtimer platform function to reserve systimers
  ARM: OMAP: Add DMTIMER capability variable to represent timer
    features
  ARM: OMAP2+: HWMOD: Correct timer device attributes
  ARM: OMAP2+: Fix external clock support for dmtimers
  ARM: OMAP: Remove loses_context variable from timer platform data
  ARM: OMAP: Remove timer function pointer for context loss counter
  ARM: OMAP: Add flag to indicate if a timer needs a manual reset
  ARM: OMAP1: Fix dmtimer support
  ARM: OMAP2+: Move dmtimer clock set function to dmtimer driver
  ARM: OMAP2+: Simplify dmtimer clock aliases

 arch/arm/mach-omap1/timer.c                        |    3 +-
 arch/arm/mach-omap2/clock2420_data.c               |   39 +------
 arch/arm/mach-omap2/clock2430_data.c               |   39 +------
 arch/arm/mach-omap2/clock3xxx_data.c               |   26 +----
 arch/arm/mach-omap2/clock44xx_data.c               |   34 +++---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    8 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   10 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 --
 arch/arm/mach-omap2/timer.c                        |   82 +--------------
 arch/arm/plat-omap/dmtimer.c                       |  111 +++++++++++++++-----
 arch/arm/plat-omap/include/plat/dmtimer.h          |   22 +---
 11 files changed, 118 insertions(+), 262 deletions(-)

-- 
1.7.9.5

