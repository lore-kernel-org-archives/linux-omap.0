From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] omap device tree changes for v4.6 merge window, part 2
Date: Tue,  1 Mar 2016 15:01:21 -0800
Message-ID: <41480.1345709295$1456873374@news.gmane.org>
References: <pull-1456872971-400983>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1456872971-400983>
In-Reply-To: <pull-1456872971-400983>
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

The following changes since commit b9d3ec1d98c658226606e66e55c940491447e617:

  ARM: dts: am57xx-beagle-x15: Add eeprom information (2016-02-22 11:18:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/dt-pt2

for you to fetch changes up to 5193523ba644d60283986495d410659922660b5b:

  ARM: dts: omap3-sniper: TWL4030 keypad support (2016-03-01 12:57:06 -0800)

----------------------------------------------------------------
Part 2 of device tree changes for omaps for v4.6 merge window:

- A series of GPMC related interrupt changes from
  Rogeq Quadros <rogerq@ti.com> to prepare adding interrupt
  support to the NAND driver

- Add RTC support for ti81xx

- Correct LogicPD Torpedo mode description

- Add basic support for LG Optimus Black phone in several
  patches by Paul Kocialkowski <contact@paulk.fr>

- Change address-cells for dra7 for LPAE

- Add TBCLK for PWMSS on dra7

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: dm3730-torpedo-devkit: Add "Wireless" to model

Lokesh Vutla (1):
      ARM: dts: DRA7: change address-cells and size-cells

Paul Kocialkowski (3):
      ARM: dts: LG Optimus Black codename sniper basic support
      ARM: dts: omap3-sniper: USB OTG support
      ARM: dts: omap3-sniper: TWL4030 keypad support

Roger Quadros (11):
      ARM: dts: dra7: Fix NAND device nodes
      ARM: dts: dra7: Remove redundant nand property
      ARM: dts: am437x: Fix NAND device nodes
      ARM: dts: am437x: Disable wait pin monitoring for NAND
      ARM: dts: am335x: Fix NAND device nodes
      ARM: dts: am335x: Disable wait pin monitoring for NAND
      ARM: dts: dm816x: Fix NAND device nodes
      ARM: dts: dm8168-evm: ARM: dts: Disable wait pin monitoring for NAND
      ARM: dts: omap3: Fix NAND device nodes
      ARM: dts: dm814x: dra62x: Fix NAND device nodes
      ARM: dts: dm814x: dra62x: Disable wait pin monitoring for NAND

Tony Lindgren (4):
      Merge branch 'omap-for-v4.6/dt-gpmc' into omap-for-v4.6/dt
      ARM: dts: Add RTC entry for dm814x and dra62x
      ARM: dts: Add RTC entry for dm816x
      Revert "ARM: dts: DRA7: Add dt nodes for PWMSS"

Vignesh R (2):
      ARM: dts: DRA7: Add TBCLK for PWMSS
      ARM: dts: DRA7: Add dt nodes for PWMSS

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/am335x-baltos-ir5221.dts        |   9 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi            |   8 +-
 arch/arm/boot/dts/am335x-cm-t335.dts              |   9 +-
 arch/arm/boot/dts/am335x-evm.dts                  |   7 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi            |   8 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |   8 +-
 arch/arm/boot/dts/am33xx.dtsi                     |   2 +
 arch/arm/boot/dts/am4372.dtsi                     |   2 +
 arch/arm/boot/dts/am437x-cm-t43.dts               |  11 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               |   8 +-
 arch/arm/boot/dts/am43x-epos-evm.dts              |   8 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts           |   2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts         |   2 +-
 arch/arm/boot/dts/dm8148-evm.dts                  |  10 +-
 arch/arm/boot/dts/dm814x.dtsi                     |   9 +
 arch/arm/boot/dts/dm8168-evm.dts                  |   8 +-
 arch/arm/boot/dts/dm816x.dtsi                     |   9 +
 arch/arm/boot/dts/dra62x-j5eco-evm.dts            |  10 +-
 arch/arm/boot/dts/dra7-evm.dts                    |   9 +-
 arch/arm/boot/dts/dra7.dtsi                       |  22 +-
 arch/arm/boot/dts/dra72-evm.dts                   |   9 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi              |  24 ++
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |   5 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        |   8 +-
 arch/arm/boot/dts/omap3-beagle.dts                |   5 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi               |   6 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi    |   4 +
 arch/arm/boot/dts/omap3-evm-37xx.dts              |   8 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                |   4 +
 arch/arm/boot/dts/omap3-igep.dtsi                 |   6 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi      |   4 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi      |   4 +
 arch/arm/boot/dts/omap3-ldp.dts                   |  10 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi           |   6 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi           |   6 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi       |   4 +
 arch/arm/boot/dts/omap3-sniper.dts                | 254 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-tao3530.dtsi              |   6 +-
 arch/arm/boot/dts/omap3.dtsi                      |   2 +
 arch/arm/boot/dts/omap3430-sdp.dts                |   6 +-
 41 files changed, 464 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-sniper.dts
