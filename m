From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] device tree updates for omaps for v4.8 merge window
Date: Wed, 22 Jun 2016 04:06:42 -0700
Message-ID: <20160622110640.GD22353@atomide.com>
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

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/dt-part1-signed-v2

for you to fetch changes up to 52c7c91319e469142628199548852198bcc3150f:

  ARM: dts: AM43xx: Add node for RNG (2016-06-22 00:44:16 -0700)

----------------------------------------------------------------
Device tree changes for omaps for v4.8 merge window:

- PWM binding updates and related dts changes

- OCM RAM updates for dra7

- Enable n900 lirc-rx51 driver

- omap3-gta04 updates for backlight, bma180, itg3200, hmc5843 and wifi

- am335x, am437x and am57xx operating point updates and additions

- am335x-icev2 pca9536 node

- dra72-evm regulator updates

- edma spelling fixes

- am335x and am437x ethernet phy update

- a series of mcbsp updates

- omap3-gta04 eeprom

- dra7 PCIe unit address fix

- stdout-path for beaglebone variants

- crypto accelerator nodes for am335x, am437x and dra7

----------------------------------------------------------------
Andrew F. Davis (2):
      ARM: dts: am437x-idk-evm: Mark MAC as having only one PHY
      ARM: dts: am335x-bone-common: Mark MAC as having only one PHY

Dave Gerlach (10):
      ARM: dts: dra7: Add ocmcram nodes
      ARM: dts: dra7: Add ti,secure-ram node to ocmcram1 node
      ARM: dts: am335x: Update MPU regulator range for TI boards
      ARM: dts: am33xx: Move to operating-points-v2 table and ti-cpufreq driver
      ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
      ARM: dts: am4372: Add operating-points-v2 table
      ARM: dts: am437x-gp-evm: Hook dcdc2 as the cpu0-supply
      ARM: dts: dra7: Add dt node for the syscon control module wkup
      ARM: dts: dra7: Move cpus node to parent dts for dra74x and dra72x
      ARM: dts: dra7: Move to operating-points-v2 table

Enric Balletbo i Serra (1):
      ARM: dts: am335x-bone-common: use stdout-path in Beaglebone boards.

Franklin S Cooper Jr (5):
      ARM: dts: am437x: Add missing compatibles to PWM binding documents
      pwm: pwm-tiehrpwm: Update dt binding document to use generic node name
      pwm: pwm-tiecap: Update dt binding document to use proper unit address
      ARM: dts: am437x/am33xx/da850: Add new ECAP and EPWM bindings
      ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP and EPWM nodes

H. Nikolaus Schaller (5):
      ARM: dts: omap3-gta04: Define and use bma180 irq pin
      ARM: dta: omap3-gta04: Define and use itg3200  irq pin
      ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
      ARM: dts: omap3-gat04: Fix wifi handling
      ARM: dts: omap3-gta04: Add RFID eeprom node

Ivaylo Dimitrov (1):
      ARM: dts: n900: enable lirc-rx51 driver

Joel Fernandes (2):
      ARM: dts: DRA7: Add DT node for DES IP
      ARM: dts: DRA7: Add DT nodes for AES IP

Kishon Vijay Abraham I (1):
      ARM: dts: DRA7: fix unit address of second PCIe instance

Lokesh Vutla (4):
      ARM: dts: DRA7: Add support for SHA IP
      ARM: dts: DRA7: Add DT node for RNG IP
      ARM: dts: AM43xx: clk: Add RNG clk node
      ARM: dts: AM43xx: Add node for RNG

Marek Belisko (1):
      ARM: dts: omap3-gta04: Add backlight support

Misael Lopez Cruz (1):
      ARM: dts: dra72-evm: Rename 3.3V regulator tag

Peter Ujfalusi (6):
      ARM: dts: omap3: Add clocks to McBSP nodes
      ARM: dts: omap5-board-common: Add pdmclk binding for audio
      ARM: dts: omap4-panda-common: Add pdmclk binding for audio
      ARM: dts: omap4-sdp: Add pdmclk binding for audio
      ARM: dts: omap4-var-som-om44: Add pdmclk binding for audio
      ARM: dts: omap4-duovero: Add pdmclk binding for audio

Robert P. J. Day (1):
      ARM: dts: Correct misspelling, "emda3" -> "edma3"

Vignesh R (2):
      ARM: dts: DRA7: Add dt nodes for PWMSS
      ARM: dts: am335x-icev2: Add DT node for TI PCA9536

 Documentation/devicetree/bindings/dma/ti-edma.txt  |   4 +-
 .../devicetree/bindings/pwm/pwm-tiecap.txt         |  38 +++-
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  38 +++-
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        |  33 ++-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  12 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |  11 +
 arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   2 +-
 arch/arm/boot/dts/am335x-icev2.dts                 |   7 +
 arch/arm/boot/dts/am33xx.dtsi                      | 126 ++++++++---
 arch/arm/boot/dts/am4372.dtsi                      | 111 ++++++++--
 arch/arm/boot/dts/am437x-gp-evm.dts                |   4 +
 arch/arm/boot/dts/am437x-idk-evm.dts               |   1 +
 arch/arm/boot/dts/am43xx-clocks.dtsi               |   8 +
 arch/arm/boot/dts/dm814x.dtsi                      |   2 +-
 arch/arm/boot/dts/dra7.dtsi                        | 242 ++++++++++++++++++++-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |  12 +-
 arch/arm/boot/dts/dra72x.dtsi                      |  16 --
 arch/arm/boot/dts/dra74x.dtsi                      |  25 +--
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  66 +++++-
 arch/arm/boot/dts/omap3-n900.dts                   |  12 +
 arch/arm/boot/dts/omap3.dtsi                       |  10 +
 arch/arm/boot/dts/omap4-duovero.dtsi               |   5 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   5 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   5 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   5 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |   5 +
 drivers/clk/ti/clk-43xx.c                          |   1 +
 28 files changed, 681 insertions(+), 127 deletions(-)
