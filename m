From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Wed, 18 Feb 2015 22:14:59 +0100
Message-ID: <201502182214.59888@pali>
References: <20131206213613.GA19648@earth.universe> <201502112128.44852@pali> <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15000533.yA9aAdqIEO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--nextPart15000533.yA9aAdqIEO
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 February 2015 21:40:33 Nishanth Menon wrote:
> On Wed, Feb 11, 2015 at 2:28 PM, Pali Roh=C3=A1r=20
<pali.rohar@gmail.com> wrote:
> > On Wednesday 11 February 2015 16:22:51 Matthijs van Duin=20
wrote:
> >> On 11 February 2015 at 13:39, Pali Roh=C3=A1r
> >> <pali.rohar@gmail.com>
> >=20
> > wrote:
> >> >> Anyhow, since checking the firewalls/APs to see if you
> >> >> have permission will probably only get you yet another
> >> >> fault if things are walled off, the robust way of
> >> >> dealing with this sort of situation is by probing the
> >> >> device with a read while trapping bus faults. This also
> >> >> handles modules that are unreachable for other reasons,
> >> >> e.g. being disabled by eFuse.
> >> >=20
> >> > It is possible to patch kernel code to mask or ignore
> >> > that fault? Can you help me with something like that?
> >>=20
> >> As I mentioned, I'm still learning my way around the
> >> kernel, so I don't feel very comfortable suggesting a
> >> concrete patch just yet. I've been browsing arch/arm/mm/
> >> however and my impression is that all that would be
> >> required is editing fault.c by making a copy of do_bad but
> >> containing
> >>=20
> >>     return user_mode(regs) || !fixup_exception(regs);
> >>=20
> >> and hook it onto the appropriate fault codes.  However,
> >> this really needs the opinion of someone more familiar
> >> with this code.
> >>=20
> >> I do have an observation to make on the issue of fault
> >> decoding: the list in fsr-2level.c may be "standard ARMv3
> >> and ARMv4 aborts" but they are quite wrong for ARMv7 which
> >> has:
> >>=20
> >> [ 0] -
> >> [ 1] alignment fault
> >> [ 2] debug event
> >> [ 3] section access flag fault
> >> [ 4] instruction cache maintainance fault (reported via
> >> data abort) [ 5] section translation fault
> >> [ 6] page access flag fault
> >> [ 7] page translation fault
> >> [ 8] bus error on access
> >> [ 9] section domain fault
> >> [10] -
> >> [11] page domain fault
> >> [12] bus error on section table walk
> >> [13] section permission fault
> >> [14] bus error on page table walk
> >> [15] page permission fault
> >> [16] (TLB conflict abort)
> >> [17] -
> >> [18] -
> >> [19] -
> >> [20] (lockdown abort)
> >> [21] -
> >> [22] async bus error (reported via data abort)
> >> [23] -
> >> [24] async parity/ECC error (reported via data abort)
> >> [25] parity/ECC error on access
> >> [26] (coprocessor abort)
> >> [27] -
> >> [28] parity/ECC error on section table walk
> >> [29] -
> >> [30] parity/ECC error on page table walk
> >> [31] -
> >>=20
> >> Some entries are patched up near the bottom of fault.c but
> >> many bogus messages remain, for example the "on linefetch"
> >> vs "on non-linefetch" is misleading since no such thing
> >> can be inferred from the fault status on v7.  Also, the
> >> i-cache maintenance fault handling looks wrong to me: it
> >> should fetch the actual fault status from IFSR (even
> >> though the address still comes from DFSR) and dispatch
> >> based on that.
> >>=20
> >> Async external aborts (async bus error and async parity/ECC
> >> error) give you basically no info. DFAR will contain
> >> garbage hence displaying it will confuse rather than
> >> enlighten, a traceback is pointless since the instruction
> >> that caused the access is long retired, likewise
> >> user_mode() doesn't matter since a transition to kernel
> >> space may have happened after the access that cause the
> >> abort. Basically they should be treated more as an IRQ
> >> than as a fault (note they can also be masked just like
> >> irqs). In case of a bus error, it may be appropriate to
> >> just warn about it, or perhaps send a signal to the
> >> current process, although in the latter case it should
> >> have some means to distinguish it from a synchronous bus
> >> error.
> >>=20
> >> At least on the cortex-a8, a parity/ECC error (whether
> >> async or not) is to be regarded as absolutely fatal.=20
> >> Quoth the TRM: "No recovery is possible. The abort handler
> >> must disable the caches, communicate the fail directly
> >> with the external system, request a reboot."
> >>=20
> >> Bit 10 no longer indicates an asynchronous (let alone
> >> imprecise) fault.  Apart from the debug events and async
> >> aborts (and possibly some implementation-defined aborts),
> >> all aborts listed are synchronous, and DFAR/IFAR is valid.
> >> There's no technical obstruction to make these trappable
> >> via the kernel exception handling mechanism. (Though at
> >> least in case of parity/ECC errors one shouldn't.)
> >=20
> > Tony, Nishanth, or somebody else... can you help with memory
> > management? Or do you know some expert for arch/arm/mm/
> > code?
>=20
> Folks in linux-arm-kernel are probably the right people, I
> suppose. Looping them in.

Hi folks in linux-arm-kernel!

Can you help us with above problem? How to catch external abort=20
on non-linefetch in kernel driver and prevent kernel panic?

Here is that kernel panic log:=20
http://thread.gmane.org/gmane.linux.ports.arm.omap/108397/

We want to check for "Unhandled fault: external abort on non-
linefetch" and if it happens disable some functionality in kernel=20
driver omap-aes.ko

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart15000533.yA9aAdqIEO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTlANMACgkQi/DJPQPkQ1KJ9gCfWH0MnXd4Wty3GqPfu+LahzRV
pEEAn0RXM0pGhqcx4Iw2UGVF1JIBdWkb
=uwwu
-----END PGP SIGNATURE-----

--nextPart15000533.yA9aAdqIEO--
