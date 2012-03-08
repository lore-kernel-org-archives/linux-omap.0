From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/15] ARM: OMAP4: hwmod data: add almost all remaining IP
 blocks
Date: Thu, 08 Mar 2012 03:51:23 -0700
Message-ID: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47038 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2CHKxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

This series adds basic hwmods for all but one of the remaining
OMAP4 IP blocks that can be meaningfully controlled by the
kernel.  (The remaining IP block is the USIM - there's a clocking
problem that requires further investigation to resolve.)

There are a few new boot-time warnings added by this series:

[    0.280548] omap_hwmod: trace_clk_div_ck: missing clockdomain for tr=
ace_clk_div_ck.
[    0.302429] omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck=
=2E
[    0.319519] omap_hwmod: sl2if: cannot be enabled for reset (3)

These messages will be resolved by subsequent patches, and, while annoy=
ing,
should not affect the operation of the system.

These patches have been boot-tested and suspend-tested on a
OMAP44xx PandaBoard.

The series is intended to apply on the
'hwmod_remove_link_arrays_cleanup_3.4' branch, posted previously.

These patches are also available via git from git://git.pwsan.com/linux=
-2.6
in the branch "hwmod_enable_remaining_hwmods_devel_3.4".


- Paul

---

hwmod_enable_remaining_hwmods_devel_3.4
   text	   data	    bss	    dec	    hex	filename
6590067	 677452	5593500	12861019	 c43e5b	vmlinux.omap2plus_defconfig.or=
ig
6594227	 684620	5593500	12872347	 c46a9b	vmlinux.omap2plus_defconfig

Beno=C3=AEt Cousson (6):
      ARM: OMAP4: hwmod data: add GPMC
      ARM: OMAP4: hwmod data: add the Slimbus IP blocks
      ARM: OMAP4: hwmod data: add McASP
      ARM: OMAP4: hwmod data: add remaining USB-related IP blocks
      ARM: OMAP4: hwmod data: add the OCP-WP IP block
      ARM: OMAP4: hwmod data: add DEBUGSS skeleton

Ming Lei (1):
      ARM: OMAP4: hwmod data: introduce fdif(face detect module) hwmod

Paul Walmsley (8):
      ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common
      ARM: OMAP4: hwmod data: add HDQ/1-wire
      ARM: OMAP4: hwmod data: add EMIF1 and 2
      ARM: OMAP4: hwmod data: add GPU
      ARM: OMAP4: hwmod data: add some interconnect-related IP blocks
      ARM: OMAP4: hwmod data: add OCM RAM IP block
      ARM: OMAP4: hwmod data: add System Control Module
      ARM: OMAP4: hwmod data: add PRCM and related IP blocks


 arch/arm/mach-omap2/Makefile                     |    8=20
 arch/arm/mach-omap2/clockdomain44xx.c            |    6=20
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   10=20
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2=20
 arch/arm/mach-omap2/clockdomains_common_data.c   |   24=20
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       | 1473 ++++++++++++++=
+++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1=20
 7 files changed, 1443 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
