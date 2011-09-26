From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Mon, 26 Sep 2011 11:39:00 -0700
Message-ID: <87mxdrcfnf.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58398 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601Ab1IZSjH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 14:39:07 -0400
Received: by yxi19 with SMTP id 19so6098881yxi.14
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 11:39:04 -0700 (PDT)
In-Reply-To: <CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Sat, 24 Sep 2011 16:11:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> Santosh, Kevin,
>
> [...]
>>>> After that, pm_runtime_put_sync() is called, which will trigger th=
e
>>>> driver's ->runtime_suspend callback. =C2=A0The ->runtime_suspend()=
 callback
>>>> checks bank->mod_usage as well, and if zero, doesn't do anything
>>>> (notably, it doesn't disable debounce clocks.)
>>> I need some clarification in reproducing/testing the fix on OMAP343=
0SDP.
>>> The first thing I am trying to verify is the code flow of suspend.
>>>
>>> 1) With no debounce clock enabled, when I enable UART timeouts, I
>>> automatically see
>>> system going to retention. That is I don't have to type echo mem >
>>> /sys/power/state
>>> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>>> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>>> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>>>
>>> 2) I am do not see the print in omap_gpio_suspend/resume(), but I s=
ee
>>> the print in
>>> *_prepare_for_idle()/*_resume_after_idle().
>>>
>> Hmmm,
>>
>> This is mostly happening because you are missing a below
>> fix from Kevin in the branch you are testing with.
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg54927.html
>> {OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers}
>>
>> If you rebase, your branch against 3.1-rc6, you should already
>> have this fix. Commit {126caf1376e7}
> Yes, this patch was missing in Kevin's branch and was
> causing the suspend issue.
>
> As pointed out by Kevin, debounce clock was not getting disabled.
> In my testing I was somehow grepping CORE power domain instead
> of PER power domain and hence missed it. The fix for the debounce
> clock issue is at the end of the email.
>
> - Have re-based the for_3.2/gpio-cleanup branch against 3.1-rc6.

Not needed.   Just merge with v3.1-rc6 when testing.

> - Dropped [PATCH 26/26] gpio/omap: add dbclk aliases for all gpio mod=
ules
> as suggested by Kevin since it's already taken care by hwmod.

good

> - Added the debounce clock fix in the end.

Thanks.  Glad you found and fixed it.

Rather than add this patch as a fix at the end, I prefer if the problem
is fixed in the original patches that added/created the problem.

Kevin


> With above, PER is hitting low power state in Suspend and Idle path.
>
> Have pushed a branch at below URL with mentioned changes.
> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
> for_3.2/kevin/gpio-cleanup
>
> Regards,
> Tarun
>
> From 5d9a97197ea5426fc79b7a47dd0fd9c6b6ebbbba Mon Sep 17 00:00:00 200=
1
> From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Date: Sat, 24 Sep 2011 13:32:32 +0530
> Subject: [PATCH] gpio/omap: fix debounce clock handling
>
> GPIO debounce clock can gate the PER power domain transition
> and needs to be disabled in GPIO driver suspend.
>
> The debounce clock is not getting disabled in runtime_suspend
> callback because of an un-necessary bank->mod_usage check.
> In omap_gpio_suspend/resume too, there is no need to do
> any operation if the gpio bank is not used.
>
> Remove the un-necessary bank->mod_usage check from
> suspend callbacks.
>
> Thanks to Kevin Hilman for pointing out this issue.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c597303..349e774 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1107,6 +1107,9 @@ static int omap_gpio_suspend(struct device *dev=
)
>  	void __iomem *wake_status;
>  	unsigned long flags;
>
> +	if (!bank->mod_usage || !bank->loses_context)
> +		return 0;
> +
>  	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
>  		return 0;
>
> @@ -1128,6 +1131,9 @@ static int omap_gpio_resume(struct device *dev)
>  	void __iomem *base =3D bank->base;
>  	unsigned long flags;
>
> +	if (!bank->mod_usage || !bank->loses_context)
> +		return 0;
> +
>  	if (!bank->regs->wkup_en || !bank->saved_wakeup)
>  		return 0;
>
> @@ -1151,9 +1157,6 @@ static int omap_gpio_runtime_suspend(struct dev=
ice *dev)
>  	int j;
>  	unsigned long flags;
>
> -	if (!bank->mod_usage)
> -		return 0;
> -
>  	spin_lock_irqsave(&bank->lock, flags);
>  	/*
>  	 * If going to OFF, remove triggering for all
> @@ -1199,9 +1202,6 @@ static int omap_gpio_runtime_resume(struct devi=
ce *dev)
>  	int j;
>  	unsigned long flags;
>
> -	if (!bank->mod_usage)
> -		return 0;
> -
>  	spin_lock_irqsave(&bank->lock, flags);
>  	for (j =3D 0; j < hweight_long(bank->dbck_enable_mask); j++)
>  		clk_enable(bank->dbck);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
