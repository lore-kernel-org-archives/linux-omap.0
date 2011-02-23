From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 1/3] omap: voltage: Allow custom vp_init() implementation
Date: Thu, 24 Feb 2011 02:15:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE49223@dbde02.ent.ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
 <1298483913-20344-2-git-send-email-premi@ti.com>
 <AANLkTimWhTdKsuw8fUTx_6=+xVQqS89VR_POBnn-hHOm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53405 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1BWUpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 15:45:31 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NKjSJx017561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 14:45:30 -0600
In-Reply-To: <AANLkTimWhTdKsuw8fUTx_6=+xVQqS89VR_POBnn-hHOm@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, February 24, 2011 12:06 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC 1/3] omap: voltage: Allow custom vp_init()
> implementation
>=20
> On Wed, Feb 23, 2011 at 23:28, Sanjeev Premi <premi@ti.com> wrote:
> > Current implementation expects AVS to be available
> > on the processor - by default. May not be true.
> >
> > This patch allows the vp_init() to be implemented
> > per processor (or family) - same as vc_init().
>=20
> I believe Voltage Processor !=3D Smart reflex AVS. Smart reflex AVS
> module talks to VP talks to VC talks over I2C_SR to PMIC.
> absence of AVS does'nt imply VP,VC dont exist or the potential to hoo=
k
> up a PMIC over I2C_SR. no?

[sp] But their role is limited to AVS only. If there is/was no AVS
     what would they be doing? Delta value written via SW on I2C would
     still get TWL working.

     And if you look into the omap_vdd_info you'd see what I meant.
=20
>=20
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/voltage.c | =A0 =A06 +++++-
> > =A01 files changed, 5 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> omap2/voltage.c
> > index 12be525..bbc36e7 100644
> > --- a/arch/arm/mach-omap2/voltage.c
> > +++ b/arch/arm/mach-omap2/voltage.c
> > @@ -312,6 +312,8 @@ static struct dentry *voltage_dir;
> >
> > =A0/* Init function pointers */
> > =A0static void (*vc_init) (struct omap_vdd_info *vdd);
> > +static void (*vp_init) (struct omap_vdd_info *vdd);
> > +
> > =A0static int (*vdd_data_configure) (struct omap_vdd_info *vdd);
> >
> > =A0static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
> > @@ -416,7 +418,7 @@ static void vp_latch_vsel(struct omap_vdd_info =
*vdd)
> > =A0}
> >
> > =A0/* Generic voltage init functions */
> > -static void __init vp_init(struct omap_vdd_info *vdd)
> > +static void __init omap_vp_init(struct omap_vdd_info *vdd)
> > =A0{
> > =A0 =A0 =A0 =A0u32 vp_val;
> > =A0 =A0 =A0 =A0u16 mod;
> > @@ -1557,11 +1559,13 @@ static int __init omap_voltage_early_init(v=
oid)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_info =3D omap3_vdd_info;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nr_scalable_vdd =3D OMAP3_NR_SCALABL=
E_VDD;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc_init =3D omap3_vc_init;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init =3D omap_vp_init;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_data_configure =3D omap3_vdd_dat=
a_configure;
> > =A0 =A0 =A0 =A0} else if (cpu_is_omap44xx()) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_info =3D omap4_vdd_info;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nr_scalable_vdd =3D OMAP4_NR_SCALABL=
E_VDD;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc_init =3D omap4_vc_init;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init =3D omap_vp_init;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_data_configure =3D omap4_vdd_dat=
a_configure;
> > =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: voltage driver suppo=
rt not added\n",
> __func__);
>=20
>=20
> Regards,
> Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
