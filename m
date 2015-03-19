From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Thu, 19 Mar 2015 14:34:30 +0200
Message-ID: <550AC256.4070509@ti.com>
References: <1426741501.10003.6.camel@midgaarde>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426741501.10003.6.camel@midgaarde>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Knight <g.knight-+7FPL3kuI1+B+jHODAdFcQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/19/2015 07:05 AM, Greg Knight wrote:
> Hi, Mark,
>=20
> I've attached a patch which adds a device-tree field "ti,dma-min-byte=
s"
> which replaces the macro DMA_MIN_BYTES. Adjusting this field addresse=
s
> issues we've had where, in our particular use case, the usleep() in t=
he
> SPI worker thread eats a full 20% of our CPU (AM3359).
>=20
> I opted to implement it as a device-tree parameter and keep the origi=
nal
> value (160) as the default, in order to avoid impacting anyone else.
>=20
> The patch is attached. Patches 1-2 are an unrelated McASP change (see=
 my
> other message).
>=20
> What is the process for getting this upstreamed?

Please follow the guidelines in Documentation/SubmittingPatches. Patche=
s as
attachments are not preferred since it makes replying/commenting on the
patches hard.

Strictly speaking the dma-min-bytes should not be in DT, it is a softwa=
re
parameter for the Linux SPI driver implementation.
Also, when changing DT bindings, please update the documentation as wel=
l (and
CC the relevant lists with that).

This threshold of 160 bytes in the omap2-mcspi driver is artificial any=
ways it
is changed from 8 to 160 by this commit:
8b66c13474e16 spi/omap2_mcspi: change default DMA_MIN_BYTES value to 16=
0

It has been changed because of wl1271, but I'm not sure if banging byte=
s over
the bus when the transfer is less then 160bytes is that great thing. I =
would
guess that the sweet spot is at around the low tens.

But if it is really like this that different devices perform better wit=
h
different threshold for choosing between PIO or DMA transfer then this =
setting
should come from the slave device and should only affect the transfer s=
etup
when communicating with that device.

Probably adding a parameter (optional) to spi_device struct, so drivers=
 can
pass dma_over_poi_threshold?
If it is not set, than just use whatever is the default.

But I don't think this setting should be in the DT.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
