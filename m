From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Wed, 6 May 2015 13:44:17 +0200
Message-ID: <20150506114417.GI30910@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel>
 <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3529567.PeFp1NNa1q@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> On Wednesday 06 May 2015 12:37:52 Pali Roh=C3=A1r wrote:
> > On Wednesday 06 May 2015 11:31:15 Arnd Bergmann wrote:
> > > On Wednesday 06 May 2015 10:49:01 Pali Roh=C3=A1r wrote:
> > > > With this patch "revision" DT string entry is used to set globa=
l system_rev
> > > > variable. DT "revision" is expected to be string with one hexad=
ecimal number.
> > > > So "Revision" line in /proc/cpuinfo will be same as "revision" =
DT value.
> > > >=20
> > > > Signed-off-by: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > >=20
> > > +devicetree mailing list
> > >=20
> > > The property needs to be specified in a binding somewhere.
> > >=20
> > > > @@ -246,5 +247,14 @@ const struct machine_desc * __init setup_m=
achine_fdt(unsigned int dt_phys)
> > > >     /* Change machine number to match the mdesc we're using */
> > > >     __machine_arch_type =3D mdesc->nr;
> > > > =20
> > > > +   /* Set system revision from DT */
> > > > +   prop =3D of_get_flat_dt_prop(dt_root, "revision", &size);
> > > > +   if (prop && size > 0) {
> > > > +           char revision[11];
> > > > +           strlcpy(revision, prop, min(size, (int)sizeof(revis=
ion)));
> > > > +           if (kstrtouint(revision, 16, &system_rev) !=3D 0)
> > > > +                   system_rev =3D 0;
> > > > +   }
> > > > +
> > > >     return mdesc;
> > > >  }
> > > >=20
> > >=20
> > > What is the reason for doing it this early? I think it would be n=
icer to do
> > > it after unflattening the DT.
> > >=20
> >=20
> > It needs to be done in this code, so "system_rev" variable is set
> > properly...
>=20
> What I mean is which code accesses this variable that early?
>=20

ATAG code is doing it at same early stage, so I added it to same early
stage...

> > > Also, it seems strange to have a string property and then use kst=
rtouint
> > > to convert it into a number. I think it should either be specifie=
d in a DT
> > > binding to be a string and then have the kernel not assume that i=
t is a number,
> > > or we should define it to be binary.
> > >=20
> > >       Arnd
> >=20
> > Variable "system_rev" is number and it always was. So chaning type =
will
> > break more parts.
> >=20
> > And it is string DT property to be human readable. Some other devel=
opers
> > suggested for v2 to change it to string (from number).
>=20
> Both of them would be human readable, you just use something else to
> read them ;-)
>=20
> If we have a string here, we should just change all uses of system_re=
v
> in the kernel accordingly, there are only a few of them:
>=20
> $ git grep -w system_rev
> arch/arm/include/asm/system_info.h:extern unsigned int system_rev;
> arch/arm/kernel/atags_parse.c:  system_rev =3D tag->u.revision.rev;
> arch/arm/kernel/setup.c:unsigned int system_rev;
> arch/arm/kernel/setup.c:EXPORT_SYMBOL(system_rev);
> arch/arm/kernel/setup.c:        seq_printf(m, "Revision\t: %04x\n", s=
ystem_rev);
> arch/arm/mach-clps711x/devices.c:       system_rev =3D SYSFLG1_VERID(=
readl(base + SYSFLG1));
> arch/arm/mach-clps711x/devices.c:       soc_dev_attr->revision =3D ka=
sprintf(GFP_KERNEL, "%u", system_rev);
> arch/arm/mach-davinci/board-da850-evm.c:        switch (system_rev & =
0xF) {
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev =3D 0x2700=
0;
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev |=3D (mo_v=
ersion << MOTHERBOARD_SHIFT);
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev |=3D (exp_=
version << EXPBOARD_SHIFT);
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    mo_version =3D (syste=
m_rev >> MOTHERBOARD_SHIFT) & VERSION_MASK;
> arch/arm/mach-ixp4xx/goramo_mlr.c:              system_rev =3D __raw_=
readl(flash + CFG_REV);
> arch/arm/mach-omap2/board-rx51-peripherals.c:   if ((system_rev >=3D =
SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
> arch/arm/mach-omap2/board-rx51-peripherals.c:       system_rev >=3D S=
YSTEM_REV_B_USES_VAUX3) {
> arch/arm/mach-orion5x/dns323-setup.c:   if (machine_is_dns323() && sy=
stem_rev =3D=3D DNS323_REV_A1)
> arch/arm/mach-orion5x/dns323-setup.c:   system_rev =3D dns323_identif=
y_rev();
> arch/arm/mach-orion5x/dns323-setup.c:   pr_info("DNS-323: Identified =
HW revision %c1\n", 'A' + system_rev);
> arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
> arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
> arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
> arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130)
> arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130) {
> arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130)
> arch/arm/mach-pxa/magician.c:           if (system_rev < 3)
> arch/arm/mach-pxa/magician.c:           if (system_rev < 3)
> arch/arm/mach-pxa/magician.c:           system_rev =3D board_id & 0x7=
;
> arch/arm/mach-pxa/magician.c:           if (lcd_select && (system_rev=
 < 3))
> arch/arm/mach-pxa/raumfeld.c:   if ((system_rev & 0xff) =3D=3D 2) {
> arch/arm/mach-pxa/raumfeld.c:   if ((system_rev & 0xff) > 1) {
> arch/arm/mach-pxa/viper.c:              system_rev =3D (VIPER_BOARD_V=
ERSION(version) << 8) |
> arch/arm/mach-pxa/zeus.c:       system_rev =3D __raw_readw(ZEUS_CPLD_=
VERSION);
> arch/arm/mach-pxa/zeus.c:       pr_info("Zeus CPLD V%dI%d\n", (system=
_rev & 0xf0) >> 4, (system_rev & 0x0f));
> arch/arm/mach-zynq/common.c:    system_rev =3D zynq_get_revision();
> arch/arm/mach-zynq/common.c:    soc_dev_attr->revision =3D kasprintf(=
GFP_KERNEL, "0x%x", system_rev);
>=20
> In fact, half the uses of this actually assign the revision number th=
emselves.
> code outside of arch/arm/mach-* and /proc/cpuinfo currently uses the =
variable.
>=20
> 	Arnd

--=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
