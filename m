From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap device tree changes for v4.4
Date: Wed, 14 Oct 2015 14:38:59 -0700
Message-ID: <21936.3417047591$1444858813@news.gmane.org>
References: <pull-1444855886-636599>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1444855886-636599>
In-Reply-To: <pull-1444855886-636599>
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

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/dt-pt1

for you to fetch changes up to be146412501bc2ed49183637605da97f47125696:

  ARM: dts: omap3-igep: Use OMAP3_CORE1_IOPAD pinmux macro (2015-10-14 12:28:13 -0700)

----------------------------------------------------------------
Device tree changes for omaps for v4.4 merge window:

- DCAN sleep pins for am437x-gp-evm

- A series of changes to add audio support for dra7

- Add support for gpio keys and LEDs on dra7

- Regulator clean-up for am335x-wega

- A series of changes to enable IOMMUs and mailboxes for dra7
  accelerators

- Add support for am335x-bonegreen

- Fix up GPIO flags where 0 was used instead of GPIO_ACTIVE_HIGH

- Fix omap3-lilly-am33x IRQ level flag

- Remove duplicate uart2 pinmux for igep and fix indentation and
  update igep to use pinctrl macros for the register offsets

- Fix MMC cd-gpios usage

Note that this branch is against v4.3-rc4 as that contains critical
MMC related fixes to boot with MMC working on most omaps.

----------------------------------------------------------------
Grygorii Strashko (3):
      ARM: dts: dra7-evm: add pcf8575 gpio expander (i2c1 addr 20)
      ARM: dts: dra7-evm: add gpio leds support
      ARM: dts: dra7-evm: add gpio key support

Javier Martinez Canillas (2):
      ARM: dts: Use defined GPIO constants in flags cell for OMAP2+ boards
      ARM: dts: omap3-lilly-a83x: Don't use IRQ level flag for a GPIO

Laurent Pinchart (3):
      ARM: dts: omap3-igep: Fix indentation
      ARM: dts: omap3-igep0020: Remove duplicate uart2 pinmux
      ARM: dts: omap3-igep: Use OMAP3_CORE1_IOPAD pinmux macro

Mugunthan V N (3):
      ARM: dts: am335x: fix cd-gpios definition as per hardware design and dt binding docs
      ARM: dts: am43xx: fix cd-gpios definition as per hardware design and dt binding docs
      ARM: dts: dra7xx: am57xx: fix cd-gpios definition as per hardware design and dt binding docs

Peter Ujfalusi (10):
      ARM: dts: dra7: Add McASP3 node
      ARM: dts: dra7-evm: Rename mmc2_3v3 supply to evm_3v3_sw
      ARM: dts: dra7-evm: Add fixed regulator to be used by aic3106's DVDD
      ARM: dts: dra7-evm: Enable pcf8575 (0x26 address) on i2c2 bus
      ARM: dts: dra7-evm: Audio support
      ARM: dts: dra72-evm: Add fixed regulator representing DVDD supply for aic3106
      ARM: dts: dra72-evm: Add gpio hog for vin6_sel_s0 to select audio
      ARM: dts: dra72-evm: Audio support
      ARM: dts: am57xx-beagle-x15: Add fixed regulator for aic3104's DVDD
      ARM: dts: am57xx-beagle-x15: Enable analog audio support

Robert Nelson (1):
      ARM: dts: Add am335x-bonegreen

Roger Quadros (1):
      ARM: dts: am437x-gp-evm: Add DCAN sleep pins

Suman Anna (9):
      ARM: dts: DRA74x: Add IPC sub-mailbox nodes for all IPUs & DSPs
      ARM: dts: DRA72x: Add IPC sub-mailbox nodes for IPU1, IPU2 & DSP1
      ARM: dts: dra7-evm: Enable the system mailboxes 5 and 6
      ARM: dts: dra72-evm: Enable the system mailboxes 5 and 6
      ARM: dts: beagle-x15: Enable the system mailboxes 5 and 6
      ARM: dts: DRA7: Add dsp1_system syscon node
      ARM: dts: DRA74x: Add dsp2_system syscon node
      ARM: dts: DRA7: Add common IOMMU nodes
      ARM: dts: DRA74x: Add IOMMU nodes for DSP2

Teresa Remmet (1):
      ARM: dts: am335x-wega: Clean up regulators

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   3 +-
 arch/arm/boot/dts/am335x-bonegreen.dts             |  53 +++++
 arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  36 ++--
 arch/arm/boot/dts/am335x-wega.dtsi                 |  13 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  22 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 117 ++++++++++-
 arch/arm/boot/dts/dra7-evm.dts                     | 222 ++++++++++++++++++++-
 arch/arm/boot/dts/dra7.dtsi                        |  60 ++++++
 arch/arm/boot/dts/dra72-evm.dts                    | 157 ++++++++++++++-
 arch/arm/boot/dts/dra72x.dtsi                      |  21 ++
 arch/arm/boot/dts/dra74x.dtsi                      |  51 +++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   6 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi            |   4 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  10 +-
 arch/arm/boot/dts/omap3-gta04a5.dts                |   2 +-
 arch/arm/boot/dts/omap3-igep.dtsi                  |  68 +++----
 arch/arm/boot/dts/omap3-igep0020.dts               |   9 -
 arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   4 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           |   4 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   4 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   4 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   4 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   6 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |   2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 +-
 arch/arm/boot/dts/omap4460.dtsi                    |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |   2 +-
 44 files changed, 805 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen.dts
