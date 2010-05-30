From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sun, 30 May 2010 22:02:39 +0200
Message-ID: <201005302202.39511.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org> <201005292227.15479.rjw@sisk.pl> <AANLkTim6zsho4RSrseJostaOJe9lL4VNRKA3vDGJWJhK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTim6zsho4RSrseJostaOJe9lL4VNRKA3vDGJWJhK@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Saturday 29 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday 29 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Friday 28 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> On Fri, May 28, 2010 at 1:44 AM, Florian Mickler <florian@mickl=
er.org> wrote:
> >> >> > On Thu, 27 May 2010 20:05:39 +0200 (CEST)
> >> >> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > ...
> >> >> > To integrate this with the current way of doing things, i gat=
hered it
> >> >> > needs to be implemented as an idle-state that does the suspen=
d()-call?
> >> >> >
> >> >>
> >> >> I think it is better no not confuse this with idle. Since initi=
ating
> >> >> suspend will cause the system to become not-idle, I don't think=
 is is
> >> >> beneficial to initiate suspend from idle.
> >> >
> >> > It is, if the following two conditions hold simultaneously:
> >> >
> >> > (a) Doing full system suspend is ultimately going to bring you m=
ore energy
> >> >    savings than the (presumably lowest) idle state you're curren=
tly in.
> >> >
> >> > (b) You anticipate that the system will stay idle for a consider=
ably long time
> >> >    such that it's worth suspending.
> >> >
> >>
> >> I still don't think this matters. If you are waiting for in interr=
upt
> >> that cannot wake you up from suspend, then idle is not an indicato=
r
> >> that it is safe to enter suspend. I also don't think you can avoid=
 any
> >> user-space suspend blockers by delaying suspend until the system g=
oes
> >> idle since any page fault could cause it to go idle. Therefore I d=
on't
> >> see a benefit in delaying suspend until idle when the last suspend
> >> blocker is released (it would only mask possible race conditions).
> >
> > I wasn't referring to suspend blockers, but to the idea of initiati=
ng full
> > system suspend from idle, which I still think makes sense.  If you =
are
> > waiting for an interrupt that cannot wake you from suspend, then
> > _obviously_ suspend should not be started.  However, if you're not =
waiting for
> > such an interrupt and the (a) and (b) above hold, it makes sense to=
 start
> > suspend from idle.
> >
>=20
> What about timers? When you suspend timers stop (otherwise it is just
> a deep-idle mode), and this could cause problems. Some drivers rely o=
n
> timers if the hardware does not have a completion interrupt. It is no=
t
> uncommon to see send command x then wait 200ms in a some hardware
> specs.

QoS should be used in such cases.

Rafael
