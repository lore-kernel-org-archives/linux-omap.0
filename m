From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Tue, 10 Feb 2015 13:04:23 +0100
Message-ID: <54D9F3C7.5000809@freebox.fr>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-4-git-send-email-bigeasy@linutronix.de> <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D9441B.7070403@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org
Cc: tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/10/2015 12:34 AM, Peter Hurley wrote:
> Hi Nicolas,
> 
> Thanks for the report.
> 
[...]
>> When a caracter is received on the UART while the kernel is printing
>> the boot messages, as soon as the kernel configures the UART for
>> receiving (after root filesystem mount), it gets stuck printing the
>> following message repeatedly:
>>
>> serial8250: too much work for irq29
>>
>> Once stuck, the reception of another character allows the boot process
>> to finish.
>>
>> From what I can gather, when we hit that, the UART_IIR_NO_INT is 0 (so the
>> interrupt is raised), but the UART_LSR_DR bit is 0 as well so the UART_RX
>> register is never read to clear the interrupt.
> 
> The "too much work" message means serial8250_handle_irq() is returning 0,
> ie., not handled. Which in turn means IIR indicates no interrupt is pending
> (UART_IIR_NO_INT == 1).
> 
> Can you log the register values for LSR and IIR at both patch locations
> in serial8250_do_startup()?
> 
> (I can get you a debug patch, if necessary. Let me know)

Hi Peter,

Thanks for your reply.

Here is what I have when the issue is triggered:

[   12.154877] lsr 0x60 / iir 0x01
[   12.158071] lsr 0x60 / iir 0x01
[   12.161438] serial8250: too much work for irq29
[   12.165982] lsr 0x60 / iir 0x0c
[   12.169354] serial8250: too much work for irq29
[   12.173900] lsr 0x60 / iir 0x0c
(previous two messages are repeated and printk_ratelimited())

When the issue is not triggered:

[   10.784871] lsr 0x60 / iir 0x01
[   10.788066] lsr 0x60 / iir 0x01
[   10.794734] VFS: Mounted root (nfs filesystem) readonly on device 0:13.
[   10.801654] devtmpfs: mounted
[   10.805169] Freeing unused kernel memory: 184K (807be000 - 807ec000)
(userland takes over after that)

I have also displayed the IIR and LSR registers when the "too much fork for
IRQ" condition is triggered.

In the serial8250_do_startup(), before the interrupt are unmasked at the end,
the IIR looks sane and UART_IIR_NO_INT bit is set. When stuck
serial8250_interrupt(), UART_IIR_NO_INT is cleared and the interrupt ID is set
to 0xc which is not handled by the kernel at this time (the Kirkwood datasheet
 indicates that it is some kind of timeout condition from what I can gather).

Here is the corresponding debug patch, for reference (against a 3.19 kernel
this time):

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_
index 11c6685..ed93741 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1661,6 +1661,12 @@ static int exar_handle_irq(struct uart_port *port)
        return ret;
 }

+static inline void show_lsr_iir(struct uart_port *port)
+{
+       printk("lsr 0x%02x / iir 0x%02x\n", serial_port_in(port, UART_LSR),
+              serial_port_in(port, UART_IIR));
+}
+
 /*
  * This is the serial driver's interrupt routine.
  *
@@ -1705,6 +1711,8 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev
                        /* If we hit this, we're dead. */
                        printk_ratelimited(KERN_ERR
                                "serial8250: too much work for irq%d\n", irq);
+                       if (printk_ratelimit())
+                               show_lsr_iir(port);
                        break;
                }
        } while (l != end);
@@ -2107,6 +2115,7 @@ int serial8250_do_startup(struct uart_port *port)
        /*
         * Clear the interrupt registers.
         */
+       show_lsr_iir(port);
        if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
                serial_port_in(port, UART_RX);
        serial_port_in(port, UART_IIR);
@@ -2269,6 +2278,7 @@ dont_test_tx_en:
         * saved flags to avoid getting false values from polling
         * routines or the previous session.
         */
+       show_lsr_iir(port);
        if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
                serial_port_in(port, UART_RX);
        serial_port_in(port, UART_IIR);

Regards,

-- 
Nicolas Schichan
Freebox SAS
