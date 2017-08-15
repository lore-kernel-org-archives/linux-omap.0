From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] device tree changes for omaps for v4.14
Date: Tue, 15 Aug 2017 09:52:26 -0700
Message-ID: <24134.1067398482$1505308706@news.gmane.org>
References: <pull-1502815785-702769>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1502815785-702769>
In-Reply-To: <pull-1502815785-702769>
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

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v4.14/dt-v3-signed

for you to fetch changes up to d510d12f26f49905d53ab550fcb40e848a01a60e:

  ARM: dts: nokia n900: update dts with camera support (2017-08-14 11:34:25 -0700)

----------------------------------------------------------------
Device tree changes for omaps for v4.14 merge window:

- A series of changes for dra7 and am572 to use generic
  MMC vqmmc regulator

- Clean-up tps65217 internal interrupts to define them
  only in tps65217.dtsi

- Add dra7 iodelay pinctrl driver configuration

- Add buzzer support for am437x-gp-evm

- Disable HDMI CEC internal pull-ups as it seems that
  all boards have an external pull for these

- Remove unnecessary interrupt-parent for omap3

- Configure droid 4 vaudio regulator initial mode and
  add vibrator

- Enable NAND dma prefetch for am335x-evm, am437x and dra7

- Add pcie1 dt node for EP mode for am57x and dra7

- Add support for new dra76x SoCs and dra76x-evm

----------------------------------------------------------------
Enric Balletbo i Serra (2):
      ARM: dts: tps65217: Add charger interrupts to the common tps65217.dtsi file
      ARM: dts: tps65217: Add power button interrupt to the common tps65217.dtsi file

Faiz Abbas (1):
      ARM: dts: am437x-gp-evm: Add support for buzzer

Franklin S Cooper Jr (3):
      ARM: dts: am335x-evm: Enable NAND dma prefetch by default
      ARM: dts: am437xx: Enable NAND dma prefetch by default
      ARM: dts: dra7xx: Enable NAND dma prefetch by default

Karthik Tummala (1):
      ARM: dts: omap3: Remove needless interrupt-parent property

Kishon Vijay Abraham I (9):
      ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
      ARM: dts: dra72-evm: Add vqmmc supply to mmc1
      ARM: dts: dra72-evm-revc: Add vqmmc supply to mmc1
      ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO lines
      ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
      ARM: dts: am571x-idk: Fix GPIO polarity for MMC1 card detect
      ARM: dts: am572x-idk: Fix GPIO polarity for MMC1 card detect
      ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc"
      ARM: dts: DRA7: Add pcie1 dt node for EP mode

Lokesh Vutla (2):
      ARM: dts: Add support for dra76x family of devices
      ARM: dts: Add support for dra76-evm

Pavel Machek (1):
      ARM: dts: nokia n900: update dts with camera support

Ravikumar Kattekola (1):
      ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2

SZ Lin (1):
      ARM: dts: am335x: add support for Moxa UC-8100-ME-T open platform

Sebastian Reichel (2):
      ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio
      ARM: dts: omap4-droid4: Add vibrator

Tony Lindgren (4):
      Merge tag 'v4.13-rc1' into omap-for-v4.14/mmc-regulator
      Merge branch 'omap-for-v4.14/mmc-regulator' into omap-for-v4.14/dt
      ARM: dts: Add dra7 iodelay configuration
      ARM: dts: Disable HDMI CEC internal pull-ups

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   3 -
 arch/arm/boot/dts/am335x-chiliboard.dts            |   3 -
 arch/arm/boot/dts/am335x-evm.dts                   |   1 +
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     | 525 +++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                |  15 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   1 +
 arch/arm/boot/dts/am571x-idk.dts                   |  11 +-
 arch/arm/boot/dts/am572x-idk.dts                   |  11 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   7 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |   2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             | 258 ++++++++++
 arch/arm/boot/dts/dra7-evm.dts                     | 255 +---------
 arch/arm/boot/dts/dra7.dtsi                        |  36 +-
 arch/arm/boot/dts/dra71-evm.dts                    |  16 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |   7 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |  18 +
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          |   2 +-
 arch/arm/boot/dts/dra72-evm.dts                    |  18 +
 arch/arm/boot/dts/dra76-evm.dts                    | 423 +++++++++++++++++
 arch/arm/boot/dts/dra76x.dtsi                      |  19 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |   1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts               |   2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts               |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |  89 +++-
 arch/arm/boot/dts/omap3-overo-base.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |   2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   4 -
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  42 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   2 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts           |   2 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   2 +-
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/tps65217.dtsi                    |   3 +
 include/dt-bindings/pinctrl/dra.h                  |   3 +
 45 files changed, 1532 insertions(+), 285 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
 create mode 100644 arch/arm/boot/dts/dra7-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra76-evm.dts
 create mode 100644 arch/arm/boot/dts/dra76x.dtsi
