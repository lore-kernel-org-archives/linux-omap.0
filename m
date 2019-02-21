From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] dts changes for cpsw phy driver for v5.1
Date: Thu, 21 Feb 2019 08:45:31 -0800
Message-ID: <pull-1550767488-25979@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

The following changes since commit 947b7802597106dcbef2ddca23d386f9339ba334:

  ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-cpsw-phy

for you to fetch changes up to bae2bf97939aebd74dfd8f0b76b4902a19e63eef:

  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)

----------------------------------------------------------------
Device tree changes to make CPSW Ethernet use proper phy driver

We now have a proper PHY driver with drivers/phy/ti/phy-gmii-sel.c to
configure the CPSW PHY. These changes update all CPSW users to use the
new driver that already got merged during v5.0 merge window.

----------------------------------------------------------------
Grygorii Strashko (5):
      ARM: dts: dra7: switch to use phy-gmii-sel
      ARM: dts: dm814x: switch to use phy-gmii-sel
      ARM: dts: am4372: switch to use phy-gmii-sel
      ARM: dts: am335x: switch to use phy-gmii-sel
      dt-bindings: net: ti: deprecate cpsw-phy-sel bindings

 Documentation/devicetree/bindings/net/cpsw-phy-sel.txt |  2 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts             |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts             |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts             |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts                |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts                     |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi                 |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                       |  4 ----
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi      |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts         |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi              |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                       | 15 ++++++++-------
 arch/arm/boot/dts/am437x-l4.dtsi                       | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts                   |  5 +----
 arch/arm/boot/dts/dm814x.dtsi                          | 15 +++++++++------
 arch/arm/boot/dts/dra7-l4.dtsi                         | 15 ++++++++-------
 16 files changed, 36 insertions(+), 75 deletions(-)
