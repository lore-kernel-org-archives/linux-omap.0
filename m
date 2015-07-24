From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap soc changes for v4.3
Date: Fri, 24 Jul 2015 05:06:10 -0700
Message-ID: <16826.1477527723$1437739679@news.gmane.org>
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
To: linux-omap@vger.kernel.org, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/soc-signed

for you to fetch changes up to 24da741c678f865de3182194604dbddcc7fc7f3c:

  Merge branch 'dm814x-soc' into omap-for-v4.3/soc (2015-07-23 21:59:18 -0700)

----------------------------------------------------------------
SoC changes for omaps for v4.3 merge window:

- Clean-up omap4_local_timer_init to drop deal legacy code

- Provide proper IO map table for dra7

- Clean-up IOMMU layer init code as it now uses IOMMU framework

- A series of changes to fix up dm814x support that's been in a broken
  half-merged state for quite some time

- A series of PRCM and hwmod changes via Paul Walmsley <paul@pwsan.com>:

  - I/O wakeup support for AM43xx
  - register lock and unlock support to the hwmod code (needed for the RTC
    IP blocks on some chips)
  - several fixes for sparse warnings and an unnecessary null pointer test
  - a DRA7xx clockdomain configuration workaround, to deal with some hardware
    bugs

----------------------------------------------------------------
Keerthy (6):
      ARM: OMAP4: PRM: Remove hardcoding of PRM_IO_PMCTRL_OFFSET register
      ARM: AM43xx: Add the PRM IRQ register offsets
      ARM: dts: AM4372: Add PRCM IRQ entry
      ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 register offsets
      ARM: OMAP4+: PRM: Add AM437x specific data
      ARM: PRM: AM437x: Enable IO wakeup feature

Lokesh Vutla (1):
      ARM: OMAP2+: hwmod: add support for lock and unlock hooks

Markus Elfring (1):
      ARM: OMAP2: Delete an unnecessary check

Nishanth Menon (1):
      ARM: DRA7: Provide proper IO map table

Paul Walmsley (1):
      Merge branch 'prcm-a-for-v4.3' into hwmod-prcm-for-v4.3

Sekhar Nori (2):
      ARM: OMAP2+: sparse: add missing static declaration
      ARM: OMAP2+: sparse: add missing function declarations

Suman Anna (1):
      ARM: OMAP2+: Remove module references from IOMMU machine layer

Tony Lindgren (10):
      ARM: OMAP2+: Clean up omap4_local_timer_init
      ARM: OMAP2+: Fix dm814x DT_MACHINE_START
      ARM: OMAP2+: Fix scm compatible for dm814x
      ARM: OMAP2+: Add minimal clockdomains for dm814x
      ARM: OMAP2+: Add custom prwdm_operations for 81xx to support dm814x
      ARM: OMAP2+: Add support for initializing dm814x clocks
      Merge tag 'for-v4.3/omap-hwmod-prcm-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.3/soc
      ARM: OMAP2+: Prepare dm81xx hwmod code for adding minimal dm814x support
      ARM: OMAP2: Add minimal dm814x hwmod support
      Merge branch 'dm814x-soc' into omap-for-v4.3/soc

Vignesh R (1):
      ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm to SW_WKUP

 arch/arm/boot/dts/am4372.dtsi                      |   1 +
 arch/arm/mach-omap2/Makefile                       |   3 +-
 arch/arm/mach-omap2/board-generic.c                |   6 +-
 arch/arm/mach-omap2/clockdomain.h                  |   3 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/clockdomains81xx_data.c        |  23 +-
 arch/arm/mach-omap2/common.h                       |   1 +
 arch/arm/mach-omap2/control.c                      |   1 +
 arch/arm/mach-omap2/io.c                           |  70 ++-
 arch/arm/mach-omap2/iomap.h                        |  63 +++
 arch/arm/mach-omap2/omap-iommu.c                   |  13 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |   2 +-
 arch/arm/mach-omap2/omap3-restart.c                |   1 +
 arch/arm/mach-omap2/omap4-restart.c                |   1 +
 arch/arm/mach-omap2/omap54xx.h                     |   8 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  16 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   7 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 571 ++++++++++++++-------
 arch/arm/mach-omap2/pdata-quirks.c                 |   6 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c        | 122 ++++-
 arch/arm/mach-omap2/prcm-common.h                  |   8 +
 arch/arm/mach-omap2/prcm43xx.h                     |   7 +
 arch/arm/mach-omap2/prm44xx.c                      |  61 ++-
 arch/arm/mach-omap2/prm_common.c                   |   1 +
 arch/arm/mach-omap2/timer.c                        |  18 +-
 drivers/clk/ti/Makefile                            |   2 +-
 drivers/clk/ti/clk-814x.c                          |  31 ++
 drivers/clk/ti/clk-816x.c                          |   2 +-
 include/linux/clk/ti.h                             |   3 +-
 31 files changed, 778 insertions(+), 279 deletions(-)
 create mode 100644 drivers/clk/ti/clk-814x.c
