From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] OMAP2+: hwmod: miscellaneous fixes for 2.6.39
Date: Mon, 07 Mar 2011 22:44:25 -0700
Message-ID: <20110308054315.1309.10538.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60566 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1CHFp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 00:45:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

this series contains some fixes for the OMAP hwmod code and data:

- the OCP_SYSCONFIG.AUTOIDLE bit mask has been corrected;

- several OMAP2/3 hwmods have been marked with SYSS_HAS_RESET_STATUS,
  which was previously missing;

- _init_clocks() now passes along the return value of its clock lookups,
  allowing an enclosing iterator to terminate if something goes wrong;

- an enhancement allowing non-standard OMAP2/3 hard-reset line status bit
  shifts to be explicitly specified;

- and a minor documentation fix.


- Paul


---

hwmod_a_2.6.39
   text	   data	    bss	    dec	    hex	filename
5702465	 501384	5596664	11800513	 b40fc1	vmlinux.omap2plus_defconfig.orig
5702629	 501384	5596664	11800677	 b41065	vmlinux.omap2plus_defconfig


Avinash.H.M (1):
      omap: hwmod: add syss reset done flags to omap2, omap3 hwmods

Paul Walmsley (1):
      OMAP2+: hwmod: fix a documentation bug with HWMOD_NO_OCP_AUTOIDLE

Rajendra Nayak (1):
      OMAP2+: hwmod: Fix what _init_clock returns

Tarun Kanti DebBarma (1):
      OMAP2+: hwmod: fix incorrect computation of autoidle_mask

omar ramirez (1):
      OMAP2+: hwmod: use status bit info for reset line


 arch/arm/mach-omap2/omap_hwmod.c             |   79 +++++++++++++++-----------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |   11 ++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |   12 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   13 +++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   18 +++---
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    5 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +
 7 files changed, 82 insertions(+), 60 deletions(-)

