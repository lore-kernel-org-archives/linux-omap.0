From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Thu, 19 Mar 2015 18:23:18 +0200
Message-ID: <550AF7F6.7080200@ti.com>
References: <1426741501.10003.6.camel@midgaarde>	<550AC256.4070509@ti.com> <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Knight <g.knight-+7FPL3kuI1+B+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/19/2015 03:16 PM, Greg Knight wrote:
> Will refer to that documentation and update the SPI docs before resub=
mitting.
>=20
> Re; Threshold of 160 is artificial: Believe me, I am more than aware
> of this. SPI runs in any speed from low kHz to multi MHz. The only
> reason I can fathom for having such a high DMA_MIN_BYTES is to
> facilitate high-speed low-volume communication (eg read one byte at a
> time from userspace without buffering.) The reason I'm looking at thi=
s
> at all is because we're doing low-speed low-volume communication, for
> which the burn in PIO mode causes severe performance degradation.
> Internally we'd changed it to 20, but I might try 8. I originally
> tried 0, but observed poor behavior for our use cases. DMA_MIN_BYTES
> at 8 would be sensible for our application, but at 160 it is not.
>=20
> How about moving the speed to the spidev DT nodes?

The issue is that: "The device tree is a data structure for describing =
hardware"
DMA_MIN_BYTES is a software parameter. To be specific, it is Linux soft=
ware
parameter applicable only to spi-omap2-mcspi.c driver.

I think the best thing we could do is to calculate the DMA_MIN_BYTES in=
 the
driver based on the SPI speed. Something which will give ~160 in the sp=
eed in
which the wl driver is used and something which works best in your setu=
p in
the speed you are using the SPI bus.
The best way is to give some msec as a limit. If the transfer would tak=
e more
then X msec on the bus to be transferred, we will use DMA, if it is les=
s than
that we fall back to PIO.
Yes, the CPU speed is not taken into account, but IMHO the bus speed is=
 more
important.

What do you think? Will this work for you?

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
