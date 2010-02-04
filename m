From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Thu, 4 Feb 2010 21:15:23 +0530 (IST)
Message-ID: <40204.192.168.10.88.1265298323.squirrel@dbdmail.itg.ti.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
    <20100128032242.GA9070@lixom.net>
    <50326.192.168.10.89.1265296150.squirrel@dbdmail.itg.ti.com>
    <20100204152847.GA711@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39198 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab0BDPp0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 10:45:26 -0500
In-Reply-To: <20100204152847.GA711@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Olof,

> Hi,
>
> Shortening the email a bit and only including the pieces that still have open questions:
>
>
> On Thu, Feb 04, 2010 at 08:39:10PM +0530, Govindraj.R wrote:
>> >> +#define OMAP_SERIAL_NAME ? ? "ttyO"
>> >> +#define OMAP_SERIAL_MAJOR ? ?204
>> >> +#define OMAP_SERIAL_MINOR ? ?64
>> >
>> > Where did these numbers come from? 204/64 are listed as in use in
>> > Documentation/devices.txt. 213 is the first available minor there. (You
>> > should also update that file).
>> >
>>
>> I was referring to some custom uart soc driver files.
>> Most of them seemed to use in an similar fashion,
>>
>> References:
>> drivers/serial/samsung.c
>> drivers/serial/timbuart.c
>> drivers/serial/uartlite.c
>>
>> And many more which co-exist with 8250 driver.
>> Use in an similar way.
>
> Yes, the way you do it is fine, but you need to select a different minor
> number. You just copied the one that the samsung driver uses, you have
> to select the next available one and update the documentation file I
> named above.
>

Will update the minor number with the one avialable.


>> >> + * @baud: baudrate for which divisor needs to be calculated.
>> >> + *
>> >> + * We have written our own function to get the divisor so as to support
>> >> + * 13x mode.
>> >> + */
>> >
>> > Again, the why, not the how. Why do you need the 13x divisor? What's
>> > magic about 3Mbaud?
>> >
>>
>> Refering to TRM UART chapter 17:
>>
>> Table 17-1. UART Mode Baud Rates, Divisor Values, and Error Rates
>>
>> referring to oversampling - divisor value
>>
>> baudrate 460,800 to 3,686,400 all have divisor 13
>>
>> except 3,000,000 which has divisor value 16
>>
>> thus we are checking if baud != 3000000
>
> Ok. It's always useful to have just a bit of information in the driver
> so you don't have to search around the manual when trying to figure out
> why something was done.
>
> Maybe something simple: "3Mbaud is unique in that it requires a divisor
> of 13. See the TRM for full details".

ok. will add that comments.

>
>> >> + ? ? serial_out(up, UART_LCR, UART_LCR_DLAB);
>> >> + ? ? serial_out(up, UART_DLL, 0);
>> >> + ? ? serial_out(up, UART_DLM, 0);
>> >> + ? ? serial_out(up, UART_LCR, 0);
>> >> +
>> >> + ? ? serial_out(up, UART_LCR, 0xbf);
>> >> +
>> >> + ? ? up->efr = serial_in(up, UART_EFR);
>> >> + ? ? serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
>> >> + ? ? serial_out(up, UART_LCR, 0x0); ? ? ? ? ?/* Access FCR */
>> >
>> > Access FCR by writing LCR? Please explain. Same goes for the ones below.
>>
>>
>> Most of these configuration come straight from TRM:
>>
>> 7.5 UART/IrDA/CIR Basic Programming Model
>
> I was mostly referring to the fact that the comment says FCR, but the code says LCR.
> Is it the same register with two names, or something else that's not quite correct?
>
>> >> + ? ? ? ? ? ? serial_out(up, UART_LCR, 0xbf); /* Access EFR */
>> >
>> > EFR or LCR?!
>>
>> writing 0xbf to LCR gives acces to EFR
>>
>> references : 17.5 UART/IrDA/CIR Basic Programming Model
>
> Ah. Care to update the comment to mention that? I guess the case above is similar.


Before accessing FCR we need to write 0x00 to LCR,

I will correct it as,

/**** Access to FCR requires writing Ox00 to LCR *****/


>
>> > Nearly every OMAP setup seems to prefer 115200 as default baudrate, right?
>>
>> Yes, but shouldn't we initialize to lowest possible baud?
>
> I don't see why that should be done. It's easiest if it's initialized
> to the most commonly used speed, that way people can drop the annoying
> ",115200" from the console bootarg string.
>
>> >> +static
>> >> +int serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
>> >
>> > No linewrap (checkpatch should have caught this)
>>
>> I use checkpatch --strict,
>> don't know how this passed
>
>
> Yeah, seems like it doesn't check for it. :-) No big deal but since I was already
> commenting on other things in the patch I mentioned it.
>
>> >> + ? ? ? ? ? ? ? ? ? ? up->uart_dma.tx_buf_dma_phys + UART_XMIT_SIZE)
>> >> + ? ? ? ? ? ? up->uart_dma.tx_buf_size =
>> >> + ? ? ? ? ? ? ? ? ? ? (up->uart_dma.tx_buf_dma_phys + UART_XMIT_SIZE) - start;
>> >> + ? ? omap_set_dma_dest_params(up->uart_dma.tx_dma_channel, 0,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_AMODE_CONSTANT,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->uart_dma.uart_base, 0, 0);
>> >> + ? ? omap_set_dma_src_params(up->uart_dma.tx_dma_channel, 0,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_AMODE_POST_INC, start, 0, 0);
>> >> + ? ? omap_set_dma_transfer_params(up->uart_dma.tx_dma_channel,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_DATA_TYPE_S8,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->uart_dma.tx_buf_size, 1,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DMA_SYNC_ELEMENT,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? up->uart_dma.uart_dma_tx, 0);
>> >
>> >
>> > Isn't there a dma_sync call missing somewhere around here? Same for
>> > the similar RX setup (both before DMA is started, as well as once it is
>> > completed on the RX side).
>>
>> Sorry i didn't get you here as don't see any such dma_sync call
>> in arch/arm/plat-omap/dma.c.
>
> It's not part of the OMAP dma driver, but instead it's part of the
> DMA mapping API.  You have to make sure that the buffers (as well as
> descriptors) that the DMA engine are going to access will be written to
> the level of coherency (i.e. memory) before the operation begins (for
> dma-from-memory), and you have to make sure any caches are invalidated
> after the operation completes and you wish to read the resulting data
> (for dma-to-memory).
>

Could you refer me to any omap driver that currently use dma_sync?

>
> -Olof
>



-- 
Regards,
Govindraj.R


