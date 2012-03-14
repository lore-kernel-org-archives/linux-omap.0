From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: opp: test for iva before attempting to set iva opp
Date: Wed, 14 Mar 2012 10:09:16 -0700
Message-ID: <87k42nhzyb.fsf@ti.com>
References: <1331732912-16771-1-git-send-email-mvs@tigris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:60498 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760744Ab2CNRJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 13:09:09 -0400
Received: by iadj38 with SMTP id j38so4408094iad.16
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 10:09:05 -0700 (PDT)
In-Reply-To: <1331732912-16771-1-git-send-email-mvs@tigris.de> (Maximilian
	Schwerin's message of "Wed, 14 Mar 2012 14:48:32 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <mvs@tigris.de>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

Maximilian Schwerin <mvs@tigris.de> writes:

> From: Steve Sakoman <steve@sakoman.com>

Thanks for the patch.

Please add a descriptive changelog here.

Also, please Cc linux-arm-kernel@lists.infradead.org for all
upstream-bound patches.

Kevin

> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
> ---
>  arch/arm/mach-omap2/opp.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 9262a6b..414f2ec 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>  				__func__, i);
>  			return -EINVAL;
>  		}
> +
> +		if ((strcmp(opp_def->hwmod_name,"iva") == 0) && !omap3_has_iva())
> +			continue;
> +
>  		oh = omap_hwmod_lookup(opp_def->hwmod_name);
>  		if (!oh || !oh->od) {
>  			pr_warn("%s: no hwmod or odev for %s, [%d] "
