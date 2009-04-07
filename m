From: David Brownell <david-b@pacbell.net>
Subject: Re: Preempt-RT on OMAP3?
Date: Mon, 6 Apr 2009 19:27:09 -0700
Message-ID: <200904061927.09627.david-b@pacbell.net>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com> <200904061520.59391.david-b@pacbell.net> <5a7b8b7b0904061912i47d9f87fr507816fe3f189ecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n30.bullet.mail.mud.yahoo.com ([68.142.207.49]:35235 "HELO
	n30.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751590AbZDGC1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 22:27:13 -0400
In-Reply-To: <5a7b8b7b0904061912i47d9f87fr507816fe3f189ecc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: linux-omap@vger.kernel.org


> > RX DMA is troublesome with the MUSB code, and there are some bugfix=
es
> > pending which should affect it. =A0(Posted to linux-usb over the la=
st
> > week or two.)
> >
> > Do these problems show up with DMA disabled?
>=20
> I guess you mean with CONFIG_MUSB_PIO_ONLY - yes, I've tried that. I
> don't observe the Rx DMA problems as described previously in that
> configuration, no ........=20

Good...


> However I instead I see hard-lockups with=20
> no obvious cause and no messages printed to the console. (The only
> repeatable one I've found so far is exiting cyclictest with ^C. Not
> good). These lockups could well be and probably are unrelated, but
> none-the-less, it's very troubling!

Given the bootlog excerpt you posted, I'm thinking there are
still some basic goofy things with the RT patches you're using
even outside the scope of MUSB.  Basic as in timer tick and
kernel thread setup; lots of things look goofy.


=20
> I've uploaded my defconfig here:
> http://hugovincent.com/files/lkml-20090407/
> along with a log of the bootup process. I've enabled a bunch of debug
> options and self-tests. You can see the rather verbose output of some
> spinlock tests (I think) failing early in the bootup process,
> somewhere in timer initialization (I think?).

Those look like lockdep things.  Get a more complete boot log
and maybe someone will be able to sort out what's up.

- Dave



>=20
> Regards,
> Hugo
>=20
>=20



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
