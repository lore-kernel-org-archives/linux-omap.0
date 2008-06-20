From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 01/02] OMAP3 CPUidle driver
Date: Fri, 20 Jun 2008 10:25:59 -0700
Message-ID: <87mylg3tnc.fsf@paris.hilman.org>
References: <0a2401c8cac8$db978770$68bf18ac@ent.ti.com>
	<87skvd9dal.fsf@paris.hilman.org>
	<003001c8d034$194be460$68bf18ac@ent.ti.com>
	<871w2w6kbg.fsf@paris.hilman.org>
	<87ve07jjl7.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:50369 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757009AbYFTR0G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2008 13:26:06 -0400
In-Reply-To: <87ve07jjl7.fsf@trdhcp146196.ntc.nokia.com>
 (=?iso-8859-1?Q?=22H=F6gander?= Jouni"'s message of "Wed\, 18 Jun 2008
 10\:19\:48 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

jouni.hogander@nokia.com (H=F6gander Jouni) writes:

> "ext Kevin Hilman" <khilman@mvista.com> writes:
>
>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>
>>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>>=20
>>>> > This patch adds the OMAP3 cpuidle driver. Irq enable/disable is =
done
>>>> > in the core cpuidle driver before it queries the governor for th=
e
>>>> > next state.
>>>>=20
>>>> Can you explain why you need the IRQ/FIQ disable added to=20
>>>> cpuidle_idle_call()
>>>>=20
>>>
>>> This was done to prevent any interrupts firing in between a=20
>>> cpuidle_curr_governor->select() and target_state->enter().
>>
>> I understand that, but I still don't understand exactly what you're
>> trying to prevent.  Did you have a specific bug that this prevented?
>>
>>> An interrupt in between could end up with a previously selected=20
>>> state to be programmed.
>>
>> Remember that this function _is_ the idle loop, meaning when this ru=
ns
>> nothing else is happening.  After the select, if other system activi=
ty
>> has happened (e.g. and interrupt, or thread wakeup etc.), it will ru=
n
>> before the target_state->enter() because of the check for
>> need_resched().
>
> What happens if this interrupt, or thread wakeup causes change on
> latency requirements? Then we are entering sleep state which was
> selected using wrong latency requirement data.

If a thread is awoken by an interrupt, then need_resched() will be
true, and the idle loop will exit without trying to enter the idle
state.

>>
>>> Any suggestions on a better way to handle this?
>>
>> Just drop the IRQ/FIQ disables altogether.
>
> At least these are needed at some point in idle loop. Otherwise we
> might stepout from idle and sram in a point where it is not acceptabl=
e.

Agreed, interrupt enable/disable is needed in the idle loop, but not
in the CPUidle code. =20

The current OMAP idle loop code (omap2_pm_idle) already does this, but
the CPUidle "enter state" hook does not. =20

The omap3_enter_idle() function should be the one who enables/disables
interrupts.  At a minimulm, the omap_sram_idle should be called with
interrupts disabled.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
