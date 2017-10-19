From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] non-urgent device tree fixes for omaps for v4.15 merge
 window
Date: Thu, 19 Oct 2017 14:59:30 -0700
Message-ID: <pull-1508450284-272943@atomide.com>
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

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/fixes-dt-signed

for you to fetch changes up to 1ff516a4bacf146a261b66d89892046078dba86c:

  ARM: dts: Fix typo for omap4 mcasp rx path (2017-10-13 09:43:22 -0700)

----------------------------------------------------------------
Non-urgent device tree fixes for omaps that can all wait for v4.15
merge window.

Turns out that we have many devices working just because we have
the legacy platform data still around. This is mostly an issue
for omap4, other SoCs just have minimal fixes needed.

As many of the missing device tree nodes and properties are for
devices that have no drivers in the mainline kernel, such as
slimbus, iss, mcasp, aess, fdif and gpu, we might as well start
using the new "ti,sysc" interconnect target module binding for
them so we can get the devices with no child device drivers idled.

This also makes it possible to drop unnecessary platform data
in later patches.

----------------------------------------------------------------
Tony Lindgren (15):
      ARM: dts: Add missing dma hwmods property for omap3
      ARM: dts: Configure pmu without interrupt for omap4430
      ARM: dts: Add missing properties for omap4 control modules
      ARM: dts: Add missing hwmods property for omap4 dma
      ARM: dts: Add missing smartreflex node and binding for omap4
      ARM: dts: Add missing onewire node for omap4
      ARM: dts: Add missing hsi node for omap4
      ARM: dts: Add missing wdt3 node for omap4
      ARM: dts: Add missing dma hwmod property for omap5
      ARM: dts: Add missing hwmod related nodes for am33xx
      ARM: dts: Add missing hwmod related properties for dra7
      dt-bindings: bus: Minimal TI sysc interconnect target module binding
      ARM: dts: Add nodes for missing omap4 interconnect target modules
      ARM: dts: Configure SmartReflex only to idle the interconnect target module
      ARM: dts: Fix typo for omap4 mcasp rx path

 .../devicetree/bindings/arm/omap/ctrl.txt          |   2 +
 Documentation/devicetree/bindings/bus/ti-sysc.txt  |  93 ++++++++
 Documentation/devicetree/bindings/hsi/omap-ssi.txt |  13 +-
 .../bindings/memory-controllers/ti/emif.txt        |   6 +-
 .../devicetree/bindings/power/ti-smartreflex.txt   |  47 ++++
 arch/arm/boot/dts/am33xx.dtsi                      |  10 +-
 arch/arm/boot/dts/dra7.dtsi                        |  34 +++
 arch/arm/boot/dts/omap3.dtsi                       |   1 +
 arch/arm/boot/dts/omap4.dtsi                       | 256 ++++++++++++++++++++-
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 10 files changed, 447 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/power/ti-smartreflex.txt
