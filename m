From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove double MODULE_ALIAS declaration.
Date: Tue, 5 Aug 2008 12:14:49 +0300
Message-ID: <20080805091449.GJ7193@atomide.com>
References: <1214489878-20272-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58869 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759453AbYHEJOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 05:14:52 -0400
Content-Disposition: inline
In-Reply-To: <1214489878-20272-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roman Tereshonkov <roman.tereshonkov@nokia.com> [080626 17:23]:
> Only once MODULE_ALIAS declaration is enough.
> Columns are counted from 0 to n_cols - 1.

Pushing today.

Tony

> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  drivers/input/keyboard/omap-twl4030keypad.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
> index 20aeb3c..68c5b8e 100644
> --- a/drivers/input/keyboard/omap-twl4030keypad.c
> +++ b/drivers/input/keyboard/omap-twl4030keypad.c
> @@ -158,7 +158,7 @@ static void twl4030_kp_scan(int release_all)
>  		if (!changed)
>  			continue;
>  
> -		for (col = 0; col < n_cols + 1; col++) {
> +		for (col = 0; col < n_cols; col++) {
>  			int key;
>  
>  			if (!(changed & (1 << col)))
> @@ -373,4 +373,3 @@ MODULE_ALIAS("platform:omap_twl4030keypad");
>  MODULE_AUTHOR("Texas Instruments");
>  MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:omap_twl4030keypad");
> -- 
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
