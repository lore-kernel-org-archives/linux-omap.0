From: Tony Lindgren <tony@atomide.com>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins
	for omap7xx)
Date: Wed, 7 Oct 2009 10:47:50 -0700
Message-ID: <20091007174750.GG7899@atomide.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com> <4ACB7EC0.3010401@ti.com> <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com> <87hbucp6ng.fsf@deeprootsystems.com> <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com> <878wfop4rc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54866 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932989AbZJGRsh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 13:48:37 -0400
Content-Disposition: inline
In-Reply-To: <878wfop4rc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [091006 15:18]:
> "Menon, Nishanth" <nm@ti.com> writes:
>=20
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >>=20
> >> >>> =A0 =A0 =A0 =A0W17_7XX_USB_VBUSI,
> >> >>> +
> >> >>> + =A0 =A0 =A0 /* MMC */
> >> >>> + =A0 =A0 =A0 MMC_7XX_CMD,
> >> >>> + =A0 =A0 =A0 MMC_7XX_CLK,
> >> >>> + =A0 =A0 =A0 MMC_7XX_DAT0,
> >> >>
> >> >> probably a dumb question -> but should'nt these go off to bootl=
oader
> >> >> perhaps?
> >> >>
> >> >
> >> > Perhaps, although we use either EOL (for HTC Wizard) or Haret to=
 boot,
> >> > and they don't set up the right mux configuration for our board.
> >> >
> >> > This way though, we don't have to worry about the boot loader --=
 we
> >> > can set it up right regardless of who boots us.
> >>=20
> >> I agree with Cory.
> >>=20
> >> I prefer that mux settings go into the kernel, even if they are se=
tup
> >> in the bootloader already.  It's better to have redundancy than wo=
nder
> >> what to do if changing boot loaders.
> >>=20
> > Probably opening up a can of worms.. Are the rules different for OM=
AP3?=20
> > Should'nt we have all mux done at kernel so that kernel is loader=20
> > independent?
>=20
> Yes, we should.  My preference is to always have muxing in the kernel=
=2E

Agreed. We still should support bootloader only muxing too.

BTW, I've been thinking about the following sets of patches for the nex=
t
merge window:

1. Do the include directories for mach-omap1 and mach-omap2 as suggeste=
d
   by Russell earlier

2. Move all mux code to only live under arch/arm/*omap*/ and make sure
   drivers don't call omap_cfg_reg() any longer

3. Remove the enumeration for the mux and require all the boards to
   register the pins they'll use

After these it should be trivial to improve the mux code further. The
steps 2 & 3 above will be most likely breaking things for some boards,
so help will be needed with testing.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
