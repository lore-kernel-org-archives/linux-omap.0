From: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Subject: RE: [PATCH] ARM: OMAP4: cpuidle: fix: call cpu_cluster_pm_exit
 conditionally
Date: Thu, 29 Aug 2013 16:03:47 +0000
Message-ID: <902E09E6452B0E43903E4F2D568737AB35C6CD@DNCE04.ent.ti.com>
References: <1377598250-2355-1-git-send-email-murzin.v@gmail.com>,
 <87sixvw2n5.fsf@linaro.org>
 <902E09E6452B0E43903E4F2D568737AB35C674@DNCE04.ent.ti.com>,
 <521F6812.7080305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <521F6812.7080305@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, Vladimir Murzin <murzin.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi 

On 08/29/2013 06:26 PM, Santosh Shilimkar wrote:> On Thursday 29 August 2013 11:20 AM, Strashko, Grygorii wrote:
>> Hi Vladimir, Kevin
>>
>> On 08/27/2013 06:54 PM, Kevin Hilman wrote:
>>> Vladimir Murzin <murzin.v@gmail.com> writes:
>>>
>>>> We call cpu_cluster_pm_enter for dev->cpu == 0 only, but
>>>> cpu_cluster_pm_exit called without that check.
>>>>
>>>> Because of that unhandled page fault may happen:
>>>>
>>
>> [...]
>>
>>>>
>>>> It is supposed that sar_base is initialized in irq_save_context, which
>>>> is called on CPU_CLUSTER_PM_ENTER notification. If this notification
>>>> has been missed and CPU_CLUSTER_PM_EXIT is received sar_base is NULL.
>>>>
>>>> Fix it by calling CPU_CLUSTER_PM_{ENTER,EXIT} under the same condition.
>>
>> Could you check, if revert of the following patch will solve the issue, pls?
>> commit e7457253494fff660a72bc0cedeee97491ccd173
>> "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"
>>
>>>>
>>>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>>>
>>> Good catch.
>>
>> Yes, but It seems, that CPUIdle logic is unclear for OAMP4 .
>> The above issue may happen if CPU1 enter/exit LP while CPU0:
>> - not enter at all (somewhere inside "coupled" core);
>> - still entering LP (somewhere before call to omap4_enter_lowpower());
>>
>> The question is - Should first CPUx, who exited from LP(C3) state,
>> restore Cluster context, or it should be done by CPU0 only?
>> (on OMAP4 CPUs may return from C3 async).
>>
>>
> Looks like I missed this thread completely. The cluster restore
> on purpose was not tied to any CPU considering some OMAPs may
> support such thing in future but for couple idle we anyway
> synchronize the CPUs at the idle exit so doing either way should be fine.
> 
> I think the sar_base bug should be fixed regardless of whether we
> change idle code.

Thanks for clarification. 

I know about couple CPU sync, but .. CPUIdle is so fragile :)

So wouldn't it be good to fix/protect omap-wakeupgen.c/irq_sar_clear() too.

Like:
	if (!sar_base)
		return;

Also, without this patch cpu_cluster_pm_exit() will be called twice by each CPU.

No questions to this patch any more.

> 
> Regards,
> Santosh

Regards,
-grygorii
