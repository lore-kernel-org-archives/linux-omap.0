From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/8] ARM: OMAP2+: hwmod/timer: first set of cleanups for 3.4
Date: Mon, 27 Feb 2012 22:36:43 -0700
Message-ID: <20120228053524.16278.59430.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58081 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2B1Fhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 00:37:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

This series does some cleanup and documentation on the OMAP hwmod code
(and a bit of the OMAP4 data) and timer code. It is the first
prerequisite series to removing a big chunk of hwmod data -- that
will be done in a later series.  This second version reimplements
the hardreset code in a way that will hopefully fix some of the
issues that Kevin was seeing.

Boot-tested on an OMAP35xx BeagleBoard and OMAP44xx ES2 Pandaboard.

This series is also available via git from git://git.pwsan.com/linux-2.6 in
the branch "hwmod_code_cleanup_3.4".


- Paul

---

hwmod_code_cleanup_3.4
   text	   data	    bss	    dec	    hex	filename
6600418	 680476	5593820	12874714	 c473da	vmlinux.omap2plus_defconfig.orig
6600374	 679788	5593820	12873982	 c470fe	vmlinux.omap2plus_defconfig

Paul Walmsley (8):
      ARM: OMAP2+: hwmod: control all hardreset lines attached to a hwmod
      ARM: OMAP4: hwmod data: remove pseudo-hwmods associated with hardreset lines
      ARM: OMAP2+: hwmod: reorganize and document the setup process
      ARM: OMAP2+: hwmod: revise hardreset behavior
      ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are reprogrammed after a reset
      ARM: OMAP2+: hwmod: provide a function to return the address space of the MPU RT
      ARM: OMAP2+: hwmod: add omap_hwmod_get_resource_byname()
      ARM: OMAP2+: timer: use a proper interface to get hwmod data


 arch/arm/mach-omap2/omap_hwmod.c             |  671 +++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  101 ----
 arch/arm/mach-omap2/timer.c                  |   15 -
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 
 4 files changed, 520 insertions(+), 269 deletions(-)

