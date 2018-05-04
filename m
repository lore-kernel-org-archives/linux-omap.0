From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap sdhci dts changes for v4.18 merge window
Date: Fri,  4 May 2018 09:17:33 -0700
Message-ID: <pull-1525450571-674978@atomide.com-3>
References: <pull-1525450571-674978@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1525450571-674978@atomide.com>
In-Reply-To: <pull-1525450571-674978@atomide.com>
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

The following changes since commit 3f4028780287ff5a7308f40e10bbba9a42b993aa:

  mmc: sdhci-omap: Get IODelay values for 3.3v DDR mode (2018-05-03 09:37:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-sdhci-signed

for you to fetch changes up to 24a6f1f65ea567d017c598faf1374ee443f73851:

  Documentation: ARM: Add new MMC requirements for DRA7/K2G (2018-05-03 10:32:20 -0700)

----------------------------------------------------------------
Device tree changes for omap variants for SDHCI

This series adds the devicetree configuration needed for pinctrl on
dra7 variants to use the SDHCI SDIO driver instead of mmc-omap-hs
driver. To use SDHCI, both the pins and the iodelay needs to be
configured.

This series is based on the related SDHCI drivers changes on a branch
set up by Ulf.

----------------------------------------------------------------
Hari Nagalla (2):
      ARM: dts: dra72-evm-common: Add wilink8 wlan support
      ARM: dts: dra7-evm: Add wilink8 wlan support

Kishon Vijay Abraham I (10):
      ARM: dts: dra72-evm-common: Remove mmc specific pinmux
      ARM: dts: dra71-evm: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra7-mmc-iodelay: Add a new pinctrl group for clk line without pullup
      ARM: dts: am57xx-idk: Use pinctrl group from dra7-mmc-iodelay.dtsi to select pulldown
      ARM: dts: dra71-evm: Use pinctrl group from dra7-mmc-iodelay.dtsi to select pulldown
      ARM: dts: am57xx-beagle-x15/am57xx-idk: Fix pinctrl-names
      ARM: dts: dra7-evm: Model EVM_3V6 regulator
      ARM: dts: dra7: Use sdhci-omap programming model
      ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node
      Documentation: ARM: Add new MMC requirements for DRA7/K2G

Sekhar Nori (1):
      ARM: dts: am574x-idk: Add pinmux configuration for MMC

Vishal Mahaveer (1):
      ARM: dts: dra76-evm: Add wilink8 wlan support

 Documentation/arm/OMAP/README                   |  4 ++
 arch/arm/boot/dts/am571x-idk.dts                |  5 +-
 arch/arm/boot/dts/am572x-idk.dts                |  5 +-
 arch/arm/boot/dts/am574x-idk.dts                | 20 +++++++
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |  3 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi        | 14 +----
 arch/arm/boot/dts/dra7-evm-common.dtsi          | 15 ++++++
 arch/arm/boot/dts/dra7-evm.dts                  | 68 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi         | 19 +++++++
 arch/arm/boot/dts/dra7.dtsi                     | 32 ++++++-----
 arch/arm/boot/dts/dra71-evm.dts                 | 17 ++----
 arch/arm/boot/dts/dra72-evm-common.dtsi         | 71 +++++++++++++++----------
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi       | 11 ++++
 arch/arm/boot/dts/dra76-evm.dts                 | 34 +++++++++++-
 15 files changed, 243 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi
