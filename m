From: Etienne Le Sueur <elesueur@cse.unsw.edu.au>
Subject: Re: cpuidle omap 4430, some clarifications please?
Date: Mon, 10 Jan 2011 20:33:14 +1100
Message-ID: <4D2AD25A.2070504@cse.unsw.edu.au>
References: <4D2A939A.6070602@cse.unsw.edu.au> <ee926018c07c96ae278aefe24048baf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lemon.ertos.nicta.com.au ([203.143.174.143]:40346 "EHLO
	lemon.ken.nicta.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1AJJdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 04:33:22 -0500
In-Reply-To: <ee926018c07c96ae278aefe24048baf7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org



On 10/01/11 6:41 PM, Santosh Shilimkar wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Etienne Le Sueur
>> Sent: Monday, January 10, 2011 10:36 AM
>> To: linux-omap@vger.kernel.org
>> Subject: cpuidle omap 4430, some clarifications please?
>>
>> Hello,
>>
>> I'm using linux-2.6.35.3 on a pandaboard taking power measurements
>> in different idle states (I've written a userspace governor for
>> cpuidle).
>>
>> It seems like the code which is supposed to put the cores in deep
>> sleep never actually gets called, see code below with my comments...
>>
>> Taken from arch/arm/mach-omap2/cpuidle44xx.c, omap4_enter_idle,
>> which gets called by cpuidle:
>>
>> ===============
>>
>>       /*
>>        * Do only WFI for non-boot CPU(aux cores)
>>        */
>>       if (dev->cpu) {
>>           wmb();
>>           do_wfi();
>>           goto return_sleep_time;
>>       }
>>
>> So on OMAP 4430, CPU1 never goes deeper than WFI?
>>
>>       /*
>>        * Do only a WFI as long as CPU1 is online
>>        */
>>       if (num_online_cpus()>  1) {
>>           wmb();
>>           do_wfi();
>>           goto return_sleep_time;
>>       }
>>
>> So while CPU1 is online (it never goes offline due to the above
>> code) CPU0 will never go deeper than WFI?
>>
>>       /*
>>        * Hold on till CPU1 hits OFF
>>        */
>>       cpu1_state = pwrdm_read_pwrst(cpu1_pd);
>>       if (cpu1_state != PWRDM_POWER_OFF) {
>>           wmb();
>>           do_wfi();
>>           goto return_sleep_time;
>>       }
>>
>> It seems like CPU1 will never 'hit off' ?
>>
>>       if (cx->type>  OMAP4_STATE_C1)
>>           clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>> &cpu_id);
>>
>> #ifdef CONFIG_PM_DEBUG
>>       pwrdm_pre_transition();
>> #endif
>>
>> The code below never gets called, therefore neither CPU0, CPU1 nor
>> the MPU go into a deeper sleep state?
>>
>>       pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
>>       omap4_set_pwrdm_state(mpu_pd, cx->mpu_state);
>>
>>       omap4_set_pwrdm_state(core_pd, cx->core_state);
>>
>>       omap4_enter_sleep(dev->cpu, cx->cpu0_state);
>>
>> =================
>>
>> Can someone clarify for me?
>>
> Yes.
> Simple rule is, no low power states are targeted when both CPUs
> are online. The C-states gets targeted only when secondary
> CPU gets offline through hotplug infrastrcutre. CPU1 hits
> OFF mode through hot-plug path and not via idle.
>
> With this CPU1 hits OFF state, and IDLE thread running
> on master CPU can hit deeper low power states. It's more of
> hardware restriction what is there on OMAP4.
>
Can you elaborate on the hardware restrictions? It seems strange to me that there would be this sort of limitation on an SoC that is designed 
for low-power.
> To put it in slightly simpler terms,
>
> In SMP mode, no active PM is exercised in IDLE and
> gets triggered when secondary cores are out of the system.
>
> Hope this clarifies.
>
> Regards,
> Santosh
