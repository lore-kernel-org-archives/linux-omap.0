From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] omap3: nand: bch ecc support added
Date: Fri, 21 Jan 2011 13:54:05 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB174@dbde02.ent.ti.com>
References: <1295518680-8737-1-git-send-email-s-ghorai@ti.com>
 <AANLkTimsD1108ASF3H9Y8pjaTsfv0D33K11KOXDmypvJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34718 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab1AUIYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 03:24:13 -0500
In-Reply-To: <AANLkTimsD1108ASF3H9Y8pjaTsfv0D33K11KOXDmypvJ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Kishore Kadiyala [mailto:kishorek.kadiyala@gmail.com]
> Sent: Friday, January 21, 2011 1:42 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-=
arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] omap3: nand: bch ecc support added
>=20
> Ghorai,
>=20
> <snip>
>=20
> > =A0#ifdef CONFIG_MTD_PARTITIONS
> > diff --git a/drivers/mtd/nand/omap_bch_decoder.c
> b/drivers/mtd/nand/omap_bch_decoder.c
> > new file mode 100644
> > index 0000000..da42bda
> > --- /dev/null
> > +++ b/drivers/mtd/nand/omap_bch_decoder.c
> > @@ -0,0 +1,393 @@
> > +/*
> > + * drivers/mtd/nand/omap_omap_bch_decoder.c
> > + *
> > + * Whole BCH ECC Decoder (Post hardware generated syndrome decodin=
g)
> > + *
> > + * Copyright (c) 2007 Texas Instruments
> > + *
> > + * Author: Sukumar Ghorai <s-ghorai@ti.com
> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Michael Fillinger <m-fillinger@t=
i.com>
>=20
> Vimal was the original author who has created this file
> [No change in file name/directory hierarchy].
> It's not fair to remove Vimal's author and add your's.
>=20
> Instead you should have kept his name and added your's.
[Ghorai] Ok.  I will do ..=20
But can you send me working version of these? At least comipled version=
 for any kernel?

>=20
> <snip>
>=20
> Regards,
> Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
