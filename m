From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: No more software ECC in omap2.c NAND driver. Why?
Date: Sat, 20 Nov 2010 02:15:24 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42788@dbde02.ent.ti.com>
References: <201011181406.15212.manningc2@actrix.gen.nz>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036977BBA2@dbde02.ent.ti.com>
 <AANLkTi=XLc==mqGcBck5P+xutxAOENX1o9Bz8qPN=fC_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58556 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab0KSUpd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 15:45:33 -0500
In-Reply-To: <AANLkTi=XLc==mqGcBck5P+xutxAOENX1o9Bz8qPN=fC_@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Charles Manning <manningc2@actrix.gen.nz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Friday, November 19, 2010 4:06 PM
> To: Ghorai, Sukumar
> Cc: Charles Manning; linux-omap@vger.kernel.org
> Subject: Re: No more software ECC in omap2.c NAND driver. Why?
>=20
> On Thu, Nov 18, 2010 at 4:33 PM, Ghorai, Sukumar <s-ghorai@ti.com> wr=
ote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Charles Manning
> >> Sent: Thursday, November 18, 2010 6:36 AM
> >> To: linux-omap@vger.kernel.org
> >> Subject: No more software ECC in omap2.c NAND driver. Why?
> >>
> >> Between 2.6.35 and 2.6.36 there have need quite a few changes in t=
he
> NAND
> >> driver, including a change from software to hardware ECC.
> >>
> >> The new code has hardware ECC forced on by:
> >>
> >> #define CONFIG_MTD_NAND_OMAP_HWECC
> >>
> >> I am surprised that this was done. Surely this should have been a
> Kconfig
> >> option to select either sw ECC or hw ECC?
> >>
> >> Does moving to hardware ECC to the exclusion of software ECC reduc=
e
> >> functionality?
> >
> > [Ghorai] This is wrongly added by me, during last few patches. So I=
 have
> > send the fix as you mentioned too as.
> > [PATCH] omap: nand: remove hardware ECC as default
> >
> > And please let me know still if it has any issue.
>=20
> For me it makes normal sw ECC page IO work, but for subpages to work =
I
> have to disable the prefetch option.
[Ghorai] I was thinking that I have modularize some GPMC call and did n=
ot do anything prefetch related modificaiton. I will check this too.=20

>=20
> > And I am re-working on the patches for the different ecc schema
> including
> > s/w, h/w or different, to pass it form board file.
> >
> >>
> >> Does the new hwecc scheme still support sub-page writes or does it=
 only
> >> provide full page writes? If sub-page writes are lost then this ha=
s =A0a
> >> ripple
> >> effect in breaking the way some UBI stuff works.
> >
> > [Ghorai]
> > 1. do you think this sub-page read/write support was there before, =
say
> in
> > 2.6.35? And breaks in 2.6.36?
>=20
> It certainly was there for sw ECC as we've been using UBI from 2.6.27
> to 2.6.35 just fine.
[Ghorai] uoderstand.

>=20
> > 2. In that case would you please let know what are the size(s) used=
 for
> > sub-page/read write?
>=20
> 512 bytes.
[Ghorai] I feel still its support in 2.6.36 too. Let me check too.=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
