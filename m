From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] dts changes for omaps for v4.19
Date: Wed, 11 Jul 2018 06:19:07 -0700
Message-ID: <pull-1531314878-371161@atomide.com-4>
References: <pull-1531314878-371161@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1531314878-371161@atomide.com>
In-Reply-To: <pull-1531314878-371161@atomide.com>
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

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/dt-signed-v2

for you to fetch changes up to 792f98677d7f777a4f58e567b5b0578191cb986a:

  Merge commit '949bdcc8a97c' into omap-for-v4.19/dt (2018-07-11 05:54:32 -0700)

----------------------------------------------------------------
dts changes for omaps for v4.19 merge window

Mostly updates to configure and improve the devices
found on various SoCs and boards:

- several patches to update support for am3517-evm
  to replace bogus fixed regulators with proper
  regulators and configure various devices such
  as wlan, bluetooth and usb1

- add missing cooling devices for omap5 and dra7

- configure dual role for usb ports for am57xx
  and dra7

- PM updates for omap4 devices to allow retention
  idle for minimal configurations

- am335x-sl50 updates for various devices

- update d-can alias names to not use undescore

- configure pandaboard gpio button

- a non-urgent change to fix dcan node address that
  i forgot to send a pull request for earlier

----------------------------------------------------------------
Adam Ford (4):
      ARM: dts: am3517-evm: Remove unnessary PMIC parameters
      ARM: dts: am3517-som: Add WL127x Wifi
      ARM: dts: am3517-som:  Add builtin Bluetooth
      ARM: dts: am3517-evm: Enable USB1 Host

Derald D. Woods (1):
      ARM: dts: am3517-evm: Add 'vdd_io_reg' regulator references

Enric Balletbo i Serra (8):
      ARM: dts: am335x-sl50: update backlight nodes
      ARM: dts: am335x-sl50: use phy-phandle declarations
      ARM: dts: am335x-sl50: add a node for the LCD controller
      ARM: dts: am335x-sl50: set dr_mode to otg
      ARM: dts: am335x-sl50: add support for DS1339 Real Time Clock
      ARM: dts: am335x-sl50: use audio-graph-card for sound
      ARM: dts: am335x-sl50: fix label names for all LEDs
      ARM: dts: am335x-sl50: enable tsadc on SL50 board

Felix Brack (1):
      ARM: dts: am33xx: Fix syntax of alias names

Kevin Hilman (1):
      ARM: dts: dra7: fix DCAN node addresses

Peter Robinson (1):
      ARM: dts: pandaboard: add gpio user button

Roger Quadros (4):
      ARM: dts: am57xx-idk: Enable dual role for USB2 port
      ARM: dts: dra7-evm: Add extcon to USB2 port
      ARM: dts: dra71-evm: Add VBUS GPIO to USB1/USB2 extcon
      ARM: dts: dra76-evm: Add VBUS GPIO to USB1/USB2 extcon

Tony Lindgren (4):
      ARM: dts: Improve omap l4per idling with wlcore edge sensitive interrupt
      ARM: dts: Configure duovero for to allow core retention during idle
      ARM: dts: omap4-droid4: Use software debounce for gpio-keys
      Merge commit '949bdcc8a97c' into omap-for-v4.19/dt

Viresh Kumar (2):
      ARM: dts: dra74x: Add missing cooling device properties for CPUs
      ARM: dts: omap5: Add missing cooling device properties for CPUs

 arch/arm/boot/dts/am335x-baltos.dtsi              |   2 +-
 arch/arm/boot/dts/am335x-evm.dts                  |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                |   2 +-
 arch/arm/boot/dts/am335x-sl50.dts                 | 297 ++++++++++++++++++----
 arch/arm/boot/dts/am33xx.dtsi                     |   4 +-
 arch/arm/boot/dts/am3517-evm.dts                  |  50 +++-
 arch/arm/boot/dts/am3517-som.dtsi                 | 105 +++++++-
 arch/arm/boot/dts/am437x-gp-evm.dts               |   2 +-
 arch/arm/boot/dts/am571x-idk.dts                  |   4 -
 arch/arm/boot/dts/am572x-idk-common.dtsi          |   4 -
 arch/arm/boot/dts/am57xx-idk-common.dtsi          |   7 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi            |  10 +
 arch/arm/boot/dts/dra7-evm.dts                    |   9 -
 arch/arm/boot/dts/dra7.dtsi                       |   4 +-
 arch/arm/boot/dts/dra71-evm.dts                   |   8 +
 arch/arm/boot/dts/dra72-evm-common.dtsi           |   1 +
 arch/arm/boot/dts/dra74x.dtsi                     |  10 +
 arch/arm/boot/dts/dra76-evm.dts                   |   8 +
 arch/arm/boot/dts/logicpd-som-lv.dtsi             |   2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |   2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts              |   2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts              |   2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi           |   2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts        |   2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts        |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                 |   2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts          |   7 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts        |   4 +-
 arch/arm/boot/dts/omap4-duovero.dtsi              |   1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi         |  24 +-
 arch/arm/boot/dts/omap4-panda-es.dts              |  12 +
 arch/arm/boot/dts/omap4-sdp.dts                   |   2 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi    |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi         |   2 +-
 arch/arm/boot/dts/omap5.dtsi                      |  14 +
 35 files changed, 512 insertions(+), 101 deletions(-)
