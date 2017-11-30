From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] fixes for omaps for v4.15-rc cycle
Date: Thu, 30 Nov 2017 08:19:27 -0800
Message-ID: <pull-1512056553-465925@atomide.com>
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

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/fixes-v2-signed

for you to fetch changes up to 7cd4a5eb64b638a71564f62175f6c7ad3f27044e:

  Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.15/fixes-v2 (2017-11-28 08:23:05 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.15-rc cycle with two fixes for hangs with the
rest being compiler warning fixes and fixes for power states and devices
on various boards:

- Fix smatch issue introduced by recent omap device changes for legacy
  resources

- Fix SRAM virt to phys related boot hang affecting n900 and other omap3 hs
  devices found by pending CMA changes. While it seems that we have not hit
  this in other use cases, let's fix it to avoid a nasty and hard to find
  suprise as right now there is just luck keeping the SRAM virtual address
  to physical address translation working with the 0xffff high_mask.

- Fix am335x reading of domain state registers that only exist for the
  PM_CEFUSE domain and produce wrong results for other domains

- Fix missing setting for error code for omap device if allocation fails

- Fix missing modules_offs for omap3 MMC3 affecting n9/n950

- Fix cm_split_idlest() reading reserved registers showing wrong
  idlestatus

- Fixes to correct #phy-cells property for compiler warnings that
  recently started happening

- Add a missing OHCI remote-wakeup-connected property that I was supposed
  to merge after the ohci-omap3 to ohci-platform changes but somehow managed
  to drop. I only noticed this was missing while debugging the OHCI/EHCI GPS
  and modem hang

- Fix a system hang with GPS or modem connected to the OHCI/EHCI bus that
  typically happened within 20 - 40 minutes on an idle system. This turned
  out to be an issue caused by using the parent interrupt controller directly
  with the WUGEN + GIC stacked interrupt controller domains

- Fixes for logicpd-somlv GPMC for Ethernet and NAND that clearly
  have been broken since we changed GPMC to use the interrupt controller
  binding for some pins. And fix the wrong pin muxing for WLAN while at it

- Fixes for am437x interrupt and dma properties to fix compiler warnings
  that recently started happening

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet
      ARM: dts: logicpd-somlv: Fix wl127x pinmux

Dan Carpenter (1):
      ARM: OMAP2+: Missing error code in omap_device_build()

Keerthy (1):
      ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Peter Ujfalusi (2):
      ARM: dts: am4372: Correct the interrupts_properties of McASP
      ARM: dts: am437x-cm-t43: Correct the dmas property of spi0

Rob Herring (2):
      ARM: dts: omap: Add missing #phy-cells to usb-nop-xceiv
      ARM: dts: am33xx: Add missing #phy-cells to ti,am335x-usb-phy

Tero Kristo (2):
      ARM: OMAP3: hwmod_data: add missing module_offs for MMC3
      ARM: OMAP2/3: CM: fix cm_split_idlest functionality

Tony Lindgren (8):
      ARM: OMAP2+: Fix smatch found issue for omap_device
      ARM: dts: Add remote-wakeup-connected for omap OHCI
      ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context
      ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen
      Merge branch 'soc-fixes' into omap-for-v4.15/fixes
      Merge branch 'dts-fixes' into omap-for-v4.15/fixes-dt
      Merge branch 'omap-for-v4.14/fixes' into omap-for-v4.15/fixes-v2
      Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.15/fixes-v2

 .../devicetree/bindings/usb/am33xx-usb.txt         |  2 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  2 ++
 arch/arm/boot/dts/am4372.dtsi                      |  6 +++--
 arch/arm/boot/dts/am437x-cm-t43.dts                |  4 ++--
 arch/arm/boot/dts/dm814x.dtsi                      |  1 +
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |  3 ++-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              | 17 +++++++++-----
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  1 +
 arch/arm/boot/dts/omap3-beagle.dts                 |  1 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 ++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  1 +
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |  1 +
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |  1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  1 +
 arch/arm/boot/dts/omap3-overo-base.dtsi            |  1 +
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  1 +
 arch/arm/boot/dts/omap3-tao3530.dtsi               |  1 +
 arch/arm/boot/dts/omap3.dtsi                       |  1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  1 +
 arch/arm/boot/dts/omap4-duovero.dtsi               |  1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  1 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |  1 +
 arch/arm/boot/dts/omap4.dtsi                       |  3 +--
 arch/arm/boot/dts/omap5-board-common.dtsi          |  2 ++
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 ++
 arch/arm/boot/dts/omap5.dtsi                       |  1 +
 arch/arm/mach-omap2/cm_common.c                    |  6 ++++-
 arch/arm/mach-omap2/omap-secure.c                  | 19 ++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h                  |  4 ++++
 arch/arm/mach-omap2/omap_device.c                  | 10 ++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  1 +
 arch/arm/mach-omap2/pm.h                           |  4 ----
 arch/arm/mach-omap2/pm34xx.c                       | 13 ++++-------
 arch/arm/mach-omap2/prcm-common.h                  |  1 +
 arch/arm/mach-omap2/prm33xx.c                      | 12 ----------
 arch/arm/mach-omap2/sleep34xx.S                    | 26 ++++------------------
 37 files changed, 90 insertions(+), 66 deletions(-)
