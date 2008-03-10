From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Problems booting Filesystem
Date: Mon, 10 Mar 2008 23:36:13 +0200
Message-ID: <20080310213612.GJ4459@kedavra.cpe.vivax.com.br>
References: <ae36f8040803101227i6be46d20y6bbc49b06deb4f7d@mail.gmail.com> <20080310201849.GF4459@kedavra.cpe.vivax.com.br> <ae36f8040803101319r74d2ec97g2c0444358ce6254@mail.gmail.com> <20080310205258.GG4459@kedavra.cpe.vivax.com.br> <ae36f8040803101359ge183967ie59ab7fa39ef0dee@mail.gmail.com> <5573C19A4BBDB441BED2A44157E970530361B68B@dlee12.ent.ti.com> <20080310212103.GI4459@kedavra.cpe.vivax.com.br> <ae36f8040803101421s18eab233gf391f19c99e329f8@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40623 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYCJVeI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 17:34:08 -0400
Content-Disposition: inline
In-Reply-To: <ae36f8040803101421s18eab233gf391f19c99e329f8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lu?s Vit?rio Cargnini <lvcargnini@gmail.com>
Cc: me@felipebalbi.com, "Hunter, Jon" <jon-hunter@ti.com>, linux-omap@vger.kernel.org

On Mon, Mar 10, 2008 at 06:21:25PM -0300, Lu?s Vit?rio Cargnini wrote:
> humm, So why I having this problem ? If I have NOR Flashes why this
> problem now with my kernel ?
> Someone try it, with my config file ?

Maybe a bug in drivers/mtd/maps/omap_nor.c ?
check whether omapflash_probe is being successfull.

Add some

printk(KERN_INFO "%s %d\n", __FUNCTION__, __LINE__);

to see if it goes through the whole function.

>=20
>=20
> On Mon, Mar 10, 2008 at 6:21 PM, Felipe Balbi <me@felipebalbi.com> wr=
ote:
> >
> > On Mon, Mar 10, 2008 at 04:12:07PM -0500, Hunter, Jon wrote:
> >  > > I'm flashing in the flash of the OSK kit ( a NAND flash I supp=
ose).
> >  >
> >  > I don't think they ever put NAND on the 5912OSKs. According to t=
he
> >  > manufacturer website you could have either Intel or Micron flash=
, but I
> >  > believe both are NOR flashes.
> >  >
> >  > See: http://omap.spectrumdigital.com/osk5912/
> >  >
> >  > Jon
> >
> >  Good catch.
> >
> >  > --
> >  > To unsubscribe from this list: send the line "unsubscribe linux-=
omap" in
> >  > the body of a message to majordomo@vger.kernel.org
> >  > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
> >
> >  --
> >  Best Regards,
> >
> >
> >  Felipe Balbi
> >  me@felipebalbi.com
> >  http://blog.felipebalbi.com
> >
>=20
>=20
>=20
> --=20
> ---------------------------------------------------------------------=
---------
> Thanks && Regards
> M.Sc. B.Sc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 ??? Building 30
> P.O. Box: 90619-900 ??? Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> ---------------------------------------------------------------------=
------------
> N?????r??y????b?X????v?^?)??{.n?+????{??f??{ay?=1D?????,j=07??f???h??=
?z?=1E?w???=0C???j:+v???w?j?m????=07????zZ+???????j"??!
--=20
Best Regards,

=46elipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
