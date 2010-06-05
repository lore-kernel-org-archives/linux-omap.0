From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 15:23:26 -0700
Message-ID: <20100605152326.7ccd5160@infradead.org>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 5 Jun 2010 14:26:14 -0700
Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:

> On Sat, Jun 5, 2010 at 9:28 AM, Arjan van de Ven
> <arjan@infradead.org> wrote:
> > On Sat, 05 Jun 2010 11:54:13 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >> On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> >> > > Trusted processes are assumed to be sane and idle when there i=
s
> >> > > nothing for them to do, allowing the machine to go into deep
> >> > > idle states.
> >> > >
> >> >
> >> > Neither the kernel nor our trusted user-space code currently
> >> > meets this criteria.
> >>
> >> Then both need fixing. Really, that's the only sane approach.
> >
> > fwiw... in MeeGo we're seeing quite good idle times (> 1 seconds)
> > without really bad hacks.
> >
>=20
> We clearly have different standards for what we consider good. We
> measure time suspended in minutes or hours, not seconds, and waking u=
p
> every second or two causes a noticeable decrease in battery life on
> the hardware we have today.

I guess I'm spoiled working with (unreleased) hardware that knows how
to power gate ;-)


>=20
> > the kernel has a set of infrastructure already to help here (range
> > timers, with which you can wakeup-limit untrusted userspace crap),
> > timer slack for legacy background timers, etc etc.
>=20
> Range timers allows the kernel to align different timers so they don'=
t
> each bring the cpu out of idle individually. They do not eliminate
> timers or make individual timers fire less often.

you're incorrect.
With range timers you can control the rate at which timers fire just
fine.=20

=46or example if the Adobe Flash player puts a timer every 10
milliseconds (yes it does that), and you give it a 3.99 seconds range,
it will fire its timers every 4 seconds.... unless other activity
happens independently, at which point it'll align with that instead.



--=20
Arjan van de Ven 	Intel Open Source Technology Centre
=46or development, discussion and tips for power savings,=20
visit http://www.lesswatts.org
