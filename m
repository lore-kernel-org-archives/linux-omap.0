From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 01/02] OMAP3 CPUidle driver
Date: Wed, 18 Jun 2008 10:19:48 +0300
Message-ID: <87ve07jjl7.fsf@trdhcp146196.ntc.nokia.com>
References: <0a2401c8cac8$db978770$68bf18ac@ent.ti.com>
	<87skvd9dal.fsf@paris.hilman.org>
	<003001c8d034$194be460$68bf18ac@ent.ti.com>
	<871w2w6kbg.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21048 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFRHY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 03:24:29 -0400
In-Reply-To: <871w2w6kbg.fsf@paris.hilman.org> (ext Kevin Hilman's message of
	"Tue, 17 Jun 2008 10:30:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@mvista.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

"ext Kevin Hilman" <khilman@mvista.com> writes:

> "Rajendra Nayak" <rnayak@ti.com> writes:
>
>>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>>=20
>>> > This patch adds the OMAP3 cpuidle driver. Irq enable/disable is d=
one
>>> > in the core cpuidle driver before it queries the governor for the
>>> > next state.
>>>=20
>>> Can you explain why you need the IRQ/FIQ disable added to=20
>>> cpuidle_idle_call()
>>>=20
>>
>> This was done to prevent any interrupts firing in between a=20
>> cpuidle_curr_governor->select() and target_state->enter().
>
> I understand that, but I still don't understand exactly what you're
> trying to prevent.  Did you have a specific bug that this prevented?
>
>> An interrupt in between could end up with a previously selected=20
>> state to be programmed.
>
> Remember that this function _is_ the idle loop, meaning when this run=
s
> nothing else is happening.  After the select, if other system activit=
y
> has happened (e.g. and interrupt, or thread wakeup etc.), it will run
> before the target_state->enter() because of the check for
> need_resched().

What happens if this interrupt, or thread wakeup causes change on
latency requirements? Then we are entering sleep state which was
selected using wrong latency requirement data.

>
>> Any suggestions on a better way to handle this?
>
> Just drop the IRQ/FIQ disables altogether.

At least these are needed at some point in idle loop. Otherwise we
might stepout from idle and sram in a point where it is not acceptable.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
