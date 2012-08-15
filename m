From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Wed, 15 Aug 2012 09:50:04 +0300
Message-ID: <1345013404.11980.17.camel@lappyti>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
	 <1344273868.12136.50.camel@deskari> <5020009C.1080308@ti.com>
	 <20120806221424.GD1298@harshnoise.musicnaut.iki.fi>
	 <5020B749.8060303@ti.com> <1344345722.7216.70.camel@lappyti>
	 <20120814213129.GA747@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zkwoKvajVK+1ii1dsk/7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:50152 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab2HOGuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 02:50:10 -0400
Received: by lbbgj3 with SMTP id gj3so753451lbb.33
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 23:50:07 -0700 (PDT)
In-Reply-To: <20120814213129.GA747@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-zkwoKvajVK+1ii1dsk/7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-15 at 00:31 +0300, Aaro Koskinen wrote:
> Hi,
>=20
> On Tue, Aug 07, 2012 at 04:22:02PM +0300, Tomi Valkeinen wrote:
> > On Tue, 2012-08-07 at 12:05 +0530, Archit Taneja wrote:
> > > On Tuesday 07 August 2012 03:44 AM, Aaro Koskinen wrote:
> > > > On Mon, Aug 06, 2012 at 11:06:28PM +0530, Archit Taneja wrote:
> > > >>> On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
> > > >>>> I can't get the display on N900 (SDI, acx565akm) to work with v3=
.6-rc1
> > > >>>> kernel, it's just full of flicker/noise.
> > > >>>>
> > > >>>> According to git-bisect, the problem is introduced by the commit=
:
> > > >>>>
> > > >>>>      commit f476ae9dab3234532d41d36beb4ba7be838fa786
> > > >>>>      Author: Archit Taneja <archit@ti.com>
> > > >>>>      Date:   Fri Jun 29 14:37:03 2012 +0530
> > > >>>>
> > > >>>>      OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parame=
ters in interface
> > > >
> > > > [...]
> > > >
> > > >> The diff I have shared introduces the register writes back. This
> > > >> should make it work like before. But we need to figure out which
> > > >> parameter write needs to be done immediately. If this works, could
> > > >> you remove each dispc register write turn by turn, and point out
> > > >> which is the culprit one?
> > > >
> > > > Thanks, the following one makes the display to work again:
> > > >
> > > > diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/ds=
s/sdi.c
> > > > index 5d31699..3c9f598 100644
> > > > --- a/drivers/video/omap2/dss/sdi.c
> > > > +++ b/drivers/video/omap2/dss/sdi.c
> > > > @@ -46,6 +46,9 @@ static void sdi_config_lcd_manager(struct omap_ds=
s_device *dssdev)
> > > >   	sdi.mgr_config.video_port_width =3D 24;
> > > >   	sdi.mgr_config.lcden_sig_polarity =3D 1;
> > > >
> > > > +	dispc_mgr_set_clock_div(dssdev->manager->id,
> > > > +				&sdi.mgr_config.clock_info);
> > > > +
> > >=20
> > > Thanks for finding this. It's a bit peculiar why this is happening. T=
he=20
> > > DISPC_DIVISOR is a shadow register for sure.
> > >=20
> > > I don't know much about SDI, but it looks like the SDI PLL needs the=
=20
> > > free running pixel clock from the LCD manager. To achieve this, we se=
t=20
> > > PCKFREEENABLE. The thing I don't understand is that whether the free=
=20
> > > running pixel clock at this point would be derived out of the old LCD=
=20
> > > and PCD values, or the new ones? It should have been old since LCD an=
d=20
> > > PCD are shadowed registers.
> > >=20
> > > In other words, I am suspecting that the field PCKFREEENABLE does a c=
opy=20
> > > of the LCD and PCD dividers from the shadow registers to the working=
=20
> > > registers.
> > >=20
> > > The regdump shows that there were issues in SDI initialization.
> > >=20
> > > Tomi,
> > >=20
> > > Any ideas about this?
> >=20
> > No real ideas. I think adding the line above, and a big HACK comment
> > above it, is ok for the time being. It's quite simple hack and shouldn'=
t
> > cause any problems anywhere.
>=20
> Will you be sending a patch (i.e. the HACK mentioned above) to fix this
> during the 3.6-rc cycle?

Yes, I'll queue it up.

> > Aaro, if you have spare time, you could test and move the call to
> > dispc_mgr_set_clock_div later, and see where calling it stops fixing th=
e
> > issue.=20
> >=20
> > My guess is that calling it after dss_sdi_init() will still work, but
> > calling it after dss_sdi_enable() does not work. And most likely inside
> > dss_sdi_enable() it won't work if placed after dispc_pck_free_enable().=
=20
>=20
> You are right that dss_sdi_enable() is the critical function. According
> to my tests, the exact breaking point is the
>=20
> 	/* Waiting for PLL to lock */
>=20
> loop. If dispc_mgr_set_clock_div() is called before it works, but if I
> put it after the loop the display fails to work.

That's interesting. I think that basically tells us that the shadow
register mechanism is somehow bypassed for pck-free. And if so, then the
above hack is not really a hack at all, but something required.

 Tomi


--=-zkwoKvajVK+1ii1dsk/7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQK0acAAoJEPo9qoy8lh71bIsQAJjQXVlkCfnPhRea3QJ1ZlCN
CNr6z317g1uUiIn1p3NeoJB6D05eKRyl90LPG3OUzOWcGhWZ5+8g6oeELZgUcAjG
OYrnSQdm3kNOUK6lG5YIL+zPI+84VeganqeoAsMPLRp0JhCw5V88cVL75mwnsM1Y
6/XVQE2PvKmRaPqiR4ZZxqtJJf2/gWwP1k3Oe8evOCcrnToRvX9CyWMhEwHOkBsV
xQBahi9yUOLwx5GFddEHGPXTSQtIeeSaVMgQeL9d8ejdcbzVMUbohjOvxb6NSqKJ
pV98hn8jwbTG9AWWPMPnY1nWo/4S0Y9VNuK3a/gQSStzNJkOpyPlUNlfxACREJlY
O0Wm6RKYRy86nuP+01cuh9TOQ22d/KFbPW5FH92GyObpzWjML+cj+BGq55wdcB8X
U7aUVkvsHKlVF9A7lkZOWIeTfaw5azHL/ANE81yJPE/YPoZSte0VilsKGrjmE1lr
xaQZDFBIHzc6PS+UFBzTK2XUN2DGsfOheVEwdyyBW08Hv2xIJF6/clnPo691j21/
Ff2i2q6ObEXMRbkLGuDgXMKXl19emGdSAnDuCriZsSdEhyQIpYISsFu3XEv7HKyW
sCUMVaELHH87RnQu7WTlJf+KobL6iRW0DNNDGmFoiVpAtKRm4rmJpR8vRVvByKvY
u6YqOJ9Pf4cxiukSxW+4
=KchI
-----END PGP SIGNATURE-----

--=-zkwoKvajVK+1ii1dsk/7--

