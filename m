From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] more fixes for omaps for v5.4
Date: Wed, 16 Oct 2019 09:22:08 -0700
Message-ID: <pull-1571242890-118432@atomide.com>
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

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/fixes-rc3-signed

for you to fetch changes up to 17a9e5bbbfe5a5a6356e47cdc1c1656e1e5e1f62:

  Merge tag 'wlcore-fix' into fixes (2019-10-11 09:15:35 -0700)

----------------------------------------------------------------
Fixes for omaps for v5.4-rc cycle

More fixes for omap variants:

- Update more panel options in omap2plus_defconfig that got changed
  as we moved to use generic LCD panels

- Remove unused twl_keypad for logicpd-torpedo-som to avoid boot
  time warnings. This is only a cosmetic fix, but at least dmesg output
  is now getting more readable after all the fixes to remove pointless
  warnings

- Fix gpu_cm node name as we still have a non-standard node name
  dependency for clocks. This should eventually get fixed by use
  of domain specific compatible property

- Fix use of i2c-mux-idle-disconnect for m3874-iceboard

- Use level interrupt for omap4 & 5 wlcore to avoid lost edge
  interrupts

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: logicpd-torpedo-som: Remove twl_keypad

Andrey Smirnov (1):
      ARM: dts: am3874-iceboard: Fix 'i2c-mux-idle-disconnect' usage

Tero Kristo (1):
      ARM: dts: omap5: fix gpu_cm clock provider name

Tony Lindgren (4):
      ARM: omap2plus_defconfig: Fix selected panels after generic panel changes
      Merge tag 'fix-missing-panels' into fixes
      ARM: dts: Use level interrupt for omap4 & 5 wlcore
      Merge tag 'wlcore-fix' into fixes

 arch/arm/boot/dts/am335x-icev2.dts                 |   2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |   6 +-
 arch/arm/boot/dts/am3874-iceboard.dts              |   9 +-
 arch/arm/boot/dts/am4372.dtsi                      |   2 +
 arch/arm/boot/dts/dra7-l4.dtsi                     |  48 +++++-----
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   4 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   2 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   2 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |   2 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |   2 +-
 arch/arm/configs/omap2plus_defconfig               |  15 ++--
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   3 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   5 +-
 arch/arm/mach-omap2/pm.c                           | 100 ---------------------
 drivers/clk/ti/clk-7xx.c                           |   6 +-
 18 files changed, 57 insertions(+), 156 deletions(-)
