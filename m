From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 0/7] UART: OMAP: Updates
Date: Mon, 16 Apr 2012 20:36:54 +0530
Message-ID: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch series collects few previously posted patches 
and adds some clock fixes to the series.

The patch series does following.
- Makes the context_loss_cnt signed to make error handling possible.
- The clock cutting is missed in the error cases, fix it.
- Make the serial_omap_console_ports depend on the macro
 OMAP_MAX_HSUART_PORTS.
- use devinit and devexit for the probe and remove functions.
- Fixes to the software flow control.

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git uart-omap-next

Shubhrajyoti D (6):
      ARM: OMAP: UART: Make context_loss_cnt signed
      UART: OMAP: Cut the clock in the error cases
      UART: OMAP: Remove the default setting of special character
      UART: OMAP: Prevent cutting of clocks if put_sync immediately follows
      UART: OMAP: Remove the hardcode serial_omap_console_ports array.
      UART: OMAP: Trivial optimisation of the probe and remove

Vikram Pandita (1):
      UART: OMAP: fix software flow control

 arch/arm/plat-omap/include/plat/omap-serial.h |    6 ++--
 drivers/tty/serial/omap-serial.c              |   47 ++++++++++++++-----------
 2 files changed, 29 insertions(+), 24 deletions(-)
