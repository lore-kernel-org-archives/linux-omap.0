From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap devicetree changes for v4.12
Date: Wed, 29 Mar 2017 10:09:49 -0700
Message-ID: <521.194787188683$1505299162@news.gmane.org>
References: <pull-1490807269-842253>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1490807269-842253>
In-Reply-To: <pull-1490807269-842253>
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

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/dt-v2-signed

for you to fetch changes up to da72e4936445e1081e1223fc58470644da8e8cdb:

  Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2 (2017-03-28 14:00:55 -0700)

----------------------------------------------------------------
Devicetree changes for omaps for v4.12 merge window:

- Add hecc node for am35x

- Add onenand support for omap3-igep

- Add bluetooth binding for n900/n9/n950

- Configure clocks and SATA for dm81xx

- Update operating points tables for am33xx, am43xx and dra7

- Update SPI flash documentation for w25q64

- Configure SPI NOR for am335x-icev2

- Mux uart0 for am437x-gp-evm

- Add thermal zones for omap3, omap4, omap5, dra7

- Configure LEDs for am335x-baltos

- A series of droid 4 changes to configure various devices
  such as keypad, regulators, gpio-keys, rtc, power button,
  compass, accelerometer, touchscreen, backlight, poweroff,
  tmp105, HDMI, LCD panel and LEDs, EHCI, and micro-SD

----------------------------------------------------------------
Bartosz Golaszewski (2):
      ARM: dts: dm8168-evm: add the external reference clock for SATA
      ARM: dts: dm8168-evm: add SATA node

Dave Gerlach (4):
      ARM: dts: am33xx: Add updated operating-points-v2 table for cpu
      ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
      ARM: dts: am4372: Update operating-points-v2 table for cpu
      ARM: dts: dra7: Add updated operating-points-v2 table for cpu

Franklin S Cooper Jr (1):
      ARM: dts: am335x-icev2: Add SPI based NOR

Keerthy (5):
      ARM: dts: omap3: Add cpu_thermal zone
      ARM: dts: DRA7: Thermal: Add slope and offset values
      ARM: dts: OMAP5: Thermal: Add slope and offset values
      ARM: dts: OMAP443x: Thermal: Add slope and offset values
      ARM: dts: OMAP4460: Thermal: Add slope and offset values

Ladislav Michl (1):
      ARM: dts: omap3-igep: OneNAND support

Sebastian Reichel (8):
      ARM: dts: omap4-droid4: Add gpio-keys
      ARM: dts: motorola-cpcap-mapphone: add rtc
      ARM: dts: motorola-cpcap-mapphone: add pwrbutton
      ARM: dts: omap4-droid4: Add compass
      ARM: dts: omap4-droid4: Add accelerometer
      ARM: dts: motorola-cpcap-mapphone: add LEDs
      ARM: dts: N900: Add bluetooth
      ARM: dts: N9/N950: add bluetooth

Sekhar Nori (1):
      Documentation: devicetree: mtd: add w25q64 to list of supported SPI flashes

Tony Lindgren (11):
      ARM: dts: Add keypad support for droid 4
      ARM: dts: Configure regulators for droid 4
      ARM: dts: omap4-droid4: Add touchscreen
      ARM: dts: omap4-droid4: Add LCD backlight
      ARM: dts: omap4-droid4: Add GPIO poweroff
      ARM: dts: omap4-droid4: Add tmp105 sensor for droid 4
      ARM: dts: omap4-droid4: Add HDMI support
      ARM: dts: omap4-droid4: Add LCD
      ARM: dts: omap4-droid4: Configure EHCI so modems can be accessed
      ARM: dts: omap4-droid4: Fix MMC1 card for detect GPIO and regulator
      Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2

Vignesh R (1):
      ARM: dts: am437x-gp-evm: Add pinmux for uart0

Yegor Yefremov (2):
      ARM: dts: AM35x: Add hecc node
      ARM: dts: am335x-baltos: add LED support

 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |   1 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |   1 +
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   1 +
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   1 +
 arch/arm/boot/dts/am335x-baltos-leds.dtsi          |  50 +++
 arch/arm/boot/dts/am335x-boneblack.dts             |  11 +
 arch/arm/boot/dts/am335x-icev2.dts                 |  33 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  87 ++++-
 arch/arm/boot/dts/am3517.dtsi                      |  12 +
 arch/arm/boot/dts/am4372.dtsi                      |   7 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  15 +
 arch/arm/boot/dts/dm8168-evm.dts                   |  10 +
 arch/arm/boot/dts/dm816x.dtsi                      |   7 +
 arch/arm/boot/dts/dra7.dtsi                        |  41 ++-
 arch/arm/boot/dts/dra74x.dtsi                      |   5 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     | 194 +++++++++++
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi           |  20 ++
 arch/arm/boot/dts/omap3-igep.dtsi                  |  52 +++
 arch/arm/boot/dts/omap3-n900.dts                   |  23 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  32 ++
 arch/arm/boot/dts/omap34xx.dtsi                    |   8 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |   8 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           | 370 ++++++++++++++++++++-
 arch/arm/boot/dts/omap443x.dtsi                    |   4 +
 arch/arm/boot/dts/omap4460.dtsi                    |   4 +
 arch/arm/boot/dts/omap5.dtsi                       |   9 +
 26 files changed, 963 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-leds.dtsi
 create mode 100644 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-cpu-thermal.dtsi
