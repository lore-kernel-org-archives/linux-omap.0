From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 02:16:45 -0700
Message-ID: <AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005292227.15479.rjw@sisk.pl>
	<AANLkTim6zsho4RSrseJostaOJe9lL4VNRKA3vDGJWJhK@mail.gmail.com>
	<201005302202.39511.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201005302202.39511.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday 29 May 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Saturday 29 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > On Friday 28 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> On Fri, May 28, 2010 at 1:44 AM, Florian Mickler <florian@mick=
ler.org> wrote:
>> >> >> > On Thu, 27 May 2010 20:05:39 +0200 (CEST)
>> >> >> > Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> > ...
>> >> >> > To integrate this with the current way of doing things, i ga=
thered it
>> >> >> > needs to be implemented as an idle-state that does the suspe=
nd()-call?
>> >> >> >
>> >> >>
>> >> >> I think it is better no not confuse this with idle. Since init=
iating
>> >> >> suspend will cause the system to become not-idle, I don't thin=
k is is
>> >> >> beneficial to initiate suspend from idle.
>> >> >
>> >> > It is, if the following two conditions hold simultaneously:
>> >> >
>> >> > (a) Doing full system suspend is ultimately going to bring you =
more energy
>> >> > =A0 =A0savings than the (presumably lowest) idle state you're c=
urrently in.
>> >> >
>> >> > (b) You anticipate that the system will stay idle for a conside=
rably long time
>> >> > =A0 =A0such that it's worth suspending.
>> >> >
>> >>
>> >> I still don't think this matters. If you are waiting for in inter=
rupt
>> >> that cannot wake you up from suspend, then idle is not an indicat=
or
>> >> that it is safe to enter suspend. I also don't think you can avoi=
d any
>> >> user-space suspend blockers by delaying suspend until the system =
goes
>> >> idle since any page fault could cause it to go idle. Therefore I =
don't
>> >> see a benefit in delaying suspend until idle when the last suspen=
d
>> >> blocker is released (it would only mask possible race conditions)=
=2E
>> >
>> > I wasn't referring to suspend blockers, but to the idea of initiat=
ing full
>> > system suspend from idle, which I still think makes sense. =A0If y=
ou are
>> > waiting for an interrupt that cannot wake you from suspend, then
>> > _obviously_ suspend should not be started. =A0However, if you're n=
ot waiting for
>> > such an interrupt and the (a) and (b) above hold, it makes sense t=
o start
>> > suspend from idle.
>> >
>>
>> What about timers? When you suspend timers stop (otherwise it is jus=
t
>> a deep-idle mode), and this could cause problems. Some drivers rely =
on
>> timers if the hardware does not have a completion interrupt. It is n=
ot
>> uncommon to see send command x then wait 200ms in a some hardware
>> specs.
>
> QoS should be used in such cases.
>

I think it makes more sense to block suspend while wakeup events are
pending than blocking it everywhere timers are used by code that could
be called while handling wakeup events or other critical work. Also,
even if you did block suspend everywhere timers where used you still
have the race where a wakeup interrupt happens right after you decided
to suspend. In other words, you still need to block suspend in all the
same places as with the current opportunistic suspend code, so what is
the benefit of delaying suspend until idle?

--=20
Arve Hj=F8nnev=E5g
