From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Mon, 09 Feb 2015 14:34:42 +0100
Message-ID: <54D8B772.1010405@freebox.fr>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410377411-26656-4-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org
Cc: tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/10/2014 09:29 PM, Sebastian Andrzej Siewior wrote:
> The serial8250_do_startup() function unconditionally clears the
> interrupts and for that it reads from the RX-FIFO without checking if
> there is a byte in the FIFO or not. This works fine on OMAP4+ HW like
> AM335x or DRA7.
> OMAP3630 ES1.1 (which means probably all OMAP3 and earlier) does not like
> this:

Hello,

Sorry to wake up an old thread, but I'm affraid that this patch causes
problems on Marvell 88f6282 (Kirkwood).

When a caracter is received on the UART while the kernel is printing
the boot messages, as soon as the kernel configures the UART for
receiving (after root filesystem mount), it gets stuck printing the
following message repeatedly:

serial8250: too much work for irq29

Once stuck, the reception of another character allows the boot process
to finish.

>From what I can gather, when we hit that, the UART_IIR_NO_INT is 0 (so the
interrupt is raised), but the UART_LSR_DR bit is 0 as well so the UART_RX
register is never read to clear the interrupt.

We are using the second UART multiplexed on mpps 15 and 16.

Reverting this particular patch fixes the issue.

We are seing the problem on a 3.18 kernel.

Regards,

-- 
Nicolas Schichan
Freebox SAS
