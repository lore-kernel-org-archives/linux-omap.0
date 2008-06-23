From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 01/02] OMAP3 CPUidle driver
Date: Mon, 23 Jun 2008 10:18:52 -0700
Message-ID: <87zlpcrrwj.fsf@paris.hilman.org>
References: <0a2401c8cac8$db978770$68bf18ac@ent.ti.com>
	<87skvd9dal.fsf@paris.hilman.org>
	<003001c8d034$194be460$68bf18ac@ent.ti.com>
	<871w2w6kbg.fsf@paris.hilman.org>
	<87ve07jjl7.fsf@trdhcp146196.ntc.nokia.com>
	<87mylg3tnc.fsf@paris.hilman.org>
	<878wwwadsw.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:43418 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYFWRSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 13:18:54 -0400
In-Reply-To: <878wwwadsw.fsf@trdhcp146196.ntc.nokia.com>
 (=?iso-8859-1?Q?=22H=F6gander?= Jouni"'s message of "Mon\, 23 Jun 2008
 09\:03\:11 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

jouni.hogander@nokia.com (H=F6gander Jouni) writes:

> "ext Kevin Hilman" <khilman@mvista.com> writes:
>
>> jouni.hogander@nokia.com (H=F6gander Jouni) writes:
>>
>>> "ext Kevin Hilman" <khilman@mvista.com> writes:
>>>
>>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>>
>>>>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>>>>=20
>>>>>> > This patch adds the OMAP3 cpuidle driver. Irq enable/disable i=
s done
>>>>>> > in the core cpuidle driver before it queries the governor for =
the
>>>>>> > next state.
>>>>>>=20
>>>>>> Can you explain why you need the IRQ/FIQ disable added to=20
>>>>>> cpuidle_idle_call()
>>>>>>=20
>>>>>
>>>>> This was done to prevent any interrupts firing in between a=20
>>>>> cpuidle_curr_governor->select() and target_state->enter().
>>>>
>>>> I understand that, but I still don't understand exactly what you'r=
e
>>>> trying to prevent.  Did you have a specific bug that this prevente=
d?
>>>>
>>>>> An interrupt in between could end up with a previously selected=20
>>>>> state to be programmed.
>>>>
>>>> Remember that this function _is_ the idle loop, meaning when this =
runs
>>>> nothing else is happening.  After the select, if other system acti=
vity
>>>> has happened (e.g. and interrupt, or thread wakeup etc.), it will =
run
>>>> before the target_state->enter() because of the check for
>>>> need_resched().
>>>
>>> What happens if this interrupt, or thread wakeup causes change on
>>> latency requirements? Then we are entering sleep state which was
>>> selected using wrong latency requirement data.
>>
>> If a thread is awoken by an interrupt, then need_resched() will be
>> true, and the idle loop will exit without trying to enter the idle
>> state.
>
> Even in that case there is still period in idle loop, were it is poss=
ible
> that latency requirement changes and cpuidle doesn't know this on fri=
st
> enter state. This is after need_resched.
>
> I don't know this area too good, but isn't it also possible that
> interrupt which is handled, has caused latency requirement change and
> there is no NEED_RESCHED flag set?

IMHO, these things should be handled on a per-driver/subsystem basis,
not by a global interrupt lock. =20

Remember that this patchset is still missing a very important piece
which is the omap3_idle_bm_check().  This is an of how these special
cases are handled.

=46or example, if an interrupt fires which triggers driver activity,
this function is supposed to look for clock activity and potentially
adjust the depth of sleep that can be entered.


>>
>>>>
>>>>> Any suggestions on a better way to handle this?
>>>>
>>>> Just drop the IRQ/FIQ disables altogether.
>>>
>>> At least these are needed at some point in idle loop. Otherwise we
>>> might stepout from idle and sram in a point where it is not accepta=
ble.
>>
>> Agreed, interrupt enable/disable is needed in the idle loop, but not
>> in the CPUidle code. =20
>>
>> The current OMAP idle loop code (omap2_pm_idle) already does this, b=
ut
>> the CPUidle "enter state" hook does not. =20
>>
>> The omap3_enter_idle() function should be the one who enables/disabl=
es
>> interrupts.  At a minimulm, the omap_sram_idle should be called with
>> interrupts disabled.
>
> If done this way, it should be checked that target state is still
> valid before entering omap_sram_idle. How could CPUidle "enter state"
> know wether it is still valid?
>

Again, this is the job of the OMAP specific idle loop, not the global
CPUidle code.

=46or example, the current idle loop simply does:

	if (omap_irq_pending())
		goto out;

so it doesn't enter idle if there's an interrupt pending.

So, I'm not arguing that your concerns aren't valid, because indeed
they are valid corner cases.  I'm just arguing that these special
cases should be handled in the OMAP code, not the global CPUidle code.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
