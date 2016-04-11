From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: fix dma transfer for vmalloced buffer
Date: Tue, 12 Apr 2016 01:31:22 +0900
Message-ID: <CAC5umyiPBORDqEZxa-kbwJ97xWetuEVETSwh5=e92OWfGkEAZA@mail.gmail.com>
References: <1458576021-4373-1-git-send-email-akinobu.mita@gmail.com>
	<CAC5umyj0zbwqt0Tmbubh0=URYvrvtWLO0q1ym1F2c7a84vRHjg@mail.gmail.com>
	<20160407175748.GY1924@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160407175748.GY1924-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

2016-04-08 2:57 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Apr 07, 2016 at 09:17:29PM +0900, Akinobu Mita wrote:
>> 2016-03-22 1:00 GMT+09:00 Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
>> >                 if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
>> >                         dma_count -= es;
>
>> The actual transfer length can be smaller than xfer->len by above line.
>> And the last word is filled after dma transfer completion.
>
>> So this patch is broken.  Could you revert remove this from your
>> development tree?
>> I don't find a way how to fix it without copy and pasting a lot of
>> line from spi core.
>
> Can you please send a patch doing the revert and explaining why we can't
> do this in the changelog?  That might help someone else looking at this
> to figure it out in future, or at least stop them trying the same thing
> and running into problems.

I'm going to come up with a fix that detects xfer->len != dma_count
and remap rx_sg in omap2_mcspi_rx_dma().  But I plan to spend
enough time tesing it, so feel free to apply revert that I sent a while ago.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
