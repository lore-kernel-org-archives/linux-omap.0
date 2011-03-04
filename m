From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
 hwmods
Date: Fri, 4 Mar 2011 15:51:07 +0100
Message-ID: <4D70FC5B.9040701@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <4D651998.3040002@ti.com> <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com> <4D6B845A.9000900@ti.com> <20110302175422.GY20560@atomide.com> <4D6F7723.5040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab1CDOvP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 09:51:15 -0500
In-Reply-To: <4D6F7723.5040001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Paul,

On 3/3/2011 12:10 PM, Cousson, Benoit wrote:
> On 3/2/2011 6:54 PM, Tony Lindgren wrote:
>>> On 2/28/2011 3:31 AM, Paul Walmsley wrote:
>>>> Tony, I guess the omap-for-linus branch will probably need to get =
rebuilt
>>>> to drop that patch, once this series is merged...
>>
>> Let's rather apply a fix or revert instead than start messing with
>> omap-for-linus. That branch is supposed to be a stable base for othe=
rs
>> to base their branches on.
>
> Paul,
>
> It is probably better to add the fix in that series at the same time =
you
> setup the timer hwmod in the following commit 38698bef5454.
> It will avoid breaking bisect.

It looks like your branch is now merged without the revert or the fix=20
proposed below, so the warning is still there :-(

Tony,
Do you plan to re-merge this branch or should I just send a revert on=20
top of it?

Thanks,
Benoit

> Regards,
> Benoit
>
> ---
>   From 35e0aff709a7ea27c65e08c7bd5d904d3193ec75 Mon Sep 17 00:00:00 2=
001
> From: Paul Walmsley<paul@pwsan.com>
> Date: Wed, 23 Feb 2011 00:14:08 -0700
> Subject: [PATCH] OMAP2+: clockevent: set up GPTIMER clockevent hwmod
> right before timer init
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Set up the GPTIMER hwmod used for the clockevent source immediately
> before it is used.  This avoids the need to set up all of the hwmods
> until the boot process is further along.  (In general, we want to def=
er
> as much as possible until late in the boot process.)
>
> This second version fixes a bug pointed out by Santosh Shilimkar
> <santosh.shilimkar@ti.com>, that would cause the kernel to use an
> incorrect timer hwmod name if the selected GPTIMER was not 1 or 12 -
> thanks Santosh.  Also, Tarun Kanti DebBarma<tarun.kanti@ti.com>
> pointed out that the original patch did not apply cleanly; this has
> now been fixed.
>
> Revert as well commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6:
> "OMAP4: hwmod data: Prevent timer1 to be reset and idle during init",
> that is not longer needed since hwmod is setup before timer used it.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson<b-cousson@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>    arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
>    arch/arm/mach-omap2/timer-gp.c             |    7 ++++++-
>    2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 2c58827..b4d3b3c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3989,7 +3989,6 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] =3D {
>    static struct omap_hwmod omap44xx_timer1_hwmod =3D {
>    	.name		=3D "timer1",
>    	.class		=3D&omap44xx_timer_1ms_hwmod_class,
> -	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>    	.mpu_irqs	=3D omap44xx_timer1_irqs,
>    	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap44xx_timer1_irqs),
>    	.main_clk	=3D "timer1_fck",
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/tim=
er-gp.c
> index 7b7c268..fb8d656 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -39,10 +39,11 @@
>    #include<asm/mach/time.h>
>    #include<plat/dmtimer.h>
>    #include<asm/localtimer.h>
> +#include<plat/common.h>
> +#include<plat/omap_hwmod.h>
>
>    #include "timer-gp.h"
>
> -#include<plat/common.h>
>
>    /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
>    #define MAX_GPTIMER_ID		12
> @@ -132,9 +133,13 @@ static void __init omap2_gp_clockevent_init(void=
)
>    {
>    	u32 tick_rate;
>    	int src;
> +	char clockevent_hwmod_name[8]; /* 8 =3D sizeof("timerXX0") */
>
>    	inited =3D 1;
>
> +	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
> +	omap_hwmod_setup_one(clockevent_hwmod_name);
> +
>    	gptimer =3D omap_dm_timer_request_specific(gptimer_id);
>    	BUG_ON(gptimer =3D=3D NULL);
>    	gptimer_wakeup =3D gptimer;

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
