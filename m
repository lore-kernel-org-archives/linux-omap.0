From: Vignesh R <vigneshr@ti.com>
Subject: Re: 8250: Possible race between console message vs DMA?
Date: Tue, 18 Apr 2017 11:49:21 +0530
Message-ID: <e51ee374-cbf1-676d-bf82-e5779f467473@ti.com>
References: <7c75614c-71cb-0a4e-222c-713f65a89f23@ti.com>
 <CAHp75Vfc6FznNByidzjRcgsj14=DLtwqb=wtut4Cb4gj5UO42w@mail.gmail.com>
 <69f52038-f0e6-6f56-4f0b-842021152e2c@ti.com>
 <CAHp75VcCTgMrowhbRd_+B5=2o0utHKt=r=+zCb-NJ1_XVZ=uWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcCTgMrowhbRd_+B5=2o0utHKt=r=+zCb-NJ1_XVZ=uWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Tuesday 18 April 2017 11:46 AM, Andy Shevchenko wrote:
> On Mon, Apr 10, 2017 at 11:16 AM, Vignesh R <vigneshr@ti.com> wrote:
>> On Sunday 09 April 2017 04:37 PM, Andy Shevchenko wrote:
>>> On Fri, Apr 7, 2017 at 2:08 PM, Vignesh R <vigneshr@ti.com> wrote:
>>>> Hi All,
>>>>
>>>> I seem to be hitting a race condition using 8250_dma (and 8250_omap
>>>> specific dma) support:
>>>>
>>>> Kernel writes log messages to console via
>>>> serial8250_console_write()->serial8250_console_putchar() which directly
>>>> accesses UART_TX register with port->lock acquired.
>>>>
>>>> Now, if the same UART instance is being used by systemd/userspace,
>>>> characters are written to UART_TX register by serial8250_tx_chars(). The
>>>> concurrent access by serial8250_console_write() and
>>>> serial8250_tx_chars() is serialized by the use of port->lock spinlock
>>>> and hence there is no issue with` non DMA case.
>>>>
>>>> But when using DMA with 8250 UART, I see that port->lock is held before
>>>> scheduling of DMA TX transfer and released as soon as the transfer is
>>>> submitted. The lock is not held until the transfer actually completes
>>>> See,
>>>> uart_start()
>>>>   ->serial8250_start_tx()->
>>>>      __start_tx()
>>>>        ->up->dma->tx_dma(up)
>>>> Or
>>>> __dma_tx_complete() in 8250_dma.c that acquires and releases port->lock
>>>> once TX DMA transfer is submitted in serial8250_tx_dma()
>>>>
>>>> So, when the port->lock is released, it is quite possible that DMA is
>>>> still transferring data to UART TX FIFO and UART FIFO might be almost full.
>>>> I see that when DMA is writing to UART TX FIFO,
>>>> serial8250_console_write() may also write kernel log messages to UART TX
>>>> FIFO(as port->lock is now free to be acquired), which is leading to
>>>> overflow and lose of data. serial8250_console_write() checks for
>>>> UART_LSR_THRE to check if Transmit hold register is empty but that may
>>>> not be enough as DMA might put data before CPU write.
>>>>
>>>> It seems that both DMA and CPU might simultaneously put data to UART
>>>> FIFO and lead to potential loss of data.
>>>> Is the expectation that UART instance used to print kernel log messages
>>>> is not intended to use DMA? Or am I missing something?
>>>>
>>>>
>>>> Any help appreciated!
>>>
>>> I have one patch in my tree for a long time already:
>>> https://bitbucket.org/andy-shev/linux/commits/9f86c648e53bd25b8ec374933764577b2a340468?at=topic/uart/rpm
>>
>> I had similar patch in mind. Do you plan to submit above patch to the
>> mailing list? You may also consider to add the issue I mentioned above
>> to the commit description. Thanks!
> 
> Yes, I'm planning to do so, but be aware that OMAP has its own DMA
> glue layer and thus my patch doesn't affect it.
> 

Yes, I am working on a patch for 8250_omap driver. Thanks!

-- 
Regards
Vignesh
