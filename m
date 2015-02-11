From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Wed, 11 Feb 2015 15:01:53 -0500
Message-ID: <54DBB531.2030504@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-4-git-send-email-bigeasy@linutronix.de> <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com> <54D9F3C7.5000809@freebox.fr> <54DA43F8.9090904@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54DA43F8.9090904@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Schichan <nschichan@freebox.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tony@atomide.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/10/2015 12:46 PM, Peter Hurley wrote:
> On 02/10/2015 07:04 AM, Nicolas Schichan wrote:
>> On 02/10/2015 12:34 AM, Peter Hurley wrote:
>>> Hi Nicolas,
>>>
>>> Thanks for the report.
>>>
>> [...]
>>>> When a caracter is received on the UART while the kernel is printing
>>>> the boot messages, as soon as the kernel configures the UART for
>>>> receiving (after root filesystem mount), it gets stuck printing the
>>>> following message repeatedly:
>>>>
>>>> serial8250: too much work for irq29
>>>>
>>>> Once stuck, the reception of another character allows the boot process
>>>> to finish.
>>>>
>>>> From what I can gather, when we hit that, the UART_IIR_NO_INT is 0 (so the
>>>> interrupt is raised), but the UART_LSR_DR bit is 0 as well so the UART_RX
>>>> register is never read to clear the interrupt.
>>>
>>> The "too much work" message means serial8250_handle_irq() is returning 0,
>>> ie., not handled. Which in turn means IIR indicates no interrupt is pending
>>> (UART_IIR_NO_INT == 1).
>>>
>>> Can you log the register values for LSR and IIR at both patch locations
>>> in serial8250_do_startup()?
>>>
>>> (I can get you a debug patch, if necessary. Let me know)
>>
>> Hi Peter,
>>
>> Thanks for your reply.
>>
>> Here is what I have when the issue is triggered:
>>
>> [   12.154877] lsr 0x60 / iir 0x01
>> [   12.158071] lsr 0x60 / iir 0x01
>> [   12.161438] serial8250: too much work for irq29
>> [   12.165982] lsr 0x60 / iir 0x0c
>> [   12.169354] serial8250: too much work for irq29
>> [   12.173900] lsr 0x60 / iir 0x0c
>> (previous two messages are repeated and printk_ratelimited())
> 
> Thanks for this information; I see I was wrong about the cause of message.
> 
> I think what happens during startup is that on this silicon clearing
> the rx fifo (by serial8250_clear_fifos()) clears data ready but not
> the rx timeout condition which causes a spurious rx interrupt when
> interrupts are enabled.
> 
> So caught between two broken UARTs: one that underflows its rx fifo because
> of unsolicited rx reads and the other that generates spurious interrupt
> without unsolicited rx reads.
> 
> 
>> When the issue is not triggered:
>>
>> [   10.784871] lsr 0x60 / iir 0x01
>> [   10.788066] lsr 0x60 / iir 0x01
>> [   10.794734] VFS: Mounted root (nfs filesystem) readonly on device 0:13.
>> [   10.801654] devtmpfs: mounted
>> [   10.805169] Freeing unused kernel memory: 184K (807be000 - 807ec000)
>> (userland takes over after that)
>>
>> I have also displayed the IIR and LSR registers when the "too much fork for
>> IRQ" condition is triggered.
>>
>> In the serial8250_do_startup(), before the interrupt are unmasked at the end,
>> the IIR looks sane and UART_IIR_NO_INT bit is set. When stuck
>> serial8250_interrupt(), UART_IIR_NO_INT is cleared and the interrupt ID is set
>> to 0xc which is not handled by the kernel at this time (the Kirkwood datasheet
>>  indicates that it is some kind of timeout condition from what I can gather).
> 
> Yes, IIR == UART_IIR_RX_TIMEOUT is to used indicate that data is in the rx fifo
> but has not reached the rx trigger level yet.
> 
> ATM, I'm not exactly sure if there is a safe way to clear the spurious interrupt
> from the interrupt handler.
> 
> I'm fairly certain the only way to clear the rx timeout interrupt is to read
> the rx fifo, but I think this would race with actual data arrival. IOW, there
> might not be a way to determine if the data read is spurious or not.

Yep, I see no safe way to clear the spurious interrupt [1] and no idea how to
keep it from happening (other than via the unsolicited RX reads in
serial8250_do_startup).

Unfortunately, I think this means we'll have to revert Sebastian's commit:

commit 0aa525d11859c1a4d5b78fdc704148e2ae03ae13
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Sep 10 21:29:58 2014 +0200

    tty: serial: 8250_core: read only RX if there is something in the FIFO
    
which just means OMAP3630 will be limited to using the omap_serial driver.

Regards,
Peter Hurley

[1]  To clear the RX timeout interrupt requires reading the rx fifo even though
LSR[data ready] indicates no data. However, this could result in dropped data
if the data became available just before clearing the RX timeout. For example,

 CPU                                 | Device
                                     |
 irq handler (simplified)            |
                                     |
   read IIR                          |
   is interrupt? yes                 |
   read LSR                          |
   is data ready? no                 |
   is IIR == Rx timeout? yes         | new data arrives
                                     | rx_fifo[0] = new data
                                     | lsr[data ready] = 1
   read RX and discard               |
                                     |
