From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 01/02] OMAP3 CPUidle driver
Date: Fri, 27 Jun 2008 12:46:38 +0300
Message-ID: <871w2jcirl.fsf@trdhcp146196.ntc.nokia.com>
References: <0a2401c8cac8$db978770$68bf18ac@ent.ti.com>
	<87skvd9dal.fsf@paris.hilman.org>
	<003001c8d034$194be460$68bf18ac@ent.ti.com>
	<871w2w6kbg.fsf@paris.hilman.org>
	<87ve07jjl7.fsf@trdhcp146196.ntc.nokia.com>
	<87mylg3tnc.fsf@paris.hilman.org>
	<878wwwadsw.fsf@trdhcp146196.ntc.nokia.com>
	<87zlpcrrwj.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58700 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbYF0Jwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 05:52:35 -0400
In-Reply-To: <87zlpcrrwj.fsf@paris.hilman.org> (ext Kevin Hilman's message of
	"Mon, 23 Jun 2008 10:18:52 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@mvista.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

"ext Kevin Hilman" <khilman@mvista.com> writes:

> jouni.hogander@nokia.com (H=C3=B6gander Jouni) writes:
>
>> "ext Kevin Hilman" <khilman@mvista.com> writes:
>>
>>> jouni.hogander@nokia.com (H=C3=B6gander Jouni) writes:
>>>
>>>> "ext Kevin Hilman" <khilman@mvista.com> writes:
>>>>
>>>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>>>
>>>>>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>>>>>=20
>>>>>>> > This patch adds the OMAP3 cpuidle driver. Irq enable/disable =
is done
>>>>>>> > in the core cpuidle driver before it queries the governor for=
 the
>>>>>>> > next state.
>>>>>>>=20
>>>>>>> Can you explain why you need the IRQ/FIQ disable added to=20
>>>>>>> cpuidle_idle_call()
>>>>>>>=20
>>>>>>
>>>>>> This was done to prevent any interrupts firing in between a=20
>>>>>> cpuidle_curr_governor->select() and target_state->enter().
>>>>>
>>>>> I understand that, but I still don't understand exactly what you'=
re
>>>>> trying to prevent.  Did you have a specific bug that this prevent=
ed?
>>>>>
>>>>>> An interrupt in between could end up with a previously selected=20
>>>>>> state to be programmed.
>>>>>
>>>>> Remember that this function _is_ the idle loop, meaning when this=
 runs
>>>>> nothing else is happening.  After the select, if other system act=
ivity
>>>>> has happened (e.g. and interrupt, or thread wakeup etc.), it will=
 run
>>>>> before the target_state->enter() because of the check for
>>>>> need_resched().
>>>>
>>>> What happens if this interrupt, or thread wakeup causes change on
>>>> latency requirements? Then we are entering sleep state which was
>>>> selected using wrong latency requirement data.
>>>
>>> If a thread is awoken by an interrupt, then need_resched() will be
>>> true, and the idle loop will exit without trying to enter the idle
>>> state.
>>
>> Even in that case there is still period in idle loop, were it is pos=
sible
>> that latency requirement changes and cpuidle doesn't know this on fr=
ist
>> enter state. This is after need_resched.
>>
>> I don't know this area too good, but isn't it also possible that
>> interrupt which is handled, has caused latency requirement change an=
d
>> there is no NEED_RESCHED flag set?
>
> IMHO, these things should be handled on a per-driver/subsystem basis,
> not by a global interrupt lock.

I agree this, but probably this is just a hole in my knowledge. I mean
I can't figure out what is reliable way to check wether sleep state
needs to be reselected. Leaving interrupts enabled makes it worse,
because then it is possible that idle loop is suspended in the middle o=
f
the loop and we don't know that this happened.

>
> Remember that this patchset is still missing a very important piece
> which is the omap3_idle_bm_check().  This is an of how these special
> cases are handled.
>
> For example, if an interrupt fires which triggers driver activity,
> this function is supposed to look for clock activity and potentially
> adjust the depth of sleep that can be entered.

Well again latency constraint might change and there is no clock
activity.

My personal opinion is just that idle loop from selection of a sleep
state to exiting it, should be "atomic". If an interrupt fires in the
middle of the loop then the state of the system is not same as it was
in the time of the state selection. In this case loop should be
exited. When there is again idle time and idle loop is entered, I
think it should be always restarted from the selection.

>
>
>>>
>>>>>
>>>>>> Any suggestions on a better way to handle this?
>>>>>
>>>>> Just drop the IRQ/FIQ disables altogether.
>>>>
>>>> At least these are needed at some point in idle loop. Otherwise we
>>>> might stepout from idle and sram in a point where it is not accept=
able.
>>>
>>> Agreed, interrupt enable/disable is needed in the idle loop, but no=
t
>>> in the CPUidle code. =20
>>>
>>> The current OMAP idle loop code (omap2_pm_idle) already does this, =
but
>>> the CPUidle "enter state" hook does not. =20
>>>
>>> The omap3_enter_idle() function should be the one who enables/disab=
les
>>> interrupts.  At a minimulm, the omap_sram_idle should be called wit=
h
>>> interrupts disabled.
>>
>> If done this way, it should be checked that target state is still
>> valid before entering omap_sram_idle. How could CPUidle "enter state=
"
>> know wether it is still valid?
>>
>
> Again, this is the job of the OMAP specific idle loop, not the global
> CPUidle code.
>
> For example, the current idle loop simply does:
>
> 	if (omap_irq_pending())
> 		goto out;
>
> so it doesn't enter idle if there's an interrupt pending.
>
> So, I'm not arguing that your concerns aren't valid, because indeed
> they are valid corner cases.  I'm just arguing that these special
> cases should be handled in the OMAP code, not the global CPUidle code=
=2E
>
> Kevin
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
