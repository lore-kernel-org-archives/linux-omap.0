From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv3 1/6] SPI omap2_mcspi.c: Check params before dereference
	or use
Date: Tue, 25 May 2010 00:28:46 -0600
Message-ID: <AANLkTim7YtMJCwm1A88SQYEARiSFxspfsJET1ta82vsO@mail.gmail.com>
References: <1268406713.14445.50.camel@quad> <AANLkTikCydr_Nj446sySru774pY2jXLKNUNVfW3LSK9R@mail.gmail.com>
	<1274710827.2888.9.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:55769 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab0EYG3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 02:29:07 -0400
Received: by gxk27 with SMTP id 27so1132506gxk.1
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 23:29:06 -0700 (PDT)
In-Reply-To: <1274710827.2888.9.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Mon, May 24, 2010 at 8:20 AM, Scott Ellis <scott@jumpnowtek.com> wro=
te:
> Check spi->chip_select for range before use.
>
> The spi->controller_state check is already in 2.6.34-rc7
>
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

Okay, I've pick up this patch, but please check your Evolution
configuration.  Patchwork seems to be barfing on the patches sent by
you.  My guess is that it relies on a "---" line between the last
"signed-off-by", and the start of the actual patch.  See here to see
what I'm talking about:

https://patchwork.kernel.org/patch/101890/

Cheers,
g.

>
> =A0drivers/spi/omap2_mcspi.c | =A0 19 +++++++++++--------
> =A01 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index e0de0d0..0b35468 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -755,7 +755,6 @@ static void omap2_mcspi_cleanup(struct spi_device
> *spi)
> =A0 =A0 =A0 =A0struct omap2_mcspi_cs =A0 *cs;
>
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(spi->master);
> - =A0 =A0 =A0 mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
>
> =A0 =A0 =A0 =A0if (spi->controller_state) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Unlink controller state from contex=
t save list */
> @@ -765,13 +764,17 @@ static void omap2_mcspi_cleanup(struct spi_devi=
ce
> *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(spi->controller_state);
> =A0 =A0 =A0 =A0}
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
> + =A0 =A0 =A0 if (spi->chip_select < spi->master->num_chipselect) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_dma =3D &mcspi->dma_channels[spi-=
>chip_select];
> +
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



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
