From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Tue, 12 Aug 2008 00:11:44 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808112352430.10219@utopia.booyaka.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com> <87r68ver5n.fsf@trdhcp146196.ntc.nokia.com> <alpine.DEB.1.00.0808111138360.10219@utopia.booyaka.com>
 <87fxpaeqbq.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1305869088-1218521504=:10219"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54667 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYHLGLp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 02:11:45 -0400
In-Reply-To: <87fxpaeqbq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1305869088-1218521504=:10219
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Jouni,=20

On Tue, 12 Aug 2008, H=C3=B6gander Jouni wrote:

> "ext Paul Walmsley" <paul@booyaka.com> writes:
>=20
> > On Mon, 11 Aug 2008, H=C3=B6gander Jouni wrote:
> >
> >> "ext Paul Walmsley" <paul@booyaka.com> writes:
> >>
> >> > Could you explain a little further why PER would have a wakeup depen=
dency=20
> >> > on CORE?  Is this something that we should only enable under certain=
=20
> >> > conditions, e.g., latency requirements for a device in PER?
> >>=20
> >> This is done to make sure we don't loose any gpio interrupts: GPIO
> >> wakeup/interrupt doesn't work for GPIOs in PER domain if PER is not
> >> active.
> >
> > I'm probably misunderstanding something, but ... wouldn't it better to=
=20
> > just keep PER powerdomain ON all the time when PER GPIOs are enabled fo=
r=20
> > interrupts?  It seems possible for PER to go to retention or OFF even w=
ith=20
> > the CORE wkdep in place, which would result in a period of time where t=
he=20
> > interrupts would be missed, no?
>=20
> No, it won't, PER goes sleep state only if CORE goes
> too. There is a hardware sleepdep between PER and CORE, thanks to
> Rajendra for pointing this out some time ago. This way there are all
> the time some wakeup mechanism available for PER gpios
> (gpio/iopad). Leaving PER ON would increase consumption.

Ah, I see.

Do you think we should add a mechanism for the CORE->PER wkdep to be=20
dynamically added and removed, based on whether GPIO2-6 balls are enabled=
=20
in IO pad wakeup?  Conceivably a board could just use GPIO1 (in WKUP), and=
=20
PER would not need to be awakened along with CORE in those instances,=20
correct?


- Paul
--155748971-1305869088-1218521504=:10219--
