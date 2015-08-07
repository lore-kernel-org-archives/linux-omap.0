From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: omap-dma + 8250_omap: fix the dmaengine_pause()
Date: Fri,  7 Aug 2015 22:00:16 +0200
Message-ID: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, peter@hurleysoftware.com
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

#1 is something that can go stable and disables RX-DMA should it
   notice that it does not work.
#2 adds the anotation as suggest by Russell.
#3 adds the missing feature to omap-dma so dmaengine_pause() works. Once
   this is merged, the warning from #1 disappears.
