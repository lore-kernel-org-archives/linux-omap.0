From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/9] OMAP2+: hwmod/clockevent: allow hwmods to be set up
	individually
Date: Mon, 28 Feb 2011 14:12:02 -0700
Message-ID: <20110228210858.15286.3200.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50081 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab1B1VOT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 16:14:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series adds the ability to set up (formerly known
as "late-initialize") individual hwmods, rather than doing them
all at once.  The goal here is for clockevent (and eventually
clocksource) hwmods to be set up right before they are needed, in
the timer init code.  Then omap_hwmod_setup_all(), which
sets up the rest of the hwmods, is intended to run as an
initcall -- much later in the boot process.

This series includes the OMAP2/3 hwmod data for the GPTIMERs that
Tarun posted earlier.  This data is necessary for this new code
to avoid warnings during boot.

Boot-tested on OMAP34xx Beagleboard and OMAP4430ES2 Panda.
Applies on Tony's 7cab8713b1ed0dab08ad6458f92a40b7ff4be619
("Merge branch 'for-tony' of
git://gitorious.org/linux-omap-dss2/linux into omap-for-linus")


- Paul

---

hwmod_clockevent_2.6.39
   text	   data	    bss	    dec	    hex	filename
5781261	 484056	5598712	11864029	 b507dd	vmlinux.omap2plus_defconfig.orig
5785233	 491096	5598680	11875009	 b532c1	vmlinux.omap2plus_defconfig

Paul Walmsley (6):
      OMAP2+: hwmod: allow multiple calls to omap_hwmod_init()
      OMAP2+: hwmod: rename some init functions
      OMAP2+: hwmod: find MPU initiator hwmod during in _register()
      OMAP2+: hwmod: ignore attempts to re-setup a hwmod
      OMAP2+: hwmod: add ability to setup individual hwmods
      OMAP2+: clockevent: set up GPTIMER clockevent hwmod right before timer init

Thara Gopinath (3):
      OMAP2420: hwmod data: add dmtimer
      OMAP2430: hwmod data: add dmtimer
      OMAP3: hwmod data: add dmtimer


 arch/arm/mach-omap2/omap_hwmod.c             |  154 ++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |  636 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |  635 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  651 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 
 arch/arm/mach-omap2/serial.c                 |    2 
 arch/arm/mach-omap2/timer-gp.c               |    7 
 arch/arm/plat-omap/include/plat/dmtimer.h    |   11 
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 
 9 files changed, 2045 insertions(+), 62 deletions(-)

