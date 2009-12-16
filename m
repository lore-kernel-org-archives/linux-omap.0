From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: Prevent direct cpufreq scaling during initialization
Date: Wed, 16 Dec 2009 06:24:39 -0800
Message-ID: <87skbbateg.fsf@deeprootsystems.com>
References: <1259748759.21203.11.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:43546 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZLPOYx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 09:24:53 -0500
Received: by iwn1 with SMTP id 1so695235iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 06:24:52 -0800 (PST)
In-Reply-To: <1259748759.21203.11.camel@boson> (Romit Dasgupta's message of "Wed\, 02 Dec 2009 15\:42\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: romit@ti.com
Cc: linux-omap@vger.kernel.org

Romit Dasgupta <romit@ti.com> writes:

> It is seen that the OMAP specific cpufreq initialization code tries to
> scale the MPU frequency to the highest possible without taking care of
> the voltage level. On power on reset the power IC does not provide the
> necessary voltage for the highest available MPU frequency (that would
> satisfy all Si families). This potentially is an window of opportunity
> for things to go wrong.
>
> Signed-off-by: Romit Dasgupta <romit@ti.com>

Looks good.  Pulling into PM branch, and queing in pm-fixes for .33-rc
series.

Kevin

> ---
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 449b6b6..f94df20 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -149,8 +149,6 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
>  							VERY_HI_RATE) / 1000;
>  	}
>  
> -	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
> -
>  	policy->min = policy->cpuinfo.min_freq;
>  	policy->max = policy->cpuinfo.max_freq;
>  	policy->cur = omap_getspeed(0);
