From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] OMAP4: Fix cpu detection
Date: Thu, 10 Dec 2009 01:20:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A826E@dbde02.ent.ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
 <782515bb0912091130r2fabec47v5c48057592edb070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57552 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757443AbZLITun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 14:50:43 -0500
In-Reply-To: <782515bb0912091130r2fabec47v5c48057592edb070@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

Thanks Nishant !!

> > + =A0 =A0 =A0 if ((hawkeye =3D=3D 0xb852) && (rev =3D=3D 0x0)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP4430_REV_ES1_0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("OMAP%04x %s\n", omap_rev() >=
> 16, rev_name);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 printk(KERN_ERR "Unknown OMAP CPU id\n");
> a) Do you want to state unknown OMAP4 CPU id?
> b) why not use pr_err?
OK

> > @@ -280,7 +280,7 @@ void __init omap2_set_globals_343x(void)
> > =A0#if defined(CONFIG_ARCH_OMAP4)
> > =A0static struct omap_globals omap4_globals =3D {
> > =A0 =A0 =A0 =A0.class =A0=3D OMAP443X_CLASS,
> > - =A0 =A0 =A0 .tap =A0 =A0=3D OMAP2_L4_IO_ADDRESS(0x4830a000),
> > + =A0 =A0 =A0 .tap =A0 =A0=3D OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE=
),
>=20
> What does this have to do with the subject of the patch? I agree it i=
s
> a good thing to have, but probably belongs elsewhere.
This is everything to do with subject. ID_CODE reg is in SCM and you
Need a right base to read that reg, Isn't it ?
>=20
> > =A0 =A0 =A0 =A0.ctrl =A0 =3D OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE=
),
> > =A0 =A0 =A0 =A0.prm =A0 =A0=3D OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BAS=
E),
> > =A0 =A0 =A0 =A0.cm =A0 =A0 =3D OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE=
),
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-=
omap/include/plat/cpu.h
> > index 2e17890..2a141ba 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -443,7 +443,8 @@ IS_OMAP_TYPE(3517, 0x3517)
> > =A0#define OMAP3505_REV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP35XX=
_CLASS | (0x3505 << 16) | (v << 12))
> > =A0#define OMAP3517_REV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP35XX=
_CLASS | (0x3517 << 16) | (v << 12))
> >
> > -#define OMAP443X_CLASS =A0 =A0 =A0 =A0 0x44300034
> > +#define OMAP443X_CLASS =A0 =A0 =A0 =A0 0x44300044
> > +#define OMAP4430_REV_ES1_0 =A0 =A0 0x44300044
> Errr.. why? I suspect this might be to get the class and subclass rig=
ht..
>=20
> Dont we need an cpu_is_omap_4430() to use it correctly? (unless I
> missed a pending patch series as I am checking l-o kernel codebase)..
> do we need the following?
> IS_OMAP_CLASS(44xx, 0x44)
> IS_OMAP_SUBCLASS(443x, 0x443)
>=20
> then you will have is_omap_443x() and you can now:
> #define cpu_is_omap4430 is_omap443x()
This has to be done and I planning to do this in next series. This seri=
es just
enables the basic boot on ES1.0.

Regards,=20
Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
