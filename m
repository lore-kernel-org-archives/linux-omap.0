From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP HSMMC: fix MMC3 dma
Date: Sun, 8 Feb 2009 11:10:24 -0800
Message-ID: <200902081110.25166.david-b@pacbell.net>
References: <1233052573-6223-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:46149 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753044AbZBHThD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 14:37:03 -0500
In-Reply-To: <1233052573-6223-1-git-send-email-notasas@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: tony@atomide.com, drzeus-mmc@drzeus.cx, ext-adrian.hunter@nokia.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 27 January 2009, Grazvydas Ignotas wrote:
> @@ -1058,6 +1054,25 @@ static int __init omap_mmc_probe(struct platfo=
rm_device *pdev)
> =A0=A0=A0=A0=A0=A0=A0=A0OMAP_HSMMC_WRITE(host->base, HCTL,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> =A0
> +=A0=A0=A0=A0=A0=A0=A0/* Select DMA lines */
> +=A0=A0=A0=A0=A0=A0=A0switch (host->id) {
> +=A0=A0=A0=A0=A0=A0=A0case OMAP_MMC1_DEVID:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->dma_line_tx =3D O=
MAP24XX_DMA_MMC1_TX;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->dma_line_rx =3D O=
MAP24XX_DMA_MMC1_RX;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;

Actually the cleanest way to do that is through IORESOURCE_DMA
type resources associated with the platform devices ... but
doing it that way requires reworking the MMC platform device
setup logic.  Which I can understand wanting to avoid here.

(I think that rework is worth doing for multiple reasons; this
is just one more.)


> +=A0=A0=A0=A0=A0=A0=A0case OMAP_MMC2_DEVID:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->dma_line_tx =3D O=
MAP24XX_DMA_MMC2_TX;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->dma_line_rx =3D O=
MAP24XX_DMA_MMC2_RX;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> +=A0=A0=A0=A0=A0=A0=A0case OMAP_MMC3_DEVID:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->dma_line_tx =3D O=
MAP34XX_DMA_MMC3_TX;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->dma_line_rx =3D O=
MAP34XX_DMA_MMC3_RX;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> +=A0=A0=A0=A0=A0=A0=A0default:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(mmc_dev(host->m=
mc), "Invalid MMC id\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_irq;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> =A0=A0=A0=A0=A0=A0=A0=A0/* Request IRQ for MMC operations */
> =A0=A0=A0=A0=A0=A0=A0=A0ret =3D request_irq(host->irq, mmc_omap_irq, =
IRQF_DISABLED,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0mmc_hostname(mmc), host);


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
