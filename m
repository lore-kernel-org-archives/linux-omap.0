From: Rob Landley <rob@landley.net>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Thu, 26 Sep 2013 17:50:19 -0500
Message-ID: <1380235819.1974.94@driftwood>
References: <yw1x38oswrss.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	Format=Flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1x38oswrss.fsf@unicorn.mansr.com> (from mans@mansr.com on
	Wed Sep 25 15:49:07 2013)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andrew Morton <akpm@osdl.org>, Trivial patch monkey <trivial@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 09/25/2013 03:49:07 PM, M=E5ns Rullg=E5rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>=20
> > On Wed, Sep 25, 2013 at 10:23:06AM -0500, Rob Landley wrote:
> >> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
> >>> It could be as simple as making gas accept an extra argument for
> >>> instructions like dsb and just ignoring it.
> >>
> >> So you prefer I come up with the reversion patches locally and =20
> _not_
> >> send them upstream?
> >
> > This is a silly attitude.  What you're effectively saying is that w=
e
> > are never allowed to use any future ARM instructions in any Linux
> > kernel because that might break your precious assembler.
> >
> > I've got news for you.  We're *not* going to listen to that =20
> argument.
> >
> > END OF DISCUSSION (everything else is just a waste of time.)

Who am I to argue with capital letters?

> I fully agree.

Actually, I thought this was an armv5l regression. (My objection was to=
 =20
requiring a newer toolchain for architectures that built fine under the=
 =20
old one. My attention was attracted by the proposed patch to =20
Documentation/changes with a global updated for required binutils =20
version.)

I've since had a chance to confirm the armv5 build break I saw was just=
 =20
normal mid-rc1 noise (since fixed) and this set of patches just applies=
 =20
to armv7, which already required a newer binutils, so objection =20
withdrawn.

Rob--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
