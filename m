From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V4] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
Date: Wed, 9 Oct 2013 09:23:44 -0400
Message-ID: <525558E0.3040901@ti.com>
References: <1379520162-31932-1-git-send-email-r.sricharan@ti.com>
 <524D44B9.30208@ti.com> <20131008214523.GU8313@atomide.com>
 <525481A2.4020900@ti.com> <525556DD.7040200@ti.com> <5255575A.1040002@ti.com>
 <52555817.7070703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52555817.7070703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sricharan R <r.sricharan@ti.com>
Cc: nm@ti.com, mark.rutland@arm.com, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, marc.zyngier@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 October 2013 09:20 AM, Sricharan R wrote:
> On Wednesday 09 October 2013 06:47 PM, Santosh Shilimkar wrote:
>> On Wednesday 09 October 2013 09:15 AM, Sricharan R wrote:
>>> Santosh,
>>>
>>> On Wednesday 09 October 2013 03:35 AM, Santosh Shilimkar wrote:
>>>> On Tuesday 08 October 2013 05:45 PM, Tony Lindgren wrote:
>>>>> * Sricharan R <r.sricharan@ti.com> [131003 03:27]:
>>>>>> On Wednesday 18 September 2013 09:32 PM, Sricharan R wrote:
>>>>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>>>>> @@ -52,7 +52,6 @@
>>>>>>>  			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>>>>>>>  			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>>>>>>>  			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
>>>>>>> -		clock-frequency = <6144000>;
>>>>>>>  	};
>>>>>>>  
>>>>>>>  	gic: interrupt-controller@48211000 {
>>>>> Can the above be done later on in a separate clean-up patch?
>>>>> If so I can drop that part as that removes a dependency to the
>>>>> .dts patches queued by Benoit.
>>>>>
>>>> This can be applied separately. 
>>>>
>>>>  
>>>>>>> --- a/arch/arm/mach-omap2/omap-smp.c
>>>>>>> +++ b/arch/arm/mach-omap2/omap-smp.c
>>>>>>> @@ -41,6 +41,8 @@
>>>>>>>  
>>>>>>>  u16 pm44xx_errata;
>>>>>>>  
>>>>>>> +extern unsigned long arch_timer_freq;
>>>>>>> +
>>>>>>>  /* SCU base address */
>>>>>>>  static void __iomem *scu_base;
>>>>>>>  
>>>>> No externs in *.c files please, checkpatch.pl and sparse should warn
>>>>> about this.
>>>>>
>>>>>>  Are you planning to pull this patch and the below $subject patch as well? They are
>>>>>>  acked and tested.
>>>>>>
>>>>>>  ARM: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency
>>>>>>
>>>>>>   http://www.spinics.net/lists/linux-omap/msg97281.html
>>>>> The 20MHz patch I've applied, just noticed the above things
>>>>> when was about to apply this.
>>>>>
>>>> Now re-looking at the patch, I think this extern stuff can be and
>>>> should be avoided. It needs order change though like below. Not
>>>> tested but should work.
>>>>
>>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>>> index fa74a06..c8d8308 100644
>>>> --- a/arch/arm/mach-omap2/timer.c
>>>> +++ b/arch/arm/mach-omap2/timer.c
>>>> @@ -631,10 +631,9 @@ void __init omap4_local_timer_init(void)
>>>>  #ifdef CONFIG_SOC_OMAP5
>>>>  void __init omap5_realtime_timer_init(void)
>>>>  {
>>>> -	omap4_sync32k_timer_init();
>>>>  	realtime_counter_init();
>>>> -
>>>>  	clocksource_of_init();
>>>> +	omap4_sync32k_timer_init();
>>>>  }
>>>>  #endif /* CONFIG_SOC_OMAP5 */
>>>>  
>>>> Then, the CNTFREQ programming needs to be moved to
>>>> realtime_counter_init(). It should be actually part of that
>>>> first place instead of timer_init().
>>>>
>>>> On secondary CPU then a simple asm accessor can
>>>> read the CNTFREQ and pass that to SMC.
>>> Sorry,  I did not quite get you here. You mean an asm accessor to
>>>  the read the variable that is set in timer.c ?
>>>
>> Reading CNTFREQ CP15 directly....
>>
>   Sorry, Still not clear. CNTFREQ is per-cpu register. So when
>  the secondary cpu init happens on CPU1, then you mean we will have
>  to read it from CPU0 register and pass it for secondary ?
> 
Create a function within timer.c which sets the freq for a given CPU.
On Boot CPU you figure out frequency and then just use that static
variable.

Regards,
Santosh
