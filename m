From: "S, Venkatraman" <svenkatr@ti.com>
Subject: RE: [PATCH RESEND] update omap3 features bitmap and API to generic
 	names
Date: Tue, 11 May 2010 09:23:23 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3209B23@dbde02.ent.ti.com>
References: <1273521338-2896-1-git-send-email-svenkatr@ti.com>
 <AANLkTimNjnKG3WFK8mdpgHaLh-Xpv54fohFgEYYiVVcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52953 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab0EKDxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 23:53:36 -0400
In-Reply-To: <AANLkTimNjnKG3WFK8mdpgHaLh-Xpv54fohFgEYYiVVcg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

> -----Original Message-----
> From: menon.nishanth@gmail.com=20
> [mailto:menon.nishanth@gmail.com] On Behalf Of Menon, Nishanth
> Sent: Tuesday, May 11, 2010 5:02 AM
> To: S, Venkatraman
> Cc: linux-omap@vger.kernel.org;=20
> linux-arm-kernel@lists.infradead.org; Tony Lindgren;=20
> Chikkature Rajashekar, Madhusudhan
> Subject: Re: [PATCH RESEND] update omap3 features bitmap and=20
> API to generic names
>=20
> On Mon, May 10, 2010 at 2:55 PM, Venkatraman S=20
> <svenkatr@ti.com> wrote:
> > =A0 =A0 =A0 =A0OMAP3 features bitmap is used a method to check for =
SoC=20
> > specific features. This patch renames the global variables and the=20
> > accessor functions to use a generic name from omap3_* to
> > omap_*
> >
> > Signed-off-by: Venkatraman S <svenkatr@ti.com>
> > CC: Nishant Menon <nm@ti.com>
> Just for the patchworks
> NAK - discussed before -=20
> http://marc.info/?l=3Dlinux-omap&m=3D127349696800651&w=3D2

This patch doesn't have the descriptor load changes, and just the renam=
e.
Did you take a look at it first?
=20
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Madhusudhan Chikkature <madhu.cr@ti.com>
> > ---
> > =A0* Resent to CC Madhu
> >
> > =A0arch/arm/mach-omap2/clock3xxx_data.c =A0| =A0 =A02 +-
> > =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 18 +++=
+++++--------
> > =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 34=20
> > ++++++++++++++++----------------
> > =A03 files changed, 27 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c=20
> > b/arch/arm/mach-omap2/clock3xxx_data.c
> > index 9cba556..afa481d 100644
> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > @@ -3510,7 +3510,7 @@ int __init omap3xxx_clk_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_clkflg |=3D CK_3=
430ES2;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> > - =A0 =A0 =A0 if (omap3_has_192mhz_clk())
> > + =A0 =A0 =A0 if (omap_has_192mhz_clk())
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_96m_alwon_fck =3D omap_96m_alwo=
n_fck_3630;
> >
> > =A0 =A0 =A0 =A0if (cpu_is_omap3630()) {
> > diff --git a/arch/arm/mach-omap2/id.c=20
> b/arch/arm/mach-omap2/id.c index=20
> > 37b8a1a..a095b87 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -28,7 +28,7 @@
> > =A0static struct omap_chip_id omap_chip;
> > =A0static unsigned int omap_revision;
> >
> > -u32 omap3_features;
> > +u32 omap_features;
> >
> > =A0unsigned int omap_rev(void)
> > =A0{
> > @@ -161,14 +161,14 @@ void __init omap24xx_check_revision(void)
> > =A0#define OMAP3_CHECK_FEATURE(status,feat) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=20
> =A0 =A0 =A0 =A0 =A0 =A0=20
> > \
> > =A0 =A0 =A0 =A0if (((status & OMAP3_ ##feat## _MASK) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0
>  =A0 =A0 =A0 =A0 =A0=20
> > \
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> OMAP3_ ##feat## _SHIFT) !=3D FEAT=
_ ##feat##=20
> _NONE) { =A0=20
> > \
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_ ##feat=
; =A0 =A0 =A0 =A0
>  =A0 =A0 =A0 =A0 =A0 =A0
> > \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP_HAS_ ##feat; =
=A0 =A0 =A0 =A0 =A0
>  =A0 =A0 =A0 =A0 =A0 =A0
> > + \
> > =A0 =A0 =A0 =A0}
> >
> > =A0void __init omap3_check_features(void)
> > =A0{
> > =A0 =A0 =A0 =A0u32 status;
> >
> > - =A0 =A0 =A0 omap3_features =3D 0;
> > + =A0 =A0 =A0 omap_features =3D 0;
> >
> > =A0 =A0 =A0 =A0status =3D omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS=
);
> >
> > @@ -178,7 +178,7 @@ void __init omap3_check_features(void)
> > =A0 =A0 =A0 =A0OMAP3_CHECK_FEATURE(status, NEON);
> > =A0 =A0 =A0 =A0OMAP3_CHECK_FEATURE(status, ISP);
> > =A0 =A0 =A0 =A0if (cpu_is_omap3630())
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_192MHZ_=
CLK;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_features |=3D OMAP_HAS_192MHZ_CL=
K;
> >
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * TODO: Get additional info (where applicable) @@ -=
294,7=20
> > +294,7 @@ void __init omap4_check_revision(void)
> > =A0}
> >
> > =A0#define OMAP3_SHOW_FEATURE(feat) =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > - =A0 =A0 =A0 if (omap3_has_ ##feat()) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0\
> > + =A0 =A0 =A0 if (omap_has_ ##feat()) =A0 =A0 =A0 =A0 \
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(#feat" ");
> >
> > =A0void __init omap3_cpuinfo(void)
> > @@ -314,20 +314,20 @@ void __init omap3_cpuinfo(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * AM35xx devices
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap3_has_sgx()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_has_sgx()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OM=
AP3517_REV(rev);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "AM=
3517");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Already set in om=
ap3_check_revision() */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "AM=
3505");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > - =A0 =A0 =A0 } else if (omap3_has_iva() && omap3_has_sgx()) {
> > + =A0 =A0 =A0 } else if (omap_has_iva() && omap_has_sgx()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* OMAP3430, OMAP3525, OMAP3515, OMA=
P3503 devices */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "OMAP3430/3530");
> > - =A0 =A0 =A0 } else if (omap3_has_iva()) {
> > + =A0 =A0 =A0 } else if (omap_has_iva()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OMAP3525_REV(rev);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "OMAP3525");
> > - =A0 =A0 =A0 } else if (omap3_has_sgx()) {
> > + =A0 =A0 =A0 } else if (omap_has_sgx()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_revision =3D OMAP3515_REV(rev);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(cpu_name, "OMAP3515");
> > =A0 =A0 =A0 =A0} else {
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h=20
> > b/arch/arm/plat-omap/include/plat/cpu.h
> > index 7514174..80dc8e0 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -434,28 +434,28 @@ int omap_chip_is(struct omap_chip_id oci);
> > =A0void omap2_check_revision(void);
> >
> > =A0/*
> > - * Runtime detection of OMAP3 features
> > + * Runtime detection of OMAP features
> > =A0*/
> > -extern u32 omap3_features;
> > +extern u32 omap_features;
> >
> > -#define OMAP3_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0) -#defi=
ne=20
> OMAP3_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> > BIT(1) -#define OMAP3_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BI=
T(2) -#define=20
> > OMAP3_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(3) -#define=20
> OMAP3_HAS_ISP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> > BIT(4) -#define OMAP3_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 BIT(5)
> > +#define OMAP_HAS_L2CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0) #defin=
e=20
> OMAP_HAS_IVA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> > +BIT(1) #define OMAP_HAS_SGX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BI=
T(2) #define=20
> > +OMAP_HAS_NEON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3) #define OM=
AP_HAS_ISP=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> > +BIT(4) #define OMAP_HAS_192MHZ_CLK =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
> >
> > -#define OMAP3_HAS_FEATURE(feat,flag) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \ -static=20
> > inline unsigned int omap3_has_ ##feat(void) =A0 =A0 \
> > +#define OMAP_HAS_FEATURE(feat, flag) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \ static=20
> > +inline unsigned int omap_has_ ##feat(void) =A0 =A0 =A0\
> > =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > - =A0 =A0 =A0 return (omap3_features & OMAP3_HAS_ ##flag); =A0 =A0\
> > + =A0 =A0 =A0 return (omap_features & OMAP_HAS_ ##flag); =A0 =A0 =A0=
\
> > =A0} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >
> > -OMAP3_HAS_FEATURE(l2cache, L2CACHE)
> > -OMAP3_HAS_FEATURE(sgx, SGX)
> > -OMAP3_HAS_FEATURE(iva, IVA)
> > -OMAP3_HAS_FEATURE(neon, NEON)
> > -OMAP3_HAS_FEATURE(isp, ISP)
> > -OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> > +OMAP_HAS_FEATURE(l2cache, L2CACHE)
> > +OMAP_HAS_FEATURE(sgx, SGX)
> > +OMAP_HAS_FEATURE(iva, IVA)
> > +OMAP_HAS_FEATURE(neon, NEON)
> > +OMAP_HAS_FEATURE(isp, ISP)
> > +OMAP_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> >
> > =A0#endif
> > --
> > 1.6.3.3
> >
 --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
