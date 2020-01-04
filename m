From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] mtd: onenand: omap2: Pass correct flags for
 prep_dma_memcpy
Date: Sat, 4 Jan 2020 09:46:23 +0100
Message-ID: <9EB362B8-EA81-445C-9FD7-29ABB890100C@goldelico.com>
References: <20200104073453.16077-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20200104073453.16077-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Vignesh Raghavendra <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 04.01.2020 um 08:34 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
> 
> The commit converting the driver to DMAengine was missing the flags for
> the memcpy prepare call.
> It went unnoticed since the omap-dma drive was ignoring them.

s/drive/driver/

> 
> Fixes: 3ed6a4d1de2c5 (" mtd: onenand: omap2: Convert to use dmaengine for memcp")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Aaro reported [1] a failure on omap2-onenand pointing to
> 4689d35c765c696bdf0535486a990038b242a26b. It looks like the root cause is the
> conversion of omap2-onenand to DMAengine which missed the flags.
> 
> Basically the client is waiting for a callback without asking for it. This
> certainly causes timeout.
> 
> I have not tested the patch, but it should fix the issue.

makes the gta04a5one.dts work again.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

BR and thanks!
Nikolaus

> 
> [1] https://lore.kernel.org/lkml/20200103081726.GD15023@darkstar.musicnaut.iki.fi/
> 
> drivers/mtd/nand/onenand/omap2.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
> index edf94ee54ec7..71a632b815aa 100644
> --- a/drivers/mtd/nand/onenand/omap2.c
> +++ b/drivers/mtd/nand/onenand/omap2.c
> @@ -328,7 +328,8 @@ static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
> 	struct dma_async_tx_descriptor *tx;
> 	dma_cookie_t cookie;
> 
> -	tx = dmaengine_prep_dma_memcpy(c->dma_chan, dst, src, count, 0);
> +	tx = dmaengine_prep_dma_memcpy(c->dma_chan, dst, src, count,
> +				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> 	if (!tx) {
> 		dev_err(&c->pdev->dev, "Failed to prepare DMA memcpy\n");
> 		return -EIO;
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
