From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC3 Overo
Date: Thu, 6 Aug 2009 09:44:13 +0300
Message-ID: <20090806064413.GX7374@atomide.com>
References: <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com> <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com> <873a866xdo.fsf@deeprootsystems.com> <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com> <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com> <4A79C83E.9040603@deeprootsystems.com> <5e088bd90908051121h38678c9fha73b7beb88752156@mail.gmail.com> <4A79D104.60607@deeprootsystems.com> <bb2708720908051229x49f10094w9b19b468d4bfaec8@mail.gmail.com> <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53518 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbZHFGoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 02:44:16 -0400
Content-Disposition: inline
In-Reply-To: <bb2708720908051902p4b369784s8fc5056be9ba047d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* John Sarman <johnsarman@gmail.com> [090806 05:11]:
> On Wed, Aug 5, 2009 at 2:35 PM, Kevin Hilman<khilman@deeprootsystems.=
com> wrote:
> > Steve Sakoman wrote:
> >>
> >> On Wed, Aug 5, 2009 at 10:58 AM, Kevin
> >> Hilman<khilman@deeprootsystems.com> wrote:
> >>>
> >>> Steve Sakoman wrote:
> >>>>
> >>>> And up to now in each case I shrug and say "no time to do that n=
ow,
> >>>> I'll just leave kernel pinmuxing turned off and do it in u-boot"
> >>>
> >>> I agree there are lots of shortcomings in the current mux code an=
d we've
> >>> been hitting them regularily lately.
> >>>
> >>> That being said, for mux settings that done one-time only at boot=
, what
> >>> are
> >>> the problems you're running into?
> >>
> >> It's been a few months since I last encountered this, so the exact
> >> details are a bit fuzzy.
> >>
> >> I seem to recall that there were some basic issues with enabling
> >> kernel pinmuxing in that some of the setup that was done for all
> >> machines was just wrong for my particular machine. =A0IIRC, it was=
 due
> >> to assumptions about which pad was used for a particular function =
(for
> >> those functions which can be steered to multiple GPIO pads).
> >>
> >> So I faced having to undo that change in my board file as well as =
any
> >> issues that may have arisen from glitches on the GPIO pins during =
the
> >> process. =A0And since there were several of these I gave up and tu=
rned
> >> off kernel pinmuxing.
> >>
> >> I'd be happy if we cleaned up the "one size fits all" pinmuxing to
> >> just that subset that truly does fit all boards, and leave the res=
t to
> >> the board files. =A0I'd also be content to have it all done in the=
 board
> >> file for each machine.
> >
> > Indeed, any assumptions about common muxing that are not indeed com=
mon are
> > bugs and should be fixed.
> >
> > The "right" solution is to have everything in the kernel, and split=
 across
> > SoC "common" init and board specific init. =A0Of course u-boot
> > will still have to do some early muxing, but it should be redone in
> > the kernel so it's trivial to change bootloaders.
> >
> > So the real missing piece is someone to step up and rework the mux =
code.
> > The bigger problem is that the vast majority of folks don't care ab=
out the
> > common case and only care about getting thing working for a specifi=
c
> > platform.
> >
> > Kevin
> >
> I =A0like the idea of having the board file configure the mux. =A0Fir=
st of
> all lets address the shortcomings of mux.h. =A0The Pin values are
> labeled as so:
> <snip from mux.h>
> * NOTE: Please use the following naming style for new pin entries.
> =A0* =A0 =A0 =A0 For example, W8_1610_MMC2_DAT0, where:
> =A0* =A0 =A0 =A0 - W8 =A0 =A0 =A0 =A0=3D ball
> =A0* =A0 =A0 =A0 - 1610 =A0 =A0 =A0=3D 1510 or 1610, none if common f=
or both 1510 and 1610
> =A0* =A0 =A0 =A0 - MMC2_DAT0 =3D function
>=20
> But lets take the 3530 as an example.
> =A0The 3530 has three separate packages. =A0CBB, CBC, and CUS. =A0Now=
 lets
> look at MMC3_clk (the root of my original problem that started this
> thread)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CBB =A0 =A0 =A0 =A0 =A0=
 =A0 =A0CBC =A0 =A0 =A0 =A0 =A0 =A0CUS
> mmc3_clk =A0 =A0 =A0 =A0 AB1 / AF10 =A0 =A0R9 / AB2 =A0 =A0 AC1
>=20
> So to properly add these to mux.h we need to add 5 entries for mmc3_c=
lk
> =A0 =A0 =A0 AB1_35XXCBB_MMC3_CLK
> =A0 =A0 =A0 AF10_35XXCBB_MMC3_CLK
> =A0 =A0 =A0 R9_35XXCBC_MMC3_CLK
> =A0 =A0 =A0 AB2_35XXCBC_MMC3_CLK
> =A0 =A0 =A0 AC1_35XXCUS_MMC3_CLK
> We would then have to update mux.c making sure the position matches
> and add the proper settings.
>=20
> So this is obviously a maintenance nightmare.
>=20
> Another option is to add a CONFIG_35XX_CBB or CBC or CUS when selecti=
ng a board
> =A0example in menuconfig selecting MACH_OVERO would select =A0CONFIG_=
35XX_CBB.
> Then in a new mux_35xx.h located in the mach_omap2 folder have
> =A0#ifdef CONFIG_35XX_CBB
> =A0//all muxable balls
> =A0 #define N4 =A0 =A0 =A0 0x078
> =A0 #define AB1 =A0 =A0 0x164
> =A0etc .....
> =A0#endif
> where we just use the Ball name defined as its offset in the 35xx cas=
e

Yeah we need to improve the mux code as discussed many times earlier, i=
t's
been limping along since the 15xx days, and now that the mux hardware d=
oes
not have the mux configuration registers all over the place we can simp=
lify
it for later omaps.

But doing things with Kconfig won't work as we support compiling in mul=
tiple
boards and omaps. It needs to be done dynamically in in the board-*.c f=
iles.

>=20
> then we create a file say board_overo_mux.c
>=20
> =A0 in it we call
> =A0 configure_pin(AB1, MODE3, INPUT | PU | PE);
> =A0 for every ball that is muxable.

=46or the sensible configurations we already have these defines mux.h:

/* 34xx active pin states */
#define OMAP34XX_PIN_OUTPUT		0
#define OMAP34XX_PIN_INPUT		OMAP3_INPUT_EN
#define OMAP34XX_PIN_INPUT_PULLUP	(OMAP2_PULL_ENA | OMAP3_INPUT_EN \
						| OMAP2_PULL_UP)
#define OMAP34XX_PIN_INPUT_PULLDOWN	(OMAP2_PULL_ENA | OMAP3_INPUT_EN)

/* 34xx off mode states */
#define OMAP34XX_PIN_OFF_NONE           0
#define OMAP34XX_PIN_OFF_OUTPUT_HIGH	(OMAP3_OFF_EN | OMAP3_OFFOUT_EN \
						| OMAP3_OFFOUT_VAL)
#define OMAP34XX_PIN_OFF_OUTPUT_LOW	(OMAP3_OFF_EN | OMAP3_OFFOUT_EN)
#define OMAP34XX_PIN_OFF_INPUT_PULLUP	(OMAP3_OFF_EN | OMAP3_OFF_PULL_EN=
 \
						| OMAP3_OFF_PULL_UP)
#define OMAP34XX_PIN_OFF_INPUT_PULLDOWN	(OMAP3_OFF_EN | OMAP3_OFF_PULL_=
EN)
#define OMAP34XX_PIN_OFF_WAKEUPENABLE	OMAP3_WAKEUP_EN

So I'd rather stick with those because otherwise we easily end up with
wrong combinations. Of course the naming could be more generic there :)

Regards,

Tony

=20
> voila, =A0we have a predefined limit of pins so once mux_35xx.h is fu=
lly
> defined, and the driver code is in place then the only thing that a
> developer would need to do to leverage the mux is edit his board file=
=2E
>=20
> Im sure I have glossed ove many details but this is a general outline=
=2E
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
