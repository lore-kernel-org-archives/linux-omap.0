From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] clock related dts changes for omaps for v4.16
Date: Thu, 14 Dec 2017 07:58:26 -0800
Message-ID: <pull-1513266986-900907@atomide.com-2>
References: <pull-1513266986-900907@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1513266986-900907@atomide.com>
In-Reply-To: <pull-1513266986-900907@atomide.com>
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

The following changes since commit 998601de3c05fb02795d6d9cb1d4dcb25a6019a1:

  Merge commit 'fe7020e64f04' into omap-for-v4.16/dt-clk (2017-12-11 08:26:36 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-clk-signed

for you to fetch changes up to 80a06c0d8357d1e75a8fbc10813fcdada4d897fb:

  ARM: dts: dm816x: add clkctrl nodes (2017-12-11 08:28:37 -0800)

----------------------------------------------------------------
Clock related dts changes for omaps for v4.16 merge window

This branch contains a series of dts changes from Tero Kristo to
start using clkctrl clocks.

Note that this branch is based on a merge of omap-for-v4.16/soc-signed
and an immutable commit from Tero Kristo fe7020e64f04 ("clk: ti: omap4:
clkctrl data fixes for opt-clocks") that is also in clk-next.

----------------------------------------------------------------
Tero Kristo (20):
      ARM: dts: omap5: add fck under timer1
      ARM: dts: omap4: add fck under timer1
      ARM: dts: am33xx: add fck under timers1/2
      ARM: dts: am43xx: add fck under timers1/2
      ARM: dts: dra7: add fck under timer1
      ARM: dts: dm814x: add fck under timers1/2
      ARM: dts: dm816x: add fck under timers1/2
      ARM: dts: omap5: add bus functionality to base PRCM nodes
      ARM: dts: omap4: add bus functionality to base PRCM nodes
      ARM: dts: dra7: add bus functionality to base PRCM nodes
      ARM: dts: am33xx: add bus functionality to base PRCM node
      ARM: dts: am43xx: add bus functionality to base PRCM node
      ARM: dts: dm816x: add bus functionality to base PRCM node
      ARM: dts: omap4: add clkctrl nodes
      ARM: dts: omap5: add clkctrl nodes
      ARM: dts: dra7: add clkctrl nodes
      ARM: dts: am33xx: add clkctrl nodes
      ARM: dts: am43xx: add clkctrl nodes
      ARM: dts: dm814x: add clkctrl nodes
      ARM: dts: dm816x: add clkctrl nodes

 arch/arm/boot/dts/am335x-bone-common.dtsi       |   2 +-
 arch/arm/boot/dts/am335x-boneblue.dts           |   2 +-
 arch/arm/boot/dts/am335x-evm.dts                |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |   2 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi            | 205 +++---
 arch/arm/boot/dts/am33xx.dtsi                   |  14 +-
 arch/arm/boot/dts/am4372.dtsi                   |  16 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |   2 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi            | 230 ++----
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   2 +-
 arch/arm/boot/dts/dm814x-clocks.dtsi            |  30 +
 arch/arm/boot/dts/dm814x.dtsi                   |   4 +
 arch/arm/boot/dts/dm816x-clocks.dtsi            |  30 +
 arch/arm/boot/dts/dm816x.dtsi                   |   9 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi          |   4 +-
 arch/arm/boot/dts/dra7.dtsi                     |  84 ++-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   4 +-
 arch/arm/boot/dts/dra72x.dtsi                   |   4 +-
 arch/arm/boot/dts/dra74x.dtsi                   |   6 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi            | 909 ++++++------------------
 arch/arm/boot/dts/omap4.dtsi                    |  37 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi          | 895 ++++++++---------------
 arch/arm/boot/dts/omap5.dtsi                    |  46 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi          | 623 ++++++----------
 24 files changed, 1091 insertions(+), 2071 deletions(-)
