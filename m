From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Mon, 30 Jul 2012 23:36:15 -0500
Message-ID: <501760BF.8070801@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36466 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2GaEgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 00:36:21 -0400
In-Reply-To: <50171841.40309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 07/30/2012 06:26 PM, Jon Hunter wrote:

[...]

> 1. When HWMOD attempts to disable the clock domain for OMAP2/3 devices 
>    we simply return without doing anything. Not sure if it is safe to 
>    remove this but I can do some more testing on OMAP2/3. 
> 
> commit a0307bd539ecef976793679a1c4ff0d47b22c4bd
> Author: Jon Hunter <jon-hunter@ti.com>
> Date:   Mon Jul 30 18:04:06 2012 -0500
> 
>     ARM: OMAP2/3: Allow HWMOD to disable clock domains
>     
>     Currently when HWMOD attempts to disable a clock domain on OMAP2/3 devices we
>     will return from the function clkdm_hwmod_disable() without actually disabling
>     the clock domain. Per the comment this is deliberate because initially HWMOD
>     OMAP2/3 devices did not support clock domains. However, clock domains are now
>     supported by HWMOD for these devices and so allow HWMOD to disable the clock
>     domains.
>     
>     XXX - Tested on OMAP3430 beagle board, but needs more testing on OMAP2/3
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 011186f..8f7a941 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -1075,10 +1075,6 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>   */
>  int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>  {
> -       /* The clkdm attribute does not exist yet prior OMAP4 */
> -       if (cpu_is_omap24xx() || cpu_is_omap34xx())
> -               return 0;
> -
>         /*
>          * XXX Rewrite this code to maintain a list of enabled
>          * downstream hwmods for debugging purposes?
> 
> 
> 2. I need to make the following changes to your patch. The change to
>    omap2_clkdm_clk_disable() was needed to get the EMU to turn off.
>    At the same time I thought we should make the same change to
>    omap2_clkdm_clk_enable().
> 
> diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> index 09385a9..c94b2fb 100644
> --- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> @@ -223,7 +223,8 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>                 _enable_hwsup(clkdm);
>         } else {
>                 if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
> -                       omap2_clkdm_wakeup(clkdm);
> +                       (cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm) :
> +                               omap3_clkdm_wakeup(clkdm);
>         }
>  
>         return 0;
> @@ -257,7 +258,8 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
>                 _enable_hwsup(clkdm);
>         } else {
>                 if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
> -                       omap2_clkdm_sleep(clkdm);
> +                       (cpu_is_omap24xx()) ? omap2_clkdm_sleep(clkdm) :
> +                               omap3_clkdm_sleep(clkdm);
>         }

I just remembered you sending out a patch [1] to address #2 above. Let
me know your thoughts about change #1.

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=134333691309305&w=2
