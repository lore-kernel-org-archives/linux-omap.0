From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Fri, 20 Mar 2015 14:58:33 +0200
Message-ID: <550C1979.5030208@ti.com>
References: <1426741501.10003.6.camel@midgaarde>	<550AC256.4070509@ti.com>	 <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>	 <550AF7F6.7080200@ti.com> <1426786080.13824.23.camel@symus-gk-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426786080.13824.23.camel@symus-gk-mint>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Knight <g.knight-+7FPL3kuI1+B+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/19/2015 07:28 PM, Greg Knight wrote:
> Changing DMA_MIN_BYTES to, say, "dma_min_time_ms" sounds reasonable t=
o
> me. I don't know how to compute it completely accurately as some SPI
> implementations I've seen seem to like to inject little delays betwee=
n
> bytes for some reason, but a reasonable enough estimate should just b=
e
> spi_transfer_time_ms =3D (bits * 1000) / spi_clock_speed.
>=20
> I would like to have the ability to configure it without a kernel
> recompile, though. Would a kernel param (module_param) be acceptable =
for
> this application?

Or sysfs interface as Mark suggested? But module_param should work as w=
ell.

> You don't happen to know the WL12xx SPI clock speed off the top of yo=
ur
> head, do you?

In case of n900 it is 48000000 (board-rx51-peripherals.c). It is using =
32bit
words over SPI.

Based on this and your experience I guess it is possible to come up wit=
h a
formula which satisfy both.

> Regards,
> Greg
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
