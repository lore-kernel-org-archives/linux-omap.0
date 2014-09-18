From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] part 2 of omap SoC changes for v3.18 merge window
Date: Thu, 18 Sep 2014 13:11:01 -0700
Message-ID: <28495.4325216406$1411071181@news.gmane.org>
References: <pull-1411070912-460910>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1411070912-460910>
In-Reply-To: <pull-1411070912-460910>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 377fb3f5d9a34b2913939e0620c1c585b5913bab:

  ARM: OMAP5+: Reuse OMAP4 PM code for OMAP5 and DRA7 (2014-09-09 19:13:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/soc-part2-for-v3.18

for you to fetch changes up to 1306c08a7cd7e6136490ab2bc728d2c39741003e:

  ARM: OMAP4+: Remove static iotable mappings for SRAM (2014-09-18 09:47:35 -0700)

----------------------------------------------------------------
Few hwmod changes to support upcoming 8250 driver with DMA,
start using the SRAM driver for some omaps, and update the
defconfig.

----------------------------------------------------------------
Rajendra Nayak (3):
      ARM: AM335x: Get rid of unused sram init function
      ARM: OMAP4+: Move SRAM data to DT
      ARM: OMAP4+: Remove static iotable mappings for SRAM

Tony Lindgren (7):
      ARM: OMAP2+: Add hwmod flag for HWMOD_RECONFIG_IO_CHAIN
      ARM: OMAP3: Use manual idle for UARTs because of DMA errata
      ARM: omap2plus_defconfig: Shrink with savedefconfig
      ARM: omap2plus_defconfig: Add cpufreq to defconfig
      ARM: omap2plus_defconfig: Add support for distros with systemd
      ARM: omap2plus_defconfig: Enable battery and reset drivers
      ARM: omap2plus_defconfig: Enable some display features

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  3 +
 arch/arm/boot/dts/am33xx.dtsi                      |  5 +-
 arch/arm/boot/dts/am4372.dtsi                      |  5 ++
 arch/arm/boot/dts/omap4.dtsi                       |  6 ++
 arch/arm/boot/dts/omap5.dtsi                       |  8 ++-
 arch/arm/configs/omap2plus_defconfig               | 79 +++++++++++++++++-----
 arch/arm/mach-omap2/io.c                           | 17 -----
 arch/arm/mach-omap2/omap4-common.c                 | 22 +++++-
 arch/arm/mach-omap2/omap_hwmod.c                   |  4 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |  4 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 12 ++--
 arch/arm/mach-omap2/sram.c                         | 39 +----------
 arch/arm/mach-omap2/sram.h                         |  7 --
 13 files changed, 119 insertions(+), 92 deletions(-)
