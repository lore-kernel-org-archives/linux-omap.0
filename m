From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 10:28:19 +0200
Message-ID: <20100529102819.21732783@schatten.dmk.lab>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<20100528114123.GA22947@srcf.ucam.org>
	<4BFFB681.1000105@nokia.com>
	<AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>
	<4BFFC5DF.5030504@nokia.com>
	<AANLkTikKGeGHHL6AYC7uBuT7Zihj7lozfidWQ8zRHwab@mail.gmail.com>
	<4BFFCF39.3010507@nokia.com>
	<AANLkTinyh1YLmL6miVAxvkh9RMYDY5JChA-_f7oN0zvb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinyh1YLmL6miVAxvkh9RMYDY5JChA-_f7oN0zvb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, ext Brian Swetland <swetland@google.com>, ext Matthew Garrett <mjg59@srcf.ucam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 29 May 2010 02:42:35 +0300
=46elipe Contreras <felipe.contreras@gmail.com> wrote:

> On Fri, May 28, 2010 at 5:12 PM, Igor Stoppa <igor.stoppa@nokia.com> =
wrote:
> > ext Brian Swetland wrote:
> >> How is it flawed? =A0Serious question.
> >
> > I would avoid repeating all the good arguments given so far, but to=
 make it
> > short:
> >
> > * I believe runtime PM is a much better starting point (at least fo=
r the
> > type of HW targeted at mobile devices) because it mimics an always-=
on system
> > toward userspace, which requires less disruption in the way apps ar=
e
> > designed
>=20
> I agree.
>=20
> If I understand correctly, if we have a perfect user-space that only
> does work when strictly needed and trying to do it in bursts, then we
> would be reaching the lowest power state, and there would be no need
> for suspend. The problem is that Android's user-space is pretty far
> from that, so they said "let's segregate user-space and go to lower
> power mode anyway".

This has already been mentioned (who knew?): Android doesn't
want to depend on userspace for this.

Cheers,
=46lo
