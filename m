From: Rob Landley <rob@landley.net>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Tue, 24 Sep 2013 16:23:48 -0500
Message-ID: <1380057828.1974.73@driftwood>
References: <yw1xpprywhad.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	Format=Flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1xpprywhad.fsf@unicorn.mansr.com> (from mans@mansr.com on
	Tue Sep 24 07:11:38 2013)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Pavel Machek <pavel@ucw.cz>, Will Deacon <will.deacon@arm.com>, Trivial patch monkey <trivial@kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

On 09/24/2013 07:11:38 AM, M=E5ns Rullg=E5rd wrote:
> Rob Landley <rob@landley.net> writes:
>=20
> > On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
> >> During 3.12-rc, Will Deacon introduced code into arch/arm that
> >> requires binutils 2.22.
> >
> > Um, my toolchain is using the last gplv2 snapshot of binutils out o=
f
> > git, which is just past 2.17 and can build armv7 (but not armv8).
> >
> > Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some
> > thought to have gone into that? Possibly a mention of it?
>=20
> I seriously doubt that 2.12 still works at all (I doubt it can even b=
e
> built on a modern system).  In my experience, binutils older than 2.1=
9
> or so rarely works properly for ARM.

I've been building every kernel release with 2.17 for several years, on=
 =20
a bunch of different architectures. Toolchain releases after that are =20
GPLv3* and I can't distribute those binaries, so I can't ship prebuilt =
=20
binary toolchains.

(Lots of other people produce cross compilers, but nobody else seems to=
 =20
produce prebuilt statically linked _native_ compilers. It would be nice=
 =20
if they did.)

> What value is there in maintaining compatibility with a truly ancient
> binutils version anyway?

What value is there in requiring the new toolchain? From what I could =20
see of the commits it was micro-optimizations around memory barriers.

*shrug* I can revert the patch locally, or patch the extra instruction =
=20
into my toolchain. But I do object to changing the documentation =20
globally for every architecture because one architecture did something =
=20
they apparently never thought through (or they'd have commented in the =
=20
commit that it requires a big toolchain version jump; pretty sure they =
=20
didn't actually notice).

Rob

* The Free Software Foundation got so pissed that MacOS X and BSD and =20
such were sticking with the last GPLv2 release of binutils that they =20
deleted the binutils tarball off their website and replaced it with one=
 =20
including GPLv3 source code. Check the FTP site if you don't believe =20
me. Some of us have it snapshotted though. In my case, I actually =20
fished the last GPLv2 version out of source control, right before the =20
license change was committed, because I wanted armv7 support.--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
