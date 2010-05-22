From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/6 Revised] SPI omap2_mcspi.c: Check params before
	dereference or use
Date: Sat, 22 May 2010 03:39:36 -0600
Message-ID: <AANLkTikCydr_Nj446sySru774pY2jXLKNUNVfW3LSK9R@mail.gmail.com>
References: <1268406713.14445.50.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:56213 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab0EVJj5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 05:39:57 -0400
Received: by gxk27 with SMTP id 27so1092354gxk.1
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 02:39:56 -0700 (PDT)
In-Reply-To: <1268406713.14445.50.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>
Cc: spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org

On Fri, Mar 12, 2010 at 9:11 AM, Scott Ellis <scott@jumpnowtek.com> wro=
te:
> This was previously submitted directly to the linux-kernel list.
> It was incomplete the first time because it failed to also check
> the chip_select value.
>
> Check spi->controller_state before dereference.
> Check spi->chip_select for range before use.
>
> Neither are necessarily valid after spi_alloc_device() and
> then spi_add_device() fails. Calling spi_put_device() will
> trigger the error.
>
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

Hi Scott,

Can you please respin and repost your pending patches on top of
2.6.34?  The current patches don't apply as-is and I've lost track of
what needs to be done.

Thanks,
g.

> =A0drivers/spi/omap2_mcspi.c | =A0 30 +++++++++++++++++-------------
> =A01 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 715c518..fe1b56d 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -748,22 +748,26 @@ static void omap2_mcspi_cleanup(struct spi_devi=
ce *spi)
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*mcspi_dma;
> =A0 =A0 =A0 =A0struct omap2_mcspi_cs =A0 *cs;
>
> - =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
> + =A0 =A0 =A0 if (spi->controller_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unlink controller state from context=
 save list */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D spi->controller_state;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&cs->node);
>
> - =A0 =A0 =A0 /* Unlink controller state from context save list */
> - =A0 =A0 =A0 cs =3D spi->controller_state;
> - =A0 =A0 =A0 list_del(&cs->node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(spi->controller_state);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 kfree(spi->controller_state);
> + =A0 =A0 =A0 if (spi->chip_select < spi->master->num_chipselect) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(spi->m=
aster);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_dma =3D &mcspi->dma_channels[spi-=
>chip_select];
>
> - =A0 =A0 =A0 if (mcspi_dma->dma_rx_channel !=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(mcspi_dma->dma_rx_channel=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_dma->dma_rx_channel =3D -1;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 if (mcspi_dma->dma_tx_channel !=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(mcspi_dma->dma_tx_channel=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_dma->dma_tx_channel =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi_dma->dma_rx_channel !=3D -1) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(mcspi_dma=
->dma_rx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_dma->dma_rx_chann=
el =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mcspi_dma->dma_tx_channel !=3D -1) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(mcspi_dma=
->dma_tx_channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_dma->dma_tx_chann=
el =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0}
>
>
>
>
>
>
>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
