From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Thu, 11 Sep 2014 12:14:50 -0700
Message-ID: <20140911191449.GF18849@atomide.com>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
 <20140911190136.GM3755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60615 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753112AbaIKTO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 15:14:56 -0400
Content-Disposition: inline
In-Reply-To: <20140911190136.GM3755@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [140911 12:02]=
:
> On Thu, Sep 11, 2014 at 10:39:43AM -0700, Tony Lindgren wrote:
> > * Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [140910 01=
:27]:
> > > of_device_ids (i.e. compatible strings and the respective data) a=
re not
> > > supposed to change at runtime. All functions working with of_devi=
ce_ids
> > > provided by <linux/of.h> work with const of_device_ids. So mark t=
he
> > > non-const function parameters and structs for OMAP2+ as const, to=
o.
> >=20
> > Hmm this does not seem to compile with omap2plus_defconfig because
> > of section type conflicts. Looks like there's some issue now with t=
he
> > use of __initconst:
> >=20
> > arch/arm/mach-omap2/board-generic.c:262:20: error: dra72x_boards_co=
mpat causes a section type conflict with omap_dt_match_table
> > arch/arm/mach-omap2/board-generic.c:30:34: note: =E2=80=98omap_dt_m=
atch_table=E2=80=99 was declared here
> > scripts/Makefile.build:257: recipe for target 'arch/arm/mach-omap2/=
board-generic.o' failed
> The problem is dra74x_boards_compat though:
>=20
> 	static const char *dra74x_boards_compat[] __initconst =3D {
> 		...
>=20
> *dra74x_boards_compat is const, but dra74x_boards_compat isn't, so
> either the variable must go into __initdata or it must be declared as=
:
>=20
> 	static const char * const dra74x_boards_compat[] __initconst =3D {
> 		...

Ah OK.
=20
> (but then I guess you get another warning because struct machine_desc=
's
> dt_compat is declared as
>=20
> 	const char **dt_compat;
>=20
> .)
>=20
> With the patch below, arch/arm/mach-omap2/board-generic.c compiles ju=
st
> fine. Don't know yet if the additional const in <asm/mach_desc.h> is
> problematic ...

Yes OK thanks. It Would be nice to have those as __initconst to discard
the unused ones.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
