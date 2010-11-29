From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5 v2] OMAP: idle path errata fixes
Date: Mon, 29 Nov 2010 14:19:48 -0600
Message-ID: <1291061993-4740-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248Ab0K2UT4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 15:19:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Hi,
as discussed in [1], here is step 2 - idle path errata fixes
http://marc.info/?l=linux-omap&m=129045338806957&w=2


Eduardo Valentin (1):
  OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2

Nishanth Menon (1):
  OMAP3630: PM: Erratum i608: disable RTA

Peter 'p2' De Schrijver (2):
  OMAP3: PM: Erratum i581 support: dll kick strategy
  OMAP3630: PM: Disable L2 cache while invalidating L2 cache

Richard Woodruff (1):
  OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all

 arch/arm/mach-omap2/control.c   |    5 +-
 arch/arm/mach-omap2/control.h   |    5 +
 arch/arm/mach-omap2/pm.h        |    6 ++
 arch/arm/mach-omap2/pm34xx.c    |   40 ++++++++
 arch/arm/mach-omap2/sleep34xx.S |  187 ++++++++++++++++++++++++---------------
 5 files changed, 171 insertions(+), 72 deletions(-)

Bloat-o-meter results (Vs 2.6.37-rc3):
add/remove: 1/0 grow/shrink: 7/0 up/down: 257/0 (257)
function                                     old     new   delta
omap3_pm_init                               1776    1916    +140
omap_sram_idle                               996    1048     +52
omap3_save_scratchpad_contents               732     760     +28
vermagic                                      45      60     +15
linux_banner                                 133     147     +14
omap2_init_mmc                              1032    1036      +4
pm34xx_errata                                  -       2      +2
kernel_config_data                         13899   13901      +2

Regards,
Nishanth Menon
