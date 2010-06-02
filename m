From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 02 Jun 2010 15:41:11 -0500
Message-ID: <1275511271.2799.516.camel@mulgrave.site>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	 <20100601135102.GA8098@srcf.ucam.org>
	 <1275426085.21962.967.camel@mulgrave.site> <201006020024.14220.rjw@sisk.pl>
	 <1275431816.21962.1108.camel@mulgrave.site>
	 <AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	 <1275451342.21962.1777.camel@mulgrave.site>
	 <AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	 <1275491111.2799.110.camel@mulgrave.site>
	 <20100602214748.7742e3ae@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45913 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758728Ab0FBUlT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jun 2010 16:41:19 -0400
In-Reply-To: <20100602214748.7742e3ae@schatten.dmk.lab>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, mark.gross@intel.com, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com

On Wed, 2010-06-02 at 21:47 +0200, Florian Mickler wrote:
> On Wed, 02 Jun 2010 10:05:11 -0500
> James Bottomley <James.Bottomley@suse.de> wrote:
>=20
> > On Tue, 2010-06-01 at 21:41 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> > > No, they have to be two separate constraints, otherwise a constra=
int
> > > to block suspend would override a constraint to block a low power=
 idle
> > > mode or the other way around.
> >=20
> > Depends.  If you block the system from going into low power idle, d=
oes
> > that mean you still want it to be fully suspended?
> >=20
> > If yes, then we do have independent constraints.  If not, they have=
 a
> > hierarchy:
> >=20
> >       * Fully Interactive (no low power idle or suspend)
> >       * Partially Interactive (may go into low power idle but not
> >         suspend)
> >       * None (may go into low power idle or suspend)
> >=20
> > Which is expressable as a ternary constraint.
> >=20
> > James
> >=20
>=20
> But unblocking suspend at the moment is independent to getting idle.
> If you have the requirement to stay in the highest-idle level (i.e.
> best latency you can get) that does not (currently) mean, that you ca=
n
> not suspend.

I don't understand that as a reason.  If we looks at this a qos
constraints, you're saying that the system may not drop into certain lo=
w
power states because it might turn something off that's currently being
used by a driver or a process.  Suspend is certainly the lowest state o=
f
that because it turns everything off, why would it be legal to drop int=
o
that?

I also couldn't find this notion of separation of idleness power from
suspend blocking in the original suspend block patch set ... if you can
either tell me where it is, or give me an example of the separated use
cases, I'd understand better.

> To preserve that explicit fall-through while still having working
> run-time-powermanagement I think the qos-constraints need to be
> separated.=20

OK, as above, why?  or better yet, just give an example.

> <disclaimer: just from what I read>
> Provided you can reach the same power state from idle, current suspen=
d
> could probably also be implemented by just the freezing part and a hi=
nt
> to the idle-loop to provide accelerated fall-through to lowest power.=
=20
> </disclaimer>
>=20
> At that point, you could probably merge the constraints.=20
>=20
> But the freezing part is also the hard part, isn't it? (I have no
> idea. Thomas seems to think about cgroups for that and doing smth abo=
ut the timers.)

Um, well, as I said, I think using suspend from idle and freezer is
longer term.  I think if we express the constraints as qos android can
then use them to gate when to enter S3 .. which is functionally
equivalent to suspend blockers.  And the vanilla kernel can use them to
gate power states for the drivers in suspend from idle.

James


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
