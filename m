From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2] reboot: Backup orderly_poweroff
Date: Tue, 19 Jan 2016 16:02:30 +0530
Message-ID: <569E10BE.2020809@ti.com>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com> <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com> <56977BA7.702@ti.com>
 <20160114112354.GA17869@gmail.com>
 <20160114132527.575e0f20@lxorguk.ukuu.org.uk>
 <20160115101459.GB23349@gmail.com> <5698F420.2010500@ti.com>
 <20160119090623.GA29678@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160119090623.GA29678@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, edubezval@gmail.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, joel@jms.id.au, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, dyoung@redhat.com, josh@joshtriplett.org, mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

Hi Ingo,

On Tuesday 19 January 2016 02:36 PM, Ingo Molnar wrote:
>
> * Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>
>> On 01/15/2016 12:14 PM, Ingo Molnar wrote:
>>>
>>> * One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:
>>>
>>>>> If kernel_power_off() is called then the system should power off. No ifs and
>>>>> whens.
>>>>
>>>> Even if it doesn't the watchdog should kill it.
>>>>
>>>> That is broken on some platforms on the watchdog side as the
>>>> watchdog shuts down during our power off callbacks - because the system
>>>> firmware is too stupid to reset the watchdog as it powers back up (so
>>>> keeps rebooting).
>>>>
>>>> If you watchdog and firmware function properly you shouldn't even have to
>>>> care if you crash during the kernel power off.
>>>
>>> That's a good point as well - if the system is 'stuck' for some notion of stuck,
>>> then watchdog drivers can help.
>>>
>>
>> Seems ARM doesn't have endless loop implemented in machine_power_off() - so,
>> not too much chances for Watchdog to fire.
>> void machine_power_off(void)
>> {
>> 	local_irq_disable();
>> 	smp_send_stop();
>>
>> 	if (pm_power_off)
>> 		pm_power_off();
>>
>> 	--- endless loop ?
>> 	--- or restart ?
>> }
>> [and even if it will be there - 20-30sec is usual timeout for Watchdog and this
>> enough time to burn the system in case of thermal emergency poweroff :(]
>>
>>> Here it's unclear whether user-space even called the sys_reboot() system call.
>>>
>>
>> That's true - original log [1] has
>> Nov 30 11:19:22 [    5.942769] thermal thermal_zone3: critical temperature reached(108 C),shutting down
>> [...]
>> Nov 30 11:19:24 [    7.387900] ahci 4a140000.sata: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part ccc apst
>> Nov 30 11:19:24 INIT: Switching to runlevel: 0
>> Nov 30 11:19:24 INIT: Sending processes the TERM signal
>>
>> and there are no
>> [  220.004522] reboot: Power down
>>
>>
>> Also, It's not the first time this part of code is discussed (thermal emergency poweroff) [2],
>> so the good question, as for me, is it really required and safe to use orderly_poweroff() in
>> case of thermal emergency poweroff ([3] as example)?
>>
>> In general, this kind of use case can be simulated using SysRq on any arch
>> - [3.290034] Freeing unused kernel memory: 492K (c0a67000 - c0ae2000)
>>    INIT: version 2.88 booting
>>    Starting udev
>> ^^ The issue most probably might happens when system in the process of loading modules
>> So, once modules loading process is started - fire Sysrq "poweroff(o)"
>
> So I'd say emergency poweroff should be named accordingly - and the
> orderly_poweroff() name suggest anything but an emergency, right?
>
> So I'd be fine with the following:
>
>   - introduce a poweroff_emergency() core kernel function call
>
>   - use it in drivers where it's justified
>
>   - poweroff_emergency() has a configurable timeout value. If the timeout value is
>     set to 0 then it powers the system off immediately.
>
> Functionally it would be mostly equivalent to your current patch (except the '0'
> immediate poweroff functionality).

Thanks for the suggestion. I will work on this and get back.

Best Regards,
Keerthy

>
> Thanks,
>
> 	Ingo
>
