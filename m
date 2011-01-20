From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Thu, 20 Jan 2011 16:50:32 +0530
Message-ID: <20110120112032.GC1987@m-desktop>
References: <1295336995-15831-1-git-send-email-premi@ti.com>
 <AANLkTiko+QoLQn-qA9km-_WNfokrLimt2+D7UGmm_VpV@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302485095F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49246 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752916Ab1ATLVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 06:21:30 -0500
Received: by yxt3 with SMTP id 3so128745yxt.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 03:21:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302485095F6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 20, 2011 at 04:28:11PM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Varadarajan, Charulatha=20
> > Sent: Tuesday, January 18, 2011 2:44 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
> >=20
> > Couple of minor comments.
>=20
> [snip]...[snip]
>=20
> > > --- a/arch/arm/mach-omap2/control.h
> > > +++ b/arch/arm/mach-omap2/control.h
> > > @@ -365,6 +365,13 @@
> > > =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEAT_NEON =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 0
> > > =A0#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEAT_NEON_NONE =A0 =A0 =
=A0 =A0 =A01
> > >
> > > +/*
> > > + * Product ID register
> > > + */
> >=20
> > Do not use multiline comment style for single line comments
>=20
> [sp] Was only following the multi-line comment stye few lines
>      above...
>=20
> >=20
> > > +#define OMAP3_PRODID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x020C
> > > +
> > > +#define OMAP3_SKUID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0f
> > > +#define =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_SKUID_720MHZ =A0 =A0=
 =A00x08
> > >
> > > =A0#ifndef __ASSEMBLY__
> > > =A0#ifdef CONFIG_ARCH_OMAP2PLUS
> > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > > index 5f9086c..53fbe01 100644
> > > --- a/arch/arm/mach-omap2/id.c
> > > +++ b/arch/arm/mach-omap2/id.c
> > > @@ -195,6 +195,15 @@ static void __init omap3_check_features(void=
)
> > > =A0 =A0 =A0 =A0 * TODO: Get additional info (where applicable)
> > > =A0 =A0 =A0 =A0 * =A0 =A0 =A0 e.g. Size of L2 cache.
> > > =A0 =A0 =A0 =A0 */
> > > +
> > > + =A0 =A0 =A0 /*
> > > + =A0 =A0 =A0 =A0* Does it support 720MHz?
> > > + =A0 =A0 =A0 =A0*/
> >=20
> > Ditto
>=20
> [sp] Same here.
>      But since the code is quite evident, I will remove the comment
>      altogether.
>=20
> >=20
> > > + =A0 =A0 =A0 status =3D (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_P=
RODID));
> > > +
> > > + =A0 =A0 =A0 if (status & OMAP3_SKUID_720MHZ) {
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_features |=3D OMAP3_HAS_720MH=
Z;
> > > + =A0 =A0 =A0 }
> >=20
> > No need of { } as there is only one line statement inside the=20
> > if condition.
>=20
> [sp] missed this.

Looks fine. Feel free to add after the above changes:

Reviewed-by: G, Manjunath Kondaiah <manjugk@ti.com>

-Manjunath

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
