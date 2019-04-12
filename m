From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] soc changes for omaps for v5.2
Date: Fri, 12 Apr 2019 10:02:05 -0700
Message-ID: <pull-1555087688-487222@atomide.com>
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

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/soc-signed

for you to fetch changes up to 72aff4ecf1cb85a3c6e6b42ccbda0bc631b090b3:

  ARM: OMAP2+: pm33xx-core: Do not Turn OFF CEFUSE as PPA may be using it (2019-04-09 08:05:17 -0700)

----------------------------------------------------------------
SoC changes for omap variants for v5.2 merge window

This series of changes mostly consists of ti-sysc interconnect driver
related preparation work. With these changes and the related ti-sysc
driver changes, we can start dropping legacy omap_hwmod_*data.c platform
data for many devices.

There are also two am335x and am437x related PM changes for secure
devices that have ROM handling some parts and needs EFUSE power domain
active.

----------------------------------------------------------------
Andrew F. Davis (1):
      ARM: OMAP2+: Wakeupgen: AM43xx HS devices should save context like non-HS

Kabir Sahane (1):
      ARM: OMAP2+: pm33xx-core: Do not Turn OFF CEFUSE as PPA may be using it

Tony Lindgren (8):
      ARM: dts: Fix dcan clkctrl clock for am3
      ARM: OMAP2+: Fix potentially uninitialized return value for _setup_reset()
      ARM: OMAP2+: Make interconnect target module allocation functions static
      ARM: OMAP2+: Prepare class allocation for dynamically allocated modules
      ARM: OMAP2+: Define _HWMOD_STATE_DEFAULT and use it
      ARM: OMAP2+: Allocate struct omap_hwmod based on dts data
      ARM: OMAP2+: Remove hwmod .rev data and use local SoC checks instead
      ARM: OMAP2+: Handle reset quirks for dynamically allocated modules

 arch/arm/boot/dts/am33xx-l4.dtsi                   |   4 +-
 arch/arm/mach-omap2/common.h                       |   9 +
 arch/arm/mach-omap2/i2c.c                          |  11 +-
 arch/arm/mach-omap2/io.c                           |   7 +-
 arch/arm/mach-omap2/mmc.h                          |   8 +
 arch/arm/mach-omap2/omap-wakeupgen.c               |   4 +-
 arch/arm/mach-omap2/omap_hwmod.c                   | 200 ++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod.h                   |   8 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   2 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   3 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   7 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   1 -
 arch/arm/mach-omap2/pm33xx-core.c                  |   8 +-
 arch/arm/mach-omap2/sr_device.c                    |   5 +-
 19 files changed, 215 insertions(+), 71 deletions(-)
