From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/11] omap2/3/4: Multi-omap updates to boot test with
	omap3_defconfig
Date: Fri, 30 Apr 2010 13:33:39 -0700
Message-ID: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60726 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab0D3Udp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:33:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This series makes the omap3_defconfig bootable on most mach-omap2
boards. So far I've boot tested omap3_defconfig on:

BOARD	OMAP	ARM	NOTES
n800	2420	ARMv6	Userspace won't boot because of TLS and VFP issues
n900	3430	ARMV7
zoom3	3630	ARMV7
blaze	4430	ARMV7	CONFIG_SMP disabled

I've pushed these into multi-omap branch in the linux omap tree,
would like to hear status of other boards booting with omap3_defconfig
with these patches.

CONFIG_FB_OMAP is now disabled until some weirdness on at least zoom3
is sorted out. And, you need to disable CONFIG_KPROBES on 2.6.34-rc6
until that fix is in mainline.

Anyways, let's use omap3_defconfing from now on to compile and boot
test every patch as a sanity test.

Regards,

Tony


---

Tony Lindgren (11):
      omap2/3/4: Fix multi.h when omap3 and omap4 are selected without omap2
      omap2/3: Fix DEBUG_LL for omap zoom2/3
      omap3: Fix compile for board-cm-t35
      omap3: Remove non-muxable ball entries for 3630
      omap4: Fix multiboot with CONFIG_PM and CONFIG_ARCH_OMAP3 selected
      omap4: Fix omap_l2_cache_init not to run for other omaps
      omap2/3/4: Add new boards to omap3_defconfig
      omap2/3/4: Make omap3_defconfig usable on Nokia boards
      omap2/3/4: Update PMIC options for TWL and Menelaus chips
      omap2/3/4: Dissable CONFIG_PM_VERBOSE in omap3_defconfig
      omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig


 arch/arm/configs/omap3_defconfig               |   34 ++++-----
 arch/arm/kernel/head.S                         |   10 +++
 arch/arm/mach-omap2/board-4430sdp.c            |    3 +
 arch/arm/mach-omap2/board-cm-t35.c             |    1 
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 -
 arch/arm/mach-omap2/include/mach/debug-macro.S |    4 +
 arch/arm/mach-omap2/io.c                       |    9 +++
 arch/arm/mach-omap2/mux34xx.c                  |   86 ------------------------
 arch/arm/plat-omap/include/plat/multi.h        |   16 +++-
 arch/arm/plat-omap/include/plat/serial.h       |    2 -
 arch/arm/plat-omap/sram.c                      |   16 ++++
 11 files changed, 68 insertions(+), 115 deletions(-)

-- 
Signature
