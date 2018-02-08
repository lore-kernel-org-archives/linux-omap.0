From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] serial: 8250: Don't service RX FIFO if interrupts are
 disabled
Date: Thu, 8 Feb 2018 22:45:59 +0530
Message-ID: <e50c8af2-0d9f-b589-29c8-e903576d8b70@ti.com>
References: <20180208125542.15649-1-vigneshr@ti.com>
 <20180208125542.15649-2-vigneshr@ti.com>
 <CAHp75Vdo+B=Z+ScUgYvoWMSP7G6iC=LOiW57dViXCXm=g2gOLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdo+B=Z+ScUgYvoWMSP7G6iC=LOiW57dViXCXm=g2gOLw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 08-Feb-18 8:46 PM, Andy Shevchenko wrote:
> On Thu, Feb 8, 2018 at 2:55 PM, Vignesh R <vigneshr@ti.com> wrote:
>> Currently, data in RX FIFO is read based on UART_LSR register state even
>> if RDI and RLSI interrupts are disabled in UART_IER register.
>> This is because when IRQ handler is called due to TX FIFO empty event,
>> RX FIFO is serviced based on UART_LSR register status instead of
>> UART_IIR status. This defeats the purpose of disabling UART RX
>> FIFO interrupts during throttling(see, omap_8250_throttle()) as IRQ
>> handler continues to drain UART RX FIFO resulting in overflow of buffer
>> at tty layer.
>> Fix this by making sure that driver drains UART RX FIFO only when
>> UART_IIR_RDI is set along with UART_LSR_BI or UART_LSR_DR bits.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
>> -       if (status & (UART_LSR_DR | UART_LSR_BI)) {
>> +       if (status & (UART_LSR_DR | UART_LSR_BI) &&
>> +           iir & UART_IIR_RDI) {
> 
>>                 if (!up->dma || handle_rx_dma(up, iir))
> 
> handle_rx_dma() checks for IRQ status as well.
> 
> But for now it seems we are on safe side since checks are done versus
> IRQ status with bit 2 set, meaning that iir & RDI will be true.
> 
>>                         status = serial8250_rx_chars(up, status);
>>         }
> 
> Anyway, thanks for the patch, though I need some time to test it on
> non-OMAP hardware with DMA enabled.

This patch is needed even when DMA is not enabled.
It would be great if you could test this. But, I don't see any other
8250 drivers apart from 8250_omap.c implementing
.throttle()/.unthrottle() callbacks.

Regards
Vignesh
