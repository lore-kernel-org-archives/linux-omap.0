From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for 3.5-rc
Date: Thu, 07 Jun 2012 00:13:03 -0600
Message-ID: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60861 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759846Ab2FGGVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Hi,

Here is an initial set of fixes for power management and OMAP core
infrastructure for 3.5-rc.  Most of these patches address boot
warnings and power management problems on OMAP4, although a few of
them address more general issues.

Compile-test information is below.  The patches been boot-tested on
OMAP3530 ES3.0 BeagleBoard and OMAP4430 ES2.0 PandaBoard.  Suspend and
idle are broken on both of these platforms right now.  Unfortunately
my board farm is down at the moment, so I'm unable to do further
testing on other boards.  Boot logs, such as they are, are available
from:

http://www.pwsan.com/omap/bootlogs/20120606/omap_fixes_a_3.5rc__23a432a1860498d0dfbe36319de3b86d9832c6e7/

These patches are available via git from git://git.pwsan.com/linux-2.6
in the branch 'omap_fixes_a_3.5rc'.  Will plan to send a pull request
tomorrow unless there are actionable comments.


- Paul

---

object size (delta in bytes from v3.5-rc1 (f8f5701bdaf9134b1f90e5044a82c66324d2073f)):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
 +352 	  +88 	    0 	 +440 	n800_multi_omap2xxx/vmlinux
 +384 	  +96 	    0 	 +480 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1510_defconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
 +352 	 +312 	    0 	 +664 	omap2_4_testconfig/vmlinux
 +384 	 +448 	    0 	 +832 	omap2plus_defconfig/vmlinux
 +384 	 +384 	    0 	 +768 	omap2plus_no_pm/vmlinux
 +320 	 +320 	    0 	 +640 	omap3_4_testconfig/vmlinux
 +320 	  +88 	    0 	 +408 	omap3_testconfig/vmlinux
 +320 	 +256 	    0 	 +576 	omap4_testconfig/vmlinux


Djamil Elaidi (1):
      ARM: OMAP4+: hwmod: fix issue causing IPs not going back to Smart-Standby

Paul Walmsley (8):
      ARM: OMAP2+: hwmod: add setup_preprogram hook
      ARM: OMAP4+: AESS: enable internal auto-gating during initial setup
      ARM: OMAP4: hwmod data: add SL2IF hardreset line
      ARM: OMAP2+: hwmod code/data: fix 32K sync timer
      ARM: OMAP2+: CM: increase the module disable timeout
      ARM: OMAP4: clock data: add clockdomains for clocks used as main clocks
      ARM: OMAP2+: hwmod: add flag to prevent hwmod code from touching IP block during init
      ARM: OMAP4: hwmod data: do not enable or reset the McPDM during kernel init

Tero Kristo (1):
      ARM: OMAP2+: usb_host_fs: add custom reset for usb_host_fs (fsusb)

Todd Poynor (1):
      ARM: OMAP: PM: Lock clocks list while generating summary


 arch/arm/mach-omap2/Makefile                 |    6 +--
 arch/arm/mach-omap2/aess.c                   |   55 +++++++++++++++++++++++
 arch/arm/mach-omap2/clock44xx_data.c         |    5 ++
 arch/arm/mach-omap2/cm.h                     |   19 ++++++++
 arch/arm/mach-omap2/cminst44xx.c             |    4 +-
 arch/arm/mach-omap2/common.h                 |    2 +
 arch/arm/mach-omap2/omap_hwmod.c             |   58 +++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   23 ++++++++++
 arch/arm/mach-omap2/usb-fs.c                 |   62 ++++++++++++++++++++++++++
 arch/arm/plat-omap/clock.c                   |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   15 ++++++
 arch/arm/plat-omap/include/plat/usb.h        |    3 +
 12 files changed, 238 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-omap2/aess.c

