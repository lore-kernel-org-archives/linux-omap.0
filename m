From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:39:06 -0700
Message-ID: <AANLkTilwE8-9yi6gTI-Cx8etIX1Q6kzKobiIxtSW2Sb9@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<201006060044.16950.rjw@sisk.pl>
	<AANLkTikrPTvkXZM2yybiDfkHraRkw4oCH9nC8R4d3KS5@mail.gmail.com>
	<201006061555.38526.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:36745 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0FHAjH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 20:39:07 -0400
In-Reply-To: <201006061555.38526.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>

2010/6/6 Rafael J. Wysocki <rjw@sisk.pl>:
> On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> >> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> ...
>> >
>> > Arve, we're still learning you have some more requirements we had =
no idea
>>
>> What new requirement are you talking about. Did you assume all our
>> user-space ipc calls went though a single process?
>
> No, but I didn't assume that your wakelock-holding processes depend o=
n the
> other processes in a way that might prevent them from acquiring or dr=
opping
> a wakelock.
>

It does not prevent it from acquiring a wakelock (assuming the already
held wakelock does not have a timeout), but it could delay it and
cause an error dialog to pop up stating that the fozen app is
misbehaving.

> ...
>> >> >> Trusted code that calls into untrusted code has to deal with t=
he
>> >> >> untrusted code not responding, but we only want to pop up a me=
ssage
>> >> >> that the application is not responding if it is misbehaving, n=
ot just
>> >> >> because it was frozen though no fault of its own.
>> >
>> > When Android starts opportunistic suspend, all applications are fr=
ozen,
>> > "trusted" as well as "untrusted", right? =A0So, after they are all=
 frozen, none
>> > of them can do anything to prevent suspend from happening, right?
>>
>> Not if you mean when we write to /sys/power/state. Processes are not
>> frozen until the last suspend blocker is released.
>
> That doesn't matter. =A0In the opportunistic mode you don't need to w=
rite into
> /sys/power/state to start suspend, this is done by the kernel automat=
ically as
> soon as the last wakelock has been released (at least this is my assu=
mption
> about how this works). =A0Now, at this point the processes that don't=
 use
> wakelocks can't really prevent themselves from being frozen and only =
the
> wakelocks users can do that. =A0So, if a wakelock user depends on a p=
rocess
> that doesn't use wakelocks in such a way that (because of that depend=
ence) it
> can't acquire its wakelock while processes are being frozen, things d=
on't work
> as they are supposed to.
>
You seem to forget that we use overlapping wakelocks. A process that
need to acquire a wakelock does so before the driver it talks to
releases its wakelock. At this point no processes are frozen.

>> > Now, in my proposed approach the "untrusted" apps are frozen exact=
ly at the
>> > point Android would start opportunistic suspend and they wouldn't =
be able
>> > to do anything about that anyway. =A0So if one of your "trusted" a=
pps depends
>> > on the "untrusted" ones in a way that you describe, you alread hav=
e a bug
>> > (the "trusted" app cannot prevent automatic suspend from happening=
 even if it
>> > wants, because it depends on an "untrusted" app that has just been=
 frozen).
>> >
>>
>> I don't think what you said here is correct. If a wakeup event happe=
ns
>> all processed are unfrozen since the driver blocks suspend.
>
> This only means that the theoretical failure you gave as an example d=
oesn't
> happen in practice. =A0No problem, then. :-)
>

If individual processes are frozen, we run into problems that we
cannot run into if we freeze and thaw all processes.

>> The app that reads this event blocks suspend before reading it. If i=
t was
>> busy talking to a less trusted app when the event happened it still =
works
>> since all apps are running at this point.
>
> And how is this different from an approach with cgroup freezing? =A0A=
pps that
> use wakelock within the current framework would use "freeze locks" to=
 prevent
> the "untrusted" part of user space from being frozen or to thaw it. =A0=
Where's
> the problem, then?
>

They will not be able to get wakeup events directly from the kernel.
If the kernel does not thaw processes when a wakeup event happens, the
app may never get to the point where it grabs its wakelock.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
