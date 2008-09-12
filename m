From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Fix build for beagleboard
Date: Fri, 12 Sep 2008 08:02:52 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809120802090.16867@utopia.booyaka.com>
References: <20080911181549.GK21163@atomide.com> <1221215556-5100-1-git-send-email-peter.de-schrijver@nokia.com> <1221215556-5100-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54387 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbYILOCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 10:02:53 -0400
In-Reply-To: <1221215556-5100-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, 12 Sep 2008, Peter 'p2' De Schrijver wrote:

> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch is also necessary for 2430SDP builds to succeed.

- Paul


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
> 


- Paul
