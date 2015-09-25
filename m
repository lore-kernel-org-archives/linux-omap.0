From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for most mmc regressions and few other fixes
Date: Fri, 25 Sep 2015 07:40:35 -0700
Message-ID: <20150925144034.GR23801@atomide.com>
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

The following changes since commit 7168e947291f0ead07e5638b4599fb7845288b69:

  Merge branch 'fixes-rc1' into omap-for-v4.3/fixes (2015-09-14 13:42:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc2

for you to fetch changes up to 9a5e3f27d1b8ca349b79e8b5fe1874eeeedb6f45:

  ARM: dts: fix omap2+ address translation for pbias (2015-09-24 16:28:32 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.3-rc cycle:

- Two more patches to fix most of the MMC regressions with the
  PBIAS regulator changes. At least two MMC driver related issues
  still seems to remain for omap3 legacy booting and omap4 duovero.
  Note that the dts changes depend on a recent regulator fix, and
  are based on the regulator commit now in mainline kernel

- Enable autoidle for am43xx clocks to prevent clocks from staying
  always on

- Fix i2c5 pinctrl offsets for omap5-uevm

- Enable PCA953X as that's needed for HDMI to work on omap5

- Update phy supplies for beagle x15 beta board

- Use palmas-usb for on beagle x15 to start using the related
  driver that recently got merged
-

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: AM43XX: Enable autoidle for clks in am43xx_init_late

Grazvydas Ignotas (2):
      ARM: dts: omap5-uevm.dts: fix i2c5 pinctrl offsets
      ARM: omap2plus_defconfig: enable GPIO_PCA953X

Kishon Vijay Abraham I (2):
      regulator: pbias: program pbias register offset in pbias driver
      ARM: dts: fix omap2+ address translation for pbias

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15: Update Phy supplies

Roger Quadros (1):
      ARM: dts: am57xx-beagle-x15: use palmas-usb for USB2

Tony Lindgren (1):
      Merge commit 'b8c93646fd5c' into omap-for-v4.3/fixes

 .../bindings/regulator/pbias-regulator.txt         |  7 ++-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 42 ++++++++++------
 arch/arm/boot/dts/dra7.dtsi                        |  1 +
 arch/arm/boot/dts/omap2430.dtsi                    |  1 +
 arch/arm/boot/dts/omap3.dtsi                       | 25 +++++-----
 arch/arm/boot/dts/omap4.dtsi                       |  1 +
 arch/arm/boot/dts/omap5-uevm.dts                   |  4 +-
 arch/arm/boot/dts/omap5.dtsi                       |  1 +
 arch/arm/configs/omap2plus_defconfig               |  1 +
 arch/arm/mach-omap2/io.c                           |  1 +
 drivers/regulator/pbias-regulator.c                | 56 +++++++++++++++++++---
 11 files changed, 104 insertions(+), 36 deletions(-)
