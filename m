From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
Date: Thu, 7 Jun 2018 09:29:32 +0200
Message-ID: <20180607072932.GO13775@localhost>
References: <20180606134338.4645-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606134338.4645-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 06, 2018 at 02:43:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently saved_vals is being allocated and there is no check for
> failed allocation (which is more likely than normal when using
> GFP_ATOMIC).  Fix this by checking for a failed allocation and
> propagating this error return down the the caller chain.
> 
> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 9c3c00515aa0..0905ee002041 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
>  
>  	mux_bytes = pcs->width / BITS_PER_BYTE;
>  
> -	if (!pcs->saved_vals)
> +	if (!pcs->saved_vals) {
>  		pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
> +		if (!pcs->saved_vals)
> +			return -ENOMEM;
> +	}
>  
>  	switch (pcs->width) {
>  	case 64:
> @@ -1649,8 +1652,13 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
>  	if (!pcs)
>  		return -EINVAL;
>  
> -	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
> -		pcs_save_context(pcs);
> +	if (pcs->flags & PCS_CONTEXT_LOSS_OFF) {
> +		int ret;
> +
> +		ret = pcs_save_context(pcs);
> +		if (ret < 0)
> +			return ret;
> +	}

This appears to be the right fix (along the lines of what the author may
have intended by having the helper return an int), but as a follow-up
patch, why not move the allocation to probe() instead?

Also this doesn't look like something that requires atomic allocation in
the first place, GFP_KERNEL should do for the legacy suspend callback.

>  	return pinctrl_force_sleep(pcs->pctl);
>  }

But for this fix, feel free to add:

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
