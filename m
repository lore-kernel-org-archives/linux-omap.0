From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] device tree changes for omaps for v5.2
Date: Mon, 15 Apr 2019 10:00:53 -0700
Message-ID: <pull-1555343712-332506@atomide.com>
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

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/dt-signed

for you to fetch changes up to bcbb63b80284af0061ac44fe944d31a8482d2b8a:

  ARM: dts: dra7: Separate AM57 dtsi files (2019-04-12 09:57:07 -0700)

----------------------------------------------------------------
Devicetree changes for omap variants

This series of changes configures dra7 pcie x2 lane mode, configures
am43xx-epos-evm regulators and keypad wakeup source, and uses standard
reset-gpios instead of gpio-reset for n810.

We also need to split dra7 dtsi files for properly supporting dra76x
and am576 as some of the devices are different such as usb and pruss.

----------------------------------------------------------------
Andrew F. Davis (2):
      ARM: dts: am43xx-epos-evm: Add matrix keypad as wakeup source
      ARM: dts: omap2420-n810: Use new CODEC reset pin name

Kabir Sahane (1):
      ARM: dts: am43xx-epos-evm: Keep DCDC5 and DCDC6 always on

Kishon Vijay Abraham I (1):
      ARM: dts: dra7: Add properties to enable PCIe x2 lane mode

Mike Erdahl (1):
      ARM: dts: am43xx-epos-evm: Keep DCDC3 regulator on in suspend to memory

Roger Quadros (2):
      dt-binding: arm: omap: Add information for AM5748
      ARM: dts: dra7: Separate AM57 dtsi files

 .../devicetree/bindings/arm/omap/omap.txt          |  6 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts               | 11 ++++++++
 arch/arm/boot/dts/am5718.dtsi                      | 32 +++++++++++++++++++++
 arch/arm/boot/dts/am571x-idk.dts                   |  2 +-
 arch/arm/boot/dts/am5728.dtsi                      | 33 ++++++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts                   |  5 ++--
 arch/arm/boot/dts/am5748.dtsi                      | 33 ++++++++++++++++++++++
 arch/arm/boot/dts/am574x-idk.dts                   |  4 +--
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |  2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |  6 ++--
 arch/arm/boot/dts/dra7.dtsi                        |  2 ++
 arch/arm/boot/dts/omap2420-n810.dts                |  2 +-
 13 files changed, 128 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/am5718.dtsi
 create mode 100644 arch/arm/boot/dts/am5728.dtsi
 create mode 100644 arch/arm/boot/dts/am5748.dtsi
