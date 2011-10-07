From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/8] OMAP2+: omap_hwmod: manage the wake-up latency
 constraints
Date: Thu, 6 Oct 2011 20:53:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110062048160.4611@utopia.booyaka.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com> <1316622258-3892-1-git-send-email-j-pihet@ti.com> <1316622258-3892-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39575 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758323Ab1JGCxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 22:53:15 -0400
In-Reply-To: <1316622258-3892-5-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi

a comment:

On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> Hwmod is queried from the OMAP_PM layer to manage the power domains
> wake-up latency constraints. Hwmod retrieves the correct power domain
> and if it exists it calls the corresponding power domain function.
> 
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   26 +++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
>  2 files changed, 27 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 84cc0bd..c6b1cc9 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2618,11 +2619,34 @@ ohsps_unlock:
>  	return ret;
>  }
>  
> +/*
> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
> + *
> + * @oh: struct omap_hwmod* to which the target device belongs to.
> + * @cookie: identifier of the constraints list for @oh.
> + * @min_latency: the minimum allowed wake-up latency for @oh.
> + *
> + * Returns 0 upon success.
> + */

It's good that there is some documentation here, but it would be better if 
it were kerneldoc-style documentation.  Please see 
Documentation/kernel-doc-nano-HOWTO.txt.

Also it would be good to have a bit more documentation here beyond simply 
"Returns 0 upon success."  For example, how should a caller remove a 
wakeup latency constraint?  Also, this function can return -EINVAL, not 
counting whatever pwrdm_set_wkup_lat_constraint() can return, so that 
should be documented above also.

This applies to the function comments in the rest of the patches too.  
Some of them have quite good kerneldoc comments, such as 
pwrdm_wakeuplat_update_pwrst(); others need some work, like 
pwrdm_set_wkup_lat_constraint().

> +int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
> +				       void *cookie, long min_latency)
> +{
> +	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	if (!pwrdm) {
> +		pr_err("%s: Error: could not find powerdomain "
> +		       "for %s\n", __func__, oh->name);
> +		return -EINVAL;
> +	}
> +
> +	return pwrdm_set_wkup_lat_constraint(pwrdm, cookie, min_latency);
> +}
> +
>  /**
>   * omap_hwmod_get_context_loss_count - get lost context count
>   * @oh: struct omap_hwmod *
>   *
> - * Query the powerdomain of of @oh to get the context loss
> + * Query the powerdomain of @oh to get the context loss
>   * count for this device.
>   *
>   * Returns the context loss count of the powerdomain assocated with @oh
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 0e329ca..75e0e7a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -603,6 +603,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
>  				 void *user);
>  
>  int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
> +int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh, void *cookie,
> +				       long min_latency);
>  u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
>  int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
> -- 
> 1.7.4.1
> 


- Paul
