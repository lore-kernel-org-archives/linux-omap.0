From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/27] OMAP3: PM: base off-mode support
Date: Wed, 14 Oct 2009 14:57:43 -0700
Message-ID: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series adds the base off-mode support to the OMAP3 PM core.
The code originates from the OMAP PM branch[1] and has been tested
broadly on a variety of OMAP3 platforms.

It is currently based on Tony's for-next branch since it depends
on the IO address space rework series.

This series is also available in the branch 'pm-upstream/pm-off' in
my linux-omap-pm git repo at
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin

[1] http://elinux.org/OMAP_Power_Management


Aaro Koskinen (2):
  OMAP: PM: Clear DMA channel state after a wakeup
  OMAP3: PM: Fix INTC context save/restore

Jouni Hogander (1):
  OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2

Juha Yrjola (1):
  OMAP: Store reboot mode in scratchpad on OMAP34xx

Kalle Jokiniemi (4):
  OMAP3: PM: Fix secure SRAM context save/restore
  ARM: OMAP: Add missing SMS_SYSCONFIG save/restore
  OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
  PM: Disable usb host HW save and restore

Kevin Hilman (2):
  OMAP3: PM debug: allow runtime toggle of PM features
  PM debug: allow configurable wakeup from suspend on OMAP GPtimer

Peter 'p2' De Schrijver (1):
  OMAP3: PM: Wait for SDRC ready iso a blind delay

Rajendra Nayak (11):
  OMAP3: PM: GPMC context save/restore
  OMAP3: PM: GPIO context save/restore
  OMAP3: PM: INTC context save/restore
  OMAP3: PM: PRCM context save/restore
  OMAP3: PM: Populate scratchpad contents
  OMAP3: PM: SCM context save/restore
  OMAP3: PM: SRAM restore function
  OMAP3: PM: handle PER/NEON/CORE in idle
  OMAP3: PM: Restore MMU table entry
  OMAP3: PM: MPU off-mode support
  OMAP3: PM: CORE domain off-mode support

Tero Kristo (5):
  OMAP: PM: DMA context save/restore for off-mode support
  OMAP3 PM: off-mode support for HS/EMU devices
  OMAP3: PM: save secure RAM only during init
  OMAP3: PM: Enable SDRAM auto-refresh during sleep
  OMAP3: PM: SDRC auto-refresh workaround for off-mode

 arch/arm/mach-omap2/control.c             |  364 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.c                |   98 +++++++-
 arch/arm/mach-omap2/irq.c                 |   66 +++++
 arch/arm/mach-omap2/pm-debug.c            |   29 ++
 arch/arm/mach-omap2/pm.h                  |   10 +
 arch/arm/mach-omap2/pm34xx.c              |  321 ++++++++++++++++++++++-
 arch/arm/mach-omap2/powerdomains34xx.h    |    8 +-
 arch/arm/mach-omap2/prcm.c                |  402 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/sdrc.c                |   27 ++
 arch/arm/mach-omap2/serial.c              |    2 -
 arch/arm/mach-omap2/sleep34xx.S           |  218 ++++++++++++++--
 arch/arm/mach-omap2/timer-gp.c            |    2 +
 arch/arm/plat-omap/dma.c                  |   62 +++++-
 arch/arm/plat-omap/gpio.c                 |   93 +++++++
 arch/arm/plat-omap/include/mach/control.h |   14 +
 arch/arm/plat-omap/include/mach/dma.h     |    5 +
 arch/arm/plat-omap/include/mach/gpio.h    |    3 +-
 arch/arm/plat-omap/include/mach/gpmc.h    |    3 +
 arch/arm/plat-omap/include/mach/irqs.h    |    5 +
 arch/arm/plat-omap/include/mach/prcm.h    |    5 +
 arch/arm/plat-omap/include/mach/sdrc.h    |    2 +
 arch/arm/plat-omap/include/mach/sram.h    |    2 +
 arch/arm/plat-omap/sram.c                 |    6 +-
 23 files changed, 1700 insertions(+), 47 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/include/mach/dma.h
