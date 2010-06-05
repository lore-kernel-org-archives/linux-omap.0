From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 03:33:00 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
References: <20100603193045.GA7188@elte.hu> <20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-341504658-1275701128=:2933"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
Content-ID: <alpine.LFD.2.00.1006050326410.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-341504658-1275701128=:2933
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.LFD.2.00.1006050326411.2933@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o551Xlcm005039

Arve,

On Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
> >> I kind of agree here, so I'd like to focus a bit on that.
> >>
> >> Here's my idea in the very general terms:
> >>
> >> (1) Use the cgroup freezer to "suspend" the "untrusted" apps (ie. th=
e ones
> >> =A0 =A0 that don't use suspend blockers aka wakelocks in the Android=
 world) at the
> >> =A0 =A0 point Android would normally start opportunistic suspend.
> >
> > There is an additional benefit to this approach:
> >
> > =A0 =A0 In the current android world a background task (e.g. download
> > =A0 =A0 initiated before the screensaver kicked in) prevents the susp=
end,
> > =A0 =A0 but that also means that the crapplications can still suck po=
wer
> > =A0 =A0 completely unconfined.
> >
>=20
> Yes this can happen. It is usually only a big problem when you combine
> an (trusted) application that has a bug that blocks suspend forever
> with an application that wakes up too often for us to enter low power
> idle modes.

Why is it a BUG in the trusted app, when I initiate a download and put
the phone down ?

That download might take a minute or two, but that's not an
justification for the crapplication to run unconfined and prevent
lower power states.

> > =A0 =A0 With the cgroup freezer you can "suspend" them right away and
> > =A0 =A0 just keep the trusted background task(s) alive which allows u=
s to
> > =A0 =A0 go into deeper idle states instead of letting the crapplicati=
ons
> > =A0 =A0 run unconfined until the download finished and the suspend
> > =A0 =A0 blocker goes away.
> >
>=20
> Yes this would be better, but I want it in addition to suspend, not
> instead of it. It is also unclear if our user-space code could easily
> make use of it since our trusted code calls into untrusted code.

Sorry, that's really the worst argument I saw in this whole
discussion.=20

You're basically saying, that you have no idea what your user space
stack is doing and you do not care at all as long as your suspend
blocker scheme makes things work somehow.

Up to that point, I really tried hard to step back from my initial
"OMG, promoting crap is a nono" reaction and work with you on a
sensible technical solution to confine crap and make it aligned with
other efforts in this area.

So now, after I spent a reasonable amount of time (as you did) to
understand what your requirements are, you come up with another
restriction which is so outside of any level of sanity, that I'm at
the point of giving up and just going into NAK mode.

Can you please answer the following question:

    What is the point of having the distinction of "trusted" and
    "untrusted" when you have no way to prevent "trusted" code calling
    "into "untrusted" code ?

That's violating any sense of abstraction and layering and makes it
entirely clear that the only way you can deal with your own design
failure is a big hammer which you need to force into the kernel.

Sorry, no. I'm perfectly willing to make progress on that, as long as
we walk on a sane ground. But abusing the kernel for fixing basic
engineering problems in the user space side of affairs is completely
out of discussion.

> >> I wonder what people think. =A0Is this realistic and if so, would it=
 be difficult
> >> to implement?
> >
> > I think it's realistic and not overly complicated to implement.
> >
>=20
> The kernel support can be easily implemented on most arm hardware, I
> don't know if it can work on most existing x86 hardware. It does not

It does not matter. Even Intel folks told you more than once, that x86
hardware is going to be fixed pretty soon. Hint: that's crucial to
their business ....

> give us the same power savings as suspend with existing software, but
> it can handle bad apps better (assuming you don't combine
> opportunistic suspend and cgroup freezing). The biggest hurdle is how
> to handle dependencies between processes that gets frozen and
> processes that don't get frozen.

See above.

Thanks,

	tglx
--8323328-341504658-1275701128=:2933
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-341504658-1275701128=:2933--
