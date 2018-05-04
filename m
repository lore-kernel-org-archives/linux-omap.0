From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap dts changes for v4.18 merge window
Date: Fri,  4 May 2018 09:17:32 -0700
Message-ID: <pull-1525450571-674978@atomide.com-2>
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

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-signed

for you to fetch changes up to 8dfa75524a0e0e2b4eaf2a3dc178f6b4d8db85d9:

  ARM: dts: correct invalid I/O definition for MMC/SD card detect on T410 (2018-05-03 10:03:01 -0700)

----------------------------------------------------------------
Device tree changes for omap variants for v4.18 merge window

This series adds support for am335x-pockebeagle and also add missing
pinctrl configuration for am335x evm and beagle bone variants.

There are also changes to add missing omap3 oscillator clocks for audio,
and fixes am437x tps65218 irq type used for various board specific
files.

There are also few minor fixes included that are not urgent. The
fixes for n8x0 audio also depend on driver changes, and the hp t410
mmc card detect mux typo is harmless.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: logicpd-som-lv: Enable Touchscreen controller

Faiz Abbas (1):
      ARM: dts: am33xx: Add pinmux data for mmc1 in am335x-evm, evmsk and beaglebone

Graeme Smecher (1):
      ARM: dts: correct invalid I/O definition for MMC/SD card detect on T410

H. Nikolaus Schaller (2):
      ARM: dts: omap3-pandora: Add fixed 26MHz clock as fck for twl
      ARM: dts: omap3-gta04: Add fixed 26MHz clock as fck for twl

Peter Ujfalusi (7):
      ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck for twl
      ARM: dts: am437x-gp-evm: Correct tps65218 irq type
      ARM: dts: am437x-cm-t43: Correct tps65218 irq type
      ARM: dts: am437x-epos-evm: Correct tps65218 irq type
      ARM: dts: am437x-sk-evm: Correct tps65218 irq type
      ARM: dts: omap2420-n810: Enable McBSP2 for audio
      ARM: dts: omap2420-n810: Correct the audio codec (tlv320aic33) node

Robert Nelson (1):
      ARM: dts: Add am335x-pocketbeagle

 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi    |   9 +-
 arch/arm/boot/dts/am335x-evm.dts             |   9 +-
 arch/arm/boot/dts/am335x-evmsk.dts           |   9 +-
 arch/arm/boot/dts/am335x-osd335x-common.dtsi | 124 ++++++++++++++
 arch/arm/boot/dts/am335x-pocketbeagle.dts    | 237 +++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-cm-t43.dts          |   2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts          |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts          |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts         |   2 +-
 arch/arm/boot/dts/dm8148-t410.dts            |   2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi        |  25 +++
 arch/arm/boot/dts/omap2420-n810.dts          |  63 ++++++-
 arch/arm/boot/dts/omap3-beagle-xm.dts        |  10 ++
 arch/arm/boot/dts/omap3-gta04.dtsi           |  10 ++
 arch/arm/boot/dts/omap3-pandora-common.dtsi  |  10 ++
 16 files changed, 507 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-osd335x-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-pocketbeagle.dts
