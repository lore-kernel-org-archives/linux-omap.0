From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 25 May 2010 01:38:16 +0200
Message-ID: <201005250138.16293.rjw@sisk.pl>
References: <1274482015-30899-1-git-send-email-arve@android.com> <201005242049.18920.rjw@sisk.pl> <87wrusvrqe.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87wrusvrqe.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: felipe.balbi@nokia.com, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 25 May 2010, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>=20
> > On Monday 24 May 2010, Felipe Balbi wrote:
> >> On Mon, May 24, 2010 at 02:46:54AM +0200, ext Rafael J. Wysocki wr=
ote:
> >> >On Saturday 22 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> This patch series adds a suspend-block api that provides the sa=
me
> >> >> functionality as the android wakelock api. This version adds a
> >> >> delay before suspending again if no suspend blockers were used
> >> >> during the last suspend attempt.
> >> >
> >> >Patches [1-6/8] applied to suspend-2.6/linux-next
> >>=20
> >> funny thing is that even without sorting out the concerns plenty o=
f=20
> >> developers had on the other thread, this series is still taken. Wh=
at's=20
> >> the point in dicussing/reviewing the patches then ?
> >
> > I don't think the concerns you're referring to can be solved out. =20
> > Some people just don't like the whole idea and I don't think there'=
s
> > any way we can improve the patches to make them happy.  The only
> > "solution" they would be satisfied with would simply be rejecting
> > the feature altogether, although there are no practically viable
> > alternatives known to me.
>=20
> I'm not sure who the "some people" you're referring to are, but I'll
> assume I'm included in that group.
>=20
> I don't think this is a fair characterization of the objections, nor
> do I think "rejecting the feature altogether" is the only satisfactor=
y
> answer.  Speaking for myself, I find the idea of being able to suspen=
d
> while idle a valid objective, and certainly see the usefulness of it
> for embedded systems.  I'm also an owner and user of an Android phone=
,
> so I am certainly not out just to make life difficult for Android.
>=20
> The primary objection is not the end goal, but rather the
> implementation.  In particular, the problematic redefintion of what i=
t
> means to be idle, or "not doing work that's immediately useful to the
> user" to use the phrase from the changelog (where "useful" is still
> not defined.)

So, in fact, you don't like the _idea_, because the _idea_ is to use su=
spend
blockers instead of trying to define what "idle" means.

I don't think it's generally possible to define "idle" to match every p=
ossible
criteria one can imagine, so you're request to do that simply cannot be
satisfied.

> This (re)definition completely bypasses all current idle
> infrastructure based on timers, scheduler, etc. and makes "usefulness=
"
> defined in terms of who holds suspend blockers.

That's because the point is not to suspend when the system is "idle", b=
ecause
that would mean "suspend transparently from the applications' point of =
view",
which is what the Android people _don't_ _want_ _to_ _do_, because in t=
hat
case their battery life would go to the toilet.  The idea is to suspend=
 even
when the system is not techincally "idle" and you don't like _that_.

> This of course will lead to a scattering of suspend blockers into any
> drivers/subsystems considered "useful", which by looking through curr=
ent
> Android kernels is many of them.

That depends on the maintainers of these subsystems, who still have the=
 power
to reject requested changes.

As I said before, I don't think there's a way to resolve this so that e=
veryone
is happy and in my opinion there are reasons to merge the feature.

Also I don't think we can make any progress discussing it.  We've alrea=
dy
discussed it for a month or so without any real progress and I don't se=
e how
that's going to change now.

Thanks,
Rafael
