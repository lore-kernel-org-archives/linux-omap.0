From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] omap3|4: opp: make omapx_opp_init non-static
Date: Tue, 01 Feb 2011 14:01:00 -0800
Message-ID: <87y65zpg83.fsf@ti.com>
References: <1294260576-20237-1-git-send-email-nm@ti.com>
	<1294260576-20237-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35022 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147Ab1BAWBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 17:01:07 -0500
Received: by mail-vx0-f179.google.com with SMTP id 40so562159vxb.38
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 14:01:05 -0800 (PST)
In-Reply-To: <1294260576-20237-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 5 Jan 2011 14:49:35 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>

Nishanth Menon <nm@ti.com> writes:

> omap3 and omap4 opp_init should be made non-static to allow
> for platform specific opp table tweaking. making these static
> conflicts with the definition in pm.h(global) as well.
> we include pm.h as well to ensure that there are no such prototype
> conflicts with actual implementation in the future.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin

> ---
>  arch/arm/mach-omap2/opp3xxx_data.c |    3 ++-
>  arch/arm/mach-omap2/opp4xxx_data.c |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> index 0486fce..fd3a1af 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -21,6 +21,7 @@
>  #include <plat/cpu.h>
>  
>  #include "omap_opp_data.h"
> +#include "pm.h"
>  
>  static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	/* MPU OPP1 */
> @@ -88,7 +89,7 @@ static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
>  /**
>   * omap3_opp_init() - initialize omap3 opp table
>   */
> -static int __init omap3_opp_init(void)
> +int __init omap3_opp_init(void)
>  {
>  	int r = -ENODEV;
>  
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index a11fa56..f0e9939 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -22,6 +22,7 @@
>  #include <plat/cpu.h>
>  
>  #include "omap_opp_data.h"
> +#include "pm.h"
>  
>  static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>  	/* MPU OPP1 - OPP50 */
> @@ -42,7 +43,7 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>  /**
>   * omap4_opp_init() - initialize omap4 opp table
>   */
> -static int __init omap4_opp_init(void)
> +int __init omap4_opp_init(void)
>  {
>  	int r = -ENODEV;
