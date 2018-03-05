From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 6/6] dra7 sdhci dts changes for v4.17
Date: Mon,  5 Mar 2018 10:11:06 -0800
Message-ID: <pull-1520273005-304551@atomide.com-6>
References: <pull-1520273005-304551@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com>
In-Reply-To: <pull-1520273005-304551@atomide.com>
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

The following changes since commit 5bfd9c8e7bfcba36bfbe24e967bf42de83c7f56c:

  ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP (2018-02-28 14:24:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v4.17/dt-sdhci

for you to fetch changes up to 18aa0f4bca701cb078a6d58a3ed804aa6a4690c7:

  ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default mode (2018-02-28 14:27:15 -0800)

----------------------------------------------------------------
Kishon Vijay Abraham I (7):
      ARM: dts: am57xx-beagle-x15: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra7-evm: Remove mmc specific pinmux
      ARM: dts: dra7-evm: Add "vqmmc-supply" property for mmc2
      ARM: dts: am57xx-idk: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra76-evm: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra71-evm: Select pull down for mmc1_clk line in default mode
      ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default mode

Ravikumar Kattekola (1):
      ARM: dts: dra71-evm: Correct evm_sd regulator max voltage

Sekhar Nori (3):
      ARM: dts: dra76x: Create a common file with MMC/SD IOdelay data
      ARM: dts: dra76-evm: Shift to using common IOdelay data
      ARM: dts: dra76-evm: Add pinctrl data for higher speed MMC/SD modes

 arch/arm/boot/dts/am571x-idk.dts                |   2 +-
 arch/arm/boot/dts/am572x-idk.dts                |   3 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  12 +
 arch/arm/boot/dts/dra7-evm.dts                  |  28 +--
 arch/arm/boot/dts/dra71-evm.dts                 |  17 +-
 arch/arm/boot/dts/dra76-evm.dts                 |  50 +----
 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi       | 285 ++++++++++++++++++++++++
 8 files changed, 324 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi
