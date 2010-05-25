From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v3 1/3] omap3 gpmc: functionality enhancement
Date: Tue, 25 May 2010 20:07:42 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DA9F8EB@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
 	<1274181389-7488-2-git-send-email-s-ghorai@ti.com>
 <AANLkTikFxtzDpiJvJjnuonM2urMJR1LDLafx5JtpC_bS@mail.gmail.com>
 	<1274284094.6286.17.camel@thunk>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D991D50@dbde02.ent.ti.com>
 <AANLkTikK4ISAsLFS-l5fXGxCppv98F2qqb8OBnZ7OTHd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58084 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab0EYOiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 10:38:08 -0400
In-Reply-To: <AANLkTikK4ISAsLFS-l5fXGxCppv98F2qqb8OBnZ7OTHd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, "peter.barada@gmail.com" <peter.barada@gmail.com>

Vimal,

> -----Original Message-----
> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> Sent: Thursday, May 20, 2010 12:01 AM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> tony@atomide.com; sakoman@gmail.com; mike@compulab.co.il;
> Artem.Bityutskiy@nokia.com; peter.barada@gmail.com
> Subject: Re: [PATCH v3 1/3] omap3 gpmc: functionality enhancement
>=20
> On Wed, May 19, 2010 at 11:34 PM, Ghorai, Sukumar <s-ghorai@ti.com> w=
rote:
> >> > > +
> >> > > + =A0 =A0 =A0 case GPMC_CONFIG_RDY_BSY:
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =A0=3D gpmc_cs_read_reg(c=
s, GPMC_CS_CONFIG1);
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D WR_RD_PIN_MONITORING=
;
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_write_reg(cs, GPMC_CS_CO=
NFIG1, regval);
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >
> >> > IIRC, at least in OMAP2/3, ready/busy pin is not in use (not
> connected).
> >>
> >> On the Logic OMAP3530 LV SOM and Torpedo modules, the R/B# pin of =
the
> >> NAND in the Micron mt29c2g4maklajg-6it POP part is connected to th=
e
> >> WAIT0 pin on the OMAP3530 and I'm looking to use it to speed up NA=
ND
> >> accesses
> > [Ghorai] So better keep this feature,
>=20
> Yes, looks like there are some boards which can still take advantage =
of
> this.
>=20
> >>
> [...]
> >> > > @@ -456,13 +572,20 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
> >> > > =A0/**
> >> > > =A0* gpmc_prefetch_reset - disables and stops the prefetch eng=
ine
> >> > > =A0*/
> >> > > -void gpmc_prefetch_reset(void)
> >> > > +int gpmc_prefetch_reset(int cs)
> >> > > =A0{
> >> > > + =A0 =A0 =A0 if (gpmc_pref_used =3D=3D cs)
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_pref_used =3D -EINVAL;
> >> > > + =A0 =A0 =A0 else
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> > > +
> >> >
> >> > This is also not required. As, this function will be called only=
 if
> >> > prefetch was used.
> > [Ghorai] Agree. Can you see this input too?
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28520.htm=
l
>=20
> Exactly, this is what I am telling here. Enable prefetch engine call
> is already being check for *busy* or not.
[Ghorai] Agree.
>=20
> >
> [...]
> >> > > +int gpmc_ecc_init(int cs, int ecc_size)
> >> > > +{
> >> > > + =A0 =A0 =A0 unsigned int val =3D 0x0;
> >> > > +
> >> > > + =A0 =A0 =A0 /* check if ecc engine already by another cs */
> >> > > + =A0 =A0 =A0 if (gpmc_ecc_used =3D=3D -EINVAL)
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_ecc_used =3D cs;
> >> > > + =A0 =A0 =A0 else
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >> > Here few things need be to consider:
> >> > 1. 'init' is supposed to done once for every instance of driver
> during
> >> probe
> >> > 2. But ECC engine, too, have only one instance at a time, So
> >> > 3. As long as all NAND chip are supposed to use same ECC macheni=
sm,
> we
> >> > can go for only one time 'init' for all drivers, perhaps in
> >> > gpmc_nand.c.
> >> > 4. But in case, different instances of driver (or NAND chip) req=
uires
> >> > different ECC machenism (for ex. Hamming or BCH, or even with
> >> > different capabilities of error correction),
> >> > this will no longer vailid. Then rather we should have something=
 like
> >> > 'gpmc_ecc_config' call to configer ECC engine for everytime a dr=
iver
> >> > needs it (something like as it is done for prefetch engine).
> > [Ghorai]
> > a. do you think it will reduce the throughput?
> No. But in current implementation it will be called for each instance
> driver. (see my 3rd point)
>=20
> > b. Moreover I think we will take this as 5th patch as cleanup/
> improvemnt.
> > c. And how to know that ECC engine is in used other driver should n=
ot
> use it? Any bit to know that ecc engine is busy, as we check for pref=
etch?
> Do not really remember config registers. Perhaps there is no way.
> But I guess you should check into register GPMC_ECC_CONFIG at bit 1.
> This is the bit we are setting to enable ECC calculation, IIRC.
[Ghorai] there are two functions -
       info->nand.ecc.calculate        =3D omap_calculate_ecc;
       info->nand.ecc.hwctl            =3D omap_enable_hwecc;
And GPMC_ECC_CONFIG register..
	3:1 ECCCS Selects the CS where ECC is computed=20
	0 ECCENABLE Enables the ECC feature
Now we enable omap_enable_hwecc (with GPMC_ECC_CONFIG[ECCENABLE]=3D1); =
and its get disabled (automatically) when ecc_size data transfer over. =
But say still it did not read the ecc value yet (omap_calculate_ecc).
So how to protect following omap_enable_hwecc() before omap_calculate_e=
cc()  without additional flag? Any input is welcome.

>=20
> > d. any further input on http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg28520.html
> And this what I was suggesting in my point 4. In my example
> 'gpmc_ecc_config' is analogy to 'gpmc_ecc_request'.
> I said *config*, since in such scenario you need to configer HW
> ECCconfig register everytime as well, rather just checking
> availability and enabling.
[Ghorai] As above.
>=20
> >
> [...]
> >> > > +int gpmc_ecc_reset(int cs)
> >> > > +{
> >> > > + =A0 =A0 =A0 if (gpmc_ecc_used =3D=3D cs)
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_ecc_used =3D -EINVAL;
> >> > > + =A0 =A0 =A0 else
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> > > +
> >> > > + =A0 =A0 =A0 return 0;
> >> > > +}
>=20
> I guess in this function you should also clear gpmc ecc config
> register explicitly.
>=20
>=20
> --
> Regards,
> Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
