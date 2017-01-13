From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] tty: serial: 8250_omap: Enable DMA support
Date: Fri, 13 Jan 2017 13:31:58 +0530
Message-ID: <20170113080201.6515-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series re enables DMA support for UART 8250_omap driver.

Tested on AM335x, AM437x that use EDMA and OMAP5 and DRA74 EVM with
SDMA.

Vignesh R (3):
  serial :8250: omap: pause DMA only if DMA transfer in progress
  tty: serial: 8250_omap: Add OMAP_DMA_TX_KICK quirk for AM437x
  tty: serial: 8250_omap: Remove rx_dma_broken flag

 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

-- 
2.11.0
