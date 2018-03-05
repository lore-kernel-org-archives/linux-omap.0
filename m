From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/6] omap soc changes for v4.17
Date: Mon,  5 Mar 2018 10:11:01 -0800
Message-ID: <pull-1520273005-304551@atomide.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit fe27f16794f313f5fc16f6d2f42d8c2b2f4d70cc:

  ARM: OMAP2+: Fix sar_base inititalization for HS omaps (2018-02-14 08:35:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/soc-signed

for you to fetch changes up to e33509c19da5931e4363c85f6e83bd11803ba121:

  ARM: OMAP2+: Fix typo for wakeup_ns_pa_addr (2018-02-28 14:47:13 -0800)

----------------------------------------------------------------
SoC changes for omaps for v4.17

This series is mostly a series from Suman Anna to remove now unused
platform data that is now coming from device tree. This also make it
a bit simpler to move the timer code to live under drivers in a
separate series of patches. There are also few minor clean-ups for
omap4 PM code.

----------------------------------------------------------------
Suman Anna (7):
      ARM: OMAP2+: Cleanup omap_gpio_dev_attr usage
      ARM: OMAP2+: Cleanup omap_i2c_dev_attr usage
      ARM: OMAP2+: Cleanup omap_timer_capability_dev_attr usage
      ARM: OMAP2+: Cleanup omap2_spi_dev_attr and other legacy data
      ARM: OMAP2+: Cleanup omap_mcbsp_dev_attr and other legacy data
      ARM: OMAP: Move plat/i2c.h into mach-omap1 folder
      ARM: OMAP2+: Remove unused gpio header file references

Tony Lindgren (3):
      ARM: OMAP2+: Include types.h directly for hwmod data
      ARM: OMAP2+: Use v7_invalidate_l1 in omap4_finish_suspend
      ARM: OMAP2+: Fix typo for wakeup_ns_pa_addr

 arch/arm/mach-omap1/common.h                       |   3 +-
 arch/arm/mach-omap1/i2c.c                          |   2 -
 .../{plat-omap/include/plat => mach-omap1}/i2c.h   |   9 +-
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/hsmmc.c                        |   2 -
 arch/arm/mach-omap2/i2c.h                          |  15 +--
 arch/arm/mach-omap2/msdi.c                         |   1 -
 arch/arm/mach-omap2/omap4-sar-layout.h             |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  11 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  18 ----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  61 +----------
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   3 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  25 +----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   4 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 116 ---------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   8 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  75 -------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  54 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  53 ----------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  31 +-----
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   1 -
 arch/arm/mach-omap2/sleep44xx.S                    |   7 +-
 arch/arm/plat-omap/include/plat/dmtimer.h          |   4 -
 include/linux/platform_data/asoc-ti-mcbsp.h        |  12 ---
 include/linux/platform_data/gpio-omap.h            |   5 -
 include/linux/platform_data/spi-omap2-mcspi.h      |   8 --
 26 files changed, 13 insertions(+), 519 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap1}/i2c.h (90%)
