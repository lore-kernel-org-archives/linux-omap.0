From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Tue, 10 Feb 2015 10:32:17 +0100
Message-ID: <54D9D021.6000409@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-4-git-send-email-bigeasy@linutronix.de> <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D9441B.7070403@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Nicolas Schichan <nschichan@freebox.fr>, linux-serial@vger.kernel.org
Cc: tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/10/2015 12:34 AM, Peter Hurley wrote:
> The "too much work" message means serial8250_handle_irq() is returning 0,
> ie., not handled. Which in turn means IIR indicates no interrupt is pending
> (UART_IIR_NO_INT == 1).

The OMAP UART for instance have two possible TX-IRQ handling. The
default is to fire the interrupt once there is room for at least one
byte in the FIFO. I set the OMAP_UART_SCR_TX_EMPTY bit to get the same
behavior as the 8250 driver expects (interrupt while the FIFO is empty).
Without this bit set I've seen the message from time to time.

Sebastian
