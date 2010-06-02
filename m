From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 01:06:07 +0200
Message-ID: <20100603010607.5baf82a6@schatten.dmk.lab>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>
	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<1275451342.21962.1777.camel@mulgrave.site>
	<AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	<1275491111.2799.110.camel@mulgrave.site>
	<20100602214748.7742e3ae@schatten.dmk.lab>
	<1275511271.2799.516.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275511271.2799.516.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, mark.gross@intel.com, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Wed, 02 Jun 2010 15:41:11 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Wed, 2010-06-02 at 21:47 +0200, Florian Mickler wrote:
> > On Wed, 02 Jun 2010 10:05:11 -0500
> > James Bottomley <James.Bottomley@suse.de> wrote:
> >=20
> > > On Tue, 2010-06-01 at 21:41 -0700, Arve Hj=F8nnev=E5g wrote:
> > > > No, they have to be two separate constraints, otherwise a const=
raint
> > > > to block suspend would override a constraint to block a low pow=
er idle
> > > > mode or the other way around.
> > >=20
> > > Depends.  If you block the system from going into low power idle,=
 does
> > > that mean you still want it to be fully suspended?
> > >=20
> > > If yes, then we do have independent constraints.  If not, they ha=
ve a
> > > hierarchy:
> > >=20
> > >       * Fully Interactive (no low power idle or suspend)
> > >       * Partially Interactive (may go into low power idle but not
> > >         suspend)
> > >       * None (may go into low power idle or suspend)
> > >=20
> > > Which is expressable as a ternary constraint.
> > >=20
> > > James
> > >=20
> >=20
> > But unblocking suspend at the moment is independent to getting idle=
=2E
> > If you have the requirement to stay in the highest-idle level (i.e.
> > best latency you can get) that does not (currently) mean, that you =
can
> > not suspend.
>=20
> I don't understand that as a reason.  If we looks at this a qos
> constraints, you're saying that the system may not drop into certain =
low
> power states because it might turn something off that's currently bei=
ng
> used by a driver or a process.  Suspend is certainly the lowest state=
 of
> that because it turns everything off, why would it be legal to drop i=
nto
> that?
>=20
> I also couldn't find this notion of separation of idleness power from
> suspend blocking in the original suspend block patch set ... if you c=
an
> either tell me where it is, or give me an example of the separated us=
e
> cases, I'd understand better.
>=20
> > To preserve that explicit fall-through while still having working
> > run-time-powermanagement I think the qos-constraints need to be
> > separated.=20
>=20
> OK, as above, why?  or better yet, just give an example.

Hm. Maybe it is me who doesn't understand.=20

With proposed patchset:=20
1. As soon as we unblock suspend we go down.  (i.e. suspending)
2. While suspend is blocked, the idle-loop does it's things. (i.e.
runtime power managment -> can give same power-result as suspend)

possible cases:
1:=20
   - qos-latency-constraints: 1ms,  [here: forbids anything other than
     C1 idle state.]
   - suspend is blocked

2: - qos latency-constraints: as in 1
   - suspend unblocked

3: - qos latency-constraints: infinity, cpu in lowest power state.
   - suspend is blocked

4: - qos latency-constraints: infinity, cpu in lowest power state.
   - suspend unblocked


in case 2 and 4 we would suspend, regardeless of the qos-latency.

in case 1 and 3 we would stay awake, regardeless of the qos-latency
constraint.


If only one constraint, then case 2 (or 3) wouldn't be possible. But it
is possible now.=20

A possible use case as an example?
(hmm... i'm trying my imagination hard now):=20
	Your sound needs low latency, so that could be a cause for the
	qos-latency constraint.=20

	And unblocking suspend could nonetheless happen:
	For example... you have an firefox open and don't want to
	prevent suspend for that case when the display is turned off


Cheers,
=46lo
