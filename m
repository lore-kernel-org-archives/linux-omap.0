From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Tue, 15 Dec 2015 12:04:35 +0100
Message-ID: <1684644.M9TF75k3RB@wuerfel>
References: <20150713131902.GH26485@atomide.com> <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr> <20151215093325.GK13531@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215093325.GK13531@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tuesday 15 December 2015 10:33:25 Pali Roh=E1r wrote:
> On Monday 30 November 2015 11:09:42 Nicolas Pitre wrote:
> > On Mon, 30 Nov 2015, Pali Roh=E1r wrote:
> > > On Monday 30 November 2015 07:23:53 Tony Lindgren wrote:
> > > > * Pali Roh=E1r <pali.rohar@gmail.com> [151129 16:16]:
> > > > > On Monday 30 November 2015 01:09:17 Nicolas Pitre wrote:
> > > > > > On Sun, 29 Nov 2015, Russell King - ARM Linux wrote:
> > > In arch/arm/kernel/setup.c is function setup_arch() and it calls:
> > >=20
> > >   mdesc =3D setup_machine_fdt(__atags_pointer);
> > >   if (!mdesc)
> > >       mdesc =3D setup_machine_tags(__atags_pointer, __machine_arc=
h_type);
> > >=20
> > > So it looks like that on atags address is stored either atags str=
ucture
> > > or DT structure... so it is truth kernel uncompress code put DT b=
lob to
> > > same offset where is expected atags structure?
> >=20
> > No.  It doesn't put it anywhere. Those functions read DT/ATAGs from=
 the=20
> > passed address.  But you know this address won't be the one you wan=
t for=20
> > the legacy ATAGs.
> >=20
> > What you should do is to add a init_early hook to your mdesc struct=
ure=20
> > and retrieve your ATAGs from there directly at PAGE_OFFSET + 0x100.
> >=20
> > Now I suspect paging_init() marks the point where the ATAGs will be=
=20
> > overwritten.  To prevent this, you might have to add an additional =
tweak=20
> > in arm_mm_memblock_reserve() similar to the one already present for=
=20
> > CONFIG_SA1111. Something like:
> >=20
> >       memblock_reserve(PHYS_OFFSET, PAGE_SIZE);
> >=20
> > And later on you can return that page back to the system.
> >=20
>=20
> So am I understand correctly that solution would be to hack
> arch/arm/mm/mmu.c to not overwrite page at PHYS_OFFSET?

I would think we can just copy the data from PAGE_OFFSET + 0x100
to a some other page from your init_early hook. IIRC you can't use
kmalloc there, but memblock_alloc() should work.

	Arnd
