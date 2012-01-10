From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2 3/3] arm:omap:omap4: Hook-up am33xx support to existing prm code
Date: Tue, 10 Jan 2012 10:09:22 -0800
Message-ID: <87zkdvpgz1.fsf@ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
	<1326017894-7632-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46640 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754282Ab2AJSJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 13:09:26 -0500
Received: by mail-yw0-f46.google.com with SMTP id j63so986241yhj.33
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 10:09:25 -0800 (PST)
In-Reply-To: <1326017894-7632-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 8 Jan 2012 15:48:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> AM33XX PRM module (L4_WK domain) will be treated as another seperate
> partition in _prm_bases[] table.
>
> Also, since cpu_is_omap34xx check is true for am33xx family of
> devices, we must check cpu_is_am33xx fisrt, in order to follow
> omap4 execution path.

Can you remind me why cpu_is_omap34xx() is true for AM33xx family?
These AM3xxx devices make my brain hurt.

> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
> index 3d9894f..fcc4123 100644
> --- a/arch/arm/mach-omap2/prminst44xx.c
> +++ b/arch/arm/mach-omap2/prminst44xx.c
> @@ -19,6 +19,7 @@
>  #include "common.h"
>
>  #include "prm44xx.h"
> +#include "prm33xx.h"
>  #include "prminst44xx.h"
>  #include "prm-regbits-44xx.h"
>  #include "prcm44xx.h"
> @@ -31,6 +32,7 @@ static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
>  	[OMAP4430_CM2_PARTITION]		= 0,
>  	[OMAP4430_SCRM_PARTITION]		= 0,
>  	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
> +	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
>  };

I'm not crazy about just extending the "normal" OMAP4 table.  That would
imply that with each OMAP4 derivatve we keep extending this table.

Instead, how about rename this to one to omap44xx_prm_bases[], then
create a new one called am33xx_prm_bases[].  Then, at init time, assing
_prm_bases to the right one based on cpu_is_.

Kevin

