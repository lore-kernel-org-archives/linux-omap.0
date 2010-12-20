From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 0/7] OMAP: idle path errata fixes
Date: Mon, 20 Dec 2010 14:05:02 -0600
Message-ID: <1292875509-9896-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38105 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130Ab0LTUFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 15:05:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Santosh <santosh.shilimkar@ti.com>

Hi,
as discussed in [1], here is step 2 - idle path errata fixes.
this is the next rev incorporating comments from V4 of this series.

Rebased to: 2.6.37-rc6 (k.org vanilla)

Tested:
this series:
	SDP3430
	SDP3630
this series + ASM cleanup series[2]
	SDP3430
	SDP3630
Test Script:
http://elinux.org/OMAP_Power_Management#Quick_verification_of_suspend-idle_functionality

v4: http://marc.info/?l=linux-omap&m=129271283307741&w=2
V3: http://marc.info/?t=129140247800030&r=1&w=2
V2: http://marc.info/?l=linux-omap&m=129106200408109&w=2

Major change in V5:
	comment updates, minor typo cleanups
	collated acks

Eduardo Valentin (1):
  OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2

Nishanth Menon(3):
  OMAP3: pm: introduce errata handling
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
 arch/arm/mach-omap2/cpuidle34xx.c |   31 ++++--
 arch/arm/mach-omap2/pm.h          |   15 +++-
 arch/arm/mach-omap2/pm34xx.c      |   47 +++++++++-
 arch/arm/mach-omap2/sleep34xx.S   |  191 +++++++++++++++++++++++--------------
 6 files changed, 218 insertions(+), 86 deletions(-)

bloat-o-meter report Vs 2.6.37-rc6
add/remove: 2/0 grow/shrink: 8/1 up/down: 330/-1 (329)
function                                     old     new   delta
omap3_pm_off_mode_enable                      80     192    +112
omap3_pm_init                               1792    1872     +80
omap3630_ctrl_disable_rta                      -      44     +44
omap3_save_scratchpad_contents               732     760     +28
static.__func__                            13783   13808     +25
vermagic                                      45      60     +15
linux_banner                                 132     147     +15
prcm_interrupt_handler                       268     276      +8
pm34xx_errata                                  -       2      +2
static.__warned                              238     239      +1
kernel_config_data                         13718   13717      -1


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
