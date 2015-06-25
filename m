From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: devtree: Save atags if are in DT atags field
Date: Wed, 24 Jun 2015 22:06:04 -0700
Message-ID: <20150625050604.GM4156@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-2-git-send-email-pali.rohar@gmail.com>
 <2802980.ITgIdpK9OB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2802980.ITgIdpK9OB@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [150515 13:11]:
> On Friday 15 May 2015 21:50:06 Pali Roh=C3=A1r wrote:
> > @@ -256,5 +257,10 @@ const struct machine_desc * __init setup_machi=
ne_fdt(unsigned int dt_phys)
> >                         system_rev =3D 0;
> >         }
> > =20
> > +       /* Save atags */
> > +       prop =3D of_get_flat_dt_prop(dt_root, "atags", NULL);
> > +       if (prop)
> > +               save_atags((void *)prop);
> > +
> >         return mdesc;
> >=20
>=20
> How about checking whether this is actually running on the one board
> that needs it first?
>=20
> I'd rather not introduce something that may end up being considered
> an ABI on other machines.

It seems having this within CONFIG_ARM_ATAG_DTB_COMPAT should be
enough here.

Regards,

Tony
