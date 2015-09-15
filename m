From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.3-rc1
Date: Tue, 15 Sep 2015 08:46:50 -0700
Message-ID: <20150915154650.GS10928@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc1

for you to fetch changes up to 60fdcb8863d9b4a8b6c6b367886fadb50d4c0b07:

  ARM: dts: Fixup model name for HP t410 dts (2015-09-14 13:33:47 -0700)

----------------------------------------------------------------
Fixes for omaps against v4.3-rc1:

- Fix long time regression on beagle for tfp410 pin muxing

- Fix dm814x control base address typo and related Ethernet
  phy configuration

- Fix igepv2 Ethernet pinmuxing as only some boards have it

- Fix pbias regulator compatible values as a pending regulator
  fix needs those for MMC1 to work properly

- Fix beagle-x15 MMC1 regulator and make pcf857x built-in

- Fix omap5 and dra7 Kconfig options when built as the only
  SoCs selected

- Fix PM errata for omap5 and dra7 as they too need it

- Fix phycore mpu voltage

Also included are a few cosmetic fixes:

- Remove unused of_irq macros

- Fix dra7 ethernet name

----------------------------------------------------------------
Carl Frederik Werner (1):
      ARM: dts: omap3-beagle: make i2c3, ddc and tfp410 gpio work again

Javier Martinez Canillas (1):
      ARM: dts: omap3-igep: Move eth IRQ pinmux to IGEPv2 common dtsi

Kishon Vijay Abraham I (3):
      ARM: dts: am57xx-beagle-x15: Fix regulator populated in MMC1 dt node
      ARM: dts: Use ti,pbias compatible string for pbias
      ARM: omap2plus_defconfig: make PCF857x built-in

Nicolas Chauvet (1):
      ARM: dts: Fixup model name for HP t410 dts

Nishanth Menon (5):
      ARM: dts: am57xx-beagle-x15: Add wakeup irq for mcp79410
      ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
      ARM: OMAP2+: board-generic: Remove stale of_irq macros
      ARM: DRA7: Select missing options for SoC only build
      ARM: OMAP5: Cleanup options for SoC only build

Teresa Remmet (1):
      ARM: dts: am335x-phycore-som: Fix mpu voltage

Tony Lindgren (1):
      ARM: dts: Fix dm814x control base to properly initialize Ethernet PHY

Vishal Mahaveer (1):
      ARM: dts: DRA7: fix a typo in ethernet

 arch/arm/boot/dts/am335x-phycore-som.dtsi    | 4 ++--
 arch/arm/boot/dts/am57xx-beagle-x15.dts      | 4 ++--
 arch/arm/boot/dts/dm8148-evm.dts             | 4 ++--
 arch/arm/boot/dts/dm8148-t410.dts            | 6 +++---
 arch/arm/boot/dts/dm814x.dtsi                | 8 ++++----
 arch/arm/boot/dts/dra7.dtsi                  | 4 ++--
 arch/arm/boot/dts/omap2430.dtsi              | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts           | 2 +-
 arch/arm/boot/dts/omap3-igep.dtsi            | 6 ------
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 6 ++++++
 arch/arm/boot/dts/omap3.dtsi                 | 2 +-
 arch/arm/boot/dts/omap4.dtsi                 | 2 +-
 arch/arm/boot/dts/omap5.dtsi                 | 2 +-
 arch/arm/configs/omap2plus_defconfig         | 2 +-
 arch/arm/mach-omap2/Kconfig                  | 6 +++++-
 arch/arm/mach-omap2/board-generic.c          | 7 -------
 arch/arm/mach-omap2/pm.h                     | 3 ++-
 17 files changed, 34 insertions(+), 36 deletions(-)
