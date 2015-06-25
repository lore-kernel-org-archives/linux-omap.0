From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
Date: Wed, 24 Jun 2015 22:12:53 -0700
Message-ID: <20150625051253.GN4156@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3513646.XX80DTTJbc@wuerfel>
 <201505152216.24622@pali>
 <46811670.AspmkHD9JS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46811670.AspmkHD9JS@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [150515 13:23]:
> On Friday 15 May 2015 22:16:24 Pali Roh=C3=A1r wrote:
> > On Friday 15 May 2015 22:12:41 Arnd Bergmann wrote:
> > > On Friday 15 May 2015 21:50:07 Pali Roh=C3=A1r wrote:
> > > >                 }
> > > >        =20
> > > >         }
> > > >=20
> > > > +       /* include the terminating ATAG_NONE */
> > > > +       atag_size =3D (char *)atag - (char *)atag_list +
> > > > sizeof(struct tag_header); +       setprop(fdt, "/", "atags",
> > > > atag_list, atag_size);
> > > > +
> > > >=20
> > > >         if (memcount) {
> > > >        =20
> > > >                 setprop(fdt, "/memory", "reg", mem_reg_property=
,
> > > >                =20
> > > >                         4 * memcount * memsize);
> > >=20
> > > The property should probably have a DT binding, and be named
> > > "linux,atags".
> > >=20
> > > It may also help to check if the "linux,atags" property already
> > > exists and not create it otherwise. That way we can put it into t=
he
> > > n900 dts file and have it updated by the compat code, but not exp=
ose
> > > the atags on other platforms unless they opt in.

Using "linux,atags" sounds good to me. And yes checking it with
getprop before doing setprop makes sense.

> > Maybe what would help: Is there a way to tell decompressor/kernel t=
o not=20
> > touch atag memory and then after kernel/board-code starts it save c=
opy=20
> > of atags? I think it is not possible right now, but correct me if I=
'm=20
> > wrong...
> >=20
>=20
> I don't think that is possible without an incompatible change to the
> boot protocol.

Agreed, let's keep the changes to minimum.

Looks like with the comments posted all the pending four patches
from Pali become quite a minimal set of three patches if we keep
the rev string as hex.

Regrds,

Tony
