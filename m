From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for
 34xx
Date: Tue, 3 Nov 2009 08:43:25 -0800
Message-ID: <20091103164324.GE8981@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <20091029203631.11843.1364.stgit@localhost>
 <4AED6330.8020007@compulab.co.il>
 <20091102191018.GD6692@atomide.com>
 <f870da180911022310n65b63bffw9a425e4aeaa9187b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50317 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbZKCQnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 11:43:23 -0500
Content-Disposition: inline
In-Reply-To: <f870da180911022310n65b63bffw9a425e4aeaa9187b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

* Mike Rapoport <mike.rapoport@gmail.com> [091102 23:10]:
> On Mon, Nov 2, 2009 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > * Mike Rapoport <mike@compulab.co.il> [091101 02:30]:
> >>
> >>
> >> Tony Lindgren wrote:
> >> > Add new style mux data for 34xx. This should also
> >> > work with 3630 easily by adding the processor subset
> >> > and ball data.
> >> >
> >> > Note that this data is __initdata, and gets optimized
> >> > out if CONFIG_OMAP_MUX is not set. Also, the debug data
> >> > gets optimized out if CONFIG_DEBUG_FS is not set.
> >> >
> >> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> > ---
> >> > =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A04
> >> > =A0arch/arm/mach-omap2/mux.h =A0 =A0 | =A0 =A02
> >> > =A0arch/arm/mach-omap2/mux34xx.c | 1552 ++++++++++++++++++++++++=
+++++++++++++++++
> >> > =A0arch/arm/mach-omap2/mux34xx.h | =A0352 +++++++++
> >> > =A04 files changed, 1910 insertions(+), 0 deletions(-)
> >> > =A0create mode 100644 arch/arm/mach-omap2/mux34xx.c
> >> > =A0create mode 100644 arch/arm/mach-omap2/mux34xx.h
> >> >
>=20
> [ snip ]
>=20
> >> > +
> >> > +#define OMAP3_CONTROL_PADCONF_MUX_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> > + =A0 =A0 =A0 =A0 =A0 (OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0=
x2)
> >>
> >> What about adding defines for each possible mode configuration, ex=
cept, perhaps,
> >> GPIO?
> >
> > Yeah it would be nice to make it easy. How about someting like:
> >
> > int __init omap_mux_init_by_name(char *name, int flags);
> > ...
> >
> > omap_mux_init_by_name("i2c1_scl", OMAP_PIN_INPUT_PULLUP);
> >
> >> #define OMAP3_PIN_CAM_D0 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE0 | OMAP_P=
IN_INPUT, 0)
> >> #define OMAP3_PIN_CAM_D0_CSI2_DX2 OMAP3_MUX(CAM_D0, OMAP_PIN_MODE2=
 | \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 OMAP_PIN_INPUT, 0)
> >>
> >> And, I'm for adding OMAP_MUX_GPIO_{OUT,IN,IN_PU,IN_PD}(x) as well.
> >
> > And we could have also:
> >
> > int __init omap_mux_init_by_gpio(int gpio, int flags);
> > ...
> >
> > omap_mux_init_by_gpio(99, OMAP_PIN_INPUT);
> >
> > As the only thing we currently have for flags is the OMAP_MUX_DYNAM=
IC,
> > we could mask that too into flags and make it int instead of u16.
>=20
> It seems we are thinking in really different directions :) You propos=
e
> imporved and easy to use replacements of omap_cfg_reg while I'm aming
> nice tables descibing board pin configuration like, e.g,
> cm_x300_mfp_cfg in arch/arm/mach-pxa/cm-x300.c. Probably it's just to=
o
> hard to me to break my PXA habbits, but I think such tables make the
> board code easier to write/maintain/understand.
> Besides, having both simple aliases for OMAP3_MUX(mode0, mux_value,
> mux_flags) for dedicated pins does not contadict having
> omap_mux_init_by_{name,gpio} helpers.

Agreed, we should make the pin muxing as easy as possible as it's
probably the biggest hurdle to anybody to start making changes to a
development board. And we should have easy to to read board specific
pin configuration tables like you're suggesting.

In the long run, we should probably start using the real signal names
as they seem to be more future proof across omaps than the register
names.

We can easily do something like this if we add char *muxname to
struct omap_board_mux (untested):

#define OMAP_MUX_SIGNAL(signal, mux_flags)				\
{									\
	.muxname	=3D #signal,					\
	.flags		=3D (mux_flags),					\
}

#define OMAP_MUX_GPIO(gpio, mux_flags)					\
{									\
	.muxname	=3D gpio_##signal,				\
	.flags		=3D (mux_flags),					\
}

#ifdef CONFIG_OMAP_MUX
static struct omap_board_mux board_mux[] __initdata =3D {
	OMAP_MUX_SIGNAL(i2c1_scl, OMAP_PIN_INPUT),
	OMAP_MUX_GPIO(98, OMAP_PIN_INPUT_PULLUP),
	OMAP_MUX_GPIO(99, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_DYNAMIC),
	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
};
#endif

Of course then we have to warn on potential duplicate signal names,
but those can be specified using the register offset + mode as
needed.

Is the above close enough to what you have in mind regarding the
board specific mux tables, or do you have still something else
in mind?

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
