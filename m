From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] nand support on omap3 boards
Date: Wed, 14 Apr 2010 10:08:06 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D4D2910@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
 	<1271180246-31779-3-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-4-git-send-email-s-ghorai@ti.com>
 	<1271180246-31779-5-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-6-git-send-email-s-ghorai@ti.com>
 	<1271180246-31779-7-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-8-git-send-email-s-ghorai@ti.com>
 	<1271180246-31779-9-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
 <t2hce9ab5791004132135j73583ea2n172704b5ed33dcec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43902 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab0DNEiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 00:38:15 -0400
In-Reply-To: <t2hce9ab5791004132135j73583ea2n172704b5ed33dcec@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> Sent: 2010-04-14 10:05
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] nand support on omap3 boards
>=20
> You post this mail in previous thread. Do not do that. ($SUBJECT is
> same as last one).
> Post it in different thread.
>=20
> And why this is not posted as a series?
> In fact these patches should be posted in two set of patches:
> 1. patches related to IRQ mode support
> 2. patches related ROM code ecc layout
[Ghorai] Agree.
>=20
> And IMHO, these patches should in revers order:
> > =A0omap: NAND: ecc layout select from board file
> > =A0omap: NAND: Making ecc layout as compatible with romcode ecc
[Ghorai] But this is the order it's in SYNC/ manju's dev tree. I think.

>=20
> One more thing all these patches should also be posted to MTD list. I=
n
> fact, most of these patches should go through mtd tree itself.
[Ghorai] ok. I will..
>=20
> --
> Regards,
> Vimal Singh
>=20
>=20
>=20
> On Tue, Apr 13, 2010 at 11:07 PM, Sukumar Ghorai <s-ghorai@ti.com> wr=
ote:
> > =A0 The following set of patches applies on top of the Tony's maste=
r
> branch.
> > =A0 And dependency on following series of patch -
> >
> >
> > Sukumar Ghorai (3):
> > =A0omap3: GPMC register definition at common location
> > =A0omap3: NAND Prefetch in IRQ mode support
> > =A0omap-3630 NAND: enable NAND io in prefetch-irq mode
> > =A0omap: NAND: ecc layout select from board file
> > =A0omap: NAND: Making ecc layout as compatible with romcode ecc
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
