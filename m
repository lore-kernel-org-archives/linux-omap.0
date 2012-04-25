From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 25 Apr 2012 13:57:46 -0700
Message-ID: <20120425205745.GX3739@atomide.com>
References: <1334861024-27386-1-git-send-email-ivan.djelic@parrot.com>
 <20120425170313.GW3739@atomide.com>
 <20120425182836.GA17023@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63295 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275Ab2DYU5u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 16:57:50 -0400
Content-Disposition: inline
In-Reply-To: <20120425182836.GA17023@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

* Ivan Djelic <ivan.djelic@parrot.com> [120425 11:33]:
> Hi Tony,
> Thanks for the review,
>=20
> On Wed, Apr 25, 2012 at 06:03:14PM +0100, Tony Lindgren wrote:
> (...)
> > >  #define GPMC_ECC1_RESULT        0x200
> > > +#define GPMC_ECC_BCH_RESULT_0   0x240
> >=20
> > Can you please add a comment here saying something like:
> >=20
> > #define GPMC_ECC_BCH_RESULT_0   0x240	/* Not available on omap2 */
>=20
> OK sure.
>=20
> > > +	/* check if ecc module is in use */
> > > +	if (gpmc_ecc_used !=3D -EINVAL)
> > > +		return -EINVAL;
> > > +	/*
> > > +	 * FIXME: some OMAP3 revisions have a hardware bug which preven=
ts
> > > +	 * the 4-bit BCH mode from working properly. Such revisions cou=
ld be
> > > +	 * detected and rejected here.
> > > +	 */
> >=20
> > This should then be disabled to avoid corruption. Maybe only allow =
it
> > initially on omaps that have been tested? And for omap2 it should r=
eturn
> > error  for sure.
>=20
> OK I'll add a check.
>=20
> >=20
> > Or do you know the broken omap3 versions?
>=20
> Well, I was hoping that someone from linux-omap could tell me :)
> I found this HW ECC feature table in
> http://processors.wiki.ti.com/index.php/Raw_NAND_ECC:
>=20
>          1b     4b      8b
> ---------------------------
> OMAP35x  YES    NO      YES
> AM35x    YES    YES     YES
> AM/DM37x YES    YES     YES
>=20
> and other wiki pages confirmed that 4-bit mode is not supported on al=
l OMAP35xx chips.
> OTOH, I know from TI support that 4-bit mode is at least supported on
> OMAP3630 ES1.x (x >=3D 1).
>=20
> So, a conservative approach would be to reject 4-bit mode on all chip=
s but
> omap3630 with rev >=3D 1.1. Other revisions/chips could be added late=
r if they are
> confirmed to work; what do you think ?

Sounds good to me.
=20
> > Also, should you first request this feature in case multiple driver=
s
> > need to share it?
>=20
> According to TI documentation (OMAP36xx ES1.x TRM, =C2=A710.1.4, GPMC=
 functional diagram),
> the GPMC ECC engines (Hamming and BCH) are dedicated to NAND access o=
nly; therefore
> I believe the mtd driver is the only potential user of this feature.
> Also, the existing Hamming ecc API does not perform any request; or d=
id I miss
> something? If I need to perform the request, is there an existing api=
 to do so?

OK I guess the only conflict would be multiple NAND chips then, which w=
e don't
have at least currently AFAIK.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
