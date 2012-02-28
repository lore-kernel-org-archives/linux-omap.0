From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/9] ARM: OMAP2+: hwmod data: cleanup in preparation for link
 array removal
Date: Tue, 28 Feb 2012 04:10:48 -0700
Message-ID: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35167 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965099Ab2B1LLd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

This series cleans up some hwmod data problems.  Some of these are
necessary prerequisites for the forthcoming link array removal series.

This series is intended to apply on the 'hwmod_code_cleanup_3.4' branch
posted earlier.

This series is available via git at git://git.pwsan.com/linux-2.6 in the
'hwmod_data_cleanup_3.4' branch.


- Paul

---

hwmod_data_cleanup_3.4
   text	   data	    bss	    dec	    hex	filename
6591935	 679436	5593756	12865127	 c44e67	vmlinux.omap2plus_defconfig.orig
6591935	 680332	5593436	12865703	 c450a7	vmlinux.omap2plus_defconfig


Paul Walmsley (9):
      ARM: OMAP2/3: hwmod data: update old names
      ARM: OMAP3: hwmod data: fix interfaces for the MMC hwmods
      ARM: OMAP3: hwmod data: add DSS->L3 interconnect for 3430ES1
      ARM: OMAP3: hwmod data: GPTIMER12 is attached to a separate interconnect
      ARM: OMAP36xx: hwmod data: fix SmartReflex interface data
      ARM: OMAP4: hwmod data: remove bandgap hwmod
      ARM: OMAP4: hwmod data: add OCP_USER_DSP; mark omap44xx_dsp__iva appropriately
      ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
      ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits


 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    4 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  137 ++++++++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   39 +------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +
 5 files changed, 121 insertions(+), 72 deletions(-)

