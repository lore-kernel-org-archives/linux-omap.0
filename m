From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 22:21:10 +0200
Message-ID: <AANLkTi=4hYRJheBBLJARJr_s5RbMs3APFTKD-pk1VJEy@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287387875-14168-2-git-send-email-ohad@wizery.com> <8762wyyv99.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49530 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab0JSUVd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 16:21:33 -0400
In-Reply-To: <8762wyyv99.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Simon Que <sque@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Tue, Oct 19, 2010 at 6:58 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> + =A0 =A0 =A0* This spin_trylock_irqsave serves two purposes:
>> +
>> + =A0 =A0 =A0* 1. Disable local interrupts and preemption, in order =
to
>> + =A0 =A0 =A0* =A0 =A0minimize the period of time in which the hwspi=
nlock
>> + =A0 =A0 =A0* =A0 =A0is taken (so caller will not preempted). This =
is
>> + =A0 =A0 =A0* =A0 =A0important in order to minimize the possible po=
lling on
>> + =A0 =A0 =A0* =A0 =A0the hardware interconnect by a remote user of =
this lock.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* 2. Make this hwspinlock primitive SMP-safe (so we can=
 try to
>> + =A0 =A0 =A0* =A0 =A0take it from additional contexts on the local =
cpu)
>> + =A0 =A0 =A0*/
>
> 3. Ensures that in_atomic/might_sleep checks catch potential problems
> =A0 with hwspinlock usage (e.g. scheduler checks like 'scheduling whi=
le
> =A0 atomic' etc.)

Nice one. Added.

>> +/**
>> + * omap_hwspinlock_unlock() - unlock a specific hwspinlock
>
> minor nit: s/lock_unlock/_unlock/ =A0to match name below

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
