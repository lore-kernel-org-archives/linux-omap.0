From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 20:25:11 +0200
Message-ID: <201006052025.11526.rjw@sisk.pl>
References: <20100603193045.GA7188@elte.hu>
	<20100605011826.GB21016@count0.beaverton.ibm.com>
	<AANLkTim3MMfJ6oa9OhUJch_v1qGyxSfrfxF3zDZhxqHk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTim3MMfJ6oa9OhUJch_v1qGyxSfrfxF3zDZhxqHk@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/4 Matt Helsley <matthltc@us.ibm.com>:
> > On Fri, Jun 04, 2010 at 05:39:17PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
> >
> > <snip>
> >
> >>
> >> >     With the cgroup freezer you can "suspend" them right away and
> >> >     just keep the trusted background task(s) alive which allows us to
> >> >     go into deeper idle states instead of letting the crapplications
> >> >     run unconfined until the download finished and the suspend
> >> >     blocker goes away.
> >> >
> >>
> >> Yes this would be better, but I want it in addition to suspend, not
> >> instead of it. It is also unclear if our user-space code could easily
> >> make use of it since our trusted code calls into untrusted code.
> >>
> >
> > Perhaps I'm misunderstanding, but suspend and the cgroup freezer
> > interoperate well today -- you don't have to choose one or the other.
> > If you've discovered otherwise I'd consider it a bug and would like to
> > hear more about it.
> >
> =

> I'm not aware of any bug with combining both, but we cannot use
> suspend at all without suspend blockers in the kernel (since wakeup
> events may be ignored)

The more I think of it, the more it appears to me that the problem of
lost wakeup events can actually be solved without suspend blockers.
I'll send a bunch of patches to address this issue, probably tomorrow.

> and I don't know how we can safely freeze
> cgroups without funneling all potential wakeup events through a
> process that never gets frozen.

If your untrusted apps get called by the trusted ones, they aren't really
untrusted in the first place.

>From what you're saying it follows that you're not really willing to accept
any solution different to your suspend blockers.  Is that really the case?

Rafael
