From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] device tree changes for omaps for v4.14, part2
Date: Thu, 17 Aug 2017 11:28:54 -0700
Message-ID: <2763.88414572484$1505308777@news.gmane.org>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit d510d12f26f49905d53ab550fcb40e848a01a60e:

  ARM: dts: nokia n900: update dts with camera support (2017-08-14 11:34:25 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/dt-v3-pt2-signed

for you to fetch changes up to b7ace5ed8867ca54503727988adec6b20af54eeb:

  ARM: dts: omap3: logicpd-torpedo-37xx-devkit: Fix MMC1 cd-gpio (2017-08-17 09:23:13 -0700)

----------------------------------------------------------------
Second set of device tree changes for omaps for v4.14 merge window.
These got delayed a bit because the iodelay changes had to be
reworked for a missing Signed-off-by. And the beagleboard-x15
wants to use iodelay too for mmc:

- A series of changes to add dra7 iodelay data used for mmc

- Add support for new beagleBoard-x15 revision c

- Fix logicpd-torpedo-37xx-devkit mmc card detect direction

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: omap3: logicpd-torpedo-37xx-devkit: Fix MMC1 cd-gpio

Kishon Vijay Abraham I (7):
      ARM: dts: dra7-evm: Add pinmux configuration for MMC
      ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
      ARM: dts: am571x-idk: Add pinmux configuration for MMC
      ARM: dts: am572x-idk: Add pinmux configuration for MMC
      ARM: dts: dra72-evm: Add pinmux configuration for MMC
      ARM: dts: dra72-evm-revc: Add pinmux configuration for MMC
      ARM: dts: dra71-evm: Add pinmux configuration for MMC

Robert Nelson (1):
      ARM: dts: am57xx-beagle-x15: Add support for rev C

Sekhar Nori (3):
      ARM: dts: dra72x: Create a common file with MMC/SD IOdelay data
      ARM: dts: dra74x: Create a common file with MMC/SD IOdelay data
      ARM: dts: am57xx-idk: Move common MMC/SD properties to common file

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/am571x-idk.dts                  |  26 +-
 arch/arm/boot/dts/am572x-idk.dts                  |  27 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi   |  29 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts     |  15 +
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts      |  39 ++
 arch/arm/boot/dts/am57xx-beagle-x15.dts           |  11 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi          |   8 +
 arch/arm/boot/dts/dra7-evm.dts                    |  22 +-
 arch/arm/boot/dts/dra71-evm.dts                   |  14 +
 arch/arm/boot/dts/dra72-evm-revc.dts              |  14 +
 arch/arm/boot/dts/dra72-evm.dts                   |  14 +
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi         | 350 ++++++++++++
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi         | 647 ++++++++++++++++++++++
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |   2 +-
 15 files changed, 1171 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
 create mode 100644 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
