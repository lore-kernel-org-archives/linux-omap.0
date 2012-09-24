From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap clock late patches for v3.7 merge window
Date: Mon, 24 Sep 2012 14:25:51 -0700
Message-ID: <48105.3087431521$1348522001@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 1e2ee2a60df5c3ab74dd1c9155fb01b5bc6f807d:

  Merge tag 'omap-devel-am33xx-for-v3.7' into test_v3.6-rc6_ocb3.7_cff3.7_odaf3.7 (2012-09-23 17:16:04 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-late-for-v3.7

for you to fetch changes up to 9cd68fa707cf6372f33eb51a5719dd7626efe5f6:

  Merge tag 'omap-devel-b-c-2-for-3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-late (2012-09-23 19:31:35 -0700)

----------------------------------------------------------------

These changes take us a step closer to merging the common clock
framework for omap but unfortunately these patches were not
ready for merging earlier. See also the notes below on the
dependencies these patches have, they are based on a merge
of sereral branches already merged.

>From Paul Walmsley <paul@pwsan.com>:

OMAP patches intended for the 3.7 merge window:

- Runtime PM conversions for the GPMC and RNG IP blocks
- Preparation patches for the OMAP common clock framework conversion
- clkdev alias additions required by other drivers
- Performance Monitoring Unit (PMU) support for OMAP2, 3, and non-4430 OMAP4
- OMAP hwmod code and data improvements
- Preparation patches for the IOMMU runtime PM conversion
- Preparation patches for OMAP4 full-chip retention support

Based on a merge of v3.6-rc6, the omap-cleanup-b-for-3.7 tag
(7852ec0536ca39cefffc6301dc77f8ae55592926),the cleanup-fixes-for-v3.7
tag (de6ca33a96a6bf61fcb91d3d399703e19ead9d1e), and the
omap-devel-am33xx-for-v3.7 tag
(11964f53eb4d9ce59a058be9999d9cfcb1ced878), due to dependencies.

----------------------------------------------------------------
Afzal Mohammed (3):
      ARM: OMAP2/3: hwmod data: add gpmc
      ARM: OMAP2+: gpmc: Adapt to HWMOD
      ARM: OMAP2+: gpmc: minimal driver support

AnilKumar Ch (1):
      ARM: OMAP2+: AM33XX: clock data: Add clkdev alias for cpu0

Benoit Cousson (1):
      ARM: OMAP4: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs entries

Igor Grinberg (1):
      ARM: OMAP: hwmod code: remove unused hwmod function prototypes

Jon Hunter (7):
      ARM: OMAP2420: Cosmetic fix for timer clock aliases
      ARM: OMAP4: Add timer clock aliases for device-tree
      ARM: OMAP: Add a timer attribute for timers that can interrupt the DSP
      ARM: OMAP3: hwmod data: Add debugss HWMOD data
      ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
      ARM: OMAP2+: PMU: Add runtime PM support
      ARM: OMAP4460/4470: PMU: Enable PMU for OMAP4460/70

Kishon Vijay Abraham I (1):
      ARM: OMAP4: hwmod data: make *phy_48m* as the main_clk of ocp2scp

Michael Jones (1):
      ARM: OMAP3: clock data: remove obsolete comment

Mike Turquette (1):
      ARM: OMAP4: cm: add bitfield width values

Ming Lei (1):
      ARM: OMAP4430: PMU: prepare to create PMU device via HWMOD

Omar Ramirez Luna (5):
      ARM: OMAP2+: omap_device: expose hwmod assert/deassert to omap devices
      ARM: OMAP: hwmod: partially un-reset hwmods might not be properly enabled
      ARM: OMAP: hwmod: revise deassert sequence
      ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
      ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp

Paul Walmsley (16):
      Merge tag 'cleanup-fixes-for-v3.7' into test_v3.6-rc6_cff3.7_odaf3.7
      Merge tag 'omap-devel-am33xx-for-v3.7' into test_v3.6-rc6_cff3.7_odaf3.7
      ARM: OMAP3: clock data: Add the USB TLL clocks device name
      ARM: OMAP2+: clock data: add some aliases for use by CPUFreq only
      SPI: OMAP: remove unnecessary includes of plat/clock.h
      Merge branch 'clock_devel_3.7' into hwmod_prcm_clock_a_3.7
      ARM: OMAP4+: hwmod code: remove clkdm requirement in _omap4_wait_target_*()
      ARM: OMAP2+: hwmod code: convert missing clockdomain warnings to debug messages
      ARM: OMAP4: hwmod data: add missing HWMOD_NO_IDLEST flags to some PRCM IP blocks
      ARM: OMAP3: hwmod data: add mmu data for iva and isp
      ARM: OMAP2xxx: hwmod/CM: add RNG integration data
      hwrng: OMAP: store per-device data in per-device variables, not file statics
      hwrng: OMAP: convert to use runtime PM
      ARM: OMAP: split OMAP1, OMAP2+ RNG device registration
      hwrng: OMAP: remove SoC restrictions from driver registration
      ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU clockdomain idle problems

Rajendra Nayak (3):
      ARM: omap: clk: add clk_prepare and clk_unprepare
      ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
      ARM: OMAP2+: clock: Remove all direct dereferencing of struct clk

Tero Kristo (4):
      ARM: OMAP4: powerdomain: add support for reading prev logic and mem states
      ARM: OMAP4: hwmod data: add support for lostcontext_mask
      ARM: OMAP4: hwmod: flag hwmods/modules not supporting module level context status
      ARM: OMAP3: hwmod data: add sad2d hwmod

Tony Lindgren (1):
      Merge tag 'omap-devel-b-c-2-for-3.7' of git://git.kernel.org/.../pjw/omap-pending into devel-late

Vaibhav Hiremath (1):
      ARM: AM33XX: cm: Add bit-field width values

 arch/arm/mach-omap1/devices.c                      |   28 ++
 arch/arm/mach-omap1/timer.c                        |    2 +-
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/board-apollon.c                |    4 +-
 arch/arm/mach-omap2/board-h4.c                     |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c                |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |   10 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |   20 +-
 arch/arm/mach-omap2/clkt_clksel.c                  |   86 ++--
 arch/arm/mach-omap2/clkt_dpll.c                    |   26 +-
 arch/arm/mach-omap2/clock.c                        |    9 +-
 arch/arm/mach-omap2/clock2420_data.c               |   24 +-
 arch/arm/mach-omap2/clock2430_data.c               |   23 ++
 arch/arm/mach-omap2/clock33xx_data.c               |    1 +
 arch/arm/mach-omap2/clock3xxx.c                    |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |   37 +-
 arch/arm/mach-omap2/clock44xx_data.c               |   21 +
 arch/arm/mach-omap2/clockdomain.c                  |   17 +
 arch/arm/mach-omap2/clockdomain.h                  |   20 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |   49 ++-
 arch/arm/mach-omap2/clockdomain44xx.c              |   11 +
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |    7 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    3 +-
 arch/arm/mach-omap2/cm-regbits-33xx.h              |  158 +++++++-
 arch/arm/mach-omap2/cm-regbits-34xx.h              |    2 +
 arch/arm/mach-omap2/cm-regbits-44xx.h              |  411 ++++++++++++++++----
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |    1 +
 arch/arm/mach-omap2/control.h                      |    1 +
 arch/arm/mach-omap2/devices.c                      |   39 +-
 arch/arm/mach-omap2/display.c                      |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c                     |   48 ++-
 arch/arm/mach-omap2/gpmc.c                         |  194 ++++++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  138 +++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   19 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   19 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 +
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  110 +++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  280 ++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  243 +++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    6 +-
 arch/arm/mach-omap2/pm.c                           |    5 +-
 arch/arm/mach-omap2/pmu.c                          |   95 +++++
 arch/arm/mach-omap2/powerdomain44xx.c              |   61 ++-
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 arch/arm/plat-omap/clock.c                         |   27 --
 arch/arm/plat-omap/include/plat/clock.h            |    5 +
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 arch/arm/plat-omap/include/plat/iommu.h            |   15 +
 arch/arm/plat-omap/include/plat/omap_device.h      |    4 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   26 +-
 arch/arm/plat-omap/omap_device.c                   |   59 ++-
 drivers/char/hw_random/omap-rng.c                  |  121 +++---
 drivers/spi/spi-omap-100k.c                        |    2 -
 drivers/spi/spi-omap2-mcspi.c                      |    1 -
 56 files changed, 2110 insertions(+), 423 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmu.c
