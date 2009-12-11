From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v7 5/5] OMAP: McBSP: Split and move read/write functions to mach-omap1/2
Date: Fri, 11 Dec 2009 14:57:37 +0100
Message-ID: <200912111457.39439.jkrzyszt@tis.icnet.pl>
References: <200912092124.14430.jkrzyszt@tis.icnet.pl> <200912092134.32015.jkrzyszt@tis.icnet.pl> <20091211152116.4c471dca.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59984 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197AbZLKN51 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:57:27 -0500
In-Reply-To: <20091211152116.4c471dca.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

=46riday 11 December 2009 14:21:16 Jarkko Nikula napisa=C5=82(a):
> On Wed, 9 Dec 2009 21:34:30 +0100
>
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > > > > Almost ready with it, one more question: what do you think ab=
out
> > > > > splitting and moving omap_mcbsp_read()/_write() there as well=
? If
> > > > > you agree, should I submit 2 patches, one with this cleanup, =
the
> > > > > other one actually introducing cache support, or is one combi=
ned
> > > > > OK?
> > > >
> > > > Sounds good to me!
>
> ...
>
> > diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c
> > git/arch/arm/mach-omap1/mcbsp.c ---
> > git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-09 15:49:52.000000000 =
+0100
> > +++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-09 16:20:43.000000000 +=
0100
> >
> > +void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
>
> ...
>
> > diff -upr git.orig/arch/arm/mach-omap2/mcbsp.c
> > git/arch/arm/mach-omap2/mcbsp.c ---
> > git.orig/arch/arm/mach-omap2/mcbsp.c	2009-12-09 15:49:52.000000000 =
+0100
> > +++ git/arch/arm/mach-omap2/mcbsp.c	2009-12-09 16:20:43.000000000 +=
0100
> >
> > +void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
>
> These functions must be unique, otherwise multi-build is not possible
> (no idea can we do it for OMAP1?).

=46unction name duplication was my concern to, but since I did the same=
 before=20
in v5b of 3/4 and noone objected that particular piece of code, I took =
into=20
consideration that it could be acceptable in case of OMAP1 vs. OMAP2/3/=
4.

> IMO, the _write and _read functions in ./plat-omap/mcbsp.c are clean
> after the patch 3/5 anyway so probably we don't need this splitting?

I agree (just tried to endear myself to Tony ;) ).

Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
