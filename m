From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: UART cleanup and runtime PM conversion for v3.3
Date: Wed, 14 Dec 2011 16:53:50 -0800
Message-ID: <878vmeodsx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Govindraj Raja <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Tony,

Please pull the OMAP UART cleanup and conversion to runtime PM.  I had
to rebase it onto your soc branch due to the serial.c changes there.

This includes changes to drivers/tty/serial/omap-serial.c and those
changes have Acks from Greg KH and Alan Cox and I got the OK from them
to merge this all together via the OMAP tree.

Thanks to Govindraj for his persistence with this series.

Boot tested on 2420/n810, 4430/Blaze, 4430/Panda
Additional PM testing on 3430/n900, 3530/Overo, 3630/Zoom3.

NOTE: while normal UART behavior works fine with this series, including
      suspend/resume, in order for wakeups from runtime PM to work, this
      series depends on the PRCM IRQ chaining series from Tero and the
      the new hwmod init state from Rajendra[1].  However, since runtime
      PM is disabled by default for the UARTs, they will behave normally
      even without those dependencies.

Kevin

[1] http://marc.info/?l=linux-omap&m=132187766930901&w=2


The following changes since commit 4390f5b2cb1f568c1d4b3e5bbf57158f6809627a:

  ARM: OMAP: TI814X: Add cpu type macros and detection support (2011-12-13 10:46:45 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/uart/runtime-pm

Deepak K (1):
      ARM: OMAP2+: UART: Allow UART parameters to be configured from board file.

Govindraj.R (19):
      ARM: OMAP2+: UART: cleanup + remove uart pm specific API
      ARM: OMAP2+: UART: cleanup 8250 console driver support
      ARM: OMAP2+: UART: Cleanup part of clock gating mechanism for uart
      ARM: OMAP2+: UART: Add default mux for all uarts.
      ARM: OMAP2+: UART: Remove mapbase/membase fields from pdata.
      ARM: OMAP2+: UART: Add runtime pm support for omap-serial driver
      ARM: OMAP2+: UART: Remove context_save and move context restore to driver
      ARM: OMAP2+: UART: Ensure all reg values configured are available from port structure
      ARM: OMAP2+: UART: Remove uart reset function.
      ARM: OMAP2+: UART: Get context loss count to context restore
      ARM: OMAP2+: UART: Move errata handling from serial.c to omap-serial
      ARM: OMAP2+: UART: Add wakeup mechanism for omap-uarts
      ARM: OMAP2+: UART: Remove old and unused clocks handling funcs
      ARM: OMAP2+: UART: remove temporary variable used to count uart instance
      ARM: OMAP2+: UART: Avoid console uart idling during bootup
      ARM: OMAP2+: UART: Avoid uart idling on suspend for no_console_suspend usecase
      ARM: OMAP2+: UART: Do not gate uart clocks if used for debug_prints
      ARM: OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
      ARM: OMAP2+: UART: Fix compilation/sparse warnings

Jon Hunter (1):
      ARM: OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |   68 +--
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |   68 +--
 arch/arm/mach-omap2/cpuidle34xx.c             |    6 -
 arch/arm/mach-omap2/pm24xx.c                  |   20 -
 arch/arm/mach-omap2/pm34xx.c                  |   43 --
 arch/arm/mach-omap2/serial.c                  |  907 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   37 +-
 arch/arm/plat-omap/include/plat/serial.h      |   10 +-
 drivers/tty/serial/omap-serial.c              |  350 +++++++++--
 11 files changed, 588 insertions(+), 1027 deletions(-)
