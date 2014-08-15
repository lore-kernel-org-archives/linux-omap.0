From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v7] 8250-core based serial driver for OMAP + DMA
Date: Fri, 15 Aug 2014 19:42:28 +0200
Message-ID: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is my complete queue fo the omap serial driver based on the 8250 core
code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
The uncertain remain the runtime-pm pieces.
I hacked a small serial testing application which sent 10x 4KiB of data in
raw mode. The number of interrupts in comparison:

    serial-omap | 8250 omap | 8250 omap + dma |
   --------------------------------------------
TX |       2558 |       641 |         0 +  30 |
RX |      40960 |       854 |         1 + 853 |

So the 8250 version uses less interrupts for the same amount of data.
The consequence is that in TX mode there should be "short" periods where
no data is sent (before the CPU gets to re-fill the FIFO). On RX we have
a smaller time frame where we have to start to purge the FIFO before it
overflows.

Sebastian
