From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Add basic support for 720MHz part
Date: Thu, 20 Jan 2011 16:28:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302485095F6@dbde02.ent.ti.com>
References: <1295336995-15831-1-git-send-email-premi@ti.com>
 <AANLkTiko+QoLQn-qA9km-_WNfokrLimt2+D7UGmm_VpV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49044 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab1ATK6U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 05:58:20 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0KAwGJP016074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 04:58:18 -0600
In-Reply-To: <AANLkTiko+QoLQn-qA9km-_WNfokrLimt2+D7UGmm_VpV@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Varadarajan, Charulatha=20
> Sent: Tuesday, January 18, 2011 2:44 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
>=20
> Couple of minor comments.

[snip]...[snip]

> > --- a/arch/arm/mach-omap2/control.h
> > +++ b/arch/arm/mach-omap2/control.h
> > @@ -365,6 +365,13 @@
> > =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEAT_NEON =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 0
> > =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEAT_NEON_NONE =A0 =A0 =A0=
 =A0 =A01
> >
> > +/*
> > + * Product ID register
> > + */
>=20
> Do not use multiline comment style for single line comments

[sp] Was only following the multi-line comment stye few lines
     above...

>=20
> > +#define OMAP3_PRODID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x020C
> > +
> > +#define OMAP3_SKUID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0f
> > +#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_SKUID_720MHZ =A0 =A0 =
=A00x08
> >
> > =A0#ifndef __ASSEMBLY__
> > =A0#ifdef CONFIG_ARCH_OMAP2PLUS
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 5f9086c..53fbe01 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -195,6 +195,15 @@ static void __init omap3_check_features(void)
> > =A0 =A0 =A0 =A0 * TODO: Get additional info (where applicable)
> > =A0 =A0 =A0 =A0 * =A0 =A0 =A0 e.g. Size of L2 cache.
> > =A0 =A0 =A0 =A0 */
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Does it support 720MHz?
> > + =A0 =A0 =A0 =A0*/
>=20
> Ditto

[sp] Same here.
     But since the code is quite evident, I will remove the comment
     altogether.

>=20
> > + =A0 =A0 =A0 status =3D (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRO=
DID));
> > +
> > + =A0 =A0 =A0 if (status & OMAP3_SKUID_720MHZ) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_720MHZ;
> > + =A0 =A0 =A0 }
>=20
> No need of { } as there is only one line statement inside the=20
> if condition.

[sp] missed this.

~sanjeev

[snip]...[snip]--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
