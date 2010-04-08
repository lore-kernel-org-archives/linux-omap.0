From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH 0/3][NAND][OMAP]: fixing omap nand driver issues
Date: Thu, 8 Apr 2010 22:01:32 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D44E1BA@dbde02.ent.ti.com>
References: <ce9ab5791001060558u362f17baj5ee90e9b4adb72a7@mail.gmail.com>
 <l2v5e088bd91004080858ub5dd068ci711a5399098ba0ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50366 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818Ab0DHQbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 12:31:42 -0400
In-Reply-To: <l2v5e088bd91004080858ub5dd068ci711a5399098ba0ee@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, Vimal Singh <vimal.newwork@gmail.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Steve Sakoman
> Sent: 2010-04-08 21:28
> To: Vimal Singh
> Cc: Linux MTD; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/3][NAND][OMAP]: fixing omap nand driver issues
>=20
> On Wed, Jan 6, 2010 at 5:58 AM, Vimal Singh <vimal.newwork@gmail.com>
> wrote:
> > From 3700088e8da8c890d9e4c6eb626e18287d149b97 Mon Sep 17 00:00:00 2=
001
> > From: Vimal Singh <vimalsingh@ti.com>
> > Date: Tue, 5 Jan 2010 16:43:08 +0530
> > Subject: [PATCH] fixing omap nand driver issues
> >
> > fixing omap nand driver issues.
> >
> > Vimal Singh (3):
> > =A0Fixing compilation warning for 'nand/omap2.c'
> > =A0NAND: OMAP: correct 'info' pointer in 'omap_nand_remove'
> > =A0NAND: OMAP: Fixing issue in oamp nand driver in prefetch mode re=
ad
>=20
> What is the status of this patch series?

[Ghorai] These are already accepted by MTD-list. Please check the first=
 three patches in the link -
http://git.infradead.org/mtd-2.6.git?a=3Dsearch&h=3DHEAD&st=3Dcommit&s=3D=
vimal

>=20
> I've been testing them on Overo and Beagle and they do indeed solve
> the prefetch issue.  So if they are queued waiting an ack:
>=20
> Acked-by: Steve Sakoman <steve@sakoman.com>
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
