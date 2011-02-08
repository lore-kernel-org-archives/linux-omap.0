From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/5] OMAP2420: hwmod data: Add HSMMC
Date: Tue, 08 Feb 2011 14:36:59 -0800
Message-ID: <877hdajgqc.fsf@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
	<1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1296660462-28489-2-git-send-email-kishore.kadiyala@ti.com>
	(Kishore Kadiyala's message of "Wed, 2 Feb 2011 20:57:38 +0530")
Sender: linux-mmc-owner@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

Kishore Kadiyala <kishore.kadiyala@ti.com> writes:

> Update the omap2420 hwmod data with the HSMMC info.
> Add a device attribute structure which will be used
> by the host driver to find whether the HSMMC controller
> supports DUAL VOLT cards.
>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

[...]

> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -43,6 +43,13 @@
>  
>  #define OMAP_MMC_MAX_SLOTS	2
>  
> +/* omap_hwmod integration data */
> +#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT	BIT(1)
> +
> +struct mmc_dev_attr {
> +	u8 flags;
> +};
> +
>  struct omap_mmc_platform_data {
>  	/* back-link to device */
>  	struct device *dev;

This part should be broken out as a separate patch. 

Kevin

