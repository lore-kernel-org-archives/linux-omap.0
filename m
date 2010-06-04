From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Thu, 3 Jun 2010 21:54:50 -0700
Message-ID: <AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45760 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0FDEyu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 00:54:50 -0400
In-Reply-To: <20100603232302.GA16184@elte.hu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

On Thu, Jun 3, 2010 at 4:23 PM, Ingo Molnar <mingo@elte.hu> wrote:
=2E..
> =A0- Controlled auto-suspend: drivers (such as input) could on wakeup
> =A0 automatically set the 'minimum wakeup latency' value of wakee tas=
ks to a
> =A0 lower value. This automatically prevents another auto-suspend in =
the near
> =A0 future: up to the point the wakee task increases its latency (via=
 the
> =A0 scheduler syscall) again and allows suspend again.
>

How do you clear the latency value in a safe way? If another wakeup
event happens right after your wakee task is done processing the last
event and decides to increase its latency, auto suspend will be
allowed even though you have an unprocessed wakeup event. Also how do
you know which task will read the event if it is not already waiting
for it?


> =A0 This means there will be no surprise suspends for a task that may=
 take a
> =A0 bit longer than usual to finish its work. [ Detail: this would on=
ly be done
> =A0 for tasks that have a non-default (non-infinity) task->latency va=
lue - to
> =A0 prevent the input driver from lowering latency values (and preven=
ting
> =A0 future suspends) just because some unaware apps are running and u=
sing input
> =A0 drivers. ]

Don't you need two inifinity values for this?

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
