From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] fixes for omaps for v5.4
Date: Wed,  2 Oct 2019 11:20:50 -0700
Message-ID: <pull-1570040410-308159@atomide.com>
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

The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/fixes-rc1-signed

for you to fetch changes up to f90ec6cdf674248dcad85bf9af6e064bf472b841:

  ARM: dts: am4372: Set memory bandwidth limit for DISPC (2019-09-30 09:32:03 -0700)

----------------------------------------------------------------
Fixes for omaps for v5.4-rc cycle

Here are fixes for omaps to deal with few regressions, and to fix
more boot time errors and warnings:

- The recent ti-sysc interconnect target module driver changes had
  incorrect clock bits for both clocks and dts that cause warnings

- For omap3-gta04, gpio changes caused the LCD to break a while back,
  and after discussing things the right fix is to set spi-cs-high

- Recent omapdrm changes to use generic panels caused tfp410 to be
  disabled as we now must enable the generic support for it in
  defconfig

- Recent omapdrm and backlight changes also finally made droid4 LCD
  to work, so let's enable it in the defconfig it can be used out
  of the box. This is not strictly a fix, but we still also have the
  older CONFIG_MFD_TI_LMU options available so this cuts down the
  confusion for trying to guess which display and which backlight
  is needed

- Recent ti-sysc interconnect target module changes need the gpio
  module disabled on some boards, but this now needs to happen at
  the module level, not at the gpio driver level

- Recent changes to probe system timers with ti-sysc caused warnings
  about mismatch in syconfig registers, so let's configure the option
  for RESET_STATUS as available in the TRMs

- Recent changes to probe LCDC with ti-sysc caused warnings about
  mismatch in sysconfig registers, so let's configure the missing
  idlemodes for both platform data and dts as documented in TRMs

- Since we moved mach-omap2 to probe with device tree, we've been
  getting voltage controller warnings. Turns out this code is no
  longer needed, so let's just remove omap2_set_init_voltage() to
  get rid of the pointless warnings

- Configure am4372 dispc memory bandwidth to avoid underflow errors

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Enable DRM_TI_TFP410

H. Nikolaus Schaller (1):
      DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again

Peter Ujfalusi (1):
      ARM: dts: am4372: Set memory bandwidth limit for DISPC

Tony Lindgren (8):
      clk: ti: dra7: Fix mcasp8 clock bits
      ARM: dts: Fix wrong clocks for dra7 mcasp
      Merge branch 'fixes-merge-window-pt2' into fixes
      ARM: omap2plus_defconfig: Enable more droid4 devices as loadable modules
      ARM: dts: Fix gpio0 flags for am335x-icev2
      ARM: OMAP2+: Fix missing reset done flag for am3 and am43
      ARM: OMAP2+: Add missing LCDC midlemode for am335x
      ARM: OMAP2+: Fix warnings with broken omap2_set_init_voltage()

 arch/arm/boot/dts/am335x-icev2.dts                 |   2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |   6 +-
 arch/arm/boot/dts/am3517-evm.dts                   |  23 +----
 arch/arm/boot/dts/am4372.dtsi                      |   2 +
 arch/arm/boot/dts/dra7-l4.dtsi                     |  48 +++++-----
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  26 +++---
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |  37 ++------
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   1 +
 arch/arm/configs/omap2plus_defconfig               |   4 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   3 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   5 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   4 +-
 arch/arm/mach-omap2/pm.c                           | 100 ---------------------
 drivers/bus/ti-sysc.c                              |  52 +++++++----
 drivers/clk/ti/clk-7xx.c                           |   6 +-
 15 files changed, 104 insertions(+), 215 deletions(-)
