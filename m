From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
Date: Wed, 06 May 2015 13:04:01 +0200
Message-ID: <3529567.PeFp1NNa1q@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com> <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150506103752.GG30910@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 May 2015 12:37:52 Pali Roh=E1r wrote:
> On Wednesday 06 May 2015 11:31:15 Arnd Bergmann wrote:
> > On Wednesday 06 May 2015 10:49:01 Pali Roh=E1r wrote:
> > > With this patch "revision" DT string entry is used to set global =
system_rev
> > > variable. DT "revision" is expected to be string with one hexadec=
imal number.
> > > So "Revision" line in /proc/cpuinfo will be same as "revision" DT=
 value.
> > >=20
> > > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > +devicetree mailing list
> >=20
> > The property needs to be specified in a binding somewhere.
> >=20
> > > @@ -246,5 +247,14 @@ const struct machine_desc * __init setup_mac=
hine_fdt(unsigned int dt_phys)
> > >     /* Change machine number to match the mdesc we're using */
> > >     __machine_arch_type =3D mdesc->nr;
> > > =20
> > > +   /* Set system revision from DT */
> > > +   prop =3D of_get_flat_dt_prop(dt_root, "revision", &size);
> > > +   if (prop && size > 0) {
> > > +           char revision[11];
> > > +           strlcpy(revision, prop, min(size, (int)sizeof(revisio=
n)));
> > > +           if (kstrtouint(revision, 16, &system_rev) !=3D 0)
> > > +                   system_rev =3D 0;
> > > +   }
> > > +
> > >     return mdesc;
> > >  }
> > >=20
> >=20
> > What is the reason for doing it this early? I think it would be nic=
er to do
> > it after unflattening the DT.
> >=20
>=20
> It needs to be done in this code, so "system_rev" variable is set
> properly...

What I mean is which code accesses this variable that early?

> > Also, it seems strange to have a string property and then use kstrt=
ouint
> > to convert it into a number. I think it should either be specified =
in a DT
> > binding to be a string and then have the kernel not assume that it =
is a number,
> > or we should define it to be binary.
> >=20
> >       Arnd
>=20
> Variable "system_rev" is number and it always was. So chaning type wi=
ll
> break more parts.
>=20
> And it is string DT property to be human readable. Some other develop=
ers
> suggested for v2 to change it to string (from number).

Both of them would be human readable, you just use something else to
read them ;-)

If we have a string here, we should just change all uses of system_rev
in the kernel accordingly, there are only a few of them:

$ git grep -w system_rev
arch/arm/include/asm/system_info.h:extern unsigned int system_rev;
arch/arm/kernel/atags_parse.c:  system_rev =3D tag->u.revision.rev;
arch/arm/kernel/setup.c:unsigned int system_rev;
arch/arm/kernel/setup.c:EXPORT_SYMBOL(system_rev);
arch/arm/kernel/setup.c:        seq_printf(m, "Revision\t: %04x\n", sys=
tem_rev);
arch/arm/mach-clps711x/devices.c:       system_rev =3D SYSFLG1_VERID(re=
adl(base + SYSFLG1));
arch/arm/mach-clps711x/devices.c:       soc_dev_attr->revision =3D kasp=
rintf(GFP_KERNEL, "%u", system_rev);
arch/arm/mach-davinci/board-da850-evm.c:        switch (system_rev & 0x=
=46) {
arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev =3D 0x27000;
arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev |=3D (mo_ver=
sion << MOTHERBOARD_SHIFT);
arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev |=3D (exp_ve=
rsion << EXPBOARD_SHIFT);
arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    mo_version =3D (system_=
rev >> MOTHERBOARD_SHIFT) & VERSION_MASK;
arch/arm/mach-ixp4xx/goramo_mlr.c:              system_rev =3D __raw_re=
adl(flash + CFG_REV);
arch/arm/mach-omap2/board-rx51-peripherals.c:   if ((system_rev >=3D SY=
STEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
arch/arm/mach-omap2/board-rx51-peripherals.c:       system_rev >=3D SYS=
TEM_REV_B_USES_VAUX3) {
arch/arm/mach-orion5x/dns323-setup.c:   if (machine_is_dns323() && syst=
em_rev =3D=3D DNS323_REV_A1)
arch/arm/mach-orion5x/dns323-setup.c:   system_rev =3D dns323_identify_=
rev();
arch/arm/mach-orion5x/dns323-setup.c:   pr_info("DNS-323: Identified HW=
 revision %c1\n", 'A' + system_rev);
arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130)
arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130) {
arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130)
arch/arm/mach-pxa/magician.c:           if (system_rev < 3)
arch/arm/mach-pxa/magician.c:           if (system_rev < 3)
arch/arm/mach-pxa/magician.c:           system_rev =3D board_id & 0x7;
arch/arm/mach-pxa/magician.c:           if (lcd_select && (system_rev <=
 3))
arch/arm/mach-pxa/raumfeld.c:   if ((system_rev & 0xff) =3D=3D 2) {
arch/arm/mach-pxa/raumfeld.c:   if ((system_rev & 0xff) > 1) {
arch/arm/mach-pxa/viper.c:              system_rev =3D (VIPER_BOARD_VER=
SION(version) << 8) |
arch/arm/mach-pxa/zeus.c:       system_rev =3D __raw_readw(ZEUS_CPLD_VE=
RSION);
arch/arm/mach-pxa/zeus.c:       pr_info("Zeus CPLD V%dI%d\n", (system_r=
ev & 0xf0) >> 4, (system_rev & 0x0f));
arch/arm/mach-zynq/common.c:    system_rev =3D zynq_get_revision();
arch/arm/mach-zynq/common.c:    soc_dev_attr->revision =3D kasprintf(GF=
P_KERNEL, "0x%x", system_rev);

In fact, half the uses of this actually assign the revision number them=
selves.
code outside of arch/arm/mach-* and /proc/cpuinfo currently uses the va=
riable.

	Arnd
