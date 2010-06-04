From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 03:09:38 -0700
Message-ID: <AANLkTimCOcDbeBsvE4ztZXgJISKn49Ela5P8eWGeUjtQ@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
	<20100604075722.GA15181@elte.hu>
	<AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
	<20100604085513.GE15181@elte.hu>
	<AANLkTinphtxn-8pGTYv_mBxKFMa7jU8i1yNbHrs50Vzl@mail.gmail.com>
	<20100604095917.GA3324@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100604095917.GA3324@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 4, 2010 at 2:59 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> You can certainly put in a suspend_blockers.h thing into some Android
> directory, and populate it with empty wrappers - as long as you only =
use it
> within Android drivers and not core kernel code or other subsystems y=
ou dont
> maintain.
>
> It's being done all the time and helpful cleanup patches eliminating =
the stubs
> are frowned upon (unless the subs are there like for years with no pr=
ogress
> and no maintenance in sight).
>
> Putting empty stubs into include/linux/ would be pushing things i thi=
nk.
>
> In fact sometimes architectures even jump the gun with major kernel f=
eatures:
> we had a dynticks implementation in ARM for years, we had RTLinux stu=
bs in x86
> code for quite some time, and we still have perfmon in IA64 - despite=
 the core
> kernel having gone for a different design.
>
> It's certainly not ideal, but it's certainly a solution that is used =
every now
> and then. The less difference there is between trees the easier it be=
comes to
> merge - for both sides, both technically and socially.

Totally -- our goal would be that as drivers find their way from our
tree to mainline we'd keep them 1:1 between the trees.  If we can it a
local suspend_blocker.h somewhere while the long term solution gets
hashed out that'd remove the biggest painpoint on a driver level.  I'm
not quite sure where the best place to drop such a thing would be --
we'd likely be including it from mach-msm, mach-tegra2, and drivers
for both those architectures in the normal driver places for the tree.
I guess we could just drop it in
arch/arm/mach-{msm,tegra2}/include/mach/ and both the subarch code and
subarch-specific-drivers we've been writing could pick it up via
#include <mach/suspend_blockers.h>

>> Yeah, I do understand that we're not making it easy for ourselves he=
re. =C2=A0I
>> think we hit the point where Rafael and Matthew signed off on things=
 and
>> thought "aha, linux-pm maintainers are happy, now we're getting some=
where"
>> only to realize the light at the end of the tunnel was a bit further=
 out
>> than we anticipated ^^
>
> That's a well-known problem on lkml: the light at the end of the tunn=
el was
> the other train ;-)
>
> Anyway, i'm not pessimistic at all: _some_ sort of scheme appears to =
be
> crystalising out today. Everyone seems to agree now that the main use=
cases are
> indeed useful and need handling one way or another - the rest is real=
ly just
> technological discussions how to achieve the mostly-agreed-upon end g=
oal.
>
> The worst situation are features where one side says 'we dont need th=
is kind
> of functionality at all' - IMO auto/opportunistic-suspend isnt in tha=
t
> situation, fortunately.

It is encouraging that there's at least some general consensus that
the feature is useful, and as Arve and I have both mentioned, we're
really not religious about names, etc, provided we can solve the
problem we're trying to solve, so if it ends up being qos constraints
or something else entirely but still gets us where we're trying to go,
it's good news.

I think one point of contention remaining may be "just blocking
suspend" vs "halting specific untrusted processes".  The latter is
difficult for us to work with because of the overall complexity of
(our) userspace environment.  A big hammer where we stop it all and
suspend ends up being less deadlock/inversion-prone.  Of course if the
general solution ends up being able to do either, then perhaps
everyone's happy.

Brian
