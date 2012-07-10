From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/5] minimal omap5 support for v3.6 merge window
Date: Tue, 10 Jul 2012 06:05:56 -0700
Message-ID: <E1SoaDN-0001gM-8N@merlin.infradead.org>
References: <pull-1341925556-888624>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341925556-888624>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit fb584511c4664573097ece7df0de06ad00b713a2:

  ARM: OMAP: sdrc: Fix the build break for OMAP4 only builds (2012-07-09 01:44:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap devel-omap5

for you to fetch changes up to 39f47d9f437fa94622bf51d7b18b42b3336ad9ac:

  ARM: Kconfig update to support additional GPIOs in OMAP5 (2012-07-09 19:14:40 +0530)

----------------------------------------------------------------
This branch contains minimal support for omap5 to boot to a
console without clock framework support. This branch depends
on omap-cleanup-part2-for-v3.6.

----------------------------------------------------------------
R Sricharan (11):
      ARM: OMAP2+: Move stubbed secure_sram_reserve function to a common.c and call it __weak
      ARM: OMAP: counter-32k: Select the CR register offset using the IP scheme
      ARM: OMAP5: id: Add cpu id for ES versions
      ARM: OMAP5: Add minimal support for OMAP5430 SOC
      ARM: OMAP5: timer: Add clocksource, clockevent support
      ARM: OMAP5: gpmc: Update gpmc_init()
      ARM: OMAP5: l3: Add l3 error handler support for omap5
      ARM: omap2+: board-generic: clean up the irq data from board file
      ARM: OMAP5: board-generic: Add device tree support
      arm/dts: OMAP5: Add omap5 dts files
      ARM: OMAP5: Add the build support

Santosh Shilimkar (2):
      ARM: OMAP5: Add the WakeupGen IP updates
      ARM: OMAP5: Add SMP support

Tarun Kanti DebBarma (1):
      ARM: Kconfig update to support additional GPIOs in OMAP5

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/omap5-evm.dts                    |   20 +++
 arch/arm/boot/dts/omap5.dtsi                       |  184 ++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap2/Kconfig                        |    8 +-
 arch/arm/mach-omap2/Makefile                       |   24 ++-
 arch/arm/mach-omap2/board-generic.c                |   42 +++--
 arch/arm/mach-omap2/common.c                       |   24 +++
 arch/arm/mach-omap2/common.h                       |   19 +-
 arch/arm/mach-omap2/control.h                      |    4 +
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/gpmc.c                         |    3 +-
 arch/arm/mach-omap2/id.c                           |   42 ++++-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    8 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |    7 +
 arch/arm/mach-omap2/io.c                           |   44 +++++
 arch/arm/mach-omap2/iomap.h                        |   27 +++
 arch/arm/mach-omap2/irq.c                          |   13 +-
 arch/arm/mach-omap2/omap-headsmp.S                 |   21 +++
 arch/arm/mach-omap2/omap-hotplug.c                 |   24 ++-
 arch/arm/mach-omap2/omap-smp.c                     |   52 ++++--
 arch/arm/mach-omap2/omap-wakeupgen.c               |  114 +++++++++---
 arch/arm/mach-omap2/omap4-common.c                 |   14 ++
 arch/arm/mach-omap2/omap4-sar-layout.h             |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/omap_l3_noc.h                  |   22 ++-
 arch/arm/mach-omap2/prcm-common.h                  |    2 +-
 arch/arm/mach-omap2/prcm.c                         |    2 +-
 arch/arm/mach-omap2/timer.c                        |    5 +
 arch/arm/plat-omap/Kconfig                         |    4 +-
 arch/arm/plat-omap/common.c                        |    9 +
 arch/arm/plat-omap/counter_32k.c                   |   16 +-
 arch/arm/plat-omap/include/plat/cpu.h              |   22 ++-
 arch/arm/plat-omap/include/plat/hardware.h         |    1 +
 arch/arm/plat-omap/include/plat/multi.h            |    9 +
 arch/arm/plat-omap/include/plat/omap-secure.h      |    5 -
 arch/arm/plat-omap/include/plat/omap54xx.h         |   32 ++++
 arch/arm/plat-omap/include/plat/serial.h           |   10 ++
 arch/arm/plat-omap/include/plat/uncompress.h       |    6 +
 arch/arm/plat-omap/sram.c                          |   11 +-
 41 files changed, 773 insertions(+), 98 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5.dtsi
 create mode 100644 arch/arm/plat-omap/include/plat/omap54xx.h
