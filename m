From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
Date: Tue, 29 Nov 2011 19:10:15 +0100
Message-ID: <4ED52007.8010804@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com> <1320317665-6381-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab1K2SK2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 13:10:28 -0500
In-Reply-To: <1320317665-6381-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Rajendra,

Sorry for the delay, I kind of forgot your series :-(

On 11/3/2011 11:54 AM, Nayak, Rajendra wrote:
> Now that OMAP4 has hwmod/module level context lost counters, make
> omap_hwmod_get_context_loss_count() return them on platforms where they
> exist, else fall back on the pwrdm level counters for older platforms.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++---
>   1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index ac17748..9d140c4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2658,9 +2658,14 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
>   	struct powerdomain *pwrdm;
>   	int ret = 0;
>
> -	pwrdm = omap_hwmod_get_pwrdm(oh);
> -	if (pwrdm)
> -		ret = pwrdm_get_context_loss_count(pwrdm);
> +	if (oh->prcm.omap4.context_offs) {

I don't think it is safe to use that, since this is an union.
You do know what OMAP2 & 3 will put in that location.
It might be zero, but who knows?

> +		/* Support for per-hwmod context register */
> +		ret = oh->prcm.omap4.context_lost_counter;
> +	} else {
> +		pwrdm = omap_hwmod_get_pwrdm(oh);
> +		if (pwrdm)
> +			ret = pwrdm_get_context_loss_count(pwrdm);
> +	}
>
>   	return ret;
>   }

Regards,
Benoit
