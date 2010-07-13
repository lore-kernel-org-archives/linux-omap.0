From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-OPP][PATCH 2/4] OMAP: Correct the return value check after
 call into find_device_opp
Date: Tue, 13 Jul 2010 07:23:02 -0500
Message-ID: <4C3C5AA6.8020303@ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com> <1279000026-24042-2-git-send-email-thara@ti.com> <1279000026-24042-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32802 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab0GMMXG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 08:23:06 -0400
In-Reply-To: <1279000026-24042-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

Gopinath, Thara had written, on 07/13/2010 12:47 AM, the following:
> Earlier we were checking on !dev_opp where as find_device_opp returns
> a error pointer in case of error. So correcting the check as in the earlier
> code even if find_device_opp returns an error opp_init_cpufreq_table
> was not exiting.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/plat-omap/opp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index a06b88d..d88a2e0 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -457,8 +457,10 @@ void opp_init_cpufreq_table(struct device *dev,
>  	int i = 0;
>  
>  	dev_opp = find_device_opp(dev);
> -	if (WARN_ON(!dev_opp))
> +	if (IS_ERR(dev_opp)) {
> +		WARN_ON(1);
could we use pr_warning here instead of WARN_ON?

>  		return;
> +	}
>  
>  	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
>  			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);


-- 
Regards,
Nishanth Menon
