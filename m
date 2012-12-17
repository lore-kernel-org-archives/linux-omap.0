From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes and cleanups for v3.8 merge window
Date: Mon, 17 Dec 2012 10:02:01 -0800
Message-ID: <20121217180200.GU4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45905 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751917Ab2LQSCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 13:02:07 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here are some fixes, including a omap2plus_defconfig build fix
caused by the merge conflict with fb branch as the merge notes
were missed probably because the pull got resolved automatically.

I had to fix the subject line for one patch and added some acks,
so the patches have recent timestamps. The patches themselves
have not changed since yesterday.

See also the tag notes below for the other changes included.

Regards,

Tony


The following changes since commit 2b8318881ddbcb67c5e8d2178b42284749442222:

  Merge tag 'fbdev-for-3.8' of git://gitorious.org/linux-omap-dss2/linux (2012-12-15 13:03:48 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/fixes-for-merge-window-v3-signed

for you to fetch changes up to 3e194c88f8b71700822828749187e65853ed8166:

  ARM: OMAP: Fix drivers to depend on omap for internal devices (2012-12-17 09:20:47 -0800)

----------------------------------------------------------------
These patches fixes a build error caused by a merge
conflict with the fb code, few timer warnings, and longer
term regressions for tfp410 and omap h4 ethernet. Also
included is a GPIO mode fix for the legacy mux code.

I've also included few more patches to finish the omap
changes for multiplatform conversion that are not strictly
fixes, but were too complex to do with the dependencies
during the merge window. Those are to move of serial-omap.h
to platform_data, and the removal of remaining cpu_is_omap
macro usage outside mach-omap2.

Then there are several trivial fixes for typos and
few minimal omap2plus_defconfig updates.

----------------------------------------------------------------
AnilKumar Chimata (1):
      ARM: OMAP2+: omap2plus_defconfig: Add tps65217 support

Javier Martinez Canillas (3):
      ARM: OMAP2+: common: remove use of vram
      ARM: OMAP2+: enable devtmpfs and devtmpfs automount
      ARM: OMAP2+: omap2plus_defconfig: enable twl4030 SoC audio

Jon Hunter (7):
      ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
      ARM: AM335x: Fix warning in timer.c
      ARM: OMAP2420: Fix ethernet support for OMAP2420 H4
      ARM: OMAP: Remove debug-devices.c
      ARM: dts: OMAP2420: Correct H4 board memory size
      ARM: dts: Add build target for omap4-panda-a4
      ARM: OMAP2+: PMU: Remove unused header

Julia Lawall (1):
      arch/arm/mach-omap2/dpll3xxx.c: drop if around WARN_ON

Oleg Matcovschi (1):
      OMAP2+: mux: Fixed gpio mux mode analysis

Peter Ujfalusi (1):
      ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER to TWL_MODULE_PM_RECEIVER

Roger Quadros (1):
      mfd: omap-usb-host: get rid of cpu_is_omap..() macros

Srinivas Kandagatla (1):
      ARM/omap: use module_platform_driver macro

Tomi Valkeinen (1):
      OMAP: board-files: fix i2c_bus for tfp410

Tony Lindgren (7):
      Merge branch 'fixes-timer-build' of git://github.com/jonhunter/linux into omap-for-v3.8/fixes-for-merge-window
      ARM: OMAP: Move plat/omap-serial.h to include/linux/platform_data/serial-omap.h
      Merge branch 'omap-for-v3.8/fixes-for-merge-window' into omap-for-v3.8/fixes-for-merge-window-v2
      MAINTAINERS: Add an entry for omap related .dts files
      ARM: OMAP: Split fb.c to remove last remaining cpu_is_omap usage
      ARM: OMAP2+: Drop plat/cpu.h for omap2plus
      ARM: OMAP: Fix drivers to depend on omap for internal devices

Vaibhav Hiremath (1):
      ARM: OMAP2+: Fix sparse warnings in timer.c

Wei Yongjun (1):
      ARM: OMAP4: remove duplicated include from omap_hwmod_44xx_data.c

YOSHIFUJI Hideaki (1):
      OMAP2: Fix a typo - replace regist with register.

 MAINTAINERS                                        |  9 +++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/omap2420-h4.dts                  |  2 +-
 arch/arm/configs/omap2plus_defconfig               |  5 ++
 arch/arm/mach-omap1/Makefile                       |  2 +-
 arch/arm/mach-omap1/fb.c                           | 80 +++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                        |  3 +-
 arch/arm/mach-omap2/Makefile                       |  2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |  1 +
 arch/arm/mach-omap2/board-am3517evm.c              |  1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |  1 +
 arch/arm/mach-omap2/board-devkit8000.c             |  1 +
 arch/arm/mach-omap2/board-h4.c                     | 83 +++++--------------
 arch/arm/mach-omap2/board-omap3evm.c               |  1 +
 arch/arm/mach-omap2/board-omap3stalker.c           |  1 +
 arch/arm/mach-omap2/common.c                       |  3 -
 arch/arm/mach-omap2/control.h                      |  2 +-
 arch/arm/mach-omap2/dpll3xxx.c                     |  3 +-
 arch/arm/mach-omap2/drm.c                          |  1 -
 arch/arm/mach-omap2/dss-common.c                   |  3 +-
 arch/arm/{plat-omap => mach-omap2}/fb.c            | 50 +-----------
 arch/arm/mach-omap2/mux.c                          | 10 +--
 arch/arm/mach-omap2/mux.h                          | 20 +++--
 arch/arm/mach-omap2/mux34xx.c                      |  2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  1 -
 arch/arm/mach-omap2/omap_twl.c                     |  8 +-
 arch/arm/mach-omap2/pmu.c                          |  2 -
 arch/arm/mach-omap2/prm2xxx.c                      |  3 +-
 arch/arm/mach-omap2/prm3xxx.c                      |  3 +-
 arch/arm/mach-omap2/serial.c                       |  3 +-
 arch/arm/mach-omap2/timer.c                        |  6 +-
 arch/arm/mach-omap2/usb-host.c                     |  4 +
 arch/arm/plat-omap/Makefile                        |  3 +-
 arch/arm/plat-omap/debug-devices.c                 | 92 ----------------------
 arch/arm/plat-omap/dmtimer.c                       | 13 +--
 arch/arm/plat-omap/include/plat/cpu.h              |  4 -
 arch/arm/plat-omap/include/plat/debug-devices.h    |  2 -
 drivers/bus/Kconfig                                |  1 +
 drivers/input/keyboard/Kconfig                     |  1 +
 drivers/media/platform/omap3isp/isp.c              |  2 -
 drivers/mfd/omap-usb-host.c                        |  3 +-
 drivers/power/avs/smartreflex.c                    |  2 -
 drivers/tty/serial/omap-serial.c                   |  3 +-
 drivers/usb/phy/Kconfig                            |  1 +
 drivers/video/omap2/Kconfig                        |  4 +
 drivers/w1/masters/Kconfig                         |  1 +
 .../linux/platform_data/serial-omap.h              |  0
 include/linux/platform_data/usb-omap.h             |  3 +
 include/video/omap-panel-tfp410.h                  |  2 +-
 49 files changed, 181 insertions(+), 273 deletions(-)
 create mode 100644 arch/arm/mach-omap1/fb.c
 rename arch/arm/{plat-omap => mach-omap2}/fb.c (76%)
 delete mode 100644 arch/arm/plat-omap/debug-devices.c
 delete mode 100644 arch/arm/plat-omap/include/plat/debug-devices.h
 rename arch/arm/plat-omap/include/plat/omap-serial.h => include/linux/platform_data/serial-omap.h (100%)
