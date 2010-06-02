From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 01:54:38 -0700
Message-ID: <AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Florian Mickler <florian@mickler.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/6/2 Thomas Gleixner <tglx@linutronix.de>:
> On Tue, 1 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/1 Thomas Gleixner <tglx@linutronix.de>:
>> > On Mon, 31 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> >> 2010/5/31 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > On Monday 31 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> 2010/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > ...
>> >> >>
>> >> >> I think it makes more sense to block suspend while wakeup even=
ts are
>> >> >> pending than blocking it everywhere timers are used by code th=
at could
>> >> >> be called while handling wakeup events or other critical work.=
 Also,
>> >> >> even if you did block suspend everywhere timers where used you=
 still
>> >> >> have the race where a wakeup interrupt happens right after you=
 decided
>> >> >> to suspend. In other words, you still need to block suspend in=
 all the
>> >> >> same places as with the current opportunistic suspend code, so=
 what is
>> >> >> the benefit of delaying suspend until idle?
>> >> >
>> >> > Assume for a while that you don't use suspend blockers, OK? =A0=
I realize you
>> >> > think that anything else doesn't make sense, but evidently some=
 other people
>> >> > have that opinion about suspend blockers.
>> >> >
>> >>
>> >> It sounded like you were suggesting that initiating suspend from =
idle
>> >> would somehow avoid the race condition with wakeup events. All I'=
m
>> >> saying is that you would need to block suspend in all the same pl=
aces.
>> >> If you don't care about ignoring wakeup events, then sure you can
>> >> initiate suspend from idle.
>> >
>> > And why should you miss a wakeup there ? If you get an interrupt i=
n
>> > the transition, then you are not longer idle.
>> >
>>
>> Because suspend itself causes you to not be idle you cannot abort
>> suspend just because you are not idle anymore.
>
> You still are addicted to the current suspend mechanism. :)
>

No I want you to stop confusing low power idle modes with suspend. I
know how to enter low power modes from idle if that low power mode is
not too disruptive.

> The whole point of doing it from idle in the form of a deep power
> state is to avoid the massive sh*tload of work which is neccesary to
> run the existing suspend code. But that needs runtime power managemen=
t
> and tweaks to avoid your timers waking you, etc.
>
> The mechanism you want to use is: suspend no matter what, like closin=
g
> the lid of the laptop, but with a few tweaks around it:
>
> =A0 1) An interrupt on a wakeup source which comes in while the suspe=
nd
> =A0 =A0 =A0code runs, i.e before you transitioned into wakeup mode, m=
ust
> =A0 =A0 =A0abort / prevent suspend.
>
> =A0 2) Prevent another attempt to suspend before the event has been
> =A0 =A0 =A0delivered and the apps have signaled that they have not lo=
nger
> =A0 =A0 =A0any work to do.
>
> =A0 As a side effect you confine crappy apps with that mechanism in
> =A0 some way.
>
> In the laptop case we do not want the tweaks as not going into suspen=
d
> might set your backpack on fire.

If that is the case you should also disable the wakeup events.

>
> If I understood you correctly then you can shutdown the CPU in idle
> completelty already, but that's not enough due to:
>
> =A0 =A01) crappy applications keeping the cpu away from idle
> =A0 =A02) timers firing
>
> Would solving those two issues be sufficient for you or am I missing
> something ?

Solving those two is enough for current android phones, but it may not
be enough for other android devices. 1 is not solvable (meaning we
cannot fix all apps), and 2 is difficult to fix since the periodic
work is useful while the device is actually in use. One possible way
to solve 2 is to allow timers on a not-idle clock. Unrelated to
Android, I also want to use opportunistic suspend on my desktop.

--=20
Arve Hj=F8nnev=E5g
