From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/8] ARM OMAP2+ GPMC: add bus children
Date: Fri, 27 Feb 2015 12:24:50 +0200
Message-ID: <54F045F2.7010005@ti.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424961956-29353-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424961956-29353-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, balbi@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Robert,

On 26/02/15 16:45, Robert ABEL wrote:
> This patch adds support for spawning buses as children of the GPMC.
> 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
> ---
>  drivers/memory/omap-gpmc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 5cabac8..74a8c52 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_mtd.h>
>  #include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/omap-gpmc.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/pm_runtime.h>
> @@ -1800,8 +1801,20 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	gpmc_cs_enable_mem(cs);
>  
>  no_timings:
> -	if (of_platform_device_create(child, NULL, &pdev->dev))
> -		return 0;
> +
> +	/* create platform device, NULL on error or when disabled */
> +	if (!of_platform_device_create(child, NULL, &pdev->dev))
> +		goto err_child_fail;
> +
> +	/* is child a common bus? */
> +	if (of_match_node(of_default_bus_match_table, child))
> +		/* create children and other common bus children */
> +		if (of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev))
> +			goto err_child_fail;

this would print "failed to create gpmc child" but we have already created
the gpmc child in the first of_platform_device_create() call.
A more appropriate message would be "failed to populate all children of child->name"

Also do you want to return failure?
it will result in of_node_put() of the child and another print message
about "probing gpmc child %s failed" in gpmc_probe_dt().

IMO if the GPMC node's child was created fine then we shouldn't return error.

> +
> +	return 0;
> +
> +err_child_fail:
>  
>  	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
>  	ret = -ENODEV;
> 

cheers,
-roger
