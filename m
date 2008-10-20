From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: Setting dss1_alwon_fck
Date: Tue, 21 Oct 2008 00:23:29 +0100
Message-ID: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
References: <1224504694.23383.11.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56260 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYJTXXq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 19:23:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ks469-0002vm-92
	for linux-omap@vger.kernel.org; Mon, 20 Oct 2008 23:23:41 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 23:23:41 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 23:23:41 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:

> Hi,
>
> Mans Rullgard has the patches mentioned below in his kernel tree at
> http://git.mansr.com/?p=3Dlinux-omap;a=3Dsummary . I currently have t=
hose
> patches and use the following sequence to set the dss1_alwon_fck cloc=
k:
>
> /* get the rate of the parent of dpll4_m4_ck, which is dpll4_ck */
> prate =3D clk_get_rate(clk_get_parent(dispc.dpll4_m4_ck));
>
> /* calculate divisor so that wanted dss1_alwon_fck is prate / div * 2=
=2E
>  * x2 because dss1_alwon_fck comes from dpll4_m4x2_ck */
> div =3D ...;
>
> /* set the rate */
> clk_set_rate(dispc.dpll4_m4_ck, prate / div);
>
> Is this the correct way to set dss1_alwon_fck?

It's the only way I could find.  I'd prefer if the mucking about with
get_parent() could be avoided, but Paul (I think) told me there was no
other way, at least not then.  Maybe it has changed since.

I'd also prefer to not do those divisor calculations.  However, I
could think of no other way to get the desired result, since
clock_set_rate() isn't aware of the cascaded dividers.

> Are the patches below needed, or can dss1_alwon_fck be set some
> other way?

At the time I wrote them, they were necessary.  If later changes to
the clock subsystem have made them obsolete, all the better.  I don't
recall seeing anything like that going in, though.

> commit e2de5e5578fbaa9b4b75074796da0608fc93e6ae
> Author: Mans Rullgard <mans@mansr.com>
> Date:   Tue Jul 22 01:58:18 2008 +0100
>
>     ARM: OMAP: add clk_get_parent() for OMAP2/3
>
>     Signed-off-by: Mans Rullgard <mans@mansr.com>
>
> :100644 100644 577be44... 28aec36... M  arch/arm/mach-omap2/clock.c
> :100644 100644 49245f7... 4aa69d5... M  arch/arm/mach-omap2/clock.h
> :100644 100644 54cc6e1... ed7af21... M  arch/arm/mach-omap2/clock24xx=
=2Ec
> :100644 100644 04dedec... 08c8c46... M  arch/arm/mach-omap2/clock34xx=
=2Ec
>
> commit 2b7b958dc79e51127d7a4ecf88ce12dbc6c31426
> Author: Mans Rullgard <mans@mansr.com>
> Date:   Tue Jul 22 01:31:11 2008 +0100
>
>     ARM: OMAP: make dpll4_m4_ck programmable with clk_set_rate()
>
>     Filling the set_rate and round_rate fields of dpll4_m4_ck makes
>     this clock programmable through clk_set_rate().  This is needed
>     to give omapfb control over the dss1_alwon_fck rate.
>
> :100644 100644 161da12... 876eb13... M  arch/arm/mach-omap2/clock34xx=
=2Eh

I'll send the patches as replies to this mail for easier reference.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
