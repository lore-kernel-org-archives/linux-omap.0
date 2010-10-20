From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3 v2] omap: opp: Add opp data
Date: Tue, 19 Oct 2010 20:02:20 -0500
Message-ID: <1287536543-9729-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45098 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179Ab0JTBC0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 21:02:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@deeprootsystems.com>, Tony <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Rev2 of the original series since opp layer is moved to power for-next tree:
http://marc.info/?l=linux-omap&m=128458780403670&w=2

This series introduces a layer to manage Operating Performance Points (OPPs)
for OMAP SoCs.

Based on kernel.org commit 51ea8a8.
Depends on OPP layer patch from Rafael's tree:
http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commit;h=56149b574181d98aedf97f1f2d91d05ab261db41 

Note: 
Tony, for applying on l-o, the following conflicts:
arch/arm/mach-omap2/Kconfig -> few additional changes to ARCH_OMAP{3,4}
not in kernel.org yet.
arch/arm/mach-omap2/io.c - hwmodint of omap4 is introduced
Conflicts are trivial and if necessary, I can post one rebased to l-o

Patch "omap4: opp: add OPP table data" is based off the OPP data from
http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=blob;f=arch/arm/mach-omap2/opp44xx_data.c;h=252e3d0cb6050a64f390b9311c1c4977d74f762a;hb=refs/heads/omap4_next

Kevin Hilman (1):
  OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
  omap: opp: add OMAP3 OPP table data and common init
  omap4: opp: add OPP table data

 arch/arm/mach-omap2/Kconfig               |    2 +
 arch/arm/mach-omap2/Makefile              |    2 +
 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/mach-omap2/opp.c                 |  142 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.h        |   82 +++++++++++++++++
 arch/arm/mach-omap2/opp4xxx_data.h        |   37 ++++++++
 arch/arm/mach-omap2/pm.c                  |    6 +
 arch/arm/mach-omap2/pm.h                  |    8 ++
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 ++----
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +--
 10 files changed, 291 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp.c
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.h
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.h

 Regards,
 Nishanth Menon
