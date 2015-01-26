From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Mon, 26 Jan 2015 09:03:23 -0800
Message-ID: <20150126170323.GF28663@atomide.com>
References: <201501232239.55801@pali>
 <201501232336.36187@pali>
 <20150126161454.GE28663@atomide.com>
 <201501261723.10505@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:60580 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200AbbAZRGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 12:06:38 -0500
Content-Disposition: inline
In-Reply-To: <201501261723.10505@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Nicolas Pitre <nico@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Laura Abbott <lauraa@codeaurora.org>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150126 08:26]:
> On Monday 26 January 2015 17:14:55 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150123 14:39]:
> > > On Friday 23 January 2015 22:39:55 Pali Roh=C3=A1r wrote:
> > > > Hello,
> > > >=20
> > > > when I boot zImage with appended DT n900 in qemu
> > > > fdt_open_into() function called from file
> > > > arch/arm/boot/compressed/atags_to_fdt.c (in function
> > > > atags_to_fdt) always returns -FDT_ERR_NOSPACE.
> > > >=20
> > > > It means that all ATAGS (including cmdline arguments)
> > > > passed by bootloader are ignored.
> > > >=20
> > > > On real n900 device I see that booted DT version also
> > > > ignore cmdline arguments from bootloader. I cannot debug
> > > > decompress code on real device, but I think it is same
> > > > problem as in qemu.
> > >=20
> > > Looks like this quick patch is fixing above problem:
> > >=20
> > > diff --git a/arch/arm/boot/compressed/head.S
> > > b/arch/arm/boot/compressed/head.S index 68be901..4a7d75b
> > > 100644
> > > --- a/arch/arm/boot/compressed/head.S
> > > +++ b/arch/arm/boot/compressed/head.S
> > > @@ -268,7 +268,7 @@ restart:	adr	r0, LC0
> > >=20
> > >  		 * area.  No GOT fixup has occurred yet, but none of=20
> the
> > >  		 * code we're about to call uses any global variable.
> > >  	=09
> > >  		*/
> > >=20
> > > -		add	sp, sp, #0x10000
> > > +		add	sp, sp, #0x20000
> > >=20
> > >  		stmfd	sp!, {r0-r3, ip, lr}
> > >  		mov	r0, r8
> > >  		mov	r1, r6
> > >=20
> > > @@ -289,7 +289,7 @@ restart:	adr	r0, LC0
> > >=20
> > >  		bleq	atags_to_fdt
> > >  	=09
> > >  		ldmfd	sp!, {r0-r3, ip, lr}
> > >=20
> > > -		sub	sp, sp, #0x10000
> > > +		sub	sp, sp, #0x20000
> > >=20
> > >  #endif
> > > =20
> > >  		mov	r8, r6			@ use the appended device tree
> >=20
> > Nico, got any ideas about this one? This seems like a
> > regression somewhere..
> >=20
> > Regards,
> >=20
> > Tony
>=20
> $ du -b arch/arm/boot/dts/omap3-n900.dtb=20
> 70212   arch/arm/boot/dts/omap3-n900.dtb
>=20
> $ echo $((0x10000))
> 65536
>=20
> I would say, problem is because omap3-n900 binary DT is too large

OK if that's the case, then your patch makes sense to me. It also
seems we can have the temporary stack be larger than the initial
stack just for atags_to_fdt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
