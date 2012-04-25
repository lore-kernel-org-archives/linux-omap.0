From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v2] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 25 Apr 2012 20:28:36 +0200
Message-ID: <20120425182836.GA17023@parrot.com>
References: <1334861024-27386-1-git-send-email-ivan.djelic@parrot.com>
 <20120425170313.GW3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35954 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756340Ab2DYS37 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 14:29:59 -0400
Content-Disposition: inline
In-Reply-To: <20120425170313.GW3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Tony,
Thanks for the review,

On Wed, Apr 25, 2012 at 06:03:14PM +0100, Tony Lindgren wrote:
(...)
> >  #define GPMC_ECC1_RESULT        0x200
> > +#define GPMC_ECC_BCH_RESULT_0   0x240
>=20
> Can you please add a comment here saying something like:
>=20
> #define GPMC_ECC_BCH_RESULT_0   0x240	/* Not available on omap2 */

OK sure.

> > +	/* check if ecc module is in use */
> > +	if (gpmc_ecc_used !=3D -EINVAL)
> > +		return -EINVAL;
> > +	/*
> > +	 * FIXME: some OMAP3 revisions have a hardware bug which prevents
> > +	 * the 4-bit BCH mode from working properly. Such revisions could=
 be
> > +	 * detected and rejected here.
> > +	 */
>=20
> This should then be disabled to avoid corruption. Maybe only allow it
> initially on omaps that have been tested? And for omap2 it should ret=
urn
> error  for sure.

OK I'll add a check.

>=20
> Or do you know the broken omap3 versions?

Well, I was hoping that someone from linux-omap could tell me :)
I found this HW ECC feature table in
http://processors.wiki.ti.com/index.php/Raw_NAND_ECC:

         1b     4b      8b
---------------------------
OMAP35x  YES    NO      YES
AM35x    YES    YES     YES
AM/DM37x YES    YES     YES

and other wiki pages confirmed that 4-bit mode is not supported on all =
OMAP35xx chips.
OTOH, I know from TI support that 4-bit mode is at least supported on
OMAP3630 ES1.x (x >=3D 1).

So, a conservative approach would be to reject 4-bit mode on all chips =
but
omap3630 with rev >=3D 1.1. Other revisions/chips could be added later =
if they are
confirmed to work; what do you think ?

> Also, should you first request this feature in case multiple drivers
> need to share it?

According to TI documentation (OMAP36xx ES1.x TRM, =C2=A710.1.4, GPMC f=
unctional diagram),
the GPMC ECC engines (Hamming and BCH) are dedicated to NAND access onl=
y; therefore
I believe the mtd driver is the only potential user of this feature.
Also, the existing Hamming ecc API does not perform any request; or did=
 I miss
something? If I need to perform the request, is there an existing api t=
o do so?

Thanks,
--
Ivan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
