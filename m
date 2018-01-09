From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v7 0/9] omap: dmtimer: Move driver out of plat-omap
Date: Tue, 9 Jan 2018 11:52:58 +0530
Message-ID: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: j-keerthy@ti.com, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

The series moves dmtimer out of plat-omap to drivers/clocksource.
The series also does a bunch of changes to pwm-omap-dmtimer code
to adapt to the driver migration and clean up plat specific
pdata-quirks and use the dmtimer platform data.

Boot tested on DRA7-EVM and AM437X-GP-EVM.
Compile tested omap1_defconfig.

This is based on top of linux-next branch.

This is tested on on IGEPv2 (OMAP3430 based) by Ladis.

Changes from V6:

  * Fixed error checking for pwm driver patch.
  * Removed one of the fixes from Ladis as per request.

Changes from V5:

  * Added couple of fixes from Ladis for  pwm-dmtimer.

Changes from v4:

  * Made OMAP_DM_TIMER config option silent.
  * Changed the driver name to timer-dm.c

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

Ladislav Michl (1):
  clocksource: timer-dm: Hook device platform data if not already
    assigned

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
 arch/arm/mach-omap2/pdata-quirks.c                 | 32 ----------
 arch/arm/mach-omap2/timer.c                        |  2 +-
 arch/arm/plat-omap/Kconfig                         |  6 --
 arch/arm/plat-omap/Makefile                        |  1 -
 drivers/clocksource/Kconfig                        |  3 +
 drivers/clocksource/Makefile                       |  1 +
 .../dmtimer.c => drivers/clocksource/timer-dm.c    | 64 ++++++++++----------
 drivers/pwm/pwm-omap-dmtimer.c                     | 68 +++++++++++++---------
 .../include/plat => include/clocksource}/dmtimer.h |  8 ++-
 include/linux/platform_data/dmtimer-omap.h         | 38 ++++++++++++
 20 files changed, 134 insertions(+), 109 deletions(-)
 rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-dm.c (94%)
 rename {arch/arm/plat-omap/include/plat => include/clocksource}/dmtimer.h (97%)

-- 
1.9.1
