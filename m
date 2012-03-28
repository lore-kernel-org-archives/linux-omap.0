From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Wed, 28 Mar 2012 06:32:33 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55903 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab2C1Gcn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Mar 2012 02:32:43 -0400
In-Reply-To: <1332842311-12308-1-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 27, 2012 at 15:28:31, Nayak, Rajendra wrote:
> Some functions like _omap4_disable_module() and _omap4_wait_target_disable()
> are (will be) used on all OMAPs OMAP4 and beyond which support module level
> control. Fix the error checks in these functions to return if called on
> any platform pre OMAP4 (i.e OMAP2 and OMAP3) instead of checking for
> !cpu_is_omap44xx(). This avoids having to update the error check with a
> '&& !cpu_is_omap54xx()' when OMAP5 is introduced and possibly similar updates
> when further OMAP generations are added.
> 

Let me add some flavor here :)

AM33xx, which has module level control, but falls under OMAP3 family of 
devices. cpu_is_omap34xx() is true for AM33xx device and we have to add 
check in all these functions. And I am sure we will have many of such 
devices in the future.

Can we use some flag based option here, instead of cpu_is_xxx() check?

Thanks,
Vaibhav

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 8ac26f2..f2a9afa 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
>   */
>  static int _omap4_wait_target_disable(struct omap_hwmod *oh)
>  {
> -	if (!cpu_is_omap44xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		return 0;
>  
>  	if (!oh)
> @@ -838,7 +838,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>  	int v;
>  
>  	/* The module mode does not exist prior OMAP4 */
> -	if (!cpu_is_omap44xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		return -EINVAL;
>  
>  	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

