From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 3/7] iommu/omap: Convert to devicetree
Date: Thu, 02 Jan 2014 01:13:42 +0100
Message-ID: <1764051.JiGg1d3s1L@avalon>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
	<1387284818-28739-4-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1387284818-28739-4-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Florian,

Thank you for the patch.

On Tuesday 17 December 2013 13:53:34 Florian Vaussard wrote:
> As OMAP2+ is moving to a full DT boot for 3.14, commit 7ce93f3
> "ARM: OMAP2+: Fix more missing data for omap3.dtsi file" adds
> basic DT bits. But the driver is not yet converted, so this will
> not work and driver will not be probed. Convert it!
> 
> Apart from standard bindings, this patch uses 'dma-window' (already
> used by Tegra SMMU) and adds a custom 'ti,#tlb-entries' binding.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 19 ++++++++++++
>  arch/arm/mach-omap2/omap-iommu.c                   |  5 +++
>  drivers/iommu/omap-iommu.c                         | 36 ++++++++++++++++---
>  3 files changed, 55 insertions(+), 5 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt

[snip]

> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 385bf5e..51efcc4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c

[snip]

> @@ -1260,11 +1277,20 @@ static int omap_iommu_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> +#if defined(CONFIG_OF)
> +static struct of_device_id omap_iommu_of_match[] = {
> +	{ .compatible = "ti,omap3-mmu-isp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap_iommu_of_match);
> +#endif
> +
>  static struct platform_driver omap_iommu_driver = {
>  	.probe	= omap_iommu_probe,
>  	.remove	= omap_iommu_remove,
>  	.driver	= {
>  		.name	= "omap-iommu",
> +		.of_match_table = omap_iommu_of_match,

If CONFIG_OF isn't defined (pretty unlikely I agree, but a possibility you 
seem to be prepared for nonetheless given the above #if), this will fail to 
compile.

>  	},
>  };

-- 
Regards,

Laurent Pinchart
