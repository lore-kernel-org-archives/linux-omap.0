From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl-core: convert to module_init()
Date: Fri, 31 May 2013 14:20:04 -0700
Message-ID: <20130531212003.GR6467@atomide.com>
References: <1370033794-5357-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49649 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754716Ab3EaVUJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 17:20:09 -0400
Content-Disposition: inline
In-Reply-To: <1370033794-5357-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, open list <linux-kernel@vger.kernel.org>

* Kevin Hilman <khilman@linaro.org> [130531 14:02]:
> There's no reason for twl-core to be subsys_inicall anymore.  Anything
> using twl that early needs a rethink, or deferred probe changes.
> 
> Boot tested and RTC wake tested (via TWL RTC) on OMAP platforms:
> 3530/Beagle, 3730/Beagle-xM, 3530/Overo, 3730/Overo-STORM, 4430/Panda,
> 4460/Panda-ES.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Totally agree:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 89ab4d9..7749b9e 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1309,7 +1309,7 @@ static int __init twl_init(void)
>  {
>  	return i2c_add_driver(&twl_driver);
>  }
> -subsys_initcall(twl_init);
> +module_init(twl_init);
>  
>  static void __exit twl_exit(void)
>  {
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
