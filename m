From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 22:04:39 -0700
Message-ID: <AANLkTimIzm7fEczlaDT5QqkiBFAjbe46rciLxxsoLSya@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005272334040.3478@localhost.localdomain>
	<20100531143339.249ae1f4@notabene.brown>
	<201006010005.19554.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201006010005.19554.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, May 31, 2010 at 3:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 31 May 2010, Neil Brown wrote:
>> On Thu, 27 May 2010 23:40:29 +0200 (CEST)
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> > On Thu, 27 May 2010, Rafael J. Wysocki wrote:
>> >
>> > > On Thursday 27 May 2010, Thomas Gleixner wrote:
>> > > > On Thu, 27 May 2010, Alan Stern wrote:
>> > > >
>> > > > > On Thu, 27 May 2010, Felipe Balbi wrote:
>> > > > >
>> > > > > > On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern w=
rote:
>> > > > > > >If people don't mind, here is a greatly simplified summar=
y of the
>> > > > > > >comments and objections I have seen so far on this thread=
:
>> > > > > > >
>> > > > > > > =A0 The in-kernel suspend blocker implementation is okay=
, even
>> > > > > > > =A0 beneficial.
>> > > > > >
>> > > > > > I disagree here. I believe expressing that as QoS is much =
better. Let
>> > > > > > the kernel decide which power state is better as long as I=
 can say I
>> > > > > > need 100us IRQ latency or 100ms wakeup latency.
>> > > > >
>> > > > > Does this mean you believe "echo mem >/sys/power/state" is b=
ad and
>> > > > > should be removed? =A0Or "echo disk >/sys/power/state"? =A0T=
hey pay no
>> > > >
>> > > > mem should be replaced by an idle suspend to ram mechanism
>> > >
>> > > Well, what about when I want the machine to suspend _regardless_=
 of whether
>> > > or not it's idle at the moment? =A0That actually happens quite o=
ften to me. :-)
>> >
>> > Fair enough. Let's agree on a non ambigous terminology then:
>> >
>> > =A0 =A0 =A0forced:
>> >
>> > =A0 =A0 =A0 =A0 =A0suspend which you enforce via user interaction,=
 which
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0also implies that you risk losi=
ng wakeups depending on
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the hardware properties
>>
>> Reasonable definition I think. =A0However the current implementation=
 doesn't
>> exactly match it.
>> With the current implementation you risk losing wakeups *independent=
* of the
>> hardware properties.
>
> Define "losing", please.
>
> Currently, we simply don't regard hardware signals occuring _during_ =
the
> suspend operation itself as wakeups (unless they are wakeup interrupt=
s to be
> precise, because these _are_ taken into account by our current code).
>
> The reason is that the meaning of given event may be _different_ at r=
un time
> and after the system has been suspended. =A0For example, consider a p=
ower button
> on a PC box. =A0If it's pressed at run time, it usually means "power =
off the
> system" to the kernel. =A0After the system has been suspended, howeve=
r, it means
> "wake up". =A0So, you have to switch from one interpretation of the e=
vent to the
> other and that's not an atomic operaition (to put it lightly).
>
>> Even with ideal hardware events can be lost - by which I mean that t=
hey will
>> not be seen until some other event effects a wake-up.
>> e.g. the interrupt which signals the event happens immediately befor=
e the
>> suspend is requested (or maybe at the same time as), but the process=
 which
>> needs to handle the event doesn't get a chance to see it before the =
suspend
>> procedure freezes that process, and even if it did it would have no =
way to
>> abort the suspend.
>>
>> So I submit that the current implementation doesn't match your descr=
iption of
>> "forced", is therefore buggy, and that if it were fixed, that would =
be
>> sufficient to meet the immediate needs of android.
>
> I don't really think it may be fixed with respect to every possible k=
ind of
> hardware. =A0On platforms where I/O interrupts are wakeup events it s=
hould
> work right now. =A0On other platforms it may be impossible to overcom=
e hardware
> limitations.
>

There is no reason you cannot make the rtc alarms work reliably on x86
hardware. Even if you may loose key events while suspending I think it
is still valuable to have reliable alarms. I gave an example earlier
why reliable alarms are useful (dvr application).

--=20
Arve Hj=F8nnev=E5g
