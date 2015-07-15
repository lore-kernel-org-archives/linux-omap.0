From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dts changes for v4.3, part 1
Date: Wed, 15 Jul 2015 04:49:36 -0700
Message-ID: <20150715114935.GD17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-pt1

for you to fetch changes up to 80edaaead3687b47ba3760588306937439ebd7bd:

  ARM: dts: am335x-evm: Switch using simple-audio-card for audio support (2015-07-14 04:28:25 -0700)

----------------------------------------------------------------
Omap dts changes for v4.3 merge window. There are also related
changes for reemoteproc platform_data and audio options for
omap2plus_defconfig to keep audio working when changing boards
to use SIMPLE_CARD. The summary of changes is:

- A large set of audio related changes for SIMPLE_CARD from
  Peter Ujfalusi <peter.ujfalusi@ti.com> for am335x and am437x

- Pinctrl dts defines for dra7 virtual mode to configure timings

- Change to use cpsw slave0 for dra7 Ethernet

- Remove unconfigured and wrong l3-mux entry for dm816x

- Add support for Gumstix Palo35 and TobiDuo boards, and  Overo
  PoP NAND and McBSP2

- Start using new HDMI binding for tilcdc

- Start using new sDMA crossbar for dra7

- Start using rproc for am335x and am437x M3 coprocessor

----------------------------------------------------------------
Adam YH Lee (2):
      ARM: dts: overo: Enable McBSP2 for all Overo COMs
      ARM: dts: overo: Add device tree for Palo35 board

Ash Charles (2):
      ARM: dts: Add DTS for Gumstix TobiDuo expansion board
      ARM: dts: overo: Support PoP NAND

Dave Gerlach (1):
      ARM: OMAP2+: Use pdata-quirks for wkup_m3 reset management

Jyri Sarha (1):
      ARM: dts: am335x-boneblack: Use new binding for HDMI

Nishanth Menon (1):
      pinctrl: dra: dt-bindings: Add virtual mode configuration option

Peter Ujfalusi (21):
      ARM: dts: dra7x: Integrate sDMA crossbar
      ARM: omap2plus_defconfig: Enable audio related config options
      ARM: dts: am437x-sk-evm: Add sleep pin settings for mcasp1
      ARM: dts: am437x-sk-evm: Switch using simple-audio-card for audio support
      ARM: dts: am43xx-epos-evm: Add gpio-hog for configuring the display/audio mux
      ARM: dts: am43xx-epos-evm: Add regulator for VBAT and DCDC4 of tps65218
      ARM: dts: am43xx-epos-evm: McASP1 node for audio support
      ARM: dts: am43xx-epos-evm: Add node for tlv320aic3111 audio codec
      ARM: dts: am43xx-epos-evm: Enable analog audio via simple-card
      ARM: dts: am437x-gp-evm: Add gpio-hog for configuring the display/audio mux
      ARM: dts: am437x-gp-evm: Rename fixed regulator vmmcsd_fixed to evm_v3_3d
      ARM: dts: am437x-gp-evm: Add node for tlv320aic3106 audio codec
      ARM: dts: am437x-gp-evm: McASP1 node for audio support
      ARM: dts: am437x-gp-evm: Enable analog audio via simple-card
      ARM: dts: am335x-evmsk: Fix mcasp1 node's indentation
      ARM: dts: am335x-evmsk: Add sleep pin settings for mcasp1
      ARM: dts: am335x-evmsk: Switch using simple-audio-card for audio support
      ARM: dts: am335x-evm: Fix mcasp1 node's indentation
      ARM: dts: am335x-evm: Rename pinctrl section for McASP1
      ARM: dts: am335x-evm: Add sleep pin settings for mcasp1
      ARM: dts: am335x-evm: Switch using simple-audio-card for audio support

Suman Anna (2):
      ARM: dts: AM33xx: Update and move wkup_m3 node to l4 node
      ARM: dts: AM4372: Add the wkupm3 rproc node

Tony Lindgren (1):
      ARM: dts: Remove L3 compatible value for dm816x

Vignesh R (1):
      ARM: dts: DRA72: switch to cpsw slave0 for ethernet

 arch/arm/boot/dts/Makefile                        |   4 +
 arch/arm/boot/dts/am335x-boneblack.dts            |  20 +++-
 arch/arm/boot/dts/am335x-evm.dts                  |  69 ++++++++----
 arch/arm/boot/dts/am335x-evmsk.dts                |  62 +++++++----
 arch/arm/boot/dts/am33xx.dtsi                     |  17 +--
 arch/arm/boot/dts/am4372.dtsi                     |   9 ++
 arch/arm/boot/dts/am437x-gp-evm.dts               | 108 +++++++++++++++---
 arch/arm/boot/dts/am437x-sk-evm.dts               |  45 ++++++--
 arch/arm/boot/dts/am43x-epos-evm.dts              | 130 ++++++++++++++++++++--
 arch/arm/boot/dts/dm816x.dtsi                     |   2 +-
 arch/arm/boot/dts/dra7.dtsi                       |  57 ++++++----
 arch/arm/boot/dts/dra72-evm.dts                   |  10 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi           |  55 +++++++++
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi   |   3 +-
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi  |  53 +++++++++
 arch/arm/boot/dts/omap3-overo-palo35.dts          |  37 ++++++
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts    |  37 ++++++
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts   |  21 ++++
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi |  65 +++++++++++
 arch/arm/boot/dts/omap3-overo-tobiduo.dts         |  21 ++++
 arch/arm/boot/dts/omap3-overo.dtsi                |   4 -
 arch/arm/configs/omap2plus_defconfig              |   3 +
 arch/arm/mach-omap2/pdata-quirks.c                |  15 +++
 include/dt-bindings/pinctrl/dra.h                 |  20 ++++
 24 files changed, 745 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-palo35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobiduo.dts
