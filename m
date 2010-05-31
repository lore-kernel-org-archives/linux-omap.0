From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv1 0/1] omap3: pm: Delink OPP layer from cpufreq
Date: Mon, 31 May 2010 18:08:47 +0530
Message-ID: <1275309527-25965-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41951 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab0EaMiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 May 2010 08:38:54 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4VCcpqd016851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 31 May 2010 07:38:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The OPP layer is currently contained in CONFIG_CPU_FREQ.
When the ARM frequency is set via bootarg 'mpurate' the
OPP layer is required to:
  - verify that specified mpurate is valid and available
    in the OPP table.
  - get voltage corresponding to specified frequency.

This is initial attempt to make OPP layer available without
cpufreq. Since, this is initial version, i am making changes
in board-omap3evm.c only. same change will be required in
other board files as well. Will do so in next version of
the patch.

I have also updated the OPP tables for OMAP3430 to include
support for 720MHz. It will be a separate patch when I submit
it next.

  [1] http://marc.info/?l=linux-omap&m=127495955603835&w=2


Sanjeev Premi (1):
  omap3: pm: Delink opp layer and cpufreq

 arch/arm/mach-omap2/Makefile          |    6 +-
 arch/arm/mach-omap2/board-omap3evm.c  |    2 +-
 arch/arm/mach-omap2/cpufreq34xx.c     |  164 --------------------------------
 arch/arm/mach-omap2/omap3-opp.h       |   20 ----
 arch/arm/mach-omap2/opp34xx_data.c    |  166 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c          |    1 -
 arch/arm/plat-omap/Makefile           |    7 +-
 arch/arm/plat-omap/cpu-omap.c         |   47 +++++++++
 arch/arm/plat-omap/include/plat/opp.h |   82 +---------------
 arch/arm/plat-omap/opp.c              |   46 ---------
 10 files changed, 225 insertions(+), 316 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cpufreq34xx.c
 delete mode 100644 arch/arm/mach-omap2/omap3-opp.h
 create mode 100644 arch/arm/mach-omap2/opp34xx_data.c

