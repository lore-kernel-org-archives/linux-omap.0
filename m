From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: [PATCH] ARM: omap2: mtd split nand_scan in ident and tail
Date: Fri, 15 Apr 2011 17:03:34 +0300
Message-ID: <1302876214.3220.62.camel@localhost>
References: <1302772529-15641-1-git-send-email-j.weitzel@phytec.de>
	 <1302874496.7246.11.camel@lws-weitzel>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:42409 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1DOOH0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 10:07:26 -0400
In-Reply-To: <1302874496.7246.11.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J.Weitzel@phytec.de
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, s.hauer@pengutronix.de, dwmw2@infradead.org, tony@atomide.com, s-ghorai@ti.com, vimalsingh@ti.com

On Fri, 2011-04-15 at 15:34 +0200, Jan Weitzel wrote:
> Am Donnerstag, den 14.04.2011, 11:15 +0200 schrieb Jan Weitzel:
> > nand_scan calls nand_scan_ident and nand_scan_tail, setting values =
like oobvail
> > according to ecc.layout. If we change the layout afterwards values =
are wrong.
> >=20
> > Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> > ---
> >  drivers/mtd/nand/omap2.c |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> > index da9a351..288423f 100644
> > --- a/drivers/mtd/nand/omap2.c
> > +++ b/drivers/mtd/nand/omap2.c
> > @@ -1073,9 +1073,9 @@ static int __devinit omap_nand_probe(struct p=
latform_device *pdev)
> >  	/* DIP switches on some boards change between 8 and 16 bit
> >  	 * bus widths for flash.  Try the other width if the first try fa=
ils.
> >  	 */
> > -	if (nand_scan(&info->mtd, 1)) {
> > +	if (nand_scan_ident(&info->mtd, 1, NULL)) {
> >  		info->nand.options ^=3D NAND_BUSWIDTH_16;
> > -		if (nand_scan(&info->mtd, 1)) {
> > +		if (nand_scan_ident(&info->mtd, 1, NULL)) {
> >  			err =3D -ENXIO;
> >  			goto out_release_mem_region;
> >  		}
> > @@ -1101,6 +1101,12 @@ static int __devinit omap_nand_probe(struct =
platform_device *pdev)
> >  		info->nand.ecc.layout =3D &omap_oobinfo;
> >  	}
> > =20
> > +	/* second phase scan */
> > +	if (nand_scan_tail(&info->mtd)) {
> > +		err =3D -ENXIO;
> > +		goto out_release_mem_region;
> > +	}
> > +
> >  #ifdef CONFIG_MTD_PARTITIONS
> >  	err =3D parse_mtd_partitions(&info->mtd, part_probes, &info->part=
s, 0);
> >  	if (err > 0)
>=20
> So no comments? Is any rework needed? Without this patch I am not abl=
e
> to mount partions with OMAP_ECC_HAMMING_CODE_HW_ROMCODE.=20

Sorry, I missed this patch. Could you please update the commit message
and make it more verbose and state clearly:

1. which problem you solve
2. how you solve it
3. why is this the right solution

Thanks!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
