From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 02/11] usb: musb: kill global and static for multi
 instance
Date: Thu, 26 Jul 2012 16:06:14 +0300
Message-ID: <20120726130613.GA2378@arwen.pp.htv.fi>
References: <1343218326-30610-1-git-send-email-ajay.gupta@ti.com>
 <20120726074057.GH29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF790@DBDE01.ent.ti.com>
 <20120726082459.GP29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF877@DBDE01.ent.ti.com>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAF41EB@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:54738 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418Ab2GZNJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 09:09:28 -0400
Received: by lahm15 with SMTP id m15so1587883lah.37
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 06:09:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAF41EB@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2012 at 12:46:43PM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> > > > > On Wed, Jul 25, 2012 at 05:42:06PM +0530, Ajay Kumar Gupta wrote:
> > > > > > @@ -240,20 +238,24 @@ int __devinit musb_init_debugfs(struct mu=
sb
> > > *musb)
> > > > > >  	struct dentry		*root;
> > > > > >  	struct dentry		*file;
> > > > > >  	int			ret;
> > > > > > +	char			name[10];
> > > > > >
> > > > > > -	root =3D debugfs_create_dir("musb", NULL);
> > > > > > +	sprintf(name, "musb%d", musb->id);
> > > > > > +	root =3D debugfs_create_dir(name, NULL);
> > > > >
> > > > > I told you to use dev_name(musb) for a reason. See what happens w=
hen
> > > > > you use dev_name(musb);
> > > > >
> > > > > Do you not think about the other users of this driver ? Do you not
> > > > > know what's the ID on platform_devices which "don't have an ID" ??
> > > >
> > > > We are now using musb_ida for all glue layers so '-1' issue will not
> > come.
> > >
> > > true.
> > >
> > > > Still if we can manage without 'id' then better to do that way.
> > >
> > > just make sure to notice that directory name will "musb.0".
>=20
> It creates musb-hdrc.0 and musb-hdrc.1 as glue layers use "musb-hdrc"
> name in platform_device_alloc() call.

yes, indeed. That shouldn't be a problem though... what do you think ?

--=20
balbi

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEUDFAAoJEIaOsuA1yqREKNYP/RXLcS+8XdedugTZR34qsVVr
OFXERXTFnfoPI+CVmHOFeQToD+KdPySMyVKwQr+7LMz8CTt26XaW5nTavl6Uk2Yo
LYYD/8wWahu54QORtBf5U48YJETYjKTh3KONmdRXalT5uszp2xqQ/QOMfC9qjUMb
Q3ulpBLSs9rs/FY0/AuwzrN7QtAUMeotoKAOUtQtpa3DNBa1YI6Esz0we2rAHhQx
MNBqCyMCscShU1Wh2m+KMaJlRMt9eOkx4ydeMuaBDvIY6mmYwAefWFA11r2fRb8H
lOvpWCDNbplcO/orrf32pq55+iFSZ4Rf/1g8lrzLdXcnwaMnTExzpxXuDpgNHR/x
32m7C8SstBjZOLi5nGQL1NLQhDGEoWvp8SaQWE0eYqhKaceoppTfFbNVbFNuoYnG
s6zDQaPs8b6wAuIn/+pAlXUCCw3eWJGKX9OyXcNF/YW5yOjbIIH5qtgzcxZK6cwz
xdghKQN5d9XLTi/0WD8ul7PKJCcHShYlf73EJljJgj+5Egt/6+bQDnqySwAqjuxB
/Q617sUlJGsT1ehuGxT1A4q/o+VdYp10QBNz6tfhDKUnYBJfxq0/BTxUTPKdLkQQ
5CoQlrFadxPq97NUQlk7vIJjLmZdksFLfMDxyXKpJEmOlDXP9jUZLRUKLPpCT7VM
BbX+ISCOy0SBDfephc8N
=kmR1
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
