From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 01/11] usb: musb: add musb->id to identify core
 instance
Date: Wed, 25 Jul 2012 15:32:21 +0300
Message-ID: <20120725123221.GY16794@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-2-git-send-email-ajay.gupta@ti.com>
 <20120725121128.GO16794@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAE5B87@DBDE01.ent.ti.com>
 <20120725122028.GV16794@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAE5BEC@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHYmV+hLPeNaasdK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:51280 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933023Ab2GYMfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 08:35:33 -0400
Received: by lban1 with SMTP id n1so571906lba.24
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 05:35:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAE5BEC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>


--wHYmV+hLPeNaasdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2012 at 12:30:12PM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> > On Wed, Jul 25, 2012 at 12:19:32PM +0000, Gupta, Ajay Kumar wrote:
> > > Hi,
> > > >
> > > > On Wed, Jul 25, 2012 at 05:37:19PM +0530, Ajay Kumar Gupta wrote:
> > > > > diff --git a/drivers/usb/musb/musb_core.c
> > > > > b/drivers/usb/musb/musb_core.c index 89d1871..f5eb8a7 100644
> > > > > --- a/drivers/usb/musb/musb_core.c
> > > > > +++ b/drivers/usb/musb/musb_core.c
> > > >
> > > > <snip>
> > > >
> > > > > @@ -1889,6 +1921,7 @@ musb_init_controller(struct device *dev, int
> > > > > nIrq,
> > > > void __iomem *ctrl)
> > > > >  	pm_runtime_enable(musb->controller);
> > > > >
> > > > >  	spin_lock_init(&musb->lock);
> > > > > +	musb->id =3D pdev->id;
> > > >
> > > > I fail to see where this musb->id would be used. Care to clarify ?
> > >
> > > Sure, It is used in musb_init_debugfs(). Please refer 02/11.
> >=20
> > Then it's a bit unnecessary right ?
> >=20
> > You can change the directory name to dev_name(musb->controller) as that=
 will
> > already have the id appended to it.
>=20
> Well, musb->id is used at many more places and it has to be there. Please=
 refer
>=20
> 01/11 where all glue layers using it for:
> +       musb_put_id(&pdev->dev, glue->musb->id);

your struct *_glue{}; should be the one holding the ID as it's the one
who requested it. If you request multiple IDs, you hold multiple IDs
(glue->id0, glue->id1, glue->idN) and so on.

--=20
balbi

--wHYmV+hLPeNaasdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD+dVAAoJEIaOsuA1yqRE/+IP/iukZ7X7dqGUWrTJnfPaY29/
1lqN8AI6t06E4ZRQ/FsCz3eUJ4gUfwkbFL4Ek4B6yPz1jkksFX9EMDBbnfLBRO4M
idRQcIRs+ULgWXYZgsCoYK9HB7Rbg565aQjiAwz7GjalrY2UmtPmzKPW8eNd314P
O4w/HVTaewmk9ii2NvxaMKaXlunFOTCTqXd3ZTv/MCoJde509YH2GzdrXeHlfG9D
AdN4igUIe1uskILapctK7ryyDMcNdEk37IFAPo2wuUorjoMH8DETvUUJg2lLNJtL
bSbrSg6x5xyGqfmwNznCRuoAV3b7QJgxeOQ3shhgwU5XmJpP6exj9Lq0ZHr0Y7be
XRXaChPA2e3xQHihaoetOETUK+tk7T7Ij8i81tIrcEUwjSgCzc5UORS70NrGx0CP
VmRFxXjqG8iuZCU5m7DXDF2XerNXYiGH3q4bqnOx/4VIUaPy2JwXLr9XeSHaoF4c
YcI7o13lFg8FyJuxCYqaeCLQIf442zCQl99eOXHSqUrIJdIzILLwMX341X+3C78x
fKlmye8bccKBc2qEFQL3P/G0IpW5HIlnS0KkgHFx19KqugcGnGeWwKFMykMKkICQ
hMSuLmsRKLrYUJv4dA+f6pqL/wWLK3Doe8tSv7uArZyCxG+LVK5VrfA/e6JW48Kq
mEVQogVR+2MMFgQiR8Rh
=hV9e
-----END PGP SIGNATURE-----

--wHYmV+hLPeNaasdK--
