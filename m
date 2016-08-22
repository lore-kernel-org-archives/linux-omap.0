From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v4 1/5] mfd: tps65217: Add support for IRQs
Date: Mon, 22 Aug 2016 12:02:40 +0200
Message-ID: <534cdc5b-42b8-14e4-e957-a0695c301056@grinn-global.com>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-2-m.niestroj@grinn-global.com>
 <576D0437.1020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <576D0437.1020800-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

ping

On 24.06.2016 11:58, Grygorii Strashko wrote:
> On 06/20/2016 01:50 PM, Marcin Niestroj wrote:
>> Add support for handling IRQs: power button, AC and USB power state
>> changes. Mask and interrupt bits are shared within one register, which
>> prevents us to use regmap_irq implementation. New irq_domain is
>> created in
>> order to add interrupt handling for each tps65217's subsystem. IRQ
>> resources have been added for charger subsystem to be able to notify
>> about
>> AC and USB state changes.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> Changes v3 -> v4 (suggested by Grygorii):
>>   * Add irq_set_parent() during irq init
>>   * Remove hardcoded IRQ trigger type, rely on DT bindings instead
>>
>> Changes v2 -> v3 (suggested by Lee):
>>   * Alphabetical reorder of includes
>>   * Rename enum tps65217_irqs -> tps65217_irq_type, so we won't confuse
>>     it with structure object with the same name.
>>   * Fix inconsistent order of irq_enable and irq_disable
>>   * Remove redundant 'else' when returning from tps65217_irq_thread
>>
>> Changes v1 -> v2: none
>>
>>   drivers/mfd/Kconfig          |   1 +
>>   drivers/mfd/tps65217.c       | 195
>> +++++++++++++++++++++++++++++++++++++++++--
>>   include/linux/mfd/tps65217.h |  12 +++
>>   3 files changed, 200 insertions(+), 8 deletions(-)
>>
>
> Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>
>
>

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
