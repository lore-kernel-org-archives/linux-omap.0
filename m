From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP4 MPU sub-system PM for v3.2
Date: Fri, 14 Oct 2011 15:54:02 -0700
Message-ID: <878vonchh1.fsf@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Tony,

Please pull the OMAP4 PM support for the MPU sub-system.

This branch is built on top of my for_3.2/omap4-pm-base branch which is
simply a merge of Russell's devel-stable and Thomas' irq/core branch
(both already part of Arnd's arm-soc/for-next branch.)

Special thanks to Santosh for this series and also the quick response on
a few last minute build/test issues I came across so we can hopefully
still get this in for v3.2.

Kevin

The following changes since commit fe7f69ad79056043413aeb7e5ce27841fe3eb20e:

  Merge branch 'irq/core' of git://tesla.tglx.de/git/linux-2.6-tip into for_3.2/omap4-mpuss-pm (2011-10-07 11:29:32 -0700)

are available in the git repository at:

  git://github.com/khilman/linux-omap-pm.git for_3.2/omap4-pm

Kevin Hilman (1):
      Merge branch 'for_3.2/omap4-mpuss-pm' into for_3.2/omap4-pm

Santosh Shilimkar (24):
      ARM: OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
      ARM: OMAP4: Export omap4_get_base*() rather than global address pointers
      ARM: OMAP4: PM: Add SAR RAM support
      ARM: OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3/L4 and DUCATI-L3
      ARM: OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
      ARM: OMAP4: PM: Initialise all the clockdomains to supported states
      ARM: OMAP: Add Secure HAL and monitor mode API infrastructure.
      ARM: OMAP: PM: Add support to allocate the memory for secure RAM
      ARM: OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
      ARM: OMAP4: PM: Add CPUX OFF mode support
      ARM: OMAP4: Remove __INIT from omap_secondary_startup() to re-use it for hotplug.
      ARM: OMAP4: PM: Program CPU1 to hit OFF when off-lined
      ARM: OMAP4: PM: CPU1 wakeup workaround from Low power modes
      ARM: OMAP4: PM: Use custom omap_do_wfi() for default idle.
      ARM: OMAP4: suspend: Add MPUSS power domain RETENTION support
      ARM: OMAP4: Remove un-used do_wfi() macro.
      ARM: OMAP4: PM: Add WakeupGen and secure GIC low power support
      ARM: OMAP4: PM: Add L2X0 cache lowpower support
      ARM: OMAP4: PM: Add MPUSS power domain OSWR support
      ARM: OMAP4: PM: Add power domain statistics support
      ARM: OMAP4: PM: Add CPUidle support
      ARM: OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
      ARM: OMAP3: CPUidle: Make use of CPU PM notifiers
      ARM: OMAP4: Fix errata i688 with MPU interconnect barriers.

 arch/arm/mach-omap2/Kconfig                        |   21 +
 arch/arm/mach-omap2/Makefile                       |   16 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |   15 +
 arch/arm/mach-omap2/cpuidle44xx.c                  |  218 +++++++++++
 arch/arm/mach-omap2/include/mach/barriers.h        |   31 ++
 arch/arm/mach-omap2/include/mach/omap-secure.h     |   57 +++
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |   39 ++
 arch/arm/mach-omap2/include/mach/omap4-common.h    |   67 +++-
 arch/arm/mach-omap2/io.c                           |    9 +
 arch/arm/mach-omap2/omap-headsmp.S                 |    5 -
 arch/arm/mach-omap2/omap-hotplug.c                 |   14 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  398 ++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.c                  |   81 ++++
 arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} |   23 ++
 arch/arm/mach-omap2/omap-smp.c                     |   45 +++
 arch/arm/mach-omap2/omap-wakeupgen.c               |  389 +++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                 |   94 +++++-
 arch/arm/mach-omap2/omap4-sar-layout.h             |   50 +++
 arch/arm/mach-omap2/pm.h                           |    1 +
 arch/arm/mach-omap2/pm44xx.c                       |  156 ++++++++-
 arch/arm/mach-omap2/sleep44xx.S                    |  378 +++++++++++++++++++
 arch/arm/plat-omap/common.c                        |    3 +
 arch/arm/plat-omap/include/plat/omap-secure.h      |   13 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 +
 arch/arm/plat-omap/include/plat/sram.h             |    5 +
 arch/arm/plat-omap/sram.c                          |   11 +-
 26 files changed, 2104 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
 create mode 100644 arch/arm/mach-omap2/include/mach/barriers.h
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-secure.h
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
 create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
 create mode 100644 arch/arm/mach-omap2/omap-secure.c
 rename arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} (70%)
 create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
 create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h
 create mode 100644 arch/arm/mach-omap2/sleep44xx.S
 create mode 100644 arch/arm/plat-omap/include/plat/omap-secure.h
