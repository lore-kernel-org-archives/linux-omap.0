From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Tue, 12 Aug 2008 08:48:41 +0300
Message-ID: <87fxpaeqbq.fsf@trdhcp146196.ntc.nokia.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
	<alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com>
	<87r68ver5n.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.1.00.0808111138360.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36823 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYHLFs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 01:48:57 -0400
In-Reply-To: <alpine.DEB.1.00.0808111138360.10219@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Mon, 11 Aug 2008 11:51:52 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

"ext Paul Walmsley" <paul@booyaka.com> writes:

> Hello Jouni,
>
> On Mon, 11 Aug 2008, H=C3=B6gander Jouni wrote:
>
>> "ext Paul Walmsley" <paul@booyaka.com> writes:
>>
>> > Could you explain a little further why PER would have a wakeup dep=
endency=20
>> > on CORE?  Is this something that we should only enable under certa=
in=20
>> > conditions, e.g., latency requirements for a device in PER?
>>=20
>> This is done to make sure we don't loose any gpio interrupts: GPIO
>> wakeup/interrupt doesn't work for GPIOs in PER domain if PER is not
>> active.
>
> I'm probably misunderstanding something, but ... wouldn't it better t=
o=20
> just keep PER powerdomain ON all the time when PER GPIOs are enabled =
for=20
> interrupts?  It seems possible for PER to go to retention or OFF even=
 with=20
> the CORE wkdep in place, which would result in a period of time where=
 the=20
> interrupts would be missed, no?

No, it won't, PER goes sleep state only if CORE goes
too. There is a hardware sleepdep between PER and CORE, thanks to
Rajendra for pointing this out some time ago. This way there are all
the time some wakeup mechanism available for PER gpios
(gpio/iopad). Leaving PER ON would increase consumption.

>
>> >> 3. Deny hwsup mode before writing next pwrst state
>> >
>> > I missed this part of the patch - could you point me at that
>> > section?
>>=20
>> Patch changes code to use set_pwrdm_state from pm34xx.c instead of
>> pwrdm_set_next_pwrst from powerdomain code. That function contains
>> denying hwsup mode.
>
> Ah, okay.
>
>
> - Paul

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
