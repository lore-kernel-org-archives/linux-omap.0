From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] fixes for omap variants for v5.3-rc cycle
Date: Wed, 14 Aug 2019 21:49:08 -0700
Message-ID: <pull-1565844391-332885@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/fixes-rc4

for you to fetch changes up to 4a65bbb9109ed7edd4b6ed7168ced48abb8561a2:

  soc: ti: pm33xx: Make two symbols static (2019-08-13 05:05:38 -0700)

----------------------------------------------------------------
Fixes for omap variants for v5.3-rc cycle

We have another fix to disable voltage switching for am57xx SDIO as
the bootrom cannot handle all the voltages after a reset that thought
I had already sent a pull request for earlier but forgot. And we also
update dra74x iodelay configuration for mmc3 to use the recommended
values.

Then I noticed we had introduced few new boot warnings with the various
recent ti-sysc changes and wanted to fix those. I also noticed we still
have too many warnings to be able to spot the real ones easily and fixed
up few of those. Sure some of the warnings have been around for a long
time and few of the fixes could have waited for the merge window, but
having more usable dmesg log level output is a valuable.

Other fixes are IO size correction for am335x UARTs that cause issues
for at least FreeBSD using the same device tree file that checks that
the child IO range is not larger than the parent has.

For omap1 ams-delta keyboard we need to fix a irq ack that broke with
all the recent gpio changes.

And there are also few static checker warning fixes for recent am335x
PM changes and ti-sysc driver and one switch fall-though update.

----------------------------------------------------------------
Emmanuel Vadot (1):
      ARM: dts: am335x: Fix UARTs length

Faiz Abbas (2):
      ARM: dts: am57xx: Disable voltage switching for SD card
      ARM: dts: dra74x: Fix iodelay configuration for mmc3

Gustavo A. R. Silva (1):
      ARM: OMAP: dma: Mark expected switch fall-throughs

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta-fiq: Fix missing irq_ack

Keerthy (1):
      soc: ti: pm33xx: Fix static checker warnings

Suman Anna (1):
      bus: ti-sysc: Simplify cleanup upon failures in sysc_probe()

Tony Lindgren (10):
      Merge commit '79499bb11db508' into fixes
      ARM: OMAP2+: Fix missing SYSC_HAS_RESET_STATUS for dra7 epwmss
      bus: ti-sysc: Fix handling of forced idle
      bus: ti-sysc: Fix using configured sysc mask value
      ARM: dts: Fix flags for gpio7
      ARM: dts: Fix incorrect dcan register mapping for am3, am4 and dra7
      ARM: OMAP2+: Fix omap4 errata warning on other SoCs
      Merge branch 'ti-sysc-fixes' into fixes
      ARM: dts: Fix incomplete dts data for am3 and am4 mmc
      Merge branch 'ti-sysc-fixes' into fixes

YueHaibing (1):
      soc: ti: pm33xx: Make two symbols static

 arch/arm/boot/dts/am33xx-l4.dtsi                | 16 +++++---
 arch/arm/boot/dts/am33xx.dtsi                   | 32 +++++++++++++---
 arch/arm/boot/dts/am4372.dtsi                   | 32 +++++++++++++---
 arch/arm/boot/dts/am437x-l4.dtsi                |  4 ++
 arch/arm/boot/dts/am571x-idk.dts                |  7 +---
 arch/arm/boot/dts/am572x-idk.dts                |  7 +---
 arch/arm/boot/dts/am574x-idk.dts                |  7 +---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  3 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   |  7 +---
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts    |  7 +---
 arch/arm/boot/dts/dra7-evm.dts                  |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  |  6 +--
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi       | 50 ++++++++++++-------------
 arch/arm/mach-omap1/ams-delta-fiq-handler.S     |  3 +-
 arch/arm/mach-omap1/ams-delta-fiq.c             |  4 +-
 arch/arm/mach-omap2/omap4-common.c              |  3 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  3 +-
 arch/arm/plat-omap/dma.c                        | 14 +++----
 drivers/bus/ti-sysc.c                           | 24 ++++++------
 drivers/soc/ti/pm33xx.c                         | 19 ++++++----
 20 files changed, 138 insertions(+), 112 deletions(-)
