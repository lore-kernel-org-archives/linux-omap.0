From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] more soc changes for omaps for v4.15 merge window
Date: Thu, 19 Oct 2017 14:59:31 -0700
Message-ID: <pull-1508450284-272943@atomide.com-2>
References: <pull-1508450284-272943@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1508450284-272943@atomide.com>
In-Reply-To: <pull-1508450284-272943@atomide.com>
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

The following changes since commit f09de60e0ae3440a139b516d579d866890ff3101:

  Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.15/ti-sysc (2017-10-10 14:19:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/ti-sysc-signed

for you to fetch changes up to 684be5a48f4950cb8823b4c4b935515a75615498:

  bus: ti-sysc: Fix unbalanced pm_runtime_enable by adding remove (2017-10-13 10:48:40 -0700)

----------------------------------------------------------------
Drop omap legacy platform data for IRQ, DMA and IO resources. With the
dts files fixed up to contain the necessary data for basic resources, we
can drop the related platform data.

Note that this branch depends on the "omap-for-v4.15/fixes-dt-signed"
branch and the patches with dependencies are based on a merge with that
branch.

These patches first ensure things keep working for the legacy "ti,hwmods"
property when we start making it optional, then adds a minimal TI sysc
interconnect target device driver to handle the new generic "ti,sysc"
compatible property. And then we can finally drop the legacy platform
data for IRQ, DMA and IO resources as seen in the diffstats.

----------------------------------------------------------------
Arnd Bergmann (1):
      bus: ti-sysc: mark PM functions as __maybe_unused

Tony Lindgren (9):
      ARM: OMAP2+: Parse module IO range from dts for legacy "ti,hwmods" support
      ARM: OMAP2+: Populate legacy resources for dma and smartreflex
      bus: ti-sysc: Add minimal TI sysc interconnect target driver
      ARM: OMAP3: Remove legacy IRQ for PRM
      ARM: OMAP4: Remove legacy IRQ for PRM
      ARM: OMAP2+: Drop omap_hwmod_irq_info
      ARM: OMAP2+: Drop omap_hwmod_dma_info
      ARM: OMAP2+: Drop legacy struct omap_hwmod_addr_space
      bus: ti-sysc: Fix unbalanced pm_runtime_enable by adding remove

Wei Yongjun (1):
      ARM: OMAP2+: omap_device: fix error return code in omap_device_copy_resources()

 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/common.h                       |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |  24 -
 arch/arm/mach-omap2/omap_device.c                  | 294 ++++-------
 arch/arm/mach-omap2/omap_device.h                  |   4 -
 arch/arm/mach-omap2/omap_hwmod.c                   | 520 +++---------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  67 +--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  27 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  15 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   6 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 100 ----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  39 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  43 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 548 -------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  20 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  57 --
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  44 --
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  41 --
 arch/arm/mach-omap2/prcm-common.h                  |   1 -
 arch/arm/mach-omap2/prm.h                          |   2 -
 arch/arm/mach-omap2/prm3xxx.c                      |  14 +-
 arch/arm/mach-omap2/prm44xx.c                      |  21 +-
 arch/arm/mach-omap2/prm_common.c                   |  12 +-
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/ti-sysc.c                              | 583 +++++++++++++++++++++
 29 files changed, 806 insertions(+), 1693 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
 create mode 100644 drivers/bus/ti-sysc.c
