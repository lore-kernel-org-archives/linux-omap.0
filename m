From: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Subject: RE: [PATCH] ARM: OMAP4: cpuidle: fix: call cpu_cluster_pm_exit
 conditionally
Date: Thu, 29 Aug 2013 15:20:18 +0000
Message-ID: <902E09E6452B0E43903E4F2D568737AB35C674@DNCE04.ent.ti.com>
References: <1377598250-2355-1-git-send-email-murzin.v@gmail.com>,<87sixvw2n5.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56565 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab3H2PUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 11:20:53 -0400
In-Reply-To: <87sixvw2n5.fsf@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Vladimir Murzin <murzin.v@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

Hi Vladimir, Kevin

On 08/27/2013 06:54 PM, Kevin Hilman wrote:
> Vladimir Murzin <murzin.v@gmail.com> writes:
>
>> We call cpu_cluster_pm_enter for dev->cpu == 0 only, but
>> cpu_cluster_pm_exit called without that check.
>>
>> Because of that unhandled page fault may happen:
>>

[...]

>>
>> It is supposed that sar_base is initialized in irq_save_context, which
>> is called on CPU_CLUSTER_PM_ENTER notification. If this notification
>> has been missed and CPU_CLUSTER_PM_EXIT is received sar_base is NULL.
>>
>> Fix it by calling CPU_CLUSTER_PM_{ENTER,EXIT} under the same condition.

Could you check, if revert of the following patch will solve the issue, pls?
commit e7457253494fff660a72bc0cedeee97491ccd173
"ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"

>>
>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>
> Good catch.

Yes, but It seems, that CPUIdle logic is unclear for OAMP4 .
The above issue may happen if CPU1 enter/exit LP while CPU0:
- not enter at all (somewhere inside "coupled" core);
- still entering LP (somewhere before call to omap4_enter_lowpower());

The question is - Should first CPUx, who exited from LP(C3) state,
restore Cluster context, or it should be done by CPU0 only?
(on OMAP4 CPUs may return from C3 async).


>
> Acked-by: Kevin Hilman <khilman@linaro.org>
>
>> ---
>>   arch/arm/mach-omap2/cpuidle44xx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>> index c443f2e..4c8982a 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -143,7 +143,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>>   	 * Call idle CPU cluster PM exit notifier chain
>>   	 * to restore GIC and wakeupgen context.
>>   	 */
>> -	if ((cx->mpu_state == PWRDM_POWER_RET) &&
>> +	if (dev->cpu == 0 && (cx->mpu_state == PWRDM_POWER_RET) &&
>>   		(cx->mpu_logic_state == PWRDM_POWER_OFF))
>>   		cpu_cluster_pm_exit();
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

