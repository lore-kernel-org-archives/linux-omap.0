From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 0/7] OMAP: idle path errata fixes
Date: Sat, 18 Dec 2010 16:53:30 -0600
Message-ID: <1292712817-24999-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab0LRWxu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Dec 2010 17:53:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Hi,
as discussed in [1], here is step 2 - idle path errata fixes.
this is the next rev incorporating comments from V2 post
of this series.

Tested:
this series:
	SDP3430
	SDP3630
this series + ASM cleanup series[2]
	SDP3430
	SDP3630
Test Script:
http://elinux.org/OMAP_Power_Management#Quick_verification_of_suspend-idle_functionality

V3: http://marc.info/?t=129140247800030&r=1&w=2

V2: http://marc.info/?l=linux-omap&m=129106200408109&w=2

Major change in V3:
	Erratas are now handled per silicon - it is much cleaner :)
	no more redundant cpu_is_omap34xx check anymore
	errata configure is __init as it should be

Eduardo Valentin (1):
  OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2

Nishanth Menon (3):
  omap3: pm: introduce errata handling
  OMAP3630: PM: Erratum i608: disable RTA
  OMAP3: PM: make omap3_cpuidle_update_states independent of
    enable_off_mode

Peter 'p2' De Schrijver (2):
  OMAP3: PM: Erratum i581 support: dll kick strategy
  OMAP3630: PM: Disable L2 cache while invalidating L2 cache

Richard Woodruff (1):
  OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all

 arch/arm/mach-omap2/control.c     |   13 +++-
 arch/arm/mach-omap2/control.h     |    7 +-
 arch/arm/mach-omap2/cpuidle34xx.c |   29 ++++--
 arch/arm/mach-omap2/pm.h          |   15 +++-
 arch/arm/mach-omap2/pm34xx.c      |   46 +++++++++-
 arch/arm/mach-omap2/sleep34xx.S   |  187 +++++++++++++++++++++++--------------
 6 files changed, 211 insertions(+), 86 deletions(-)

bloat-o-meter report Vs 2.6.37-rc6
add/remove: 2/0 grow/shrink: 7/0 up/down: 297/0 (297)
function                                     old     new   delta
omap3_pm_off_mode_enable                      80     160     +80
omap3_pm_init                               1792    1872     +80
omap3630_ctrl_disable_rta                      -      44     +44
omap3_save_scratchpad_contents               732     760     +28
static.__func__                            13783   13808     +25
vermagic                                      45      60     +15
linux_banner                                 132     147     +15
prcm_interrupt_handler                       268     276      +8
pm34xx_errata                                  -       2      +2

[1] http://marc.info/?l=linux-omap&m=129045338806957&w=2
[2] http://marc.info/?l=linux-omap&m=129268746417556&w=2

Cc: Charulatha Varadarajan <charu@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tao Hu <tghk48@motorola.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

---
Regards,
Nishanth Menon
