From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.16-rc cycle
Date: Fri, 16 Feb 2018 10:21:04 -0800
Message-ID: <pull-1518805244-774550@atomide.com>
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

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/fixes-signed

for you to fetch changes up to d39b6ea4f8c90e9e5f03a06b6a4fd4af11e2f617:

  bus: ti-sysc: Fix checking of no-reset-on-init quirk (2018-02-15 09:18:55 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.16-rc cycle

This is mostly SoC related fixes for clocks, interconnect, and PM with few
board specifc dts related fixes:

- Fix quirk handling for ti-sysc to check all quirk flags instead of just
  the first one

- Fix LogicPD boards for i2c1 muxing to avoid intermittent PMIC errors

- Fix debounce-interval use for omap5-uevm

- Fix debugfs_create_*() usage for omap1

- Fix sar_base initialization for HS omaps

- Fix omap3 prm wake interrupt for resume

- Fix kmemleak for omap_get_timer_dt()

- Enable optional clocks before main clock to prevent interconnect target
  module from being stuck in transition

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
      ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux

Geert Uytterhoeven (2):
      ARM: OMAP1: clock: Fix debugfs_create_*() usage
      ARM: dts: OMAP5: uevm: Fix "debounce-interval" property misspelling

Qi Hou (1):
      ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt

Tero Kristo (1):
      ARM: OMAP2+: hwmod_core: enable optional clocks before main clock

Tony Lindgren (4):
      Merge branch 'omap-for-v4.16/soc' into omap-for-v4.16/fixes
      ARM: OMAP3: Fix prm wake interrupt for resume
      ARM: OMAP2+: Fix sar_base inititalization for HS omaps
      bus: ti-sysc: Fix checking of no-reset-on-init quirk

 arch/arm/boot/dts/logicpd-som-lv.dtsi      |  9 ++++++++-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |  8 ++++++++
 arch/arm/boot/dts/omap5-uevm.dts           |  2 +-
 arch/arm/mach-omap1/clock.c                |  6 +++---
 arch/arm/mach-omap2/omap-wakeupgen.c       |  4 ++--
 arch/arm/mach-omap2/omap_hwmod.c           |  6 +++---
 arch/arm/mach-omap2/pm.c                   |  4 ++--
 arch/arm/mach-omap2/timer.c                | 19 +++++++++++--------
 drivers/bus/ti-sysc.c                      |  2 +-
 9 files changed, 39 insertions(+), 21 deletions(-)
