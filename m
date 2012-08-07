From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Tue, 07 Aug 2012 16:22:02 +0300
Message-ID: <1344345722.7216.70.camel@lappyti>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
	 <1344273868.12136.50.camel@deskari> <5020009C.1080308@ti.com>
	 <20120806221424.GD1298@harshnoise.musicnaut.iki.fi>
	 <5020B749.8060303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-WDIaDOhIZCne/amusAi+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:44914 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754512Ab2HGNWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 09:22:09 -0400
Received: by laai10 with SMTP id i10so1931567laa.41
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 06:22:05 -0700 (PDT)
In-Reply-To: <5020B749.8060303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org


--=-WDIaDOhIZCne/amusAi+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 12:05 +0530, Archit Taneja wrote:
> On Tuesday 07 August 2012 03:44 AM, Aaro Koskinen wrote:
> > Hi,
> >
> > On Mon, Aug 06, 2012 at 11:06:28PM +0530, Archit Taneja wrote:
> >>> On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
> >>>> I can't get the display on N900 (SDI, acx565akm) to work with v3.6-r=
c1
> >>>> kernel, it's just full of flicker/noise.
> >>>>
> >>>> According to git-bisect, the problem is introduced by the commit:
> >>>>
> >>>>      commit f476ae9dab3234532d41d36beb4ba7be838fa786
> >>>>      Author: Archit Taneja <archit@ti.com>
> >>>>      Date:   Fri Jun 29 14:37:03 2012 +0530
> >>>>
> >>>>      OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters=
 in interface
> >
> > [...]
> >
> >> The diff I have shared introduces the register writes back. This
> >> should make it work like before. But we need to figure out which
> >> parameter write needs to be done immediately. If this works, could
> >> you remove each dispc register write turn by turn, and point out
> >> which is the culprit one?
> >
> > Thanks, the following one makes the display to work again:
> >
> > diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sd=
i.c
> > index 5d31699..3c9f598 100644
> > --- a/drivers/video/omap2/dss/sdi.c
> > +++ b/drivers/video/omap2/dss/sdi.c
> > @@ -46,6 +46,9 @@ static void sdi_config_lcd_manager(struct omap_dss_de=
vice *dssdev)
> >   	sdi.mgr_config.video_port_width =3D 24;
> >   	sdi.mgr_config.lcden_sig_polarity =3D 1;
> >
> > +	dispc_mgr_set_clock_div(dssdev->manager->id,
> > +				&sdi.mgr_config.clock_info);
> > +
>=20
> Thanks for finding this. It's a bit peculiar why this is happening. The=
=20
> DISPC_DIVISOR is a shadow register for sure.
>=20
> I don't know much about SDI, but it looks like the SDI PLL needs the=20
> free running pixel clock from the LCD manager. To achieve this, we set=
=20
> PCKFREEENABLE. The thing I don't understand is that whether the free=20
> running pixel clock at this point would be derived out of the old LCD=20
> and PCD values, or the new ones? It should have been old since LCD and=
=20
> PCD are shadowed registers.
>=20
> In other words, I am suspecting that the field PCKFREEENABLE does a copy=
=20
> of the LCD and PCD dividers from the shadow registers to the working=20
> registers.
>=20
> The regdump shows that there were issues in SDI initialization.
>=20
> Tomi,
>=20
> Any ideas about this?

No real ideas. I think adding the line above, and a big HACK comment
above it, is ok for the time being. It's quite simple hack and shouldn't
cause any problems anywhere.

Aaro, if you have spare time, you could test and move the call to
dispc_mgr_set_clock_div later, and see where calling it stops fixing the
issue.=20

My guess is that calling it after dss_sdi_init() will still work, but
calling it after dss_sdi_enable() does not work. And most likely inside
dss_sdi_enable() it won't work if placed after dispc_pck_free_enable().=20

 Tomi


--=-WDIaDOhIZCne/amusAi+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIRZ6AAoJEPo9qoy8lh71beYQAIOzLYDFZhwoYOT/JyTFbIpP
7+ZBo9okNa1vVY6M12d7dmz3Aafep18OzW9n7dNtQdCUPw5WuciuPfh4ezj/GYZG
k/W3R1Sh+LqdUXVt9LHFnFUVgwLFSbu2S6COha0Lz0hn5MGOIFoHDqhtv3RCsQN9
jzQ5EBIc44zpiNLJDRKCMTvKzOTEo/bvNM9tZvGUyeUypWxXZ3O01QRIYRM9OsMl
LcStOmNFyydIICz1ALCHbh0wfXeoIZbAwL5+hsHL8NXOgpAr/3ohpmME3CJ+y7++
xcwBKkhc1xMgMBmTtTjVW/6nx11VS81uax5UgIFgebdazFzez2EkQpjFrlqV/8l1
ZezA0iOPWUxtlLqakDH/6v1hCOQ75WIMR1pzLpbAZ/6Js6jPYX2WOIksQ/LlnZ6j
GicFk03pjTLaga5vSY0R3ZhjvQ1nYwg+zgr09qGMV7vRm1jL+vP3GEHUp6MqTmJI
OTDJ+NKKJW8FfoIm2fY/pFHP3TupeGIH8TGbLXMt7LR6OwCDgKRjkMYuYPI3BtYn
I8s84t4DL+8cjdzFp4n+eWPZ6SkHhBueuoveNl9CRAv/S9tyMnNKZlCgWF4eg/cQ
c5Zt0IMhGsoGfBqyFddMaxF5buvwMrJsdBv5/twxmaDznBBLZ/gMcO6BlQqguQ3v
tVoFRPSkmRVFPAta7ddF
=mN8s
-----END PGP SIGNATURE-----

--=-WDIaDOhIZCne/amusAi+--

