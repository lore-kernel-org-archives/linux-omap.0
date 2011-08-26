From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 07/12] OMAP: dmtimer: pm_runtime support
Date: Fri, 26 Aug 2011 22:04:00 +0530
Message-ID: <4E57CAF8.3030109@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>	<1310731501-13078-8-git-send-email-tarun.kanti@ti.com>	<4E57BB61.2010804@ti.com> <87liug3zw0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59283 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755310Ab1HZQeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 12:34:08 -0400
Received: by mail-yi0-f54.google.com with SMTP id 19so2542510yib.27
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 09:34:07 -0700 (PDT)
In-Reply-To: <87liug3zw0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>

On Friday 26 August 2011 09:53 PM, Kevin Hilman wrote:
> Santosh<santosh.shilimkar@ti.com>  writes:
>
>> On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
>>> Add pm_runtime feature to dmtimer whereby _get_sync() is called within
>>> omap_dm_timer_enable(), _put_sync() is called in omap_dm_timer_disable().
>>>
>>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>>> [p-basak2@ti.com: added pm_runtime logic in probe()]
>>> Signed-off-by: Partha Basak<p-basak2@ti.com>
>>> Reviewed-by: Varadarajan, Charulatha<charu@ti.com>
>>> Acked-by: Cousson, Benoit<b-cousson@ti.com>
>>> ---
>>>    arch/arm/plat-omap/dmtimer.c              |   31 +++++++---------------------
>>>    arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
>>>    2 files changed, 8 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
>>> index 54564e9..0560248 100644
>>> --- a/arch/arm/plat-omap/dmtimer.c
>>> +++ b/arch/arm/plat-omap/dmtimer.c
>>> @@ -38,6 +38,7 @@
>>>    #include<linux/io.h>
>>>    #include<linux/slab.h>
>>>    #include<linux/err.h>
>>> +#include<linux/pm_runtime.h>
>>>
>>>    #include<plat/dmtimer.h>
>>>
>>> @@ -193,33 +194,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
>>>
>>>    void omap_dm_timer_enable(struct omap_dm_timer *timer)
>>>    {
>>> -	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>>> -
>>> -	if (timer->enabled)
>>> -		return;
>>> -
>>> -	if (!pdata->needs_manual_reset) {
>>> -		clk_enable(timer->fclk);
>>> -		clk_enable(timer->iclk);
>>> -	}
>>> -
>>> -	timer->enabled = 1;
>>> +	pm_runtime_get_sync(&timer->pdev->dev);
>>>    }
>>>    EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>>>
>>>    void omap_dm_timer_disable(struct omap_dm_timer *timer)
>>>    {
>>> -	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>>> -
>>> -	if (!timer->enabled)
>>> -		return;
>>> -
>>> -	if (!pdata->needs_manual_reset) {
>>> -		clk_disable(timer->iclk);
>>> -		clk_disable(timer->fclk);
>>> -	}
>>> -
>>> -	timer->enabled = 0;
>>> +	pm_runtime_put_sync(&timer->pdev->dev);
>> Better to use pm_runtime_put_sync_suspend() to make
>> it irq safe.
>
> Actually, better to just use the async version: pm_runtime_put()
>
> Why does it need to be IRQ safe?
>
>>>    }
>>>    EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
>>>
>>> @@ -461,7 +442,7 @@ int omap_dm_timers_active(void)
>>>    	struct omap_dm_timer *timer;
>>>
>>>    	list_for_each_entry(timer,&omap_timer_list, node) {
>>> -		if (!timer->enabled)
>>> +		if (!timer->reserved)
>>>    			continue;
>>>
>>>    		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG)&
>>> @@ -536,6 +517,10 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>>>    	timer->irq = irq->start;
>>>    	timer->pdev = pdev;
>>>
>>> +	/* Skip pm_runtime_enable for OMAP1 */
>>> +	if (!pdata->needs_manual_reset)
>>> +		pm_runtime_enable(&pdev->dev);
>>> +
>> Here too.
>> /s /pm_runtime_enable /pm_runtime_irq_safe
>
> I think you mean adding _irq_safe, not removing the _enable?
>
> I disagree with the IRQ-safe part.  Let's avoid using IRQ-safe unless
> *really* needed, and justified.
>
The reason may not be satisfactory, bust some the client drivers
are calling the timer APIs from IRQ context that created regressions
on internal trees. That's was the only reason behind my comment.

On other hand, none of this client drivers are supported in
mainline, so my comment from mainline point of is void.

Regards
Santosh
