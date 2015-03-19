From: Greg Knight <g.knight-+7FPL3kuI1+B+jHODAdFcQ@public.gmane.org>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Thu, 19 Mar 2015 13:28:00 -0400
Message-ID: <1426786080.13824.23.camel@symus-gk-mint>
References: <1426741501.10003.6.camel@midgaarde>	<550AC256.4070509@ti.com>
	 <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>
	 <550AF7F6.7080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <550AF7F6.7080200-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> I think the best thing we could do is to calculate the DMA_MIN_BYTES
in the
> driver based on the SPI speed. Something which will give ~160 in the
speed in
> which the wl driver is used and something which works best in your
setup in
> the speed you are using the SPI bus.
> The best way is to give some msec as a limit. If the transfer would
take more
> then X msec on the bus to be transferred, we will use DMA, if it is
less than
> that we fall back to PIO.
> Yes, the CPU speed is not taken into account, but IMHO the bus speed
is more
> 

Changing DMA_MIN_BYTES to, say, "dma_min_time_ms" sounds reasonable to
me. I don't know how to compute it completely accurately as some SPI
implementations I've seen seem to like to inject little delays between
bytes for some reason, but a reasonable enough estimate should just be
spi_transfer_time_ms = (bits * 1000) / spi_clock_speed.

I would like to have the ability to configure it without a kernel
recompile, though. Would a kernel param (module_param) be acceptable for
this application?

You don't happen to know the WL12xx SPI clock speed off the top of your
head, do you?

Regards,
Greg

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
