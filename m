From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
Date: Fri, 15 May 2015 22:21:13 +0200
Message-ID: <46811670.AspmkHD9JS@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <3513646.XX80DTTJbc@wuerfel> <201505152216.24622@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:61981 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934570AbbEOUV5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2015 16:21:57 -0400
In-Reply-To: <201505152216.24622@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Friday 15 May 2015 22:16:24 Pali Roh=E1r wrote:
> On Friday 15 May 2015 22:12:41 Arnd Bergmann wrote:
> > On Friday 15 May 2015 21:50:07 Pali Roh=E1r wrote:
> > >                 }
> > >        =20
> > >         }
> > >=20
> > > +       /* include the terminating ATAG_NONE */
> > > +       atag_size =3D (char *)atag - (char *)atag_list +
> > > sizeof(struct tag_header); +       setprop(fdt, "/", "atags",
> > > atag_list, atag_size);
> > > +
> > >=20
> > >         if (memcount) {
> > >        =20
> > >                 setprop(fdt, "/memory", "reg", mem_reg_property,
> > >                =20
> > >                         4 * memcount * memsize);
> >=20
> > The property should probably have a DT binding, and be named
> > "linux,atags".
> >=20
> > It may also help to check if the "linux,atags" property already
> > exists and not create it otherwise. That way we can put it into the
> > n900 dts file and have it updated by the compat code, but not expos=
e
> > the atags on other platforms unless they opt in.
> >=20
> >       Arnd
>=20
> Maybe what would help: Is there a way to tell decompressor/kernel to =
not=20
> touch atag memory and then after kernel/board-code starts it save cop=
y=20
> of atags? I think it is not possible right now, but correct me if I'm=
=20
> wrong...
>=20

I don't think that is possible without an incompatible change to the
boot protocol.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
