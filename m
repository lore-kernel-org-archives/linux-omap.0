From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v14 REPOST 07/12] OMAP: dmtimer: pm_runtime support
Date: Fri, 26 Aug 2011 09:23:43 -0700
Message-ID: <87liug3zw0.fsf@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-8-git-send-email-tarun.kanti@ti.com>
	<4E57BB61.2010804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E57BB61.2010804@ti.com> (Santosh's message of "Fri, 26 Aug 2011
	20:57:29 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Santosh <santosh.shilimkar@ti.com> writes:

> On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
>> Add pm_runtime feature to dmtimer whereby _get_sync() is called within
>> omap_dm_timer_enable(), _put_sync() is called in omap_dm_timer_disable().
>>
>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>> [p-basak2@ti.com: added pm_runtime logic in probe()]
>> Signed-off-by: Partha Basak<p-basak2@ti.com>
>> Reviewed-by: Varadarajan, Charulatha<charu@ti.com>
>> Acked-by: Cousson, Benoit<b-cousson@ti.com>
>> ---
>>   arch/arm/plat-omap/dmtimer.c              |   31 +++++++---------------------
>>   arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
>>   2 files changed, 8 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
>> index 54564e9..0560248 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -38,6 +38,7 @@
>>   #include<linux/io.h>
>>   #include<linux/slab.h>
>>   #include<linux/err.h>
>> +#include<linux/pm_runtime.h>
>>
>>   #include<plat/dmtimer.h>
>>
>> @@ -193,33 +194,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
>>
>>   void omap_dm_timer_enable(struct omap_dm_timer *timer)
>>   {
>> -	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>> -
>> -	if (timer->enabled)
>> -		return;
>> -
>> -	if (!pdata->needs_manual_reset) {
>> -		clk_enable(timer->fclk);
>> -		clk_enable(timer->iclk);
>> -	}
>> -
>> -	timer->enabled = 1;
>> +	pm_runtime_get_sync(&timer->pdev->dev);
>>   }
>>   EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>>
>>   void omap_dm_timer_disable(struct omap_dm_timer *timer)
>>   {
>> -	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>> -
>> -	if (!timer->enabled)
>> -		return;
>> -
>> -	if (!pdata->needs_manual_reset) {
>> -		clk_disable(timer->iclk);
>> -		clk_disable(timer->fclk);
>> -	}
>> -
>> -	timer->enabled = 0;
>> +	pm_runtime_put_sync(&timer->pdev->dev);
> Better to use pm_runtime_put_sync_suspend() to make
> it irq safe.

Actually, better to just use the async version: pm_runtime_put()

Why does it need to be IRQ safe?

>>   }
>>   EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
>>
>> @@ -461,7 +442,7 @@ int omap_dm_timers_active(void)
>>   	struct omap_dm_timer *timer;
>>
>>   	list_for_each_entry(timer,&omap_timer_list, node) {
>> -		if (!timer->enabled)
>> +		if (!timer->reserved)
>>   			continue;
>>
>>   		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG)&
>> @@ -536,6 +517,10 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>>   	timer->irq = irq->start;
>>   	timer->pdev = pdev;
>>
>> +	/* Skip pm_runtime_enable for OMAP1 */
>> +	if (!pdata->needs_manual_reset)
>> +		pm_runtime_enable(&pdev->dev);
>> +
> Here too.
> /s /pm_runtime_enable /pm_runtime_irq_safe

I think you mean adding _irq_safe, not removing the _enable?

I disagree with the IRQ-safe part.  Let's avoid using IRQ-safe unless
*really* needed, and justified.

Kevin

>>   	/* add the timer element to the list */
>>   	spin_lock_irqsave(&dm_timer_lock, flags);
>>   	list_add_tail(&timer->node,&omap_timer_list);
>> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
>> index 90a504a..53d5da6 100644
>> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
>> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
>> @@ -238,7 +238,6 @@ struct omap_dm_timer {
>>   	void __iomem *io_base;
>>   	unsigned long rate;
>>   	unsigned reserved:1;
>> -	unsigned enabled:1;
>>   	unsigned posted:1;
>>   	u8 func_offset;
>>   	u8 intr_offset;
>
> With above fixed, you can add,
>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Regards
> Santosh
