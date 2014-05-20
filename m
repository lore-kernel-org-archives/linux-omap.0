From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] omap dt changes for v3.16 merge window, part 2
Date: Mon, 19 May 2014 18:31:25 -0700
Message-ID: <20140520013125.GH15793@atomide.com>
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

The following changes since commit 3fdb77174a2c173e0e69f2499b836a0e412f6c4d:

  ARM: dts: omap3-n900: use MATRIX_KEY for keymap (2014-05-06 10:22:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/dt-part2-v2

for you to fetch changes up to d712ff63b18309c939396f593510fbcccbafb9e4:

  ARM: dts: Enable mcpdm and mcbsp1 on DuoVero (2014-05-19 17:20:31 -0700)

----------------------------------------------------------------
Device tree related changes for omaps.

----------------------------------------------------------------
Balaji T K (2):
      ARM: dts: omap5: add sata node
      ARM: dts: dra7: add OCP2SCP3 and SATA nodes

Joachim Eastwood (7):
      ARM: dts: Change IOPAD macro's for OMAP4/5
      ARM: dts: Add support for OMAP4 Variscite OM44 family
      ARM: dts: Add support for OMAP4 VAR-DVK-OM44
      ARM: dts: Add VAR-SOM-OM44 WLAN nodes
      ARM: OMAP2+: Use pdata quirks for wl12xx on VAR-STK/DVK-OM44
      ARM: dts: Convert DuoVero Parlor to use IOPAD macro
      ARM: dts: Enable mcpdm and mcbsp1 on DuoVero

Johan Hovold (1):
      ARM: dts: AM33XX: fix ethernet and mdio default state

Minal Shah (1):
      ARM: dts: dra7: add support for parallel NAND flash

Mugunthan V N (2):
      ARM: dts: am4372: Add cpsw phy sel dt node
      ARM: dts: am437x-gp-evm: Add ethernet support for GP EVM

Pekon Gupta (1):
      ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition

Roger Quadros (4):
      ARM: dts: omap4+: Add clocks to USB2 PHY node
      ARM: dts: dra7-clock: Add "l3init_960m_gfclk" clock gate
      ARM: dts: dra7: Add USB related nodes
      dts: dra7-evm: add USB support

Sourav Poddar (2):
      ARM: omap2+: skip device build from platform code for dt
      ARM: dts: am4372: Add hdq device tree data

Wolfram Sang (1):
      ARM: dts: am335x-evm: fix comments for lcd pins

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   3 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  58 ++--
 arch/arm/boot/dts/am335x-evmsk.dts                 |   2 +
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   8 +
 arch/arm/boot/dts/am335x-nano.dts                  |   5 +
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +
 arch/arm/boot/dts/am4372.dtsi                      |  16 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |  72 +++++
 arch/arm/boot/dts/am43x-epos-evm.dts               |  14 +-
 arch/arm/boot/dts/dra7-evm.dts                     | 142 +++++++++
 arch/arm/boot/dts/dra7.dtsi                        | 208 +++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  12 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  18 +-
 arch/arm/boot/dts/omap4-duovero.dtsi               |  98 +++---
 arch/arm/boot/dts/omap4-var-dvk-om44.dts           |  71 +++++
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   | 235 ++++++++++++++
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |  68 ++++
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 343 +++++++++++++++++++++
 arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
 arch/arm/boot/dts/omap4-var-stk-om44.dts           |  17 +
 arch/arm/boot/dts/omap4.dtsi                       |   2 +
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  66 ++--
 arch/arm/boot/dts/omap5-sbc-t54.dts                |   8 +-
 arch/arm/boot/dts/omap5.dtsi                       |  42 +++
 arch/arm/mach-omap2/hdq1w.c                        |   2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  10 -
 arch/arm/mach-omap2/pdata-quirks.c                 |   7 +
 include/dt-bindings/pinctrl/omap.h                 |  13 +-
 31 files changed, 1415 insertions(+), 233 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-var-dvk-om44.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
 delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts
