From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:23:24 -0700
Message-ID: <AANLkTiny-hiPoKKKolNAhpvFUS-GaArBO8bwYBUg5glx@mail.gmail.com>
References: <Pine.LNX.4.44L0.1006052233100.22666-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.1006060650270.28143-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1006060650270.28143-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

2010/6/6 Alan Stern <stern@rowland.harvard.edu>:
> On Sat, 5 Jun 2010, Alan Stern wrote:
>
>> > If you are referring to the approach that we don't use suspend but
>> > freeze a cgroup instead, this only solves the problem of bad apps.=
 It
>> > does not help pause timers in trusted user space code and in the
>> > kernel, so it does not lower our average power consumption.
>>
>> You can solve this problem if you restructure your "trusted" apps in
>> the right way. =A0Require a trusted app to guarantee that whenever i=
t
>> doesn't hold any suspend blockers, it will do nothing but wait (in a
>> poll() system call for example) for a wakeup event. =A0When the even=
t
>> occurs, it must then activate a suspend blocker.
>>
>> Better yet, make it more fine-grained. =A0Instead of trusted apps, h=
ave
>> trusted threads. =A0Freeze the untrusted threads along with everythi=
ng
>> else, and require the trusted threads to satisfy this guarantee.
>>
>> In this way, while the system is idle no user timers will get renewe=
d.
>> Kernel timers are another matter, but we should be able to handle th=
em.
>> There's nothing Android-specific about wanting to reduce kernel time=
r
>> wakeups while in a low-power mode.
>
> In fact it's possible to do this with only minimal changes to the
> userspace, providing you can specify all your possible hardware wakeu=
p
> sources. =A0(On the Android this list probably isn't very large -- I
> imagine it includes the keypad, the radio link(s), the RTC, and maybe
> a few switches, buttons, or other things.)
>
> Here's how you can do it. =A0Extend the userspace suspend-blocker API=
, so
> that each suspend blocker can optionally have an associated wakeup
> source.
>
> The power-manager process should keep a list of "active" wakeup
> sources. =A0A source gets removed from the list when an associated
> suspend blocker is activated.
>

How do you do this safely? If you remove the active wakeup only when
activating the suspend blocker, you will never unblock suspend if
another wakeup event happens after user-space blocked suspend but
before user-space read the events.

Also, I'm not sure we can easily associate a wakeup event with a user
space suspend blocker. For instance when an alarm triggers it is
sometimes because of a user-space alarm and sometimes because an
in-kernel alarm.

> When the "active" list is empty and no suspend blockers are activated=
,
> the power manager freezes ALL other processes, trusted and untrusted
> alike. =A0It then does a big poll() on all the wakeup sources. =A0Whe=
n the
> poll() returns, its output is used to repopulate the "active" list an=
d
> processes are unfrozen.
>
> (You can also include some error detection: If a source remains on th=
e
> "active" list for too long then something has gone wrong.)
>
> To do all this you don't even need to use cgroups. =A0The existing PM
> implementation allows a user process to freeze everything but itself;
> that's how swsusp and related programs work.
>
> This is still a big-hammer sort of approach, but it doesn't require a=
ny
> kernel changes.
>
> Alan Stern
>
>



--=20
Arve Hj=F8nnev=E5g
