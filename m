From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: OMAP: Fix OMAP1 build error
Date: Fri, 20 Jan 2012 08:22:46 -0800
Message-ID: <20120120162245.GN22818@atomide.com>
References: <4F198E58.4070509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32132 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab2ATQWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 11:22:51 -0500
Content-Disposition: inline
In-Reply-To: <4F198E58.4070509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>

* Cousson, Benoit <b-cousson@ti.com> [120120 07:22]:
> CONFIG_OF is not defined for OMAP1 yet and thus the omap1_defconfig build
> generate an error for 3.3-rc1.
> 
> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
> drivers/i2c/busses/i2c-omap.c:1021:26: error: 'omap_i2c_of_match' undeclared (first use in this function)
> drivers/i2c/busses/i2c-omap.c:1021:26: note: each undeclared identifier is reported only once for each function it appears in
> 
> Wrap omap_i2c_of_match with of_match_ptr() to prevent compilation error in case of OMAP1 build.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

Thanks, Ben care to ack this one? I'd like to apply it into
my fixes branch so I can compile and boot test all the
following fixes without having to apply this fix every
time I compile ;)

Regards,

Tony

> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f713eac..801df60 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1018,7 +1018,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_release_region;
>  	}
>  
> -	match = of_match_device(omap_i2c_of_match, &pdev->dev);
> +	match = of_match_device(of_match_ptr(omap_i2c_of_match), &pdev->dev);
>  	if (match) {
>  		u32 freq = 100000; /* default to 100000 Hz */
>  
> -- 
> 1.7.0.4
> 
