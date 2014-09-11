From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: make of_device_ids const
Date: Thu, 11 Sep 2014 21:14:57 +0200
Message-ID: <20140911191457.GN3755@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911173943.GB18849@atomide.com>
 <20140911190136.GM3755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140911190136.GM3755-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Sep 11, 2014 at 09:01:36PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Sep 11, 2014 at 10:39:43AM -0700, Tony Lindgren wrote:
> > * Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> [140910 01=
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
>=20
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
>=20
> diff --git a/arch/arc/include/asm/mach_desc.h b/arch/arc/include/asm/=
mach_desc.h
> index e8993a2be6c2..f4a7bc8d8967 100644
> --- a/arch/arc/include/asm/mach_desc.h
> +++ b/arch/arc/include/asm/mach_desc.h
this is obviously non-sense. The definition for arm already has the
const I added here for arc.

So the patch for board-generic.c below is fine. I will create a proper
patch for it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
