From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap cleanup part2 for v3.2 merge window
Date: Fri, 23 Sep 2011 14:37:35 -0700
Message-ID: <20110923213735.GZ2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39013 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab1IWVhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 17:37:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap cleanup branch again from:

git://github.com/tmlind/linux.git cleanup

This contains a fix for earlier cleanup patches and has omap_device
cleanup and PM cleanup merged in.

As some of the later cleanup was based on a -rc6 while the
earlier branch was based on -rc4, the git request pull
against the earlier cleanup produces noise.

So instead, below is a diff to the previous pull request 
against -rc7 that show the incremental changes.

Regards,

Tony


--- /tmp/old	2011-09-23 14:32:54.435085320 -0700
+++ /tmp/new	2011-09-23 14:33:09.163108235 -0700
@@ -4,7 +4,30 @@
 
 are available in the git repository at:
 
-  git://github.com/tmlind/linux.git cleanup-part1
+  git://github.com/tmlind/linux.git cleanup
+
+Grazvydas Ignotas (1):
+      OMAP: omap_device: make latency autoadjust messages debug
+
+Jarkko Nikula (1):
+      omap: mcbsp: Remove omap device API
+
+Johan Hovold (2):
+      OMAP2+: PM: fix typos in misc. comment and error messages
+      OMAP2+: PM: clean up error messages: replace printk with pr_err.
+
+Kevin Hilman (8):
+      OMAP: omap_device: replace debug/warning/error prints with dev_* macros
+      OMAP: omap_device: remove internal functions from omap_device.h
+      OMAP: omap_device: when building return platform_device instead of omap_device
+      OMAP: omap_device: device register functions now take platform_device pointer
+      OMAP: omap_device: _disable_idle_on_suspend() takes platform_device pointer
+      OMAP: omap_device: decouple platform_device from omap_device
+      OMAP3: PM: fix UART handling when using no_console_suspend
+      ARM: 7082/1: platform_device: pdev_archdata: add omap_device pointer
+
+Michael Jones (1):
+      OMAP2: PM debug: remove leftover debug code
 
 Paul Walmsley (12):
       OMAP3: id: remove identification codes that only correspond to marketing names
@@ -20,12 +43,16 @@
       OMAP2+: hwmod: remove OMAP_CHIP*
       OMAP: id: remove OMAP_CHIP declarations, code
 
-Tony Lindgren (4):
+Tony Lindgren (7):
       omap2+: Use Kconfig symbol in Makefile instead of obj-y
       ARM: OMAP: Move omap2_init_common_devices out of init_early
       ARM: OMAP: Introduce SoC specific early_init
       Merge branch 'omap_chip_remove_cleanup_3.2' of git://git.pwsan.com/linux-2.6 into cleanup
+      ARM: OMAP2+: Fix missing inline functions for Makefile cleanup
+      Merge branch 'for_3.2/omap_device' of git://gitorious.org/khilman/linux-omap-pm into cleanup
+      Merge branch 'for_3.2/pm-cleanup' of git://gitorious.org/khilman/linux-omap-pm into cleanup
 
+ arch/arm/include/asm/device.h                    |    5 +
  arch/arm/mach-omap2/Makefile                     |   81 +--
  arch/arm/mach-omap2/board-2430sdp.c              |    9 +-
  arch/arm/mach-omap2/board-3430sdp.c              |    9 +-
@@ -37,6 +64,8 @@
  arch/arm/mach-omap2/board-cm-t35.c               |   13 +-
  arch/arm/mach-omap2/board-cm-t3517.c             |    9 +-
  arch/arm/mach-omap2/board-devkit8000.c           |   12 +-
+ arch/arm/mach-omap2/board-flash.c                |    5 -
+ arch/arm/mach-omap2/board-flash.h                |   19 +
  arch/arm/mach-omap2/board-generic.c              |    2 +-
  arch/arm/mach-omap2/board-h4.c                   |    9 +-
  arch/arm/mach-omap2/board-igep0020.c             |   13 +-
@@ -64,13 +93,24 @@
  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |  803 +---------------------
  arch/arm/mach-omap2/clockdomains3xxx_data.c      |  398 +++++++++++
  arch/arm/mach-omap2/clockdomains44xx_data.c      |  409 +++---------
+ arch/arm/mach-omap2/devices.c                    |   44 +-
+ arch/arm/mach-omap2/display.c                    |    6 +-
+ arch/arm/mach-omap2/dma.c                        |   16 +-
+ arch/arm/mach-omap2/gpio.c                       |   10 +-
+ arch/arm/mach-omap2/hsmmc.c                      |    8 +-
+ arch/arm/mach-omap2/hwspinlock.c                 |    8 +-
  arch/arm/mach-omap2/id.c                         |  191 ++----
  arch/arm/mach-omap2/io.c                         |   52 ++-
+ arch/arm/mach-omap2/mcbsp.c                      |    8 +-
  arch/arm/mach-omap2/omap_hwmod.c                 |    3 -
  arch/arm/mach-omap2/omap_hwmod_2420_data.c       |   37 -
  arch/arm/mach-omap2/omap_hwmod_2430_data.c       |   45 --
  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c       |  169 +++---
  arch/arm/mach-omap2/omap_hwmod_44xx_data.c       |   82 ---
+ arch/arm/mach-omap2/opp.c                        |    2 +-
+ arch/arm/mach-omap2/pm.c                         |   30 +-
+ arch/arm/mach-omap2/pm24xx.c                     |   27 -
+ arch/arm/mach-omap2/pm34xx.c                     |    2 +-
  arch/arm/mach-omap2/powerdomain-common.c         |    7 +-
  arch/arm/mach-omap2/powerdomain.c                |   87 ++-
  arch/arm/mach-omap2/powerdomain.h                |    9 +-
@@ -78,12 +118,18 @@
  arch/arm/mach-omap2/powerdomains2xxx_data.c      |   44 +-
  arch/arm/mach-omap2/powerdomains3xxx_data.c      |   81 ++-
  arch/arm/mach-omap2/powerdomains44xx_data.c      |   20 +-
+ arch/arm/mach-omap2/serial.c                     |   14 +-
+ arch/arm/mach-omap2/sr_device.c                  |    6 +-
+ arch/arm/plat-omap/i2c.c                         |    8 +-
  arch/arm/plat-omap/include/plat/clock.h          |    2 -
  arch/arm/plat-omap/include/plat/common.h         |    9 +
  arch/arm/plat-omap/include/plat/cpu.h            |  108 +---
  arch/arm/plat-omap/include/plat/io.h             |    2 +-
+ arch/arm/plat-omap/include/plat/omap_device.h    |   30 +-
  arch/arm/plat-omap/include/plat/omap_hwmod.h     |    2 -
- 57 files changed, 1430 insertions(+), 2036 deletions(-)
+ arch/arm/plat-omap/mcbsp.c                       |   27 -
+ arch/arm/plat-omap/omap_device.c                 |  185 +++---
+ 77 files changed, 1645 insertions(+), 2281 deletions(-)
  create mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
  create mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
  create mode 100644 arch/arm/mach-omap2/clockdomains3xxx_data.c
