From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/3] Add support for OMAP35x processors
Date: Sat, 10 Jan 2009 22:54:42 -0800
Message-ID: <200901102254.42829.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:41441 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750840AbZAKGyo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Jan 2009 01:54:44 -0500
In-Reply-To: <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 09 January 2009, Aguirre Rodriguez, Sergio Alberto wrote:
> > =A0comment "OMAP Board Type"
> > =A0=A0=A0=A0=A0=A0depends on ARCH_OMAP2 || ARCH_OMAP3
> >=20
> > @@ -107,7 +155,7 @@ config MACH_OMAP_2430SDP
> >=20
> > =A0config MACH_OMAP_LDP
> > =A0=A0=A0=A0=A0=A0bool "OMAP3 LDP board"
> > -=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMA=
P35XX
> >=20
> > =A0config MACH_OMAP2EVM
> > =A0=A0=A0=A0=A0=A0bool "OMAP 2530 EVM board"
> > @@ -115,11 +163,11 @@ config MACH_OMAP2EVM
> >=20
> > =A0config MACH_OMAP_3430SDP
> > =A0=A0=A0=A0=A0=A0bool "OMAP 3430 SDP board"
> > -=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMA=
P35XX
> >=20
> > =A0config MACH_OMAP3EVM
> > =A0=A0=A0=A0=A0=A0bool "OMAP 3530 EVM board"
> > -=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +=A0=A0=A0=A0=A0depends on ARCH_OMAP35XX
> >=20
> > =A0config MACH_OMAP3_BEAGLE
> > =A0=A0=A0=A0=A0=A0bool "OMAP3 BEAGLE board"
>=20
> Question to all,
>=20
> Why don't making above options as choice.. endchoice.

Because that completely breaks "multi-OMAP" builds.
Having kernels build (and work!) with multiple boards
has been a goal for some time now.

Switching that stuff to choice...endchoice would be
a major regression.  I wouldn't merge such a patch.


> Or is there any case that multiple boards are compiled at once?=20
=20
Yes, it's routine to build kernels that work with
multiple boards.  Example, mine work on Beagle,
Overo, and SDP.

Why do this?  Several reasons, all of which boil
down to better quality code.  The most obvious
ones are being able to build-test more systems
in the same amount of time ... and then being
able to run-test them without needing to waste
any time worrying if the behavioral change was
due to some odd Kconfig glitch, or is just a bug
to fix in the code.

The more subtle issues have to do with the
various changes that happen to make that
work well.  Example, board specific #ifdefs
in code start to vanish ... which is good,
since they hide lits of problems, and are
nasty coding style regardless.  Sometimes
getting rid of such #ifdeffery highlights
a much better code structure.

Ditto CPU-specific #ifdeffery, of the type
which these patches add.  Fix them so they
don't add #ifdeffery like that, and they
will be a lot better accepted...

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
