From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/8] OMAP2+: hwmod core upgrades for 2.6.38: first set
Date: Tue, 16 Nov 2010 03:18:01 -0700
Message-ID: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51520 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934134Ab0KPKTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch series contains upgrades for the OMAP2+ hwmod core
code, intended for 2.6.38.  Most of these patches were developed
in response to use-cases discovered while converting device
drivers to use the hwmod code.

Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.


- Paul

---

hwmod_a_2.6.38
   text	   data	    bss	    dec	    hex	filename
5708416	 472960	5608992	11790368 b3e820	vmlinux.omap2plus_defconfig.orig
5709076	 470560	5608992	11788628 b3e154	vmlinux.omap2plus_defconfig.patched

Paul Walmsley (7):
      OMAP2+: io: split omap2_init_common_hw()
      OMAP2+: hwmod: allow custom pre-shutdown functions
      OMAP2+: hwmod: add postsetup state
      OMAP2+: hwmod: add support for per-class custom device reset functions
      OMAP2+: hwmod: rename omap_hwmod_mutex to _hwmod_list_mutex
      OMAP2+: hwmod: upgrade per-hwmod mutex to a spinlock
      OMAP2+: hwmod: fix a warning, add some docs, remove unused fields

Rajendra Nayak (1):
      OMAP2+: hwmod: Update the sysc_cache in case module context is lost


 arch/arm/mach-omap2/board-2430sdp.c          |    3 
 arch/arm/mach-omap2/board-3430sdp.c          |    3 
 arch/arm/mach-omap2/board-3630sdp.c          |    5 
 arch/arm/mach-omap2/board-4430sdp.c          |    3 
 arch/arm/mach-omap2/board-am3517evm.c        |    4 
 arch/arm/mach-omap2/board-apollon.c          |    3 
 arch/arm/mach-omap2/board-cm-t35.c           |    3 
 arch/arm/mach-omap2/board-cm-t3517.c         |    3 
 arch/arm/mach-omap2/board-devkit8000.c       |    5 
 arch/arm/mach-omap2/board-generic.c          |    3 
 arch/arm/mach-omap2/board-h4.c               |    3 
 arch/arm/mach-omap2/board-igep0020.c         |    4 
 arch/arm/mach-omap2/board-igep0030.c         |    4 
 arch/arm/mach-omap2/board-ldp.c              |    3 
 arch/arm/mach-omap2/board-n8x0.c             |    3 
 arch/arm/mach-omap2/board-omap3beagle.c      |    5 
 arch/arm/mach-omap2/board-omap3evm.c         |    3 
 arch/arm/mach-omap2/board-omap3logic.c       |    3 
 arch/arm/mach-omap2/board-omap3pandora.c     |    5 
 arch/arm/mach-omap2/board-omap3stalker.c     |    3 
 arch/arm/mach-omap2/board-omap3touchbook.c   |    5 
 arch/arm/mach-omap2/board-omap4panda.c       |    3 
 arch/arm/mach-omap2/board-overo.c            |    5 
 arch/arm/mach-omap2/board-rx51.c             |    3 
 arch/arm/mach-omap2/board-zoom.c             |    9 -
 arch/arm/mach-omap2/io.c                     |   32 ++-
 arch/arm/mach-omap2/omap_hwmod.c             |  264 ++++++++++++++++++--------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    2 
 arch/arm/mach-omap2/serial.c                 |    9 -
 arch/arm/plat-omap/include/plat/io.h         |    5 
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   47 +++--
 31 files changed, 302 insertions(+), 153 deletions(-)

