From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix build for beagleboard
Date: Thu, 11 Sep 2008 11:15:51 -0700
Message-ID: <20080911181549.GK21163@atomide.com>
References: <1221133802-19613-1-git-send-email-peter.de-schrijver@nokia.com> <1221133802-19613-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55243 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYIKSPx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 14:15:53 -0400
Content-Disposition: inline
In-Reply-To: <1221133802-19613-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080911 04:50]:

Signed-off-by?

Tony

> ---
>  drivers/i2c/chips/twl4030-power.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
> index 195c3c4..04a13aa 100644
> --- a/drivers/i2c/chips/twl4030-power.c
> +++ b/drivers/i2c/chips/twl4030-power.c
> @@ -149,7 +149,7 @@ struct triton_ins t2_wrst_seq[] __initdata = {
>  struct triton_ins sleep_on_seq[] __initdata = {
>  	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
>  			RES_STATE_SLEEP), 4},
> -	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE_R7,
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
>  			RES_STATE_SLEEP), 4},
>  };
>  
> @@ -160,6 +160,9 @@ struct triton_ins sleep_off_seq[] __initdata = {
>  	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
>  			RES_STATE_ACTIVE), 0x2},
>  };
> +
> +struct triton_ins t2_wrst_seq[] __initdata = { };
> +
>  #endif
>  
>  static int __init twl4030_write_script_byte(u8 address, u8 byte)
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
