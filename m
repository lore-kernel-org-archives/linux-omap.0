From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dts changes for v4.10, part 2
Date: Sat, 26 Nov 2016 10:42:57 -0800
Message-ID: <49049.4561185644$1505295202@news.gmane.org>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 7e2f8c0ae670327cbe0348ad2f3df7d9a55a8e5d:

  ARM: dts: Add minimal support for motorola droid 4 xt894 (2016-11-15 10:28:49 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/dt-late-signed

for you to fetch changes up to 5817430ba7250cfc5a9c4a397935b07da16c9762:

  ARM: dts: AM571x-IDK Initial Support (2016-11-23 08:40:05 -0800)

----------------------------------------------------------------
Second set of device tree changes for omaps for v4.10 merge window:

- Fix up new instances of gpio-key,wakeup to use wakeup-source

- Add beaglebone LCDC blue-and-red-wiring property to make use
  of the new driver features

- Add bindings for IIO support for am335x and am437x

- Add palmas PMIC overide powerhold property for am57xx

- Update am335x-baltos to use phy-handle property

- Add initial support for am571x-idk

----------------------------------------------------------------
Andrew F. Davis (7):
      ARM: dts: am335x-icev2: Add Industrial input support
      ARM: dts: am335x-icev2: Disable Industrial I/O LEDs and fix naming
      ARM: dts: am335x-icev2: Add ADC support
      ARM: dts: am437x-idk: Add Industrial input support
      ARM: dts: am437x-idk: Add Industrial output support
      ARM: dts: am57xx-idk: Add Industrial input support
      ARM: dts: am57xx-idk: Add Industrial output support

Jyri Sarha (1):
      ARM: dts: am335x-boneblack: Add blue-and-red-wiring -property to LCDC node

Keerthy (2):
      ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
      ARM: dts: am57xx-idk-common: Add overide powerhold property

Schuyler Patton (1):
      ARM: dts: AM571x-IDK Initial Support

Sudeep Holla (1):
      ARM: dts: omap5: replace gpio-key,wakeup with wakeup-source property

Yegor Yefremov (1):
      ARM: dts: am335x-baltos: use phy-phandle declarations

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |  10 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |   5 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |  11 +++
 arch/arm/boot/dts/am335x-icev2.dts                 |  47 ++++++++--
 arch/arm/boot/dts/am437x-idk-evm.dts               | 101 +++++++++++++++++++++
 arch/arm/boot/dts/am571x-idk.dts                   |  81 +++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts                   |   4 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |  75 +++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts                   |   2 +-
 14 files changed, 329 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/am571x-idk.dts
