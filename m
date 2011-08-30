From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2 RESEND] OMAP2+: pm: fix typos
Date: Tue, 30 Aug 2011 14:14:35 -0700
Message-ID: <87zkiqmwjo.fsf@ti.com>
References: <87r543rkdk.fsf@ti.com>
	<1314722897-25040-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45038 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756672Ab1H3VOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 17:14:39 -0400
Received: by mail-pz0-f48.google.com with SMTP id 34so81449pzk.21
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 14:14:38 -0700 (PDT)
In-Reply-To: <1314722897-25040-1-git-send-email-jhovold@gmail.com> (Johan
	Hovold's message of "Tue, 30 Aug 2011 18:48:16 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Johan Hovold <jhovold@gmail.com> writes:

> Fix typos in comment and error message.
>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Thanks, queuing for v3.2 (branch: for_3.2/pm-cleanup)

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
