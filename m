From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
	hwmods
Date: Wed, 23 Feb 2011 00:11:43 -0700
Message-ID: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58746 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab1BWHNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:13:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hello,

This series adds the ability to late-initialize individual
hwmods.  The goal here is for clockevent (and eventually
clocksource) hwmods to be late-initialized individually, and
right before they are needed, in the timer init code.  Then
omap_hwmod_late_init(), which late-inits the rest of the hwmods,
is intended to run as an initcall -- much later in the boot
process.

This series includes the OMAP2/3 hwmod data for the GPTIMERs that
Tarun posted earlier.  This data is necessary for this new code
to avoid warnings during boot.

Boot-tested on N800, OMAP34xx Beagleboard and OMAP4430ES2 Panda.
Applies on Tony's 04aa67dec63b61c1a8b9b6d001262250f1a92130
("Merge branch 'for-tony' of git://gitorious.org/usb/usb into omap-for-linus")


- Paul

---

hwmod_clockevent_2.6.39
   text	   data	    bss	    dec	    hex	filename
5774609	 497512	5596888	11869009	 b51b51	vmlinux.omap2plus_defconfig.orig
5778597	 504584	5596856	11880037	 b54665	vmlinux.omap2plus_defconfig


Paul Walmsley (5):
      OMAP2+: hwmod: find MPU initiator hwmod during in _register()
      OMAP2+: hwmod: allow multiple calls to omap_hwmod_init()
      OMAP2+: hwmod: ignore attempts to re-late-init a hwmod
      OMAP2+: hwmod: add ability to late-init individual hwmods
      OMAP2+: clockevent: late-init GPTIMER clockevent hwmod right before timer init

Thara Gopinath (3):
      OMAP2420: hwmod data: add dmtimer
      OMAP2430: hwmod data: add dmtimer
      OMAP3: hwmod data: add dmtimer


 arch/arm/mach-omap2/omap_hwmod.c             |  124 +++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  634 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  633 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  649 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c               |    8 
 arch/arm/plat-omap/include/plat/dmtimer.h    |   11 
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 
 7 files changed, 2024 insertions(+), 38 deletions(-)

