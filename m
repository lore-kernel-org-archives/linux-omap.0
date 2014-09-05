From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Fri,  5 Sep 2014 21:02:35 +0200
Message-ID: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

This is my complete queue fo the omap serial driver based on the 8250 core
code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
The runtime-pm pieces look now bug-compatible with the omap-serial driver.
Besides the runtime-om improvement I also fixed a few corner cases for the
TX-DMA problem. The DMA fixes (in edma and omap-dma) were dropped and the
problem has been in 8250-dma via patch #13.

The whole queue is available at
  git://git.breakpoint.cc/bigeasy/linux.git uart_v8

Sebastian
