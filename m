From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
Date: Thu, 20 Sep 2012 15:15:04 -0700
Message-ID: <20120920221504.GK28835@atomide.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
 <1348152453-30532-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58866 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753113Ab2ITWPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 18:15:07 -0400
Content-Disposition: inline
In-Reply-To: <1348152453-30532-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbou@mail.ru>, Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi,

* Jean Pihet <jean.pihet@newoldbits.com> [120920 07:48]:
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -131,14 +131,11 @@ static void sr_set_clk_length(struct omap_sr *sr)
>  	struct clk *sys_ck;
>  	u32 sys_clk_speed;
>  
> -	if (cpu_is_omap34xx())
> -		sys_ck = clk_get(NULL, "sys_ck");
> -	else
> -		sys_ck = clk_get(NULL, "sys_clkin_ck");
> +	sys_ck = clk_get(NULL, sr->fck_name);
>  
>  	if (IS_ERR(sys_ck)) {
> -		dev_err(&sr->pdev->dev, "%s: unable to get sys clk\n",
> -			__func__);
> +		dev_err(&sr->pdev->dev, "%s: unable to get smartreflex fck %s\n",
> +			__func__, sr->fck_name);
>  		return;
>  	}
>  

You should be able to make this even simpler and not have to pass
the clock name around at all. Just do:

syc_ck = clk_get(NULL, "fck);
...

In the driver, and add the necessary entries to the clock alias
table. That way it's up to the SoC to set up the necessary clocks
and the driver stays generic.

> @@ -1049,6 +1039,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  
>  	list_del(&sr_info->node);
>  	iounmap(sr_info->base);
> +	kfree(sr_info->fck_name);
>  	kfree(sr_info->name);
>  	kfree(sr_info);
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Then there's no need for the kfree of the fck_name
either.

There's an example of a similar patch done for twl-core.c as commit
defa6be1 (mfd: Fix compile for twl-core.c by removing cpu_is_omap usage)
in current linux next, except with smartreflex you probably don't
need to do any of the platform_device_alloc trickery like twl-core.c
neded to get around using the i2c numbers as names.

Regards,

Tony
