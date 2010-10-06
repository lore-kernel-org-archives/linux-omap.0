From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/7] [RFC] OMAP: hwmod implementation for MCBSP
Date: Wed, 6 Oct 2010 09:58:18 +0300
Message-ID: <201010060958.18330.peter.ujfalusi@nokia.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com> <201010060901.59829.peter.ujfalusi@nokia.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CF132F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:55233 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634Ab0JFG6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 02:58:21 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CF132F2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Varadarajan, Charulatha" <charu@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On Wednesday 06 October 2010 09:12:34 ext Varadarajan, Charulatha wrote=
:
> This patch series would not break OMAP1 as they do not touch
> the omap_mcbsp_register_board_cfg() in mach-omap1.

But the plat-omap/mcbsp will not going to be able to prope on OMAP1, or=
 did I=20
missed something?

Snip:
@@ -1775,25 +1685,50 @@ static int __devinit omap_mcbsp_probe(struct=20
platform_device *pdev)
        mcbsp->dma_tx_lch =3D -1;
        mcbsp->dma_rx_lch =3D -1;

-       mcbsp->phys_base =3D pdata->phys_base;
-       mcbsp->io_base =3D ioremap(pdata->phys_base, SZ_4K);
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       if (!res) {
+               dev_err(&pdev->dev, "%s:mcbsp%d has invalid memory reso=
urce\n",
+                                       __func__, pdev->id);
+               ret =3D -ENOMEM;
+               goto exit;
+       }
+       mcbsp->phys_base =3D res->start;
+       mcbsp->io_base =3D ioremap(res->start, resource_size(res));
        if (!mcbsp->io_base) {
                ret =3D -ENOMEM;
                goto err_ioremap;
        }

+       omap_mcbsp_cache_size =3D resource_size(res);
+
        /* Default I/O is IRQ based */
        mcbsp->io_type =3D OMAP_MCBSP_IRQ_IO;
-       mcbsp->tx_irq =3D pdata->tx_irq;
-       mcbsp->rx_irq =3D pdata->rx_irq;
-       mcbsp->dma_rx_sync =3D pdata->dma_rx_sync;
-       mcbsp->dma_tx_sync =3D pdata->dma_tx_sync;
+       mcbsp->tx_irq =3D platform_get_irq_byname(pdev, "tx");
+       mcbsp->rx_irq =3D platform_get_irq_byname(pdev, "rx");
+
+       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx"=
);
+       if (!res) {
+               dev_err(&pdev->dev, "%s:mcbsp%d has invalid DMA channel=
\n",
+                                       __func__, pdev->id);
+               ret =3D -ENODEV;
+               goto err_res;
+       }
+       mcbsp->dma_rx_sync =3D res->start;
+
+       res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx"=
);
+       if (!res) {
+               dev_err(&pdev->dev, "%s:mcbsp%d has invalid DMA channel=
\n",
+                                       __func__, pdev->id);
+               ret =3D -ENODEV;
+               goto err_res;
+       }
+       mcbsp->dma_tx_sync =3D res->start;

I don't think that on OMAP1 the platform_get_resource_byname function w=
ill find=20
the needed resources...

>=20
> Usage of hwmod is applicable only for OMAP2plus cpus and it modifies
> the way in which the platform device is built & registered. It makes
> use of centralised database to fetch the addresses, irq, dma info etc=
=2E,
> for OMAP2plus. OMAP1 cpus will still continue to have the old way of
> doing platform device registeration.
>=20
> pm_runtime APIs are already inplace to take care of enabling clocks i=
n
> case of OMAP1.
>=20
> Hope this clarifies.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
