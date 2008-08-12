From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Tue, 12 Aug 2008 09:53:13 +0300
Message-ID: <87wsimd8rq.fsf@trdhcp146196.ntc.nokia.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
	<alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com>
	<87r68ver5n.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.1.00.0808111138360.10219@utopia.booyaka.com>
	<87fxpaeqbq.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.1.00.0808112352430.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44370 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYHLGxw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 02:53:52 -0400
In-Reply-To: <alpine.DEB.1.00.0808112352430.10219@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Tue, 12 Aug 2008 00:11:44 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

"ext Paul Walmsley" <paul@booyaka.com> writes:

> Hello Jouni,=20
>
> On Tue, 12 Aug 2008, H=C3=B6gander Jouni wrote:
>
>> "ext Paul Walmsley" <paul@booyaka.com> writes:
>>=20
>> > On Mon, 11 Aug 2008, H=C3=B6gander Jouni wrote:
>> >
>> >> "ext Paul Walmsley" <paul@booyaka.com> writes:
>> >>
>> >> > Could you explain a little further why PER would have a wakeup =
dependency=20
>> >> > on CORE?  Is this something that we should only enable under ce=
rtain=20
>> >> > conditions, e.g., latency requirements for a device in PER?
>> >>=20
>> >> This is done to make sure we don't loose any gpio interrupts: GPI=
O
>> >> wakeup/interrupt doesn't work for GPIOs in PER domain if PER is n=
ot
>> >> active.
>> >
>> > I'm probably misunderstanding something, but ... wouldn't it bette=
r to=20
>> > just keep PER powerdomain ON all the time when PER GPIOs are enabl=
ed for=20
>> > interrupts?  It seems possible for PER to go to retention or OFF e=
ven with=20
>> > the CORE wkdep in place, which would result in a period of time wh=
ere the=20
>> > interrupts would be missed, no?
>>=20
>> No, it won't, PER goes sleep state only if CORE goes
>> too. There is a hardware sleepdep between PER and CORE, thanks to
>> Rajendra for pointing this out some time ago. This way there are all
>> the time some wakeup mechanism available for PER gpios
>> (gpio/iopad). Leaving PER ON would increase consumption.
>
> Ah, I see.
>
> Do you think we should add a mechanism for the CORE->PER wkdep to be=20
> dynamically added and removed, based on whether GPIO2-6 balls are ena=
bled=20
> in IO pad wakeup?  Conceivably a board could just use GPIO1 (in WKUP)=
, and=20
> PER would not need to be awakened along with CORE in those instances,=
=20
> correct?

If gpio irq is enabled also iopad wakeup is enabled for related pad
and wkdep is added. Same thing should be done also for core gpios,
because not all of them are capable to generate wakeup when core is
off. Problem with this is how to know in kernel side to which ball
each gpio is connected. To my understanding muxing is mostly/commonly
done in bootloader. Any idea to this? There seems to be also
enable/disable_irq_wake, where this logic could be connected.

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
