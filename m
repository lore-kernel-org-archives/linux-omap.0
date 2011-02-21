From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] OMAP2+: voltage: first pass at cleanup/reorganization
Date: Sun, 20 Feb 2011 19:08:51 -0700
Message-ID: <20110221020231.7598.14024.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59239 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1BUCMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Feb 2011 21:12:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, nm@ti.com, b-cousson@ti.com, mturquette@ti.com

Hello,

this patch set does an initial round of cleanup on the OMAP "voltage" code
in arch/arm/mach-omap2/voltage.c.  As part of this process, the header files
for the voltage code and SmartReflex are moved into arch/arm/mach-omap2, since
they are currently OMAP2+-specific.

There is still quite a bit of cleanup left to do; hopefully someone else will
get to it before I do.  More details are in the last patch.

This series was built-tested for an OSK5912-specific config, omap1_defconfig,
a N800-specific config, omap2plus_defconfig, an OMAP3-specific config, and
an OMAP4-specific config.  It was boot-tested on an OMAP35xx Beagleboard.
Further testing assistance is, of course, appreciated.

This series is available from git://git.pwsan.com/linux-2.6 in the
'voltage_split_2.6.39' branch.


- Paul


---

voltage_split_2.6.39
   text	   data	    bss	    dec	    hex	filename
5766071	 488104	5596920	11851095	 b4d557	vmlinux.omap2plus_defconfig.orig
5765631	 487848	5596920	11850399	 b4d29f	vmlinux.omap2plus_defconfig


Paul Walmsley (3):
      OMAP: smartreflex: move plat/smartreflex.h to mach-omap2/smartreflex.h
      OMAP: voltage: move plat/voltage.h to mach-omap2/voltage.h
      OMAP2+: voltage: reorganize, split code from data


 arch/arm/mach-omap2/Makefile                  |   20 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 
 arch/arm/mach-omap2/omap_opp_data.h           |   12 
 arch/arm/mach-omap2/omap_twl.c                |    2 
 arch/arm/mach-omap2/opp3xxx_data.c            |   44 +
 arch/arm/mach-omap2/opp4xxx_data.c            |   30 +
 arch/arm/mach-omap2/pm.c                      |    2 
 arch/arm/mach-omap2/smartreflex-class3.c      |    2 
 arch/arm/mach-omap2/smartreflex.c             |    2 
 arch/arm/mach-omap2/smartreflex.h             |    3 
 arch/arm/mach-omap2/sr_device.c               |    4 
 arch/arm/mach-omap2/vc.h                      |   83 ++
 arch/arm/mach-omap2/vc3xxx_data.c             |   63 ++
 arch/arm/mach-omap2/vc44xx_data.c             |   72 ++
 arch/arm/mach-omap2/voltage.c                 | 1019 +++++++------------------
 arch/arm/mach-omap2/voltage.h                 |   66 ++
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |  104 +++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |  108 +++
 arch/arm/mach-omap2/vp.h                      |  143 ++++
 arch/arm/mach-omap2/vp3xxx_data.c             |   82 ++
 arch/arm/mach-omap2/vp44xx_data.c             |   97 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 
 22 files changed, 1203 insertions(+), 758 deletions(-)
 rename arch/arm/{plat-omap/include/plat/smartreflex.h => mach-omap2/smartreflex.h} (99%)
 create mode 100644 arch/arm/mach-omap2/vc.h
 create mode 100644 arch/arm/mach-omap2/vc3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vc44xx_data.c
 rename arch/arm/{plat-omap/include/plat/voltage.h => mach-omap2/voltage.h} (68%)
 create mode 100644 arch/arm/mach-omap2/voltagedomains3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/voltagedomains44xx_data.c
 create mode 100644 arch/arm/mach-omap2/vp.h
 create mode 100644 arch/arm/mach-omap2/vp3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vp44xx_data.c

