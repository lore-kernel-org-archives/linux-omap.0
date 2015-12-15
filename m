From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Tue, 15 Dec 2015 10:33:25 +0100
Message-ID: <20151215093325.GK13531@pali>
References: <20150713131902.GH26485@atomide.com>
 <20151129180939.GE30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr>
 <201511300115.12478@pali>
 <20151130152352.GY2517@atomide.com>
 <20151130153933.GD29576@pali>
 <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

On Monday 30 November 2015 11:09:42 Nicolas Pitre wrote:
> On Mon, 30 Nov 2015, Pali Roh=C3=A1r wrote:
>=20
> > On Monday 30 November 2015 07:23:53 Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [151129 16:16]:
> > > > On Monday 30 November 2015 01:09:17 Nicolas Pitre wrote:
> > > > > On Sun, 29 Nov 2015, Russell King - ARM Linux wrote:
> > > > > > On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wro=
te:
> > > > > > > Good. And Arnd likes the idea too. So we might be converg=
ing at
> > > > > > > last which is a good thing.
> > > > > >=20
> > > > > > I disagree with the idea that there is convergence.  There =
might be
> > > > > > convergence towards an idea, but... Here's a mail extract, =
from
> > > > > > July 7th, from earlier in this very thread:
> > > > > >=20
> > > > > > Pali:
> > > > > > > Me:
> > > > > > > > Are the ATAGs at a fixed address on the N900?
> > > > > > >=20
> > > > > > > Yes, in board-rx51.c is:
> > > > > > >=20
> > > > > > > .atag_offset    =3D 0x100
> > > > > > >=20
> > > > > > > and Nokia Bootloader (proprietary) store them to that add=
ress.
> > > > > > >=20
> > > > > > > > Can that be handled in
> > > > > > > > some kind of legacy file for the N900 which calls save_=
atags()
> > > > > > > > on it, so we don't end up introducing yet more stuff th=
at we
> > > > > > > > have to maintain into the distant future?  If not, what=
 about
> > > > > > > > copying a known working atag structure into a legacy fi=
le for
> > > > > > > > the N900?
> > > > > > >=20
> > > > > > > I already asked question if it is possible to read ATAGs =
from DT
> > > > > > > booted kernel. And somebody (do not remember who) wrote t=
o ML,
> > > > > > > that it is not possible and it can be done in that uncomp=
ress
> > > > > > > code.
> > > > >=20
> > > > > Who is that somebody? If ever it happened to be me then objec=
tion is
> > > > > withdrawn. Otherwise that somebody should come forth and spea=
k up
> > > > > again.
> > > > >=20
> > > >=20
> > > > ... do not remember ... this discussion were in more email thre=
ads and=20
> > > > takes more then one year... sorry but my memory is not excellen=
t
> > >=20
> > > Yes this certainly seems like the best solution. I think we got i=
nto
> > > the atags-to-dt track as some of the atags are already being tran=
slated.
> > >=20
> > > In this case there's no need to translate them AFAIK. You can jus=
t
> > > parse them and have them available for the user space. So as long=
 as
> > > nothing trashes the atags at the atag_offset, you should be able =
to
> > > call a function to parse them in the n900 specific init_machine.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > In arch/arm/kernel/setup.c is function setup_arch() and it calls:
> >=20
> >   mdesc =3D setup_machine_fdt(__atags_pointer);
> >   if (!mdesc)
> >       mdesc =3D setup_machine_tags(__atags_pointer, __machine_arch_=
type);
> >=20
> > So it looks like that on atags address is stored either atags struc=
ture
> > or DT structure... so it is truth kernel uncompress code put DT blo=
b to
> > same offset where is expected atags structure?
>=20
> No.  It doesn't put it anywhere. Those functions read DT/ATAGs from t=
he=20
> passed address.  But you know this address won't be the one you want =
for=20
> the legacy ATAGs.
>=20
> What you should do is to add a init_early hook to your mdesc structur=
e=20
> and retrieve your ATAGs from there directly at PAGE_OFFSET + 0x100.
>=20
> Now I suspect paging_init() marks the point where the ATAGs will be=20
> overwritten.  To prevent this, you might have to add an additional tw=
eak=20
> in arm_mm_memblock_reserve() similar to the one already present for=20
> CONFIG_SA1111. Something like:
>=20
> 	memblock_reserve(PHYS_OFFSET, PAGE_SIZE);
>=20
> And later on you can return that page back to the system.
>=20
>=20
> Nicolas

So am I understand correctly that solution would be to hack
arch/arm/mm/mmu.c to not overwrite page at PHYS_OFFSET?

And should be this just when when we detect Nokia N900 in DT? Or for al=
l
OMAP2 boards? Or all ARM boards?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
