From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
Date: Fri, 28 May 2010 12:03:14 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DAA0662@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41911 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab0E1GdV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 02:33:21 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Vimal Singh
> Sent: Thursday, May 27, 2010 11:56 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v4 1/3] omap3 gpmc: functionality enhancement
>=20
> On Thu, May 27, 2010 at 6:54 PM, Sukumar Ghorai <s-ghorai@ti.com> wro=
te:
> [...]
> > -static unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_cs_map;
> > +static unsigned =A0 =A0 =A0 =A0int gpmc_cs_map; =A0 =A0 =A0 =A0/* =
flag for cs which are
> initialized */
>=20
> Tab should be after 'int', not before.
>=20
> [...]
> > @@ -456,13 +565,22 @@ EXPORT_SYMBOL(gpmc_prefetch_enable);
> > =A0/**
> > =A0* gpmc_prefetch_reset - disables and stops the prefetch engine
> > =A0*/
> > -void gpmc_prefetch_reset(void)
> > +int gpmc_prefetch_reset(int cs)
> > =A0{
> > + =A0 =A0 =A0 u32 config1;
> > +
> > + =A0 =A0 =A0 /* check if the same module/cs is trying to reset */
> > + =A0 =A0 =A0 config1 =3D gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> > + =A0 =A0 =A0 if (((config1 >> CS_NUM_SHIFT) & 0x7) !=3D cs)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > +
>=20
> You really do not need this.
> Prefetch has just one instance at a time and 'reset' will be call onl=
y
> when driver has got access to prefetch (for either read or write
> access), from the driver.
[Ghorai] Agree. And.. NAND may not be good example. But if tomorrow i/o=
 operation need to cancel for some other type of device and for big siz=
e of IO on progress. So is not this API required that case?

>=20
> --
> Regards,
> Vimal Singh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
