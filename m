From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/05] OMAP3: CPUidle driver
Date: Sat, 18 Oct 2008 16:18:56 +0200
Message-ID: <48F9F050.3040706@deeprootsystems.com>
References: <00ab01c92de9$76890190$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:2755 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYJSJ0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Oct 2008 05:26:18 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1394053fkq.5
        for <linux-omap@vger.kernel.org>; Sun, 19 Oct 2008 02:26:15 -0700 (PDT)
In-Reply-To: <00ab01c92de9$76890190$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Thursday, October 09, 2008 8:15 PM
>> To: Rajendra Nayak
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 00/05] OMAP3: CPUidle driver
>>
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>
>>>> This patch set implements Cpuidle driver for OMAP3 platforms. It is
>>>> validated on the 3430SDP (using the omap_3430sdp_min_defconfig) and
>>>> applies on the pm-20081006 branch.
>>> Excellent.  Thank you.  I'll pull into pm-20081006 today.
>>>
>>> One question: You have C6 to hit chip-off, but it is never enabled.
>>> Has this been tested?  Enabling it allows me to hit chip OFF, but it
>>> never comes back from OFF-mode.  I will push some patches 
>> to make this
>>> work with /sys/power/enable_off_mode.
>> I got this to work on custom HW, but not on 3430SDP.  Can you confirm
>> whether or not you can use C6 on 3430SDP?  Off-in-idle without CPUidle
>> seems to work, but not with CPUidle + C6.
>>
>>
> 
> Hi Kevin,
> 
> With just this patch below I could see that I was able to hit sysoff even
> with CPUidle.
> 
> Doing this I could see the SYSOFF LED toggle..
> # echo -n 1 > /sys/power/clocks_off_while_idle
> # echo -n 1 > /sys/power/sleep_while_idle
> # echo -n 1 > /sys/power/voltage_off_while_idle
> # echo -n 1 > /sys/power/enable_off_mode
> 
> And doing this stops the toggle..
> # echo -n 0 > /sys/power/enable_off_mode
> 
> Was there any other issue you saw with CPUidle + C6?
> 

Yes, I was seeing hangs as soon as I enabled off-mode.

I'm currently on the road and when I get home (Wed.) I won't have access 
  to an SDP for a while, so I'll trust you on this one.  Maybe I need an 
updated u-boot on my SDP?

Kevin

>  arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-14 14:46:21.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-14 14:46:24.000000000 +0530
> @@ -191,7 +191,7 @@ void omap_init_power_states(void)
>  				CPUIDLE_FLAG_CHECK_BM;
>  
>  	/* C6 . MPU OFF + Core OFF */
> -	omap3_power_states[OMAP3_STATE_C6].valid = 0;
> +	omap3_power_states[OMAP3_STATE_C6].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
>  	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
>  	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
> 
> 
>>> Some minor problems that I will fixup when rebasing to the next pm
>>> branch:
>>>
>>>  - You removed C0, but all the comments still refer to it
>>>  - /sys/power/enable_off_mode doesn't affect off-mode states
>>>    in CPUidle
>>>
>>> patch 1:
>>>  - I still don't like the #ifdefs for the init sequence.
>>>
>>> patch 2:
>>>  - checkpatch warning
>>>
>>> Kevin
>>>
>>>> The following C states are defined and used 
>>>>
>>>>  *      C0 . System executing code (Not an idle state)
>>>>  *      C1 . MPU WFI + Core active
>>>>  *      C2 . MPU CSWR + Core active
>>>>  *      C3 . MPU OFF + Core active
>>>>  *      C4 . MPU CSWR + Core CSWR
>>>>  *      C5 . MPU OFF + Core CSWR
>>>>  *      C6 . MPU OFF + Core OFF
>>>>
>>>> CPUidle support is not enabled by default in any of the 
>> defconfigs and hence has to enabled seperately 
>>>> if you plan to test these patches.
>>>>
>>>> CPUIdle ---> [*] CPU idle PM support
>>>>
>>>> regards,
>>>> Rajendra
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 


