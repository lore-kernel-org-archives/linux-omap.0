From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] OMAP2+: pm: fix typos
Date: Mon, 29 Aug 2011 14:13:59 -0700
Message-ID: <87r543rkdk.fsf@ti.com>
References: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35946 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754380Ab1H2VOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 17:14:08 -0400
Received: by pzk4 with SMTP id 4so9842124pzk.0
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 14:14:03 -0700 (PDT)
In-Reply-To: <1312907661-24436-1-git-send-email-jhovold@gmail.com> (Johan
	Hovold's message of "Tue, 9 Aug 2011 18:34:19 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Johan,

Johan Hovold <jhovold@gmail.com> writes:

> Fix typos in comment and error message.
>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Thanks for these PM-related cleanups.  They're much appreciated.

Patches 1 & 2 look fine.  However, can you please repost with the
linux-arm-kernel mailing list in Cc?    All patches for upstream should
also Cc that list: linux-arm-kernel@lists.infradead.org

Kevin

> ---
>  arch/arm/mach-omap2/pm.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 3feb359..fd77cf4 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -163,11 +163,11 @@ err:
>  }
>  
>  /*
> - * This API is to be called during init to put the various voltage
> + * This API is to be called during init to set the various voltage
>   * domains to the voltage as per the opp table. Typically we boot up
>   * at the nominal voltage. So this function finds out the rate of
>   * the clock associated with the voltage domain, finds out the correct
> - * opp entry and puts the voltage domain to the voltage specifies
> + * opp entry and sets the voltage domain to the voltage specified
>   * in the opp entry
>   */
>  static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
> @@ -218,7 +218,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>  	return 0;
>  
>  exit:
> -	printk(KERN_ERR "%s: Unable to put vdd_%s to its init voltage\n\n",
> +	printk(KERN_ERR "%s: Unable to set vdd_%s to its init voltage\n\n",
>  		__func__, vdd_name);
>  	return -EINVAL;
>  }
