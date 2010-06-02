From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 21:47:48 +0200
Message-ID: <20100602214748.7742e3ae@schatten.dmk.lab>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>
	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<1275451342.21962.1777.camel@mulgrave.site>
	<AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	<1275491111.2799.110.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ist.d-labs.de ([213.239.218.44]:41800 "EHLO mx01.d-labs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758555Ab0FBTsA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 15:48:00 -0400
In-Reply-To: <1275491111.2799.110.camel@mulgrave.site>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, mark.gross@intel.com, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com

On Wed, 02 Jun 2010 10:05:11 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Tue, 2010-06-01 at 21:41 -0700, Arve Hj=F8nnev=E5g wrote:
> > No, they have to be two separate constraints, otherwise a constrain=
t
> > to block suspend would override a constraint to block a low power i=
dle
> > mode or the other way around.
>=20
> Depends.  If you block the system from going into low power idle, doe=
s
> that mean you still want it to be fully suspended?
>=20
> If yes, then we do have independent constraints.  If not, they have a
> hierarchy:
>=20
>       * Fully Interactive (no low power idle or suspend)
>       * Partially Interactive (may go into low power idle but not
>         suspend)
>       * None (may go into low power idle or suspend)
>=20
> Which is expressable as a ternary constraint.
>=20
> James
>=20

But unblocking suspend at the moment is independent to getting idle.
If you have the requirement to stay in the highest-idle level (i.e.
best latency you can get) that does not (currently) mean, that you can
not suspend.

To preserve that explicit fall-through while still having working
run-time-powermanagement I think the qos-constraints need to be
separated.=20

<disclaimer: just from what I read>
Provided you can reach the same power state from idle, current suspend
could probably also be implemented by just the freezing part and a hint
to the idle-loop to provide accelerated fall-through to lowest power.=20
</disclaimer>

At that point, you could probably merge the constraints.=20

But the freezing part is also the hard part, isn't it? (I have no
idea. Thomas seems to think about cgroups for that and doing smth about=
 the timers.)

Cheers,
=46lo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
