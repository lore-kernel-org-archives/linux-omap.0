From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH 1/4] TSC2102 main SPI driver
Date: Sat, 19 Aug 2006 01:59:50 +0200
Message-ID: <fb249edb0608181659l1758287t98a39e332893ea28@mail.gmail.com>
References: <fb249edb0608180301u113ae66fg7be0b7a001c1cc46@mail.gmail.com>
	<20060818132753.31468.qmail@web37908.mail.mud.yahoo.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060818132753.31468.qmail@web37908.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 18/08/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> --- andrzej zaborowski <balrog@zabor.org> wrote:
>
> > This adds a driver for the TSC2102 chip by Texas Instruments. This
> > driver is responsible for all communication with the chip and doesn't
> > export anything for user-space, but for other drivers controlling
> > devices connected to the chip.
> >
>
> Quick review comments, will come later with more detailed review.

Many thanks for looking at the code, I wouldn't notice all the issues.

I'm going to send a corrected code next week when I'm online.

>
> +       spi->transfer = kzalloc(sizeof(struct spi_transfer) * numregs,
> +                       GFP_KERNEL);
>
> How about checking return value here?

Ok. I'm going to allocate only a single big buffer to avoid creating a
five error paths.

>
> +       set_irq_type(spi->irq, IRQT_FALLING);
> +       if (request_irq(spi->irq, tsc2102_handler,
> +                               SA_SAMPLE_RANDOM, "tsc2102", &tsc)) {
> +               printk(KERN_ERR "Could not allocate touchscreen IRQ!\n");
> +               err = -EINVAL;
> +               goto err_clk;
> +       }
>
> You should use new flags as per genirq patches, and I think
> set_irq_type may not be required.

Ah, right. I changed it to this, and dumped set_irq_type():
        if (request_irq(spi->irq, tsc2102_handler, SA_SAMPLE_RANDOM |
                                SA_TRIGGER_FALLING, "tsc2102", &tsc)) {

>
> +#define TSC2102_TS_X                   0, 0x00
> +#define TSC2102_TS_Y                   0, 0x01
>
> I think better/clean way could be, having defines taking page and addr
> as argument. e.g
>
> #define tsc2102_reg(page, addr) /* your code here as per pg and addr
> needs to be shifted and ORed as needed*/
> #define tsc2102_ts_x       tsc2102_reg(0, 0x0)
>
> and may be conversion macros from reg_to_page and page_to_reg as
> required.

Here I was trying to maintain api similar to that in omap-tsc2101.c
with page and offset as separate parameters but I see now that it
prevents an optimisation.

>
>
> ---Komal Shah
> http://komalshah.blogspot.com/
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>

I will appreciate further comments.

Do you know where I can find out what functions are "must check"?

Regards,
Andrzej
-- 
balrog 2oo6
