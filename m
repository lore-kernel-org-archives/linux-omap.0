From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: TWL4030: Fix wrong variable warning
Date: Fri, 11 Apr 2008 12:05:55 -0700
Message-ID: <20080411190555.GF7717@atomide.com>
References: <1207914696-24035-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:63001 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758425AbYDKTF5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 15:05:57 -0400
Content-Disposition: inline
In-Reply-To: <1207914696-24035-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080411 04:53]:
> twl4030_i2c_write_u8 expects a u8 variable.
> Change ctrl to be u8 in power_companion_init().

Pushing.

Tony


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
> index eedbebd..934433e 100644
> --- a/drivers/i2c/chips/twl4030-core.c
> +++ b/drivers/i2c/chips/twl4030-core.c
> @@ -679,7 +679,8 @@ static int unprotect_pm_master(void)
>  static int power_companion_init(void)
>  {
>  	struct clk *osc;
> -	u32 rate, ctrl = HFCLK_FREQ_26_MHZ;
> +	u32 rate;
> +	u8 ctrl = HFCLK_FREQ_26_MHZ;
>  	int e = 0;
>  
>  	if (cpu_is_omap2430())
> -- 
> 1.5.5.29.g7134
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
