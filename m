From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 15:29:42 +0200
Message-ID: <201006061529.42523.rjw@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006060103.20540.rjw@sisk.pl> <AANLkTikXUTZE1vesD-Ccn8VhPjhBYYS0Tw_Pq9u5nnq7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikXUTZE1vesD-Ccn8VhPjhBYYS0Tw_Pq9u5nnq7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> 2010/6/4 Matt Helsley <matthltc@us.ibm.com>:
> >> >> > On Fri, Jun 04, 2010 at 05:39:17PM -0700, Arve Hj=F8nnev=E5g =
wrote:
> >> >> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutr=
onix.de> wrote:
> >> >> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
> >> >> >
> >> >> > <snip>
> >> >> >
> >> >> >>
> >> >> >> >     With the cgroup freezer you can "suspend" them right a=
way and
> >> >> >> >     just keep the trusted background task(s) alive which a=
llows us to
> >> >> >> >     go into deeper idle states instead of letting the crap=
plications
> >> >> >> >     run unconfined until the download finished and the sus=
pend
> >> >> >> >     blocker goes away.
> >> >> >> >
> >> >> >>
> >> >> >> Yes this would be better, but I want it in addition to suspe=
nd, not
> >> >> >> instead of it. It is also unclear if our user-space code cou=
ld easily
> >> >> >> make use of it since our trusted code calls into untrusted c=
ode.
> >> >> >>
> >> >> >
> >> >> > Perhaps I'm misunderstanding, but suspend and the cgroup free=
zer
> >> >> > interoperate well today -- you don't have to choose one or th=
e other.
> >> >> > If you've discovered otherwise I'd consider it a bug and woul=
d like to
> >> >> > hear more about it.
> >> >> >
> >> >>
> >> >> I'm not aware of any bug with combining both, but we cannot use
> >> >> suspend at all without suspend blockers in the kernel (since wa=
keup
> >> >> events may be ignored)
> >> >
> >> > The more I think of it, the more it appears to me that the probl=
em of
> >> > lost wakeup events can actually be solved without suspend blocke=
rs.
> >> > I'll send a bunch of patches to address this issue, probably tom=
orrow.
> >> >
> >>
> >> I know of two ways to prevent lost wakeup events. Reset a timeout
> >> every time you receive a wakeup event or prevents suspend until yo=
u
> >> know the event has been fully processed. Does your solution fall o=
nto
> >> one of these two categories, or do you have a third way?
> >
> > Basically, it involves two mechanisms, detection of wakeup events o=
ccuring
> > right before suspend is started
>=20
> This sounds like the timeout approach which I thought you did not lik=
e.
>=20
> > and aborting suspend if wakeup events occur
> > in the middle of it.
> >
> Aborting suspend is easy, but when do you allow suspend again?

I would recommend you to wait for the patches and then comment. :-)

> >> >> and I don't know how we can safely freeze
> >> >> cgroups without funneling all potential wakeup events through a
> >> >> process that never gets frozen.
> >> >
> >> > If your untrusted apps get called by the trusted ones, they aren=
't really
> >> > untrusted in the first place.
> >> >
> >> That is not a correct statement. A trusted apps can call into an
> >> untrusted app, it just has to validate the response and handle not
> >> getting a response at all. There are also different levels of trus=
t. I
> >> may have trusted an app to provide a contact pictures, but not tru=
sted
> >> it to block suspend. When the phone rings the app will be called t=
o
> >> provide the picture for the incoming call dialog, but if it is fro=
zen
> >> at this point the more trusted app that handles the incoming phone
> >> call will not be able to get the picture.
> >
> > It will be able to do that if it causes the frozen part of user spa=
ce to be
> > thawed.
> >
> > I think you have this problem already, though, because you use full=
 system
> > suspend and all of your apps are frozen by it.  So, to handle the s=
ituation you
> > describe above, you need to carry out full system resume that will =
thaw the
> > tasks for you.  I don't see any fundamental difference betwee the t=
wo cases.
> >
>=20
> Yes, we can keep all our user space suspend blockers and thaw the
> frozen cgroup when any suspend blocker is held, but this would
> eliminate any power advantage that freezing a cgroup has over using
> suspend to freeze all processes.

Why does it have to have _any_ power advantage?  It's totally sufficien=
t if it
gives you approximately the same power savings.  IOW, it doesn't have t=
o be
_better_ if it's acceptable to the kernel people at  large.

The rest of your objections have been addressed by Alan, so I'm not goi=
ng to
repeat his arguments.

Rafael
