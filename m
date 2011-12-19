From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap uart runtime PM support for v3.2 merge window
Date: Mon, 19 Dec 2011 12:10:18 -0800
Message-ID: <20111219201018.GT6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20302 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752930Ab1LSUKX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 15:10:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap uart changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap uart

These allow us to remove quite a bit of serial port code
from arch/arm/*omap* as the omap-serial.c driver can now do
the necessary things using runtime PM :) Also this series
changes omap board-generic.c to use DT for the serial port.

The changes to drivers/tty/serial/omap-serial.c have been
agreed to be merged via omap patches in the following thread:

http://www.spinics.net/lists/linux-serial/msg05145.html

Regards,

Tony


The following changes since commit 9d297f5ee1b92a84e2cd6c547c3ac1f893128359:
  Tony Lindgren (1):
        Merge branch 'tk_prm_chain_handler_devel_3.3' of git://git.pwsan.com/linux-2.6 into prcm

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap uart

Afzal Mohammed (2):
      ARM: OMAP: am33xx: Update common omap platform files
      ARM: OMAP: am33xx: Update common OMAP machine specific sources

David Anders (1):
      ARM: OMAP: id: add chip id recognition for omap4430 es2.3

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

Hemant Pedanekar (2):
      ARM: OMAP: TI81XX: Prepare for addition of TI814X support
      ARM: OMAP: TI814X: Add cpu type macros and detection support

Jon Hunter (1):
      ARM: OMAP2+: UART: Make the RX_TIMEOUT for DMA configurable for each UART

Leonid Iziumtsev (1):
      ARM: OMAP: ID: Chip detection for OMAP4470

Rajendra Nayak (4):
      omap-serial: Get rid of all pdev->id usage
      omap-serial: Use default clock speed (48Mhz) if not specified
      omap-serial: Add minimal device tree support
      ARM: omap: pass minimal SoC/board data for UART from dt

Tony Lindgren (2):
      Merge branch 'for_3.3/uart/runtime-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into uart
      arm/dts: Add minimal device tree support for omap2420 and omap2430

 .../devicetree/bindings/serial/omap_serial.txt     |   10 +
 arch/arm/boot/dts/omap2.dtsi                       |   67 ++
 arch/arm/boot/dts/omap3.dtsi                       |   31 +
 arch/arm/boot/dts/omap4.dtsi                       |   28 +
 arch/arm/mach-omap2/Kconfig                        |   11 +-
 arch/arm/mach-omap2/board-3430sdp.c                |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c                |   68 +--
 arch/arm/mach-omap2/board-generic.c                |    1 -
 arch/arm/mach-omap2/board-n8x0.c                   |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c             |   68 +--
 arch/arm/mach-omap2/board-ti8168evm.c              |   11 +-
 arch/arm/mach-omap2/clock.c                        |    2 +-
 arch/arm/mach-omap2/clock.h                        |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |    6 +-
 arch/arm/mach-omap2/common.c                       |   48 +-
 arch/arm/mach-omap2/common.h                       |   23 +-
 arch/arm/mach-omap2/control.h                      |    8 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    6 -
 arch/arm/mach-omap2/id.c                           |   52 +-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   12 +-
 arch/arm/mach-omap2/io.c                           |   38 +-
 arch/arm/mach-omap2/irq.c                          |    2 +-
 arch/arm/mach-omap2/opp2xxx.h                      |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |   20 -
 arch/arm/mach-omap2/pm34xx.c                       |   43 -
 arch/arm/mach-omap2/serial.c                       |  907 ++++++--------------
 arch/arm/plat-omap/Makefile                        |    1 -
 .../plat-omap/include/plat/{ti816x.h => am33xx.h}  |   20 +-
 arch/arm/plat-omap/include/plat/clock.h            |    4 +-
 arch/arm/plat-omap/include/plat/cpu.h              |   56 ++
 arch/arm/plat-omap/include/plat/hardware.h         |    3 +-
 arch/arm/plat-omap/include/plat/io.h               |   12 +
 arch/arm/plat-omap/include/plat/omap-serial.h      |   37 +-
 arch/arm/plat-omap/include/plat/omap34xx.h         |    2 +
 arch/arm/plat-omap/include/plat/serial.h           |   24 +-
 .../plat-omap/include/plat/{ti816x.h => ti81xx.h}  |   18 +-
 arch/arm/plat-omap/include/plat/uncompress.h       |    8 +-
 drivers/tty/serial/omap-serial.c                   |  428 ++++++++--
 38 files changed, 1050 insertions(+), 1135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt
 create mode 100644 arch/arm/boot/dts/omap2.dtsi
 copy arch/arm/plat-omap/include/plat/{ti816x.h => am33xx.h} (53%)
 rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)
