From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 0/1] Fix OMAP2 NAND ONFI device detection
Date: Wed, 6 Nov 2013 18:18:34 -0300
Message-ID: <20131106211833.GB12624@localhost>
References: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131030191414.GA16668@norris.computersforpeace.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA2D41D@DBDE04.ent.ti.com>
 <20131030231956.GA2489@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA31B19@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48037 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932090Ab3KFVSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 16:18:30 -0500
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA31B19@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>

On Wed, Nov 06, 2013 at 08:54:56PM +0000, Gupta, Pekon wrote:
> > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> > > On Wed, Oct 30, 2013 at 09:18:53PM +0000, Gupta, Pekon wrote:
> > > >
> > > > I'm not sure, of course, but I don't see why not. It's more lik=
ely to
> > > > break for x16 than it is for x8.
> > > >
> > > Another question here is ..
> > > The above patch assumes that user has configured GPMC bus-width
> > > correctly, so if user is already providing GPMC bus-width informa=
tion
> > > via DT, then do we really need to detect NAND device bus-width ag=
ain
> > > using NAND_BUSWIDTH_AUTO ?
> > >
> >=20
> > Hm.. I think you're forgetting the original motivation for this pat=
ch,
> > which was initially explained by you :-) The problem is ONFI doesn'=
t work
> > in 16-bit mode.
> >=20
> > Let me clarify. Since GPMC and NAND widths *must* match (otherwise,=
 it
> > wouldn't make much sense, right?) we don't really need to autodetec=
t the
> > NAND width.
> >=20
> > However, since ONFI doesn't work in 16-bit mode, we would have to d=
o
> > something like this (untested pseudo code):
> >=20
> >   nand_scan_ident(...);
> >=20
> >   if (platform_data->devsize =3D=3D 16)
> >   	nand_chip->options |=3D NAND_BUSWIDTH_16;
> >=20
> > And in some cases we might even get away with such solution. Howeve=
r,
> > we can't guarantee nand_scan_ident() doesn't need to swith to 16-bi=
t mode
> > inside to perform other commands (maybe some ONFI extended paramete=
r
> > page).
> >=20
> > Therefore, and given the width can be autodetected in any case (arr=
ay
> > or ONFI based carry such information) it's much cleaner to simply d=
o:
> >=20
> >   nand_chip->options |=3D NAND_BUSWIDTH_AUTOMAGIC;
> >   nand_scan_ident(...);
> >=20
> > See? Much cleaner, no?
> >=20
> but still dependent on DT property for GPMC configurations...
> I preferred NAND bus-width detection to be completely independent
> of 'any' DT property.
>=20

I think we're still mixing GPMC and NAND, and I don't think it's sane.

> > And remember: the fact that we must know the device width to config=
ure
> > the GPMC correctly (which being a hardware parameter belongs to the=
 DT)
> > is OMAP specific. Other SoCs might not have such memory controller
> > and thus won't need such knowledge before hand, although that sound=
s
> > unlikely to me.
> >=20
> > The outcome of this discussion seems to be that no driver should ev=
er
> > need to specify the 'nand-bus-width' DT property, as Brian
> > previously suggested, right?
> >=20
> Right.. And this is where I'm suggesting that in-order to completely
> eliminate the dependency on 'nand-bus-width' DT property, you need
> to also update GPMC driver, so that its registers can be re-configure=
d with
> correct NAND bus-width after nand_scan_ident().
>=20


Well, as I said: I don't think there's any technical reason why you
can't just export a GPMC function to re-configure it from the NAND
driver. I just think it's ugly, and not useful.

So, I think you (or me, or anybody else) can push an RFC/PATCH to see
how ugly would that really be. Maybe it's not so bad.

But: on the other hand, I'd really like you to convince me as to
why is it so bad to require the DTB to have the proper GPMC bus width.

Once again:
1. the NAND devices aren't hot-pluggable
2. the "user" (who is actually an engineer, not some regular dummy user=
)
knows perfectly well the width of the device.

What's the problem with describing the hardware in the DT and saving us
lots of runtime re-configuration trouble?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
