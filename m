From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v11 00/10] omap: dmtimer: Move driver out of plat-omap
Date: Thu, 15 Feb 2018 11:31:41 +0530
Message-ID: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: j-keerthy@ti.com, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, s-anna@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

The series moves dmtimer out of plat-omap to drivers/clocksource.
The series also does a bunch of changes to pwm-omap-dmtimer code
to adapt to the driver migration and clean up plat specific
pdata-quirks and use the dmtimer platform data.

Boot tested on DRA7-EVM and AM437X-GP-EVM.
Compile tested omap1_defconfig.

This is based on top of
https://kernel.googlesource.com/pub/scm/linux/kernel/git/tmlind/linux-omap

omap-for-v4.17/soc branch.

Changes from V10:

  * Rebased on top of
https://kernel.googlesource.com/pub/scm/linux/kernel/git/tmlind/linux-omap
omap-for-v4.17/soc branch.

Changes from v9:

  * Fixed a typo in patch 9/10
Changes from v8:

  * Reordered Patch 9/10 a bit.
Changes from V7:

  * Introduced of_node_put in Patch 9/10

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

Keerthy (9):
  clocksource: dmtimer: Remove all the exports
  arm: omap: timer: Wrap the inline functions under OMAP2PLUS define
  arm: omap: Move dmtimer.h out of plat-omap
  clocksource: timer-ti-dm: Replace architecture specific guard with
    clocksource
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
 arch/arm/mach-omap2/pdata-quirks.c                 | 32 ----------
 arch/arm/mach-omap2/timer.c                        |  2 +-
 arch/arm/plat-omap/Kconfig                         |  6 --
 arch/arm/plat-omap/Makefile                        |  1 -
 drivers/clocksource/Kconfig                        |  3 +
 drivers/clocksource/Makefile                       |  1 +
 .../dmtimer.c => drivers/clocksource/timer-ti-dm.c | 64 ++++++++++----------
 drivers/pwm/pwm-omap-dmtimer.c                     | 68 +++++++++++++---------
 .../dmtimer.h => include/clocksource/timer-ti-dm.h | 25 ++++++--
 include/linux/platform_data/dmtimer-omap.h         | 38 ++++++++++++
 12 files changed, 138 insertions(+), 106 deletions(-)
 rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-ti-dm.c (94%)
 rename arch/arm/plat-omap/include/plat/dmtimer.h => include/clocksource/timer-ti-dm.h (96%)

-- 
1.9.1
