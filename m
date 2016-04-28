From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap device tree changes for v4.7 merge window, part 2
Date: Thu, 28 Apr 2016 10:25:09 -0700
Message-ID: <2942.604389$1461864388@news.gmane.org>
References: <pull-1461856674-976179>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1461856674-976179>
In-Reply-To: <pull-1461856674-976179>
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

The following changes since commit a4240d3af6771339c3557afe261a8a89573980a9:

  ARM: dts: Add support for dra72-evm rev C (SR2.0) (2016-04-14 13:43:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/dt-signed

for you to fetch changes up to 5b6042237dc85b7e2dc26806957ebf95d205e864:

  ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds (2016-04-28 08:08:48 -0700)

----------------------------------------------------------------
Part two of device tree changes for omaps for v4.7 merge window:

- Fix few typos for address-cells and interrupt-names

- Update dra7 voltage rail limits

- Update compatible string for pcf8575 for both nxp and ti prefix

- Add omap5 configuration for gpadc

- Update dra7 for qspi to remove pinmux as it needs to be done by
  the bootloader in isolation. Also update the qspi for 64MHz
  frequency.

- Add support for Baltos ir2110 and ir3220

- Add industrial and commercial grade thermal thresholds for am57xx

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: dts: omap5-board-common: DT spelling s/interrupt-name/interrupt-names/
      ARM: dts: omap5-cm-t54: DT spelling s/interrupt-name/interrupt-names/
      ARM: dts: OMAP36xx: : DT spelling s/#address-cell/#address-cells/

H. Nikolaus Schaller (2):
      ARM: dts: twl6030: describe gpadc
      ARM: dts: omap5-board-common: describe gpadc for Palmas

Keerthy (4):
      ARM: dts: am57xx: Introduce commercial grade thermal thresholds
      ARM: dts: am57xx: Introduce industrial grade thermal thresholds
      ARM: dts: am57xx-beagle-x15: Include the commercial grade thresholds
      ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds

Nishanth Menon (1):
      ARM: dts: AM57xx/DRA7: Update SoC voltage rail limits to match data sheet

Roger Quadros (1):
      ARM: dts: dra7xx: Fix compatible string for PCF8575 chip

Vignesh R (2):
      ARM: dts: dra7x: Remove QSPI pinmux
      ARM: dts: dra7x: Support QSPI MODE-0 operation at 64MHz

Yegor Yefremov (3):
      ARM: dts: split am335x-baltos-ir5221 into dts and dtsi files
      ARM: dts: add DTS for Baltos IR3220
      ARM: dts: add DTS for Baltos IR2110

 Documentation/devicetree/bindings/spi/ti_qspi.txt |   7 +
 arch/arm/boot/dts/Makefile                        |   2 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts        |  71 ++++
 arch/arm/boot/dts/am335x-baltos-ir3220.dts        | 119 +++++++
 arch/arm/boot/dts/am335x-baltos-ir5221.dts        | 387 +-------------------
 arch/arm/boot/dts/am335x-baltos.dtsi              | 408 ++++++++++++++++++++++
 arch/arm/boot/dts/am57xx-beagle-x15.dts           |   5 +-
 arch/arm/boot/dts/am57xx-commercial-grade.dtsi    |  23 ++
 arch/arm/boot/dts/am57xx-idk-common.dtsi          |   2 +
 arch/arm/boot/dts/am57xx-industrial-grade.dtsi    |  23 ++
 arch/arm/boot/dts/dra7-evm.dts                    |  33 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi           |  26 +-
 arch/arm/boot/dts/omap36xx.dtsi                   |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi         |  12 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                |   2 +-
 arch/arm/boot/dts/twl6030.dtsi                    |   6 +
 16 files changed, 690 insertions(+), 438 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir2110.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir3220.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos.dtsi
 create mode 100644 arch/arm/boot/dts/am57xx-commercial-grade.dtsi
 create mode 100644 arch/arm/boot/dts/am57xx-industrial-grade.dtsi
