From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Thu, 22 Mar 2012 11:36:04 -0700
Message-ID: <87fwd07aaz.fsf@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
	<4F69A872.50203@ti.com>
	<CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com>
	<4F6A04F3.6050306@linaro.org> <873991d3hs.fsf@ti.com>
	<4F6A5430.2090501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:49743 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756202Ab2CVSgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 14:36:07 -0400
Received: by mail-yw0-f45.google.com with SMTP id o21so2480651yho.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 11:36:06 -0700 (PDT)
In-Reply-To: <4F6A5430.2090501@linaro.org> (Daniel Lezcano's message of "Wed,
	21 Mar 2012 23:20:32 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linaro Dev <linaro-dev@lists.linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 03/21/2012 10:54 PM, Kevin Hilman wrote:
>> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>>
>>> On 03/21/2012 02:43 PM, Jean Pihet wrote:
>>>> On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
>>>> <santosh.shilimkar@ti.com>   wrote:
>>>>> Daniel,
>>>>>
>>>>> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>>>>>> This patchset is a proposition to improve a bit the code.
>>>>>> The changes are code cleanup and does not change the behavior of the
>>>>>> driver itself.
>>>>>>
>>>>>> A couple a things call my intention. Why the cpuidle device is set for cpu0 only
>>>>>> and why the WFI is not used ?
>>>>>>
>>>>>> Daniel Lezcano (7):
>>>>>>     ARM: OMAP4: cpuidle - Remove unused valid field
>>>>>>     ARM: OMAP4: cpuidle - Declare the states with the driver declaration
>>>>>>     ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>>>>>>     ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>>>>>>     ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
>>>>>>     ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>>>>>>     ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
>>>>>>       time
>>>>>>
>>>>> The series looks fine to me in general. This clean-up is applicable
>>>>> for OMAP3 cpuidle code as well.
>>>> Great!
>>>> However OMAP3 has a few specific things that cannot be removed as easily:
>>>> - the 'valid' flag is used because only certain combinations of power
>>>> domains states are possible,
>>>
>>> When I look the board-rx51 code I see:
>>>
>>> static struct cpuidle_params rx51_cpuidle_params[] = {
>>> 	/* C1 */
>>> 	{110 + 162, 5 , 1},
>>> 	/* C2 */
>>> 	{106 + 180, 309, 1},
>>> 	/* C3 */
>>> 	{107 + 410, 46057, 0},
>>> 	/* C4 */
>>> 	{121 + 3374, 46057, 0},
>>> 	/* C5 */
>>> 	{855 + 1146, 46057, 1},
>>> 	/* C6 */
>>> 	{7580 + 4134, 484329, 0},
>>> 	/* C7 */
>>> 	{7505 + 15274, 484329, 1},
>>> };
>>>
>>> If C3, C4, C6 are not valid, so AFAICS never used in the cpuidle code
>>> why the values are 'exit_latency' and 'target_residency' specified ? I
>>> mean why don't we have { 0, 0, 0 } ? Is it just for information ?
>>
>> Yes, because getting those numbers were based on some board-specific
>> measurements, and we don't want those values to be lost.  Also, some
>> usage patterns might want to (re)enable those states.
>
> When you say re-enable you mean for a custom kernel ?

Yes.

>>> I understand the purpose of this code but it looks a bit tricky and
>>> hard to factor out. Is it acceptable to create a new cpuidle driver
>>> for rx51 then we factor out the code between omap3, omap4 and rx51
>>> when all the code consistent ?
>>
>> I don't like that idea.  All the code is the same, the only thing we
>> need is the ability to pass in board-specific latency numbers for the
>> C-states.
>
> Sorry I was not clear, I was not saying duplicating the code. What I
> meant is to create a driver:
>
> struct cpuidle_driver rx51_idle_driver = {
>  	.name = 	"rx51_idle",
> 	.owner = 	THIS_MODULE,
> 	.states = {
> 		{
> 			/* What is in rx51_cpuidle_params */
> 		}
> 	};
>
> We put in there only the valid fields and we keep in a comment the
> table with the latency numbers.

Ah, OK.  I misunderstood.

> Assuming the valid field is for handling the table overwritting, we
> can then remove it. By this way, we simplify the next_valid_state
> function.

probably we can remove next_valid_state all together after 3.4 since the
new sysfs entry for that feature looks to be queued in linux-next.

> Depending if we have rx51 or not, we register the rx51 driver or the
> omap3 driver in the init function. That has also the benefit to group
> the cpuidle code in the cpuidle34xx file.

yes, but with board-specific data in SoC-specific code, which is not a
clean separation IMO.  How would you plan to pass which board it's
running on?

>> These latency numbers are obviously quite significant when it comes to
>> the final power consumption, and these values often depend on
>> board-specific settings.  Until there are generic frameworks for
>> defining all the latencies involved, passing these values in from board
>> files is absolutly needed.
>
> Yes but before creating the generic framework, we have to do a
> transversal cpuidle consolidation across the SoC, factor out the code
> when possible, and ensure the consistency between the different
> platform and see a common pattern to emerge from this work.

Agreed, but if that means ignoring platform-specific customization, and
not putting in other mechanisms to configure platform specific details,
it is throwing away useful infrastructure.

IMO, any consolidated framework needs some way to customize or pass in
latencies from platform-specific code.  Long term, I suppose this needs
to be DT based.

That being said, I do want to see this consolidation happen, so...

In OMAP land, we are in the middle of putting in place a better
framework for defining/tracking the various latencies involved in PM
transitions (using per-device PM Qos.) After that, we will likely be
reworking and revalidating these latency numbers for all OMAPs

So maybe the best approach to help in consolidation is just to drop the
board-rx51 data all together for now, as well as the ability to pass
custom C states from board files.  

The default, unoptimized OMAP3 numbers will work fine for that board,
and anyone wanting to do optimized power work for that platform can
still do it with a custom kernel.  (There is still lots of out of tree
work for the n900 that never made it upstream, so I doubt the mainline
users of n900 will be affected by this level of power tweaking.)

If we do that, then as part of the consolidation effort, some DT-based
customization should be defined as well to override/customize C states.

Kevin
