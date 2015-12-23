From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] reworked dts changes for ti81xx devices and minimal
 dra62x j5ec-evm support
Date: Tue, 22 Dec 2015 17:44:47 -0800
Message-ID: <32569.0622012646$1450835154@news.gmane.org>
References: <pull-1450834180-928842>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1450834180-928842>
In-Reply-To: <pull-1450834180-928842>
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

The following changes since commit d893656e61040f3ff7b5f72a986052a348f3c94e:

  ARM: OMAP2+: Remove useless check for legacy booting for dm814x (2015-12-09 16:53:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/81xx-dts-signed

for you to fetch changes up to 43fe6de38ea57bf3ef20e89d8bf9b799a7ff0c0b:

  ARM: dts: Add usb support for j5-eco evm (2015-12-22 16:01:41 -0800)

----------------------------------------------------------------
Add minimal device tree support for dra62x also known j5eco. It is
related to dm814x, just the clocks are a bit different and it has a
different set of integrated devices. And let's get some basic dm814x
and dra62x devices working as many of the devices are like on am33xx::

- pinctrl using the pinctrl defines as for am33xx

- Updated EDMA bindings with support for using exma_xbar

- MMC support for dm814x-evm, t410 and dra62x-j5eco-evm

- USB support for dm814x-evm, t410 and dra62x-j5eco-evm

This branch depends on an earlier omap-for-v4.5/81xx-fixes-signed
branch that has dm814x dts fixes interlaced with SoC related fixes to
keep things booting. The interlaced SoC and dts fixes were needed
because of issues with the device tree defined clocks that just
happened to work on bootloader timings for t410 earlier.

----------------------------------------------------------------
Tony Lindgren (12):
      ARM: dts: Add basic support for dra62x j5-eco SoC
      ARM: dts: Add minimal dra62x j5-eco evm support
      ARM: dts: Add pinctrl macros for dm814x
      ARM: dts: Update edma bindings on dm814x to use edma_xbar
      ARM: dts: Add mmc device entries for dm814x
      ARM: dts: Add mmc support for dm8148-evm
      ARM: dts: Add mmc support for dra62x j5-eco evm
      ARM: dts: Enable emmc on hp t410
      ARM: dts: Add usb support for dm814x and dra62x
      ARM: dts: Add usb support for dm814x-evm
      ARM: dts: Add usb support for hp t410
      ARM: dts: Add usb support for j5-eco evm

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/dm8148-evm.dts       |  55 ++++++++
 arch/arm/boot/dts/dm8148-t410.dts      |  70 ++++++++++
 arch/arm/boot/dts/dm814x.dtsi          | 226 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/dra62x-clocks.dtsi   |  23 ++++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts |  80 ++++++++++++
 arch/arm/boot/dts/dra62x.dtsi          |  23 ++++
 include/dt-bindings/pinctrl/dm814x.h   |  48 +++++++
 include/dt-bindings/pinctrl/omap.h     |   1 +
 9 files changed, 517 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra62x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dra62x-j5eco-evm.dts
 create mode 100644 arch/arm/boot/dts/dra62x.dtsi
 create mode 100644 include/dt-bindings/pinctrl/dm814x.h
