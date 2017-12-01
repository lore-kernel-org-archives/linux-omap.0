From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 0/8] omap: dmtimer: Move driver out of plat-omap
Date: Fri, 1 Dec 2017 10:46:29 +0530
Message-ID: <1512105397-2544-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: t-kristo@ti.com, linux@armlinux.org.uk, grygorii.strashko@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, ladis@linux-mips.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series moves dmtimer out of plat-omap to drivers/clocksource.
The series also does a bunch of changes to pwm-omap-dmtimer code
to adapt to the driver migration and clean up plat specific
pdata-quirks and use the dmtimer platform data.

Boot tested on DRA7-EVM and AM437X-GP-EVM.
Compile tested omap1_defconfig.

This is based on top of linux-next branch.

Changes from v3:

  * Reverted to v2 approach of using dev_get_platdata to fetch dmtimer ops.

Changes from V2:

  * Wrapped the inline functions in header file under OMAP2PLUS
  * Added a new of helper function to fetch plat_data from of node. 

Keerthy (8):
  clocksource: dmtimer: Remove all the exports
  arm: omap: timer: Wrap the inline functions under OMAP2PLUS define
  arm: omap: Move dmtimer.h out of plat-omap
  arm: OMAP: Move dmtimer driver out of plat-omap to drivers under
    clocksource
  dmtimer: Add timer ops to the platform data structure
  clocksource: dmtimer: Populate the timer ops to the pdata
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
 drivers/pwm/pwm-omap-dmtimer.c                     | 39 +++++++++-------
 .../include/plat => include/clocksource}/dmtimer.h |  8 +++-
 include/linux/platform_data/dmtimer-omap.h         | 38 +++++++++++++++
 20 files changed, 111 insertions(+), 96 deletions(-)
 rename {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c (95%)
 rename {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h (97%)

-- 
1.9.1
