From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Wed, 9 May 2012 17:55:20 +0530
Message-ID: <CANrkHUZBPMtAqS4TwwykrOwwvH6J2WeU5cWEx_Hr66UdZdOqJA@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 23, 2012 at 9:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> For the full text, please see
>
> http://lists.arm.linux.org.uk/lurker/message/20120418.100954.7fa7acf8=
=2Een.html
>
> This version contains updates for some of the comments received from =
the
> previous round, and adds the OMAP1/2 MMC and SPI drivers to the conve=
rsion.

Tested eMMC, SD on omap4 Blaze
Tested-by: Balaji T K <balajitk@ti.com>

>
> I've also added a note to feature-removal noting that the existing AP=
Is
> will be removed around 2013 - I'm planning January for that at the
> moment. =A0Having drivers around which are unconverted blocks further=
 work
> on the DMA engine conversion, so it's actually important that we get
> as many drivers converted as soon as possible.
>
> Anything which isn't converted will probably have its DMA code remove=
d,
> or if that results in the driver not being usable, the driver itself
> will be removed.
>
> This series is still in RFC mode...
>
> =A0Documentation/feature-removal-schedule.txt | =A0 11 +
> =A0arch/arm/mach-omap1/board-h2-mmc.c =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap1/board-h3-mmc.c =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap1/board-nokia770.c =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 14 +
> =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0| =A0 =A02 -
> =A0drivers/dma/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 10 +
> =A0drivers/dma/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A02 +
> =A0drivers/dma/omap-dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
521 ++++++++++++++++++++++++++++
> =A0drivers/dma/sa11x0-dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
249 ++++---------
> =A0drivers/dma/virt-dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 99 ++++++
> =A0drivers/dma/virt-dma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
138 ++++++++
> =A0drivers/mmc/host/omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
369 +++++++++-----------
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0206 =
++++++------
> =A0drivers/spi/spi-omap2-mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0228 =
+++++++------
> =A017 files changed, 1268 insertions(+), 586 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
