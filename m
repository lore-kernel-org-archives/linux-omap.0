From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP block
Date: Sat, 21 Jan 2012 00:27:37 -0700
Message-ID: <20120121071934.18707.64258.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Govindraj Raja <govindraj.r@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

[ This series is targeted for merging during v3.3-rc ]

On v3.3-rc1, the OMAP serial console doesn't behave properly when
power management is enabled (the default with omap2plus_defconfig).
This seems to be due to a combination of a silicon bug in the UART IP
block and broken FIFO settings in the OMAP serial driver.

This patch series attempts to work around these problems.  The workarounds
are not perfect; see the patch descriptions for more details.

Tested on OMAP3530 BeagleBoard.  This series will need to be tested on
OMAP2 and OMAP4 before it is ready to merge.

- Paul

---

Paul Walmsley (2):
      tty: serial: OMAP: ensure FIFO levels are set correctly in non-DMA mode
      tty: serial: OMAP: transmit FIFO threshold interrupts don't wake the chip


 arch/arm/plat-omap/include/plat/omap-serial.h |    1 
 drivers/tty/serial/omap-serial.c              |   86 ++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 5 deletions(-)

