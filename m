From: Vignesh R <vigneshr@ti.com>
Subject: 8250: Possible race between console message vs DMA?
Date: Fri, 7 Apr 2017 16:38:54 +0530
Message-ID: <7c75614c-71cb-0a4e-222c-713f65a89f23@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi All,

I seem to be hitting a race condition using 8250_dma (and 8250_omap
specific dma) support:

Kernel writes log messages to console via
serial8250_console_write()->serial8250_console_putchar() which directly
accesses UART_TX register with port->lock acquired.

Now, if the same UART instance is being used by systemd/userspace,
characters are written to UART_TX register by serial8250_tx_chars(). The
concurrent access by serial8250_console_write() and
serial8250_tx_chars() is serialized by the use of port->lock spinlock
and hence there is no issue with` non DMA case.

But when using DMA with 8250 UART, I see that port->lock is held before
scheduling of DMA TX transfer and released as soon as the transfer is
submitted. The lock is not held until the transfer actually completes
See,
uart_start()
  ->serial8250_start_tx()->
     __start_tx()
       ->up->dma->tx_dma(up)
Or
__dma_tx_complete() in 8250_dma.c that acquires and releases port->lock
once TX DMA transfer is submitted in serial8250_tx_dma()

So, when the port->lock is released, it is quite possible that DMA is
still transferring data to UART TX FIFO and UART FIFO might be almost full.
I see that when DMA is writing to UART TX FIFO,
serial8250_console_write() may also write kernel log messages to UART TX
FIFO(as port->lock is now free to be acquired), which is leading to
overflow and lose of data. serial8250_console_write() checks for
UART_LSR_THRE to check if Transmit hold register is empty but that may
not be enough as DMA might put data before CPU write.

It seems that both DMA and CPU might simultaneously put data to UART
FIFO and lead to potential loss of data.
Is the expectation that UART instance used to print kernel log messages
is not intended to use DMA? Or am I missing something?


Any help appreciated!

-- 
Regards
Vignesh
