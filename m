From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap soc updates for v4.8 merge window
Date: Thu, 30 Jun 2016 00:13:00 -0700
Message-ID: <14505.2695800134$1467270845@news.gmane.org>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/soc-signed

for you to fetch changes up to 44e7475d40eb26b8d3a6e2b2f7a5f12a5fe0942e:

  ARM: OMAP2+: Fix build if CONFIG_SMP is not set (2016-06-27 23:30:02 -0700)

----------------------------------------------------------------
SoC related changes for omaps for v4.8 merge window:

- A series of DSS platform_data fixes to prepare for DSS driver changes

- Add tblck clck aliases for PWM

- A series of trivial spelling corrections

- Remove bogus eQEP, ePWM and eCAP hwmod entries

- A series of McBSP sidetone fixes

- Remove QSPI and DSS addresses from hwmod, these come from dts

- Fix RSTST register offset for pruss

- Make ti81xx_rtc_hwmod static

- Remove wrongly defined RSTST offset for PER Domain, note
  that the subject for this one wrongly has "dts" in the
  subject

- Add support for omap5 and dra7 workaround for 801819

- A series of patches to make kexec work for SMP omaps

----------------------------------------------------------------
Andrea Gelmini (7):
      ARM: OMAP1: Fix typo in fiq.c
      ARM: OMAP1: Fix typo in mtd-xip.h
      ARM: OMAP2+: Fix typo in cm3xxx.c
      ARM: OMAP2+: Fix typo in mux34xx.c
      ARM: OMAP2+: Fix typo in omap4-common.c
      ARM: OMAP2+: Fix typo in omap_device.c
      ARM: OMAP2+: Fix typo in sdrc.h

Ben Dooks (1):
      ARM: OMAP: make ti81xx_rtc_hwmod static

Franklin S Cooper Jr (2):
      clk: ti: am335x/am4372: Add tbclk to pwm node
      ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and eCAP hwmod entries

Keerthy (2):
      ARM: AM43XX: hwmod: Fix RSTST register offset for pruss
      ARM: dts: am43xx: Remove wrongly defined RSTST offset for PER Domain

Nishanth Menon (1):
      ARM: OMAP5 / DRA7: Introduce workaround for 801819

Peter Ujfalusi (10):
      ARM: OMAP: rx51-video: Do not set TV connector_type
      ARM/video: omap2: Move omap_display_init declaration to mach-omap2/display.h
      video/platform_data: omapdss: Create new header file for platform data
      ARM: OMAP2: Use the platform_data header for omapdss
      ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
      ARM: OMAP3: McBSP: New callback for McBSP2/3 ICLK idle configuration
      ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
      ASoC: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to omap_mcbsp_cleanup()
      ASoC: omap-mcbsp: sidetone: Use the new callback for iclk handling
      ARM: OMAP2+: McBSP: Remove the old iclk allow/deny idle code

Tomi Valkeinen (1):
      ARM: DRA7: hwmod: remove DSS addresses from hwmod

Tony Lindgren (7):
      Merge branch 'peter/for-4.8_omapdss_part1' of https://github.com/omap-audio/linux-audio into omap-for-v4.8/soc
      Merge commit 'c0053bd50af5' into omap-for-v4.8/soc
      ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for kexec
      ARM: OMAP4+: Prevent CPU1 related hang with kexec
      ARM: OMAP4+: Reset CPU1 properly for kexec
      ARM: OMAP4+: Allow kexec on SMP variants
      ARM: OMAP2+: Fix build if CONFIG_SMP is not set

Vignesh R (1):
      ARM: DRA7: hwmod: Remove QSPI address space entry from hwmod

 arch/arm/mach-omap1/ams-delta-fiq.c                |   2 +-
 arch/arm/mach-omap1/include/mach/mtd-xip.h         |   2 +-
 arch/arm/mach-omap2/Kconfig                        |   8 ++
 arch/arm/mach-omap2/Makefile                       |   4 +-
 arch/arm/mach-omap2/board-ldp.c                    |   3 +-
 arch/arm/mach-omap2/board-rx51-video.c             |   4 +-
 arch/arm/mach-omap2/cm3xxx.c                       |   2 +-
 arch/arm/mach-omap2/common.h                       |   8 +-
 arch/arm/mach-omap2/display.c                      |   2 +-
 arch/arm/mach-omap2/display.h                      |   5 +
 arch/arm/mach-omap2/dss-common.c                   |   2 +-
 arch/arm/mach-omap2/io.c                           |   3 +
 arch/arm/mach-omap2/mcbsp.c                        |  31 ++---
 arch/arm/mach-omap2/mux34xx.c                      |   4 +-
 arch/arm/mach-omap2/omap-headsmp.S                 |  18 ++-
 arch/arm/mach-omap2/omap-hotplug.c                 |   6 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  29 ++++-
 arch/arm/mach-omap2/omap-secure.h                  |   1 +
 arch/arm/mach-omap2/omap-smp.c                     | 140 ++++++++++++++++-----
 arch/arm/mach-omap2/omap4-common.c                 |  16 ++-
 arch/arm/mach-omap2/omap_device.c                  |   2 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  18 ---
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  64 ----------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  85 +------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   9 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  24 +---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  54 --------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  41 ------
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  18 +++
 arch/arm/mach-omap2/prcm43xx.h                     |   1 +
 arch/arm/mach-omap2/prm33xx.h                      |   2 -
 arch/arm/mach-omap2/sdrc.h                         |   4 +-
 drivers/clk/ti/clk-33xx.c                          |   3 +
 drivers/clk/ti/clk-43xx.c                          |   6 +
 include/linux/platform_data/asoc-ti-mcbsp.h        |   4 +-
 include/linux/platform_data/omapdss.h              |  42 +++++++
 include/video/omapdss.h                            |  31 +----
 sound/soc/omap/mcbsp.c                             |  21 +++-
 sound/soc/omap/mcbsp.h                             |   3 +-
 sound/soc/omap/omap-mcbsp.c                        |   5 +-
 41 files changed, 320 insertions(+), 409 deletions(-)
 create mode 100644 include/linux/platform_data/omapdss.h
