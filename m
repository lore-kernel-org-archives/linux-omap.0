From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Thu, 11 Sep 2014 21:42:15 +0200
Message-ID: <20140911194215.GO3755@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
 <20140911190136.GM3755@pengutronix.de>
 <20140911191449.GF18849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40563 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbaIKTm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 15:42:26 -0400
Content-Disposition: inline
In-Reply-To: <20140911191449.GF18849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Tony,

On Thu, Sep 11, 2014 at 12:14:50PM -0700, Tony Lindgren wrote:
> * Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [140911 12:0=
2]:
> > On Thu, Sep 11, 2014 at 10:39:43AM -0700, Tony Lindgren wrote:
> > > * Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [140910 =
01:27]:
> > > > of_device_ids (i.e. compatible strings and the respective data)=
 are not
> > > > supposed to change at runtime. All functions working with of_de=
vice_ids
> > > > provided by <linux/of.h> work with const of_device_ids. So mark=
 the
> > > > non-const function parameters and structs for OMAP2+ as const, =
too.
> > >=20
> > > Hmm this does not seem to compile with omap2plus_defconfig becaus=
e
> > > of section type conflicts. Looks like there's some issue now with=
 the
> > > use of __initconst:
> > >=20
> > > arch/arm/mach-omap2/board-generic.c:262:20: error: dra72x_boards_=
compat causes a section type conflict with omap_dt_match_table
> > > arch/arm/mach-omap2/board-generic.c:30:34: note: =E2=80=98omap_dt=
_match_table=E2=80=99 was declared here
> > > scripts/Makefile.build:257: recipe for target 'arch/arm/mach-omap=
2/board-generic.o' failed
> > The problem is dra74x_boards_compat though:
> >=20
> > 	static const char *dra74x_boards_compat[] __initconst =3D {
> > 		...
> >=20
> > *dra74x_boards_compat is const, but dra74x_boards_compat isn't, so
> > either the variable must go into __initdata or it must be declared =
as:
> >=20
> > 	static const char * const dra74x_boards_compat[] __initconst =3D {
> > 		...
>=20
> Ah OK.
> =20
> > (but then I guess you get another warning because struct machine_de=
sc's
> > dt_compat is declared as
> >=20
> > 	const char **dt_compat;
> >=20
> > .)
> >=20
> > With the patch below, arch/arm/mach-omap2/board-generic.c compiles =
just
> > fine. Don't know yet if the additional const in <asm/mach_desc.h> i=
s
> > problematic ...
>=20
> Yes OK thanks. It Would be nice to have those as __initconst to disca=
rd
> the unused ones.
__initdata is discarded, too, but I already send a patch that adds the
additional consts. On top of this one the patch from this thread is
fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
