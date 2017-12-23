From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/4] dts changes for omaps for v4.16, part 2
Date: Sat, 23 Dec 2017 08:29:18 -0800
Message-ID: <20171223162918.GC3875@atomide.com>
References: <pull-1513966338-859035@atomide.com>
 <pull-1513966338-859035@atomide.com-3>
 <20171222185554.GB3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171222185554.GB3875@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [171222 18:58]:
> * Tony Lindgren <tony@atomide.com> [171222 18:17]:
> > From: "Tony Lindgren" <tony@atomide.com>
> > Kishon Vijay Abraham I (5):
> >       ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
> 
> Turns out the binding is still open for this change. So I will
> most likely revert this commit and reply with an updated pull
> request for this one.

Below is an updated pull request for this with just the above
patch reverted.

8< ------------------
The following changes since commit a38867305203ef5a27f0c9ff1e943a0c2fabdbce:

  ARM: dts: Move move WiFi bindings to logicpd-torpedo-37xx-devkit (2017-12-11 09:43:53 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-pt2-v2-signed

for you to fetch changes up to 1cadb0c341079785182a8d00d12ecb0bbef935fb:

  Revert "ARM: dts: dra7: Add properties to enable PCIe x2 lane mode" (2017-12-23 08:18:15 -0800)

----------------------------------------------------------------
Second set of device tree changes for omaps for v4.16 merge window

This branch mostly configures more hardware support:

- Clean-up dts files to remove leading 0x and 0s from binding notation
  to remove more dtc compiler warnings

- A series of am437x updates for backlight, to fix inverted pad
  pull macro, and to configure power management related OPPs

- Configure n950 and droid 4 command mode LCD panels

- Updates to pandora and gta04 LCD panels

- Add support for am574x-idk

- A series of changes to configure more dra7 related PCIe features

- A series of fixes for am335x-boneblue for WLAN, UARTs and CAN
  configuration

- A series of changes to configure dra7 OPPs and VDD supplies

----------------------------------------------------------------
Dave Gerlach (11):
      ARM: dts: am43xx: Fix inverted DS0_PULL_UP_DOWN_EN macro
      ARM: dts: am437x-idk-evm: Disable OPP50 for MPU
      ARM: dts: am43x-epos-evm: Hook dcdc2 as the cpu0-supply
      ARM: dts: dra7: Add vbb-supply to cpu and additional voltages
      ARM: dts: dra7: Add MPU OPP supply node
      ARM: dts: dra7: Enable 1.5 GHz operation for the CPU
      ARM: dts: am57xx-beagle-x15-common: Add cpu0 vdd supply
      ARM: dts: dra7-evm: Add cpu0 vdd supply
      ARM: dts: dra72-evm-tps65917: Add cpu0 vdd supply
      ARM: dts: am571x-idk: Add cpu0 vdd supply
      ARM: dts: am572x-idk: Add cpu0 vdd supply

H. Nikolaus Schaller (2):
      ARM: dts: gta04: improve panel compatibility string
      ARM: dts: pandora: fix panel compatibility string

Kishon Vijay Abraham I (5):
      ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
      ARM: dts: DRA74x: Use PCIe compatible specific to dra74
      ARM: dts: DRA72x: Use PCIe compatible specific to dra72
      ARM: dts: dra76-evm: Enable x2 PCIe lanes
      ARM: dts: dra7: Remove deprecated PCI compatible string

Lokesh Vutla (1):
      ARM: dts: am57xx: Add support for am574x-idk

Mathieu Malaterre (1):
      ARM: dts: am3/am4/dra7/omap: Remove leading 0x and 0s from bindings notation

Peter Ujfalusi (3):
      ARM: dts: am437x-gp-evm: Add phandle for the backlight for the panel
      ARM: dts: am437x-sk-evm: Add phandle for the backlight for the panel
      ARM: dts: am43xx-epos-evm: Add phandle for the backlight for the panel

Robert Nelson (3):
      ARM: dts: am335x-boneblue: fix wl1835 IRQ pin
      ARM: dts: am335x-boneblue: enable usarts
      ARM: dts: am335x-boneblue: enable can

Sebastian Reichel (2):
      ARM: dts: omap4-droid4: improve LCD description
      ARM: dts: n950: add display support

Tony Lindgren (1):
      Revert "ARM: dts: dra7: Add properties to enable PCIe x2 lane mode"

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/am335x-boneblue.dts           |  79 ++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi                   |   4 +-
 arch/arm/boot/dts/am3517.dtsi                   |   4 +-
 arch/arm/boot/dts/am4372.dtsi                   |   4 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |   4 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |  14 ++++
 arch/arm/boot/dts/am437x-sk-evm.dts             |   4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |   8 +-
 arch/arm/boot/dts/am571x-idk.dts                |   4 +
 arch/arm/boot/dts/am572x-idk-common.dtsi        | 100 ++++++++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts                |  93 +---------------------
 arch/arm/boot/dts/am574x-idk.dts                |  22 ++++++
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts          |   8 +-
 arch/arm/boot/dts/dra7-evm.dts                  |   2 +-
 arch/arm/boot/dts/dra7.dtsi                     |  36 +++++++--
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi       |   4 +
 arch/arm/boot/dts/dra72x.dtsi                   |  12 +++
 arch/arm/boot/dts/dra74x.dtsi                   |  12 +++
 arch/arm/boot/dts/dra76-evm.dts                 |  16 ++++
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |   8 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts            |   8 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi         |   8 +-
 arch/arm/boot/dts/omap3-n950.dts                |  88 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |   2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts        |   6 +-
 include/dt-bindings/pinctrl/am43xx.h            |   3 +-
 29 files changed, 428 insertions(+), 130 deletions(-)
 create mode 100644 arch/arm/boot/dts/am572x-idk-common.dtsi
 create mode 100644 arch/arm/boot/dts/am574x-idk.dts
