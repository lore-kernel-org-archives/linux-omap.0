From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 0/9] omap: dmtimer: Move driver out of plat-omap
Date: Thu, 16 Nov 2017 09:53:33 +0530
Message-ID: <1510806222-22096-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: j-keerthy@ti.com, linux@armlinux.org.uk, daniel.lezcano@linaro.org, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, sebastian.reichel@collabora.co.uk, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org

The series moves dmtimer out of plat-omap to drivers/clocksource.
The series also does a bunch of changes to pwm-omap-dmtimer code
to adapt to the driver migration and clean up plat specific
pdata-quirks and use the dmtimer platform data.

Boot tested on DRA7-EVM, AM335X-EVM and AM437X-GP-EVM.
Compile tested omap1_defconfig.

This is based on top of linux-next branch.

Changes from V2:

  * Wrapped the inline functions in header file under OMAP2PLUS
  * Added a new of helper function to fetch plat_data from of node.

Keerthy (9):
  clocksource: dmtimer: Remove all the exports
  arm: omap: timer: Move the inline functions under OMAP2PLUS define
  arm: omap: Move dmtimer.h out of plat-omap
  arm: OMAP: Move dmtimer driver out of plat-omap to drivers under
    clocksource
  dmtimer: Add timer ops to the platform data structure
  clocksource: dmtimer: Populate the timer ops to the pdata
  of: platform: Add a function to get platfrom data from device node
  pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
  arm: omap: pdata-quirks: Remove unused timer pdata

 arch/arm/mach-omap1/pm.c                           |  2 +-
 arch/arm/mach-omap1/timer.c                        |  2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  2 +-
 arch/arm/mach-omap2/pdata-quirks.c                 | 32 -------------
 arch/arm/mach-omap2/timer.c                        |  2 +-
 arch/arm/plat-omap/Kconfig                         |  6 ---
 arch/arm/plat-omap/Makefile                        |  1 -
 drivers/clocksource/Kconfig                        |  6 +++
 drivers/clocksource/Makefile                       |  1 +
 .../plat-omap => drivers/clocksource}/dmtimer.c    | 54 +++++++++++-----------
 drivers/of/platform.c                              | 23 +++++++++
 drivers/pwm/pwm-omap-dmtimer.c                     | 39 +++++++++-------
 .../include/plat => include/clocksource}/dmtimer.h |  8 +++-
 include/linux/of_platform.h                        |  6 +++
 include/linux/platform_data/dmtimer-omap.h         | 38 +++++++++++++++
 22 files changed, 140 insertions(+), 96 deletions(-)
 rename {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c (95%)
 rename {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h (97%)

-- 
1.9.1
