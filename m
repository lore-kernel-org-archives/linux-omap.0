From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] omap changes for ti81xx devices and minimal dra62x
 j5eco-evm support
Date: Mon, 21 Dec 2015 13:06:35 -0800
Message-ID: <39211.4389491782$1450732086@news.gmane.org>
References: <pull-1450731519-787330>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1450731519-787330>
In-Reply-To: <pull-1450731519-787330>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/81xx-devices

for you to fetch changes up to 8f2cf92a912ca7173d29c045d225588c9630ed94:

  ARM: dts: Add usb support for j5-eco evm (2015-12-21 10:43:29 -0800)

----------------------------------------------------------------
Now with dm814x support fixed up enough where we can make use of some clocks,
we can adds some more basic devices for dm814x. And we can also add minimal
support for dra62x j5eco-evm that is another ti81xx variant related to dm814x.

I would have rather merged this series toghether with the ADPLL clock driver,
and was waiting for that to get merged before sending out these patches. But
the ADPLL clock driver can be merged separately, and at least dm814x-evm,
dra62x-j5eco-evm, and t410 all boot with this series alone. So let's merge
these patches separately as that allows people to do development on these
platforms for other device drivers using the mainline kernel.

Note that this series depends on the earlier 81xx-fixes and omap initcall
changes. It also depends on the DMA commit ae0add740cd0 that's already in
mainline. As this series is mostly DTS changes with a few related hwmod
changes, it's probably best merged along with the other DTS changes.

----------------------------------------------------------------
Peter Ujfalusi (2):
      dmaengine: edma: DT: Change memcpy channel array from 16bit to 32bit type
      dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit type

Tony Lindgren (19):
      ARM: OMAP2+: Change core_initcall levels to postcore_initcall
      ARM: OMAP2+: Fix randconfig build warning for dm814_pllss_data
      Merge branch 'omap-for-v4.5/initcall'; commit 'ae0add740cd06169cd124f9aaa6eceb11e5b3060' into omap-for-v4.5/81xx-fixes
      ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
      ARM: dts: Add basic support for dra62x j5-eco SoC
      ARM: dts: Add minimal dra62x j5-eco evm support
      ARM: dts: Add pinctrl macros for dm814x
      ARM: dts: Update edma bindings on dm814x to use edma_xbar
      ARM: OMAP2+: Add mmc hwmod entries for dm814x
      ARM: dts: Add mmc device entries for dm814x
      ARM: dts: Add mmc support for dm8148-evm
      ARM: dts: Add mmc support for dra62x j5-eco evm
      ARM: dts: Enable emmc on hp t410
      ARM: OMAP2+: Update 81xx clock and power domains for default, active and sgx
      ARM: OMAP2+: Add support for dm814x and dra62x usb
      ARM: dts: Add usb support for dm814x and dra62x
      ARM: dts: Add usb support for dm814x-evm
      ARM: dts: Add usb support for hp t410
      ARM: dts: Add usb support for j5-eco evm

 Documentation/devicetree/bindings/dma/ti-edma.txt |  10 +-
 arch/arm/boot/dts/Makefile                        |   3 +-
 arch/arm/boot/dts/dm8148-evm.dts                  |  55 ++++++
 arch/arm/boot/dts/dm8148-t410.dts                 |  70 +++++++
 arch/arm/boot/dts/dm814x.dtsi                     | 226 ++++++++++++++++++++--
 arch/arm/boot/dts/dra62x-clocks.dtsi              |  23 +++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts            |  80 ++++++++
 arch/arm/boot/dts/dra62x.dtsi                     |  23 +++
 arch/arm/mach-omap2/clockdomains81xx_data.c       |  29 +--
 arch/arm/mach-omap2/cm81xx.h                      |   6 +-
 arch/arm/mach-omap2/id.c                          |   4 +-
 arch/arm/mach-omap2/omap2-restart.c               |   2 +-
 arch/arm/mach-omap2/omap_device.c                 |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c                  |   2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c        | 131 +++++++++++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c       |  10 +-
 arch/arm/mach-omap2/prm_common.c                  |   2 +
 arch/arm/mach-omap2/serial.c                      |   2 +-
 drivers/dma/edma.c                                |  53 +++--
 include/dt-bindings/pinctrl/dm814x.h              |  48 +++++
 include/dt-bindings/pinctrl/omap.h                |   1 +
 include/linux/platform_data/edma.h                |   2 +-
 22 files changed, 702 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra62x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dra62x-j5eco-evm.dts
 create mode 100644 arch/arm/boot/dts/dra62x.dtsi
 create mode 100644 include/dt-bindings/pinctrl/dm814x.h
