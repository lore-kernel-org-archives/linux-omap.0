From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 3/7] ARM: OMAP2+: Remove hard-coded test on timer ID
Date: Mon, 4 Feb 2013 17:46:12 +0000
Message-ID: <20130204174612.GF2637@n2100.arm.linux.org.uk>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com> <1359999786-8740-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34979 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab3BDRqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 12:46:20 -0500
Content-Disposition: inline
In-Reply-To: <1359999786-8740-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 04, 2013 at 11:43:02AM -0600, Jon Hunter wrote:
> @@ -280,22 +281,22 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	if (IS_ERR(timer->fclk))
>  		return -ENODEV;
>  
> -	/* FIXME: Need to remove hard-coded test on timer ID */
> -	if (gptimer_id != 12) {
> -		struct clk *src;
> -
> -		src = clk_get(NULL, fck_source);
> -		if (IS_ERR(src)) {
> -			r = -EINVAL;
> -		} else {
> -			r = clk_set_parent(timer->fclk, src);
> -			if (IS_ERR_VALUE(r))
> -				pr_warn("%s: %s cannot set source\n",
> -					__func__, oh->name);
> +	src = clk_get(NULL, fck_source);
> +	if (IS_ERR(src))
> +		return -EINVAL;

This should be:
		return PTR_ERR(src);

and should've been there previously...
