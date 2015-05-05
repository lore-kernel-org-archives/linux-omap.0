From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.1-rc1
Date: Tue, 5 May 2015 08:44:24 -0700
Message-ID: <20150505154423.GD21061@atomide.com>
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

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc1

for you to fetch changes up to e7309c2673a389a495fcfad70376d3bae8b9bc89:

  bus: omap_l3_noc: Fix master id address decoding for OMAP5 (2015-05-04 10:21:01 -0700)

----------------------------------------------------------------
Fixes for omaps, mostly a fix for power power consumption
creeping up during idle, and two l3-noc device fixes:

- Fix power consumption creeping up with I2C4 staying on
- Fix n900 microphone bias voltages
- Fix dra7 l3-noc for host clock
- Fix omap5 l3-noc id address decoding

The rest are all just minor dts fixes:

- Fix changed EXTCON_USB_GPIO_USB in defconfig
- Fix missing isp and iva #iommu-cells property
- Various beagle x15 dts fixes for pre-production changes
- Fix am437x-sk display dts entries

----------------------------------------------------------------
Felipe Balbi (2):
      ARM: dts: am437x-sk: fix for new newhaven display module revision
      ARM: dts: am437x-sk: reduce col-scan-delay-us

Grygorii Strashko (1):
      ARM: dts: am57xx-beagle-x15: Fix IRQ type for mcp7941x

Illia Smyrnov (1):
      bus: omap_l3_noc: Fix offset for DRA7 CLK1_HOST_CLK1_2 instance

Nishanth Menon (4):
      ARM: dts: am57xx-beagle-x15: Fix RTC aliases
      ARM: dts: am57xx-beagle-x15: Switch UART mux pins
      ARM: dts: am57xx-beagle-x15: Switch GPIO fan number
      ARM: dts: dra7: Fix efuse register size for ABB

Pavel Machek (1):
      ARM: dts: OMAP3-N900: Add microphone bias voltages

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO

Sebastian Reichel (1):
      ARM: dts: omap3: Add #iommu-cells to isp and iva iommu

Suman Anna (1):
      bus: omap_l3_noc: Fix master id address decoding for OMAP5

Tony Lindgren (1):
      ARM: OMAP2+: Fix omap off idle power consumption creeping up

 .../devicetree/bindings/arm/omap/l3-noc.txt        |  1 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 11 +++--
 arch/arm/boot/dts/dra7.dtsi                        | 10 ++--
 arch/arm/boot/dts/omap3-n900.dts                   |  4 ++
 arch/arm/boot/dts/omap3.dtsi                       |  2 +
 arch/arm/boot/dts/omap5.dtsi                       |  2 +-
 arch/arm/configs/omap2plus_defconfig               |  2 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h             |  1 +
 arch/arm/mach-omap2/prm-regbits-44xx.h             |  1 +
 arch/arm/mach-omap2/vc.c                           | 12 ++++-
 arch/arm/mach-omap2/vc.h                           |  2 +
 arch/arm/mach-omap2/vc3xxx_data.c                  |  1 +
 arch/arm/mach-omap2/vc44xx_data.c                  |  1 +
 drivers/bus/omap_l3_noc.c                          |  5 +-
 drivers/bus/omap_l3_noc.h                          | 54 ++++++++++++++++------
 16 files changed, 81 insertions(+), 32 deletions(-)
