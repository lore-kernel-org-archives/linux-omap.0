From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix build for beagleboard
Date: Tue, 23 Sep 2008 13:54:18 +0300
Message-ID: <20080923105417.GH5102@atomide.com>
References: <20080915182259.GB7782@frodo> <1221568163-30976-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64361 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYIWKyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 06:54:23 -0400
Content-Disposition: inline
In-Reply-To: <1221568163-30976-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org, me@felipebalbi.com

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080916 15:30]:

Pushing.

Tony

> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-power.c |   25 +++++++++++++++----------
>  1 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
> index 195c3c4..ea8f447 100644
> --- a/drivers/i2c/chips/twl4030-power.c
> +++ b/drivers/i2c/chips/twl4030-power.c
> @@ -212,7 +216,6 @@ static int __init twl4030_write_script(u8 address, struct triton_ins *script,
>  static int __init config_sleep_wake_sequence(void)
>  {
>  	int err = 0;
> -	u8 data;
>  
>  	/*
>  	 * CLKREQ is pulled high on the 2430SDP, therefore, we need to take
> @@ -242,14 +245,16 @@ static int __init config_sleep_wake_sequence(void)
>  	err |= twl4030_write_script(0x2F, sleep_off_seq,
>  					ARRAY_SIZE(sleep_off_seq));
>  
> -#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
> -	/* Disabling AC charger effect on sleep-active transitions */
> -	err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
> -					R_CFG_P1_TRANSITION);
> -	data &= 0x0;
> -	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
> -					R_CFG_P1_TRANSITION);
> -#endif
> +	if (machine_is_omap_3430sdp() || machine_is_omap_ldp()) {
> +		u8 data;
> +		/* Disabling AC charger effect on sleep-active transitions */
> +		err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
> +						R_CFG_P1_TRANSITION);
> +		data &= ~(1<<1);
> +		err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
> +						R_CFG_P1_TRANSITION);
> +	}
> +
>  	/* P1/P2/P3 LVL_WAKEUP should be on LEVEL */
>  	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
>  					R_P1_SW_EVENTS);
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
