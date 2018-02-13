From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/9] Some OMAP2+ legacy hwmod data cleanup
Date: Mon, 12 Feb 2018 19:32:34 -0600
Message-ID: <20180213013243.8378-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

The following series cleans up some legacy dev_attr data associated
with OMAP DMTimer, I2C, McBSP, McSPI and GPIO modules and removes
roughly ~500 lines. Patches are based on v4.16-rc1. I have build tested
for both omap2plus and omap1 defconfigs, and booted on a few OMAP4+
boards that I have on my desk.

Here is the patch summary:
 1. First two patches fixes header inclusion in omap-dmaengine.h and
    hsmmc-omap.h as I am getting build errors on subsequent patches when
    I removed some of the platform_data header files.
 2. Patches 3 through 7 remove the .dev_attr data for the above modules
    from various hwmod data files and some macros from McSPI & McBSP
    platform data header files
 3. Patch 8 moves the plat-omap/include/plat/i2c.h into mach-omap1
    folder as there is no common i2c code in plat-omap folder anymore.
 4. Last patch is a minor cleanup of gpio headers from couple of files.

Some important notes/comments:
 - The DMTimer patch cleanup will conflict with Keerthy's current dmtimer->
   clocksource series, but ideally he wouldn't need to convert the plat/dmtimer.h
   into a clocksource header with the removal of the plat/dmtimer.h inclusion
   from the hwmod data files.
 - I found some gaps w.r.t DMTimers on DM814x/DM816x platforms, and haven't
   fixed them. Both seems to have DMTimer1 through 8, but only DMTimers 1, 2
   and 3 are defined in dm814x.dtsi, while dm816x.dtsi is missing DMTimer8.
   DMTimer3 hwmod is not in the dm814x hwmod list, while DMTimer8 is left out
   altogther. The timer capabilities are also different between the hwmod
   data files (lists always-on) which is missing from corresponding dts files.
   Not sure which one is correct.

This leaves the hsmmc-omap and omap-dma pieces still using the .dev_attr. The
former is only used by one OMAP3 board, so can be cleaned up if we limit the
init code just for that one board.

regards
Suman

Suman Anna (9):
  dmaengine: omap-dma: include header for bool type
  mmc: hsmmc_omap: include types.h and provide header inclusion guard
  ARM: OMAP2+: Cleanup omap_gpio_dev_attr usage
  ARM: OMAP2+: Cleanup omap_i2c_dev_attr usage
  ARM: OMAP2+: Cleanup omap_timer_capability_dev_attr usage
  ARM: OMAP2+: Cleanup omap2_spi_dev_attr and other legacy data
  ARM: OMAP2+: Cleanup omap_mcbsp_dev_attr and other legacy data
  ARM: OMAP: Move plat/i2c.h into mach-omap1 folder
  ARM: OMAP2+: Remove unused gpio header file references

 arch/arm/mach-omap1/common.h                       |   3 +-
 arch/arm/mach-omap1/i2c.c                          |   2 -
 .../{plat-omap/include/plat => mach-omap1}/i2c.h   |   9 +-
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/hsmmc.c                        |   2 -
 arch/arm/mach-omap2/i2c.h                          |  15 +--
 arch/arm/mach-omap2/msdi.c                         |   1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  11 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  18 ----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  60 -----------
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   3 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  23 ----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   4 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 116 ---------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   8 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  75 -------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  54 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  53 ----------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  29 ------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   1 -
 arch/arm/plat-omap/include/plat/dmtimer.h          |   4 -
 include/linux/omap-dmaengine.h                     |   2 +
 include/linux/platform_data/asoc-ti-mcbsp.h        |  12 ---
 include/linux/platform_data/gpio-omap.h            |   5 -
 include/linux/platform_data/hsmmc-omap.h           |   8 ++
 include/linux/platform_data/spi-omap2-mcspi.h      |   8 --
 26 files changed, 16 insertions(+), 512 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap1}/i2c.h (90%)

-- 
2.15.1
