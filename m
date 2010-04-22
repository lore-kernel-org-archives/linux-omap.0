From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv3 01/11] mfd: twl4030-power: Rename DEVGROUP to DEV_GRP
Date: Thu, 22 Apr 2010 11:19:32 +0300
Message-ID: <20100422081932.GE16011@besouro.research.nokia.com>
References: <1271923663-23668-1-git-send-email-eduardo.valentin@nokia.com>
 <1271923663-23668-2-git-send-email-eduardo.valentin@nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16758 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0DVIUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 04:20:50 -0400
Content-Disposition: inline
In-Reply-To: <1271923663-23668-2-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: Core-Review <core-review@ok.research.nokia.com>, Amit Kucheria <amit.kucheria@verdurent.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>

Hello guys,

sorry for this spamming, I've missed the suppress cc list while sending these patches.

On Thu, Apr 22, 2010 at 10:07:33AM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
> From: Amit Kucheria <amit.kucheria@verdurent.com>
> 
> Stick to the names used in the reference manual
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/twl4030-power.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 6b716ef..8f82e22 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -74,12 +74,12 @@ static u8 twl4030_start_script_address = 0x2b;
>  
>  /* resource configuration registers */
>  
> -#define DEVGROUP_OFFSET		0
> +#define DEV_GRP_OFFSET		0
>  #define TYPE_OFFSET		1
>  
> -/* Bit positions */
> -#define DEVGROUP_SHIFT		5
> -#define DEVGROUP_MASK		(7 << DEVGROUP_SHIFT)
> +/* Bit positions in the registers */
> +#define DEV_GRP_SHIFT		5
> +#define DEV_GRP_MASK		(7 << DEV_GRP_SHIFT)
>  #define TYPE_SHIFT		0
>  #define TYPE_MASK		(7 << TYPE_SHIFT)
>  #define TYPE2_SHIFT		3
> @@ -333,7 +333,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
>  
>  	/* Set resource group */
>  	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &grp,
> -				rconfig_addr + DEVGROUP_OFFSET);
> +				rconfig_addr + DEV_GRP_OFFSET);
>  	if (err) {
>  		pr_err("TWL4030 Resource %d group could not be read\n",
>  			rconfig->resource);
> @@ -341,10 +341,10 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
>  	}
>  
>  	if (rconfig->devgroup >= 0) {
> -		grp &= ~DEVGROUP_MASK;
> -		grp |= rconfig->devgroup << DEVGROUP_SHIFT;
> +		grp &= ~DEV_GRP_MASK;
> +		grp |= rconfig->devgroup << DEV_GRP_SHIFT;
>  		err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> -					grp, rconfig_addr + DEVGROUP_OFFSET);
> +					grp, rconfig_addr + DEV_GRP_OFFSET);
>  		if (err < 0) {
>  			pr_err("TWL4030 failed to program devgroup\n");
>  			return err;
> -- 
> 1.7.0.4.361.g8b5fe.dirty
> 
> _______________________________________________
> Core-review mailing list
> Core-review@ok.research.nokia.com
> http://ok.research.nokia.com/cgi-bin/mailman/listinfo/core-review
