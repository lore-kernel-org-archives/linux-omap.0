From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] mtd: omap2: Release memory region in .remove function
Date: Fri, 17 Feb 2012 20:52:19 +0530
Message-ID: <CAM=Q2cuXfYA=bibwzDBdb41_KiHu1X4bExbyS2FsfjBM7RXopQ@mail.gmail.com>
References: <1329490172-8043-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329490172-8043-1-git-send-email-walle@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bernhard Walle <walle@corscience.de>
Cc: dwmw2@infradead.org, Artem.Bityutskiy@linux.intel.com, vimal.newwork@gmail.com, tony@atomide.com, s-ghorai@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 17, 2012 at 8:19 PM, Bernhard Walle <walle@corscience.de> w=
rote:
> When the driver is compiled as module, it's not possible to unload an=
d
> reload the driver again:
>
> =A0 =A0omap2-nand: probe of omap2-nand.0 failed with error -16
>
Looks right to me
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>

> This patch fixes the problem because it releases the memory region, s=
o
> that it can be requested again.
>
> Signed-off-by: Bernhard Walle <walle@corscience.de>
> ---
> =A0drivers/mtd/nand/omap2.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index b3a883e..7dfcf68 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1132,6 +1132,7 @@ static int omap_nand_remove(struct platform_dev=
ice *pdev)
> =A0 =A0 =A0 =A0/* Release NAND device, its internal structures and pa=
rtitions */
> =A0 =A0 =A0 =A0nand_release(&info->mtd);
> =A0 =A0 =A0 =A0iounmap(info->nand.IO_ADDR_R);
> + =A0 =A0 =A0 release_mem_region(info->phys_base, NAND_IO_SIZE);
> =A0 =A0 =A0 =A0kfree(&info->mtd);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
