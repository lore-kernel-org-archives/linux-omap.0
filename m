From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] Adapt twl4030 power code to new twl4030 code
Date: Tue, 7 Oct 2008 09:19:55 -0700
Message-ID: <200810070919.55138.david-b@pacbell.net>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com> <1223390050-11499-2-git-send-email-peter.de-schrijver@nokia.com> <1223390050-11499-3-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:31683 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752764AbYJGQT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 12:19:57 -0400
In-Reply-To: <1223390050-11499-3-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Peter 'p2' De Schrijver wrote:
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-power.c |  290 +++++++++++++++----------------------
>  include/linux/i2c/twl4030.h       |   64 ++++++++
>  2 files changed, 181 insertions(+), 173 deletions(-)
> 
> diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
> index cb325b0..4a543a2 100644
> --- a/drivers/i2c/chips/twl4030-power.c
> +++ b/drivers/i2c/chips/twl4030-power.c

> -#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
> -
> -	...
> -#else
> -struct triton_ins sleep_on_seq[] __initdata = {
> -	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
> -			RES_STATE_SLEEP), 4},
> -	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
> -			RES_STATE_SLEEP), 4},
> -};
> -
> -struct triton_ins sleep_off_seq[] __initdata = {
> -	{MSG_SINGULAR(DEV_GRP_NULL, 0x17, RES_STATE_ACTIVE), 0x30},
> -	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP_PR, RES_TYPE_ALL, RES_TYPE2_R0,
> -			RES_STATE_ACTIVE), 0x37},
> -	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
> -			RES_STATE_ACTIVE), 0x2},
> -};
> -
> -struct triton_ins t2_wrst_seq[] __initdata = { };
> -
> -#endif

Your set of patches seems to have discarded support for quite
a few platforms.  I don't quite know the details of what these
PM scripts are doing ... could they be misbehaving on Beagle,
so that they explain why "reboot" on RC8 fails?


> +static int __init twl4030_power_probe(struct platform_device *pdev)

Pretty much everything here is "init" code, which is fine;
I like seeing smaller runtime images.  But:


>  
> @@ -340,4 +271,17 @@ static int __init twl4030_power_init(void)
>  
>  }
>  
> +static struct platform_driver twl4030_power = {
> +	.probe		= twl4030_power_probe,
> +	.driver		= {
> +		.name = "twl4030_power",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init twl4030_power_init(void)
> +{
> +	return platform_driver_register(&twl4030_power);

... in that case, why not platform_driver_probe(), so there's
not even a whiff of a notion that this driver remain init is
done?

And I can't help but wonder why this isn't just part of
the twl4030-core code, without even a platform device/driver.

I didn't move it to drivers/mfd because it seemed almost all
SDP-specific.  But to the extent that it's something generic
and "part of the core", maybe that's where it should be.
Not necessarily part of the same file.

- Dave


> +}
> +
>  module_init(twl4030_power_init);
