From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 21:49:39 +0200
Message-ID: <20100605214939.49dd0ee0@schatten.dmk.lab>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275149418.4503.128.camel@mulgrave.site>
	<1275156734.1645.496.camel@laptop>
	<201005312314.12391.rjw@sisk.pl>
	<AANLkTil4DLUciWMVmCiiygS2Y1vLZu0Lnfys-w4q3L7W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTil4DLUciWMVmCiiygS2Y1vLZu0Lnfys-w4q3L7W@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>, tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Sat, 5 Jun 2010 20:16:33 +0300
=46elipe Contreras <felipe.contreras@gmail.com> wrote:

> On Tue, Jun 1, 2010 at 12:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
> > Do you realistically think that by hurting the _user_ you will make=
 the
> > _developer_ write better code? =A0No, really.
>=20
> As an application writer, if my users complain that their battery is
> being drained (as it happened), they stop using it, and other people
> see there are problems, so they stop using it, if people get angry
> about it they will vote it down.
>=20
> New users will see it has low score; they will not install it. That's
> a network effect.
>=20
> Having users is the quintessential reason people write code.
>=20

That is nice. But how does it impact the problem that suspend blockers
solve? And why do suspend blockers interfere with that?

Cheers,
=46lo
