From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/5] ARM: dts: OMAP: Add timer nodes
Date: Thu, 25 Oct 2012 07:18:47 -0500
Message-ID: <50892E27.7070102@ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com> <1350496873-21337-2-git-send-email-jon-hunter@ti.com> <79CD15C6BA57404B839C016229A409A83EB49C1B@DBDE01.ent.ti.com> <50887315.2000509@ti.com> <79CD15C6BA57404B839C016229A409A83EB4A768@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46938 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2JYMS4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 08:18:56 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB4A768@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 10/25/2012 07:12 AM, Hiremath, Vaibhav wrote:
> On Thu, Oct 25, 2012 at 04:30:37, Hunter, Jon wrote:
>>
>> On 10/24/2012 01:17 PM, Hiremath, Vaibhav wrote:
>>> On Wed, Oct 17, 2012 at 23:31:09, Hunter, Jon wrote:
>>>> Add the 12 GP timers nodes present in OMAP2.
>>>> Add the 12 GP timers nodes present in OMAP3.
>>>> Add the 11 GP timers nodes present in OMAP4.
>>>> Add the 7 GP timers nodes present in AM33xx.
>>>>
>>>> Add documentation for timer properties specific to OMAP.
>>>>
>>>> Please note that for OMAP2/3 devices, there is only one interrupt controller
>>>> for the ARM CPU (which has the label "intc") and so globally define this as the
>>>> interrupt parent to save duplicating the interrupt parent for all device nodes.
>>>>
>>>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>>>> Vaibhav's original nodes adding information on which timers support a PWM
>>>> output.
>>>>
>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/arm/omap/timer.txt         |   29 ++++++
>>>>  arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++++++++
>>>>  arch/arm/boot/dts/omap2.dtsi                       |   86 ++++++++++++++++++
>>>>  arch/arm/boot/dts/omap2420.dtsi                    |    8 ++
>>>>  arch/arm/boot/dts/omap2430.dtsi                    |    8 ++
>>>>  arch/arm/boot/dts/omap3.dtsi                       |   96 ++++++++++++++++++++
>>>>  arch/arm/boot/dts/omap4.dtsi                       |   86 ++++++++++++++++++
>>>>  7 files changed, 374 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
>>>>
>>>
>>> Although I have not tested this version of patch series at my end, but 
>>> whole patch-series Looks ok to me.
>>>
>>> Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>
>>
>> Thanks. I made a couple cosmetic changes in V4 apart from the
>> "interrupt-parent" addition which we are now dropping. Care to ACK
>> patches 2-5 of V4?
>>
> 
> Jon,
> 
> Good news, I could able to spend some time today on Timer issue on Am33xx 
> and figure out what is going wrong there. The register context is loosing,
> which leads to failure of interrupt test cases.

Thanks!

> Below log describes more on this,
> 
> 
> [root@arago /]# echo 1 > /tmp/omap-test/timer/all
> [    9.156122] Testing 48042000.timer with 24000000 Hz clock ...
> [root@arago /]#
> [root@arago /]#
> [root@arago /]#
> [root@arago /]# [   11.505497] Timer read test PASSED! No errors, 100 loops
> [   11.511493] omap_dm_timer_set_int_enable:664: irq_ena - 0
> [   11.517277] omap_dm_timer_set_int_enable:670: irq_ena - 2
> [   11.523095] omap_timer_interrupt_test:120: irq_ena - 0 	[BOOOOOOOOM]
> [   12.521111] Timer interrupt test FAILED! No interrupt occurred in 1 sec
> 
> 
> I changed the Test code as below, and not with your Timer patches, I have 
> tested all the timers without any issues.
> 
> So for all patch series, 
> 
> Acked-Reviewed-&-Tested-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks!

> 
> Test code diff:
> ===============
> 
> diff --git a/timer_test.c b/timer_test.c
> index e502881..c87a830 100644
> --- a/timer_test.c
> +++ b/timer_test.c
> @@ -13,6 +13,7 @@
> 
>  #define OMAP1_NUM_TIMERS       8
>  #define OMAP2_NUM_TIMERS       11
> +#define AM33XX_NUM_TIMERS      7
>  #define OMAP_MAX_NUM_TIMERS    12
>  #define OMAP_TIMER_SRC_CLKS    2
>  #define TIMER_TIMEOUT          (msecs_to_jiffies(1000))
> @@ -113,6 +114,9 @@ static int omap_timer_interrupt_test(struct omap_dm_timer *gptimer)
> 
>         irq_data.gptimer = gptimer;
>         init_completion(&irq_data.complete);
> +
> +       omap_dm_timer_enable(gptimer);
> +
>         omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
>         omap_dm_timer_set_load_start(gptimer, 0, 0xffffff00);
> 
> @@ -128,6 +132,8 @@ static int omap_timer_interrupt_test(struct omap_dm_timer *gptimer)
> 
>         omap_dm_timer_stop(gptimer);
>         omap_dm_timer_set_int_enable(gptimer, 0);
> +       omap_dm_timer_disable(gptimer);
> +

Hmmm ... I am wondering if there is another bug lingering in the dmtimer
driver. Ideally, the context should be preserved by the driver.

>         free_irq(timer_irq, &irq_data);
> 
>         return r;
> @@ -141,6 +147,8 @@ static u32 omap_timer_num_timers(void)
>                 max_num_timers = OMAP1_NUM_TIMERS;
>         else if (cpu_is_omap34xx() && (omap_type() == OMAP2_DEVICE_TYPE_GP))
>                 max_num_timers = OMAP2_NUM_TIMERS + 1;
> +       else if (soc_is_am33xx())
> +               max_num_timers = AM33XX_NUM_TIMERS;

Thanks, I noticed that too when testing AM33xx.

Cheers
Jon
