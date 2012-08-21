From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 00/13] OMAP UART patches
Date: Tue, 21 Aug 2012 12:15:42 +0300
Message-ID: <1345540555-24359-1-git-send-email-balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alan@linux.intel.com
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi guys,

here's a series of cleanup patches to the OMAP serial
driver. A later series could be made re-implementing
DMA using the DMA Engine API. Note that for RX DMA
we could be using RX Timeout IRQ as a hint that we better
use PIO instead ;-)

All patches were tested on my pandaboard, but I'd really
like to receive Tested-by on other platforms.

After this goes in, I'll probably try to get UART wakeup
working again and only after that look at DMA.

cheers

Felipe Balbi (13):
  serial: omap: define and use to_uart_omap_port()
  serial: omap: always return IRQ_HANDLED
  serial: omap: define helpers for pdata function pointers
  serial: omap: don't access the platform_device
  serial: omap: drop DMA support
  serial: add OMAP-specific defines
  serial: omap: simplify IRQ handling
  serial: omap: refactor receive_chars() into rdi/rlsi handlers
  serial: omap: move THRE check to transmit_chars()
  serial: omap: stick to put_autosuspend
  serial: omap: set dev->drvdata before enabling pm_runtime
  serial: omap: drop unnecessary check from remove
  serial: omap: make sure to suspend device before remove

 arch/arm/mach-omap2/serial.c                  |  15 +-
 arch/arm/plat-omap/include/plat/omap-serial.h |  12 +-
 drivers/tty/serial/omap-serial.c              | 707 +++++++++-----------------
 include/linux/serial_reg.h                    |   4 +
 4 files changed, 250 insertions(+), 488 deletions(-)

-- 
1.7.12.rc3
