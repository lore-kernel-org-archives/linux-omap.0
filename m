From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dts changes for v4.4 merge window, part 2
Date: Tue, 20 Oct 2015 12:35:02 -0700
Message-ID: <20151020193501.GN3078@atomide.com>
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

The following changes since commit be146412501bc2ed49183637605da97f47125696:

  ARM: dts: omap3-igep: Use OMAP3_CORE1_IOPAD pinmux macro (2015-10-14 12:28:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/dt-pt2

for you to fetch changes up to e9a267702d32fc8e71abe5f172d2924bad86e52f:

  ARM: dts: am335x-base0033: Use IOPAD pinmux macro (2015-10-20 09:28:04 -0700)

----------------------------------------------------------------
Few more omap dts changes for v4.4 merge window, mostly to fix and clean
up some omap5 issues to allow adding other omap5 boards. Also some other
fixes and clean-up:

- Fix SDIO WLAN for omap5 that's been broken for a while. As further
  patches are still needed for wl18xx, no need for stable on this one.

- Move most of omap5 support into omap5-board-common.dtsi as most omap5
  boards seem to share the same basic set of devices.

- Add minimal IGEPv5 support using based on omap5-board-common.dtsi

- Remove now unneedes gpio hogging for dra72-evm

- Update Javier Martinez Canillas email address

- Change earlier IGEP boards to use IOPAD pinmux macros

----------------------------------------------------------------
Javier Martinez Canillas (4):
      ARM: dts: Update Javier Martinez Canillas's email
      ARM: dts: omap3-igep0020: Use IOPAD pinmux macro
      ARM: dts: am335x-igep0033: Use IOPAD pinmux macro
      ARM: dts: am335x-base0033: Use IOPAD pinmux macro

Mugunthan V N (1):
      ARM: dts: dra72-evm: remove cpsw gpio hogging and add mode-gpios

Tony Lindgren (3):
      ARM: dts: Fix WLAN regression on omap5-uevm
      ARM: dts: Move most of omap5-uevm.dts to omap5-board-common.dtsi
      ARM: dts: Add basic support for isee igepv5

Vignesh R (1):
      ARM: dts: am437x-gp-evm: Add wakeup interrupt source for pixcir_i2c_ts

 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/am335x-base0033.dts        |  48 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi       |  40 +-
 arch/arm/boot/dts/am437x-gp-evm.dts          |   9 +
 arch/arm/boot/dts/dra72-evm.dts              |   7 +-
 arch/arm/boot/dts/omap3-igep.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi |  60 +--
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts   |   2 +-
 arch/arm/boot/dts/omap3-igep0020.dts         |   2 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts   |   2 +-
 arch/arm/boot/dts/omap3-igep0030.dts         |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi    | 655 +++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-igep0050.dts         |  54 +++
 arch/arm/boot/dts/omap5-uevm.dts             | 618 +------------------------
 15 files changed, 814 insertions(+), 690 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap5-board-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-igep0050.dts
