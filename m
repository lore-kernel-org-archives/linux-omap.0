From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Tue, 27 Mar 2012 14:52:49 -0500
Message-ID: <4F721A91.7000102@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60119 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab2C0Twz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 15:52:55 -0400
In-Reply-To: <1332842311-12308-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On 3/27/2012 4:58, Rajendra Nayak wrote:
> Some functions like _omap4_disable_module() and _omap4_wait_target_disable()
> are (will be) used on all OMAPs OMAP4 and beyond which support module level
> control. Fix the error checks in these functions to return if called on
> any platform pre OMAP4 (i.e OMAP2 and OMAP3) instead of checking for
> !cpu_is_omap44xx(). This avoids having to update the error check with a
> '&&  !cpu_is_omap54xx()' when OMAP5 is introduced and possibly similar updates
> when further OMAP generations are added.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 8ac26f2..f2a9afa 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -808,7 +808,7 @@ static void _enable_module(struct omap_hwmod *oh)
>    */
>   static int _omap4_wait_target_disable(struct omap_hwmod *oh)
>   {
> -	if (!cpu_is_omap44xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>   		return 0;

What about omap36xx?

>   	if (!oh)
> @@ -838,7 +838,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>   	int v;
>
>   	/* The module mode does not exist prior OMAP4 */
> -	if (!cpu_is_omap44xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>   		return -EINVAL;

Same here.

>
>   	if (!oh->clkdm || !oh->prcm.omap4.modulemode)

Cheers
Jon
