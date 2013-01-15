From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v8 2/5] mtd: omap-nand: pass device_node in platform data
Date: Tue, 15 Jan 2013 10:52:51 -0800
Message-ID: <20130115185251.GB14149@atomide.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1355481404-27695-3-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, avinashphilip-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Artem,

Looks like this patch related to making GPMC work with DT was
never sent to linux-mtd or to you so adding to cc.

Is this OK to apply along with the GPMC patches, or do you want to
take this separately with the MTD patches?

Regards,

Tony

* Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [121214 02:39]:
> Pass an optional device_node pointer in the platform data, which in turn
> will be put into a mtd_part_parser_data. This way, code that sets up the
> platform devices can pass along the node from DT so that the partitions
> can be parsed.
> 
> For non-DT boards, this change has no effect.
> 
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/nand/omap2.c                     | 4 +++-
>  include/linux/platform_data/mtd-nand-omap2.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 0002d5e..1d333497c 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1332,6 +1332,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	dma_cap_mask_t mask;
>  	unsigned sig;
>  	struct resource			*res;
> +	struct mtd_part_parser_data	ppdata = {};
>  
>  	pdata = pdev->dev.platform_data;
>  	if (pdata == NULL) {
> @@ -1557,7 +1558,8 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		goto out_release_mem_region;
>  	}
>  
> -	mtd_device_parse_register(&info->mtd, NULL, NULL, pdata->parts,
> +	ppdata.of_node = pdata->of_node;
> +	mtd_device_parse_register(&info->mtd, NULL, &ppdata, pdata->parts,
>  				  pdata->nr_parts);
>  
>  	platform_set_drvdata(pdev, &info->mtd);
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index 24d32ca..6bf9ef4 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -60,6 +60,8 @@ struct omap_nand_platform_data {
>  	int			devsize;
>  	enum omap_ecc           ecc_opt;
>  	struct gpmc_nand_regs	reg;
> -};
>  
> +	/* for passing the partitions */
> +	struct device_node	*of_node;
> +};
>  #endif
> -- 
> 1.7.11.7
> 
