From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap device tree changes for v4.10
Date: Tue, 15 Nov 2016 13:22:21 -0800
Message-ID: <7519.74388626895$1505294619@news.gmane.org>
References: <pull-1479236877-351747>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1479236877-351747>
In-Reply-To: <pull-1479236877-351747>
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

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/dt-signed

for you to fetch changes up to 7e2f8c0ae670327cbe0348ad2f3df7d9a55a8e5d:

  ARM: dts: Add minimal support for motorola droid 4 xt894 (2016-11-15 10:28:49 -0800)

----------------------------------------------------------------
Device tree changes for omaps for v4.10 merge window:

- A series of patches to configure tps65217 PMIC interrupts for
  power button, charger and usb and use them on am335x

- Configure EEPROM, LEDs and USR1 button for omap5 boards

- Add tscadc DMA properites for am33xx and am4372

- Configure baltos-ir5221 both musb channels to host mode

- Configure internal and external RTC clocks for am335x boards

- Don't reset gpio3 block on baltos

- Remove pinmux for dra72-evm for erratum i869, fix the regulators
  and seprate out tps65917 support

- Add dra718-evm support

- Add minimal droid 4 xt894 support

----------------------------------------------------------------
H. Nikolaus Schaller (3):
      ARM: dts: omap5 uevm: add EEPROM
      ARM: dts: omap5 uevm: add LEDs
      ARM: dts: omap5 uevm: add USR1 button

Keerthy (3):
      ARM: dts: AM335X-bone-common: Add the internal and external clock nodes for rtc
      ARM: dts: AM335X-evm: Add the internal and external clock nodes for rtc
      ARM: dts: AM335X-evmsk: Add the internal and external clock nodes for rtc

Lokesh Vutla (3):
      ARM: dts: dra72-evm: Remove pinmux configurations for erratum i869
      ARM: dts: dra72-evm: Fix modelling of regulators
      ARM: dts: dra72: Add separate dtsi for tps65917

Milo Kim (7):
      ARM: dts: tps65217: Specify the interrupt controller
      ARM: dts: tps65217: Add the charger device
      ARM: dts: tps65217: Add the power button device
      ARM: dts: am335x: Support the PMIC interrupt
      dt-bindings: mfd: Provide human readable defines for TPS65217 interrupts
      ARM: dts: am335x: Add the charger interrupt
      ARM: dts: am335x: Add the power button interrupt

Mugunthan V N (2):
      ARM: dts: am33xx: add DMA properties for tscadc
      ARM: dts: am4372: add DMA properties for tscadc

Nishanth Menon (1):
      ARM: dts: Add support for dra718-evm

Tony Lindgren (1):
      ARM: dts: Add minimal support for motorola droid 4 xt894

Yegor Yefremov (2):
      ARM: dts: am335x-baltos-ir5221: use both musb channels in host mode
      ARM: dts: am335x-baltos: don't reset gpio3 block

 arch/arm/boot/dts/Makefile                 |   4 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts |   2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi       |   4 +
 arch/arm/boot/dts/am335x-bone-common.dtsi  |  22 ++
 arch/arm/boot/dts/am335x-evm.dts           |   5 +
 arch/arm/boot/dts/am335x-evmsk.dts         |   5 +
 arch/arm/boot/dts/am33xx.dtsi              |   4 +
 arch/arm/boot/dts/am4372.dtsi              |   2 +
 arch/arm/boot/dts/dra71-evm.dts            | 230 +++++++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi    | 348 ++++-------------------------
 arch/arm/boot/dts/dra72-evm-revc.dts       |  21 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi  | 134 +++++++++++
 arch/arm/boot/dts/dra72-evm.dts            |  14 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts   | 188 ++++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts           |  92 ++++++++
 arch/arm/boot/dts/tps65217.dtsi            |  12 +
 include/dt-bindings/mfd/tps65217.h         |  26 +++
 17 files changed, 787 insertions(+), 326 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra71-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72-evm-tps65917.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-droid4-xt894.dts
 create mode 100644 include/dt-bindings/mfd/tps65217.h
