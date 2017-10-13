From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] device tree changes for omaps for v4.15 merge window
Date: Fri, 13 Oct 2017 09:39:01 -0700
Message-ID: <pull-1507912705-793554@atomide.com-2>
References: <pull-1507912705-793554@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1507912705-793554@atomide.com>
In-Reply-To: <pull-1507912705-793554@atomide.com>
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

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v4.15/dt

for you to fetch changes up to aefe3babab100ce389b4506672e7ee54078c905b:

  ARM: dts: omap3: Replace deprecated mcp prefix (2017-10-11 08:47:31 -0700)

----------------------------------------------------------------
Andrew F. Davis (10):
      ARM: dts: am43xx: Introduce additional pinmux definitions for DS0
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for spi0 and spi1
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for qspi1
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for ecap0
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for gpmc
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for pixcir_ts
      ARM: dts: am43xx-epos-evm: Add sleep pinmux for mmc1
      ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for uart0
      ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for usb2_phy1 and usb2_phy2
      ARM: dts: am43xx-epos-evm: Add default pinmux for unused pins

Derald D. Woods (4):
      ARM: dts: omap3-evm-37xx: Add common processor module support
      ARM: dts: omap3-evm: Add OMAP3530 specific device tree processor data
      ARM: dts: omap3: Add Sharp LS037V7DW01 'envdd' supply
      ARM: dts: omap3-evm: Add DSS {vdds_dsi,vdda_video}-supply references

Kabir Sahane (1):
      ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for matrix_keypad0

Lars Poeschel (1):
      ARM: dts: omap3: Replace deprecated mcp prefix

Ravikumar Kattekola (3):
      ARM: dts: dra7: Increase max-voltage of pbias regulator
      ARM: dts: omap5: Increase max-voltage of pbias regulator
      ARM: dts: dra7-evm: Move pcie RC node to common file

Tony Lindgren (3):
      ARM: dts: Configure earlycon for n8x0
      ARM: dts: Configure earlycon for pandaboard
      ARM: dts: Configure earlycon for omap5-common

 arch/arm/boot/dts/am43x-epos-evm.dts               | 239 +++++++++++++++++++--
 arch/arm/boot/dts/dra7-evm-common.dtsi             |   4 +
 arch/arm/boot/dts/dra7-evm.dts                     |   4 -
 arch/arm/boot/dts/dra7.dtsi                        |   2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   4 +
 arch/arm/boot/dts/omap3-evm-37xx.dts               | 209 +-----------------
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi  | 216 +++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts                    |  76 ++++++-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   4 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |   4 +
 arch/arm/boot/dts/omap5.dtsi                       |   2 +-
 include/dt-bindings/pinctrl/am43xx.h               |  12 ++
 14 files changed, 539 insertions(+), 240 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm-processor-common.dtsi
