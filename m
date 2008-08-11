From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Mon, 11 Aug 2008 11:51:52 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808111138360.10219@utopia.booyaka.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com> <87r68ver5n.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1286855529-1218476838=:10219"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54379 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbYHKRvx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 13:51:53 -0400
In-Reply-To: <87r68ver5n.fsf@trdhcp146196.ntc.nokia.com>
Content-ID: <alpine.DEB.1.00.0808111149361.10219@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1286855529-1218476838=:10219
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.1.00.0808111149362.10219@utopia.booyaka.com>

Hello Jouni,

On Mon, 11 Aug 2008, H=F6gander Jouni wrote:

> "ext Paul Walmsley" <paul@booyaka.com> writes:
>
> > Could you explain a little further why PER would have a wakeup dependen=
cy=20
> > on CORE?  Is this something that we should only enable under certain=20
> > conditions, e.g., latency requirements for a device in PER?
>=20
> This is done to make sure we don't loose any gpio interrupts: GPIO
> wakeup/interrupt doesn't work for GPIOs in PER domain if PER is not
> active.

I'm probably misunderstanding something, but ... wouldn't it better to=20
just keep PER powerdomain ON all the time when PER GPIOs are enabled for=20
interrupts?  It seems possible for PER to go to retention or OFF even with=
=20
the CORE wkdep in place, which would result in a period of time where the=
=20
interrupts would be missed, no?

> >> 3. Deny hwsup mode before writing next pwrst state
> >
> > I missed this part of the patch - could you point me at that
> > section?
>=20
> Patch changes code to use set_pwrdm_state from pm34xx.c instead of
> pwrdm_set_next_pwrst from powerdomain code. That function contains
> denying hwsup mode.

Ah, okay.


- Paul
--155748971-1286855529-1218476838=:10219--
