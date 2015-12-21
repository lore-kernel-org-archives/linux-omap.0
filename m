From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] omap device tree changes for v4.5, part 2
Date: Mon, 21 Dec 2015 13:06:37 -0800
Message-ID: <39927.8870587752$1450732118@news.gmane.org>
References: <pull-1450731519-787330>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1450731519-787330>
In-Reply-To: <pull-1450731519-787330>
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

The following changes since commit 89c6f2e5ab7a0499c6bcb25d281977ada205765d:

  ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi (2015-12-07 16:11:43 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/dt-pt2

for you to fetch changes up to 6c95771f8c71cd4dd6ed7ab84a3aea7d509d7704:

  ARM: OMAP2+: LogicPD Torpedo: Add Touchscreen Support (2015-12-21 11:10:40 -0800)

----------------------------------------------------------------
Second set of omap device tree changes for v4.5 merge window. This series
updates the EDMA bindings based on the various fixes to split EDMA into
separate independent devices. It also adds support for more devices on the
CompuLab cm-t335 and LogicPD Torpedo boards, and enables the new bindings
for qspi for am437x and dra7. There are also few dra7 regulator fixes, and
change of gpoi-key,wakeup to wakeup-source.

These depend on commit ae0add740cd0 ("dmaengine: edma: DT: Change reserved
slot array from 16bit to 32bit type") already merged into mainline.

----------------------------------------------------------------
Adam Ford (4):
      ARM: OMAP2+: LogicPD Torpedo: Add LCD Type 15 Support
      ARM: OMAP2+: LogicPD Torpedo + Wireless: Add Bluetooth
      ARM: OMAP2+: LogicPD Torpedo: Revert Duplicative Entries
      ARM: OMAP2+: LogicPD Torpedo: Add Touchscreen Support

Ilya Ledvich (1):
      ARM: dts: cm-t335: add support for USB0

Keerthy (2):
      ARM: dts: DRA72-EVM: Add regulator-allow-bypass property for ldo1 and ldo2
      ARM: dts: DRA7-EVM: Add regulator-allow-bypass property for ldo9

Peter Ujfalusi (4):
      dmaengine: edma: DT: Change memcpy channel array from 16bit to 32bit type
      dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit type
      ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
      ARM: DTS: am437x: Use the new DT bindings for the eDMA3

Sudeep Holla (2):
      ARM: dts: am335x: replace gpio-key,wakeup with wakeup-source property
      ARM: dts: omap: replace legacy *,wakeup property with wakeup-source

Tony Lindgren (1):
      Merge commit 'ae0add740cd06169cd124f9aaa6eceb11e5b3060' into omap-for-v4.5/dt

Uri Mashiach (4):
      ARM: dts: cm-t335: add support for SBC-T335
      ARM: dts: cm-t335: add support for I2C GPIO expander
      ARM: dts: cm-t335: add support for DVI/LCD
      ARM: dts: cm-t335: add support for bluetooth

Vignesh R (2):
      ARM: dts: DRA7: add entry for qspi mmap region
      ARM: dts: AM4372: add entry for qspi mmap region

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 Documentation/devicetree/bindings/dma/ti-edma.txt  |  10 +-
 Documentation/devicetree/bindings/spi/ti_qspi.txt  |  22 ++-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-cm-t335.dts               |  51 ++++-
 arch/arm/boot/dts/am335x-evm.dts                   |  13 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |  17 +-
 arch/arm/boot/dts/am335x-sbc-t335.dts              | 219 +++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |  94 ++++++---
 arch/arm/boot/dts/am4372.dtsi                      |  84 ++++++--
 arch/arm/boot/dts/am437x-gp-evm.dts                |   9 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   1 +
 arch/arm/boot/dts/dra7.dtsi                        |   6 +-
 arch/arm/boot/dts/dra72-evm.dts                    |   2 +
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  | 145 ++++++++++++--
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |  18 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |  10 +-
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |   2 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |   4 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |   4 +-
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |   4 +-
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |   4 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  34 ++--
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |   2 +-
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  24 ++-
 drivers/dma/edma.c                                 |  53 +++--
 include/linux/platform_data/edma.h                 |   2 +-
 40 files changed, 689 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-sbc-t335.dts
