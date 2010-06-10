From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Wed, 9 Jun 2010 21:51:38 -0700
Message-ID: <AANLkTilrJYg-z6mbRfhhrDdhpWUYSXGQEMCGgBj24xZs@mail.gmail.com>
References: <AANLkTilALyvthzh8rMiDFFP_QTz_o5hxdE8tArMUonpP@mail.gmail.com>
	<Pine.LNX.4.44L0.1006091031030.1728-100000@iolanthe.rowland.org>
	<AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
	<alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38557 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0FJEvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 00:51:39 -0400
In-Reply-To: <alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david@lang.hm
Cc: Alan Stern <stern@rowland.harvard.edu>, tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>

2010/6/9  <david@lang.hm>:
> On Wed, 9 Jun 2010, Arve Hj?nnev?g wrote:
>
>>
>> The power may not see the event, the process that reads the event wi=
ll
>> always see it. If the power manager is not in the poll call when the
>> event happens, the process that reads the event can read the event
>> before the power manager calls poll.
>>
>
>>
>> All input events that can wake the system are handled by one
>> user-space suspend blocker. Input devices come and go so we would ne=
ed
>> to add and remove the fds dynamically.
>
>
>>
>> For that to work the wakeup events would have to be reported to the
>> power manager in a reliable way in the first place. Passing the file
>> descriptor that the app uses to the power manager does not work for
>> this, since the app could read the event while the power manager was
>> not in the poll call and the power manager would never see it. Also,
>> existing apps don't pass their file descriptors to the power manager=
,
>> so it has the get the event from somewhere else.
>>
>
> why could the suspend blocker process see all events, but the power m=
anager
> process not see the events?
>

Because in this proposal the power manager only looks for the events
(on the same queue) when no user space suspend blockers are active.

> have the userspace talk to the power manager the way it does to the s=
uspend
> blocker now and what's the difference?
>
> effectivly think s/suspend blocker/power manager/ (with the power man=
ager
> doing all the other things that are proposed instead of grabbing the
> wakelock), the difference should be hidden to the rest of userspace.
>
> what am I missing here?
>

The current user space interface does not require that clients
register the file descriptors that they get wakeup events from with
another process.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
