From: Kevin Hilman <khilman@ti.com>
Subject: Re: !CONFIG_OMAP_32K_TIMER on OMAP4/panda
Date: Fri, 13 May 2011 14:53:23 +0200
Message-ID: <87boz6g3ss.fsf@ti.com>
References: <BANLkTi=YdcHp4mxcZ1MtG8m5st4zeSY=gg@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0374D103A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52849 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758916Ab1EMMx2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 08:53:28 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so3044379fxm.39
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 05:53:26 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0374D103A2@dbde02.ent.ti.com>
	(Hemant Pedanekar's message of "Sun, 8 May 2011 10:29:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: Rabin Vincent <rabin@rab.in>, linux-omap <linux-omap@vger.kernel.org>

Hi Hemant,

"Pedanekar, Hemant" <hemantp@ti.com> writes:

> Hello,
>
> linux-omap-owner@vger.kernel.org wrote on Saturday, May 07, 2011 10:21 PM:
>
>> On a linux-next kernel built for the Pandaboard, disabling
>> CONFIG_OMAP_32K_TIMER makes the kernel use the gptimer as the
>> clocksource, but this appears to be non-functional.  Judging from the
>> all-zeros printk timings and the fact the "sleep 1" hangs indefinitely,
>> it looks like the clocksource reads are always zero.
>> 
>> Boot log below and .config attached.  Ideas?
>> 
>> [    0.000000] Linux version 2.6.39-rc6-next-20110506+ (rabin@debian)
> [...]
>> [    0.000000] Freeing init memory: 112K
>
> This looks similar to the issue I observed on TI816X with 32K timer disabled.
>
> I have created following patch (currently a tempfix) for making timekeeping work 
> with MPU timer selected (other option is to use ".flags = HWMOD_INIT_NO_RESET" 
> in hwmod data for the timer used as clocksource):
>
> commit 77cce922c00ced4407776cc0a1d84cee40b7da90
> Author: Hemant Pedanekar <hemantp@ti.com>
> Date:   Thu Apr 28 12:59:24 2011 +0530
>
>     dmtimer: Initialize the hwmod for timer used as clocksource
>     
>     Since dmtimer driver still doesn't use hwmods, the 2nd timer used as clocksource
>     is not set up. 

The driver will never be the one to init the hwmod, it's up to device
level code to do that, so your approach is the right one.

> This results into timekeepoing failure when the timer used as
>     clocksource gets reset during hwmod setup.
>     
>     To prevent this, explicitly call omap_hwmod_setup_one() for timer used as
>     clocksource.
>     
>     Note that is is aplpicable when NOT using 32k timer which is the case for

typo: applicable

>     TI816X. For other configurations, this code will not be executed unless 32K
>     timer is explicitly disabled.

Also, you can fix up this changelog to say it's not only for 816x, but
for any case where the MPU timer is the clocksource.

>     Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index 3b9cf85..290fbfa 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -229,6 +229,11 @@ static void __init omap2_gp_clocksource_init(void)
>  		"%s: failed to request dm-timer\n";
>  	static char err2[] __initdata = KERN_ERR
>  		"%s: can't register clocksource!\n";
> +	char clocksource_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
> +
> +	/* XXX: This may not be always true, we might get different timer */
> +	sprintf(clocksource_hwmod_name, "timer%d", gptimer_id + 1);

Do you have ideas to make an upstream fix for this?  As you already
notied, this can't work in the general case (and will fail today on
beagle where gptimer_id gets set to 12.)

Kevin

> +	omap_hwmod_setup_one(clocksource_hwmod_name);
>  
>  	gpt = omap_dm_timer_request();
>  	if (!gpt)
>
>    Hemant--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
