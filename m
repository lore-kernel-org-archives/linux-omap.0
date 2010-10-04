From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 17/17] dmtimer: remove OCP config code from plat-omap
Date: Mon, 4 Oct 2010 16:26:36 +0200
Message-ID: <4CA9E41C.7000504@ti.com>
References: <1285059404-26718-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab0JDO0l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 10:26:41 -0400
In-Reply-To: <1285059404-26718-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On 9/21/2010 10:56 AM, DebBarma, Tarun Kanti wrote:
> This patch removes the ocp config code from omap-plat
> because they are supposed to be taken care of by the
> hwmod framework. Specifically, following changes are
> incorporated:
> (1) setting of smart-idle and wakeup-enable is already
> taken care in existing code and so they are simply removed
> from plat-omap
> (2) clockactivity configuration is not present in the present
> hwmod database. Therefore this filed is initialized to '1' in

Typo.

> respective database.

Could you explain why, the default setting is not working for the timers?

>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Partha Basak<p-basak2@ti.com>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>   arch/arm/plat-omap/dmtimer.c               |   11 -----------
>   5 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index fc761a5..25111bf 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -168,6 +168,7 @@ static struct omap_hwmod_class_sysconfig omap2420_timer_sysc = {
>   			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>   			   SYSC_HAS_AUTOIDLE),
>   	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.clockact       = 1, /* preserve fclk on idle */

In theory, this field is useless unless you add a flag: 
SYSC_HAS_CLOCKACTIVITY.

So how is it working in your case?


>   	.sysc_fields    =&omap_hwmod_sysc_type1,
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 2ac463f..93d5c3d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -174,6 +174,7 @@ static struct omap_hwmod_class_sysconfig omap2430_timer_sysc = {
>   			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>   			   SYSC_HAS_AUTOIDLE),
>   	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.clockact       = 1, /* preserve fclk on idle */
>   	.sysc_fields    =&omap_hwmod_sysc_type1,
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 1ce40e0..c64c95b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -147,6 +147,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
>   				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>   				SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
>   	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.clockact       = 1, /* preserve fclk on idle */
>   	.sysc_fields	=&omap_hwmod_sysc_type1,
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 9edc518..a816d30 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -538,6 +538,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
>   			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
>   			   SYSS_MISSING),
>   	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.clockact	= 1, /* preserve fclk on idle */
>   	.sysc_fields	=&omap_hwmod_sysc_type1,
>   };
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 7d57605..6211501 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -157,17 +157,6 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>   	}
>   	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>
> -	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> -	l |= 0x02<<  3;  /* Set to smart-idle mode */
> -	l |= 0x2<<  8;   /* Set clock activity to perserve f-clock on idle */

It used to be 0x2 and now you put 1:
	.clockact       = 1, /* preserve fclk on idle */

I do not understand how that patch can work???

Benoit

> -
> -	/*
> -	 * Enable wake-up on OMAP2 CPUs.
> -	 */
> -	if (cpu_class_is_omap2())
> -		l |= 1<<  2;
> -	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> -
>   	/* Match hardware reset default of posted mode */
>   	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
>   			OMAP_TIMER_CTRL_POSTED);

