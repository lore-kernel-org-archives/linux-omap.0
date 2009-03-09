From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] Boosting OPP1 voltage level
Date: Mon, 09 Mar 2009 12:11:17 -0700
Message-ID: <87sklmwlyi.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1013@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:39391 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZCITLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 15:11:22 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1791318rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 12:11:20 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1013@dbde02.ent.ti.com> (Ramesh Gupta's message of "Thu\, 12 Feb 2009 14\:48\:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gupta, Ramesh" <grgupta@ti.com> writes:

> From a0b8d146249e05465ff30cfd72592418c7a5da8d Mon Sep 17 00:00:00 2001
> From: Ramesh Gupta G <grgupta@ti.com>
> Date: Thu, 12 Feb 2009 03:03:18 +0530
> Subject: [PATCH 3/3] Boosting OPP1 voltage level
>
> some issues are observed like DSP sending SYS_ERROR
> MMU Fault if operated in OPP1, Looks like drop in voltage
> making DSP to crash, this patch boosts voltage level slightly
> for stable DSP.
>

Ramesh,

Have you retested DSPBRIDGE with the current PM branch HEAD?  Rajendra
submitted some patches that update VDD1 that are now included.  I'm
guessing that will fix the problems you've been seeing as well.

Kevin

>
> ---
>  arch/arm/mach-omap2/omap3-opp.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
> index 5540e5b..3b7fff6 100644
> --- a/arch/arm/mach-omap2/omap3-opp.h
> +++ b/arch/arm/mach-omap2/omap3-opp.h
> @@ -24,7 +24,7 @@
>  static struct omap_opp omap3_mpu_rate_table[] = {
>  	{0, 0, 0},
>  	/*OPP1*/
> -	{S125M, VDD1_OPP1, 0x18},
> +	{S125M, VDD1_OPP1, 0x1C},
>  	/*OPP2*/
>  	{S250M, VDD1_OPP2, 0x20},
>  	/*OPP3*/
> @@ -48,7 +48,7 @@ static struct omap_opp omap3_l3_rate_table[] = {
>  static struct omap_opp omap3_dsp_rate_table[] = {
>  	{0, 0, 0},
>  	/*OPP1*/
> -	{S90M, VDD1_OPP1, 0x18},
> +	{S90M, VDD1_OPP1, 0x1C},
>  	/*OPP2*/
>  	{S180M, VDD1_OPP2, 0x20},
>  	/*OPP3*/
> -- 
> 1.5.3.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
