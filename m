From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] mtd: nand: omap2: Do not assign omap_nand_info to
 platform drvdata
Date: Sat, 14 Oct 2017 17:11:23 +0200
Message-ID: <20171014171123.4095025b@bbrezillon>
References: <20171010133245.jlwto3gpmin5bmtw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171010133245.jlwto3gpmin5bmtw@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Richard Weinberger <richard@nod.at>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 10 Oct 2017 15:32:45 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> commit 67ce04bf2746 ("mtd: nand: add OMAP2/OMAP3 NAND driver") assigned
> pointer to omap_nand_info to the platform drvdata in probe function
> just to be reasigned later to the pointer to mtd_info, which is
> what remove function expects it to be. Remove useless assignment.
> 

Applied.

Thanks,

Boris

> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/mtd/nand/omap2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 01368a8f9e3f..a97c1aeed55e 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1823,7 +1823,6 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	platform_set_drvdata(pdev, info);
>  	info->ops = gpmc_omap_get_nand_ops(&info->reg, info->gpmc_cs);
>  	if (!info->ops) {
>  		dev_err(&pdev->dev, "Failed to get GPMC->NAND interface\n");


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
