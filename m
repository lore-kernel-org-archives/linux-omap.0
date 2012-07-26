From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 02/11] usb: musb: kill global and static for multi
 instance
Date: Thu, 26 Jul 2012 11:25:00 +0300
Message-ID: <20120726082459.GP29029@arwen.pp.htv.fi>
References: <1343218326-30610-1-git-send-email-ajay.gupta@ti.com>
 <20120726074057.GH29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF790@DBDE01.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJ8inJ6ig7iY3YX9"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF790-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--rJ8inJ6ig7iY3YX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2012 at 08:25:32AM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> > On Wed, Jul 25, 2012 at 05:42:06PM +0530, Ajay Kumar Gupta wrote:
> > > @@ -240,20 +238,24 @@ int __devinit musb_init_debugfs(struct musb *mu=
sb)
> > >  	struct dentry		*root;
> > >  	struct dentry		*file;
> > >  	int			ret;
> > > +	char			name[10];
> > >
> > > -	root =3D debugfs_create_dir("musb", NULL);
> > > +	sprintf(name, "musb%d", musb->id);
> > > +	root =3D debugfs_create_dir(name, NULL);
> >=20
> > I told you to use dev_name(musb) for a reason. See what happens when you
> > use dev_name(musb);
> >=20
> > Do you not think about the other users of this driver ? Do you not know
> > what's the ID on platform_devices which "don't have an ID" ??
>=20
> We are now using musb_ida for all glue layers so '-1' issue will not come.

true.

> Still if we can manage without 'id' then better to do that way.

just make sure to notice that directory name will "musb.0".

--=20
balbi

--rJ8inJ6ig7iY3YX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEP7bAAoJEIaOsuA1yqRE8/kP/iYjklps6+3DROODB0JG1nlA
Y9Ex7q5aRkonBb+sXY2vIVjBqxJt2Xc5oivNOhWQktSk5lo11TwKnrUKNq+C0B8j
MIANg60JMIC0qNkCT0ZgNhkfN4T2Aya3Bx93yR2/01bKxrsnHYU+rDs1gN6OtVUU
x87Aj+E8tG7CtYDddYpMmirGuCW+1SxvWQMX4mvVppbwUCZgJu7lmSMvgxeMBHHd
F55rh+lnPIy2+MKj78NQirvx1JoVa/fPzKIJYH5Bq7SMoJwRf2gpyOeDC9q++9mU
7RAkBY4sJAxQ5arm4K1xGrtDv3o+6S2EXhCok3m5h6VYqeYc9x2pT5jtNj4qkrkS
AzUMp2dG6U9b84wlEkb66L/YroxNcNj0vqlEzSiSGWdjNYANCzMPq58YoLbk8586
/uOV0kMsO4+plWp9lmTwK51Imjc5RZQ/q8q8fWrUoamGiXb3mpI4Kp/OQd8/+oOw
gt8X/DM4EDvZGNZpr+lcJvT9zgz9UAuANlI0ntaGAuJ6ssCBO7BCfwtRo7V1o0Nu
9iLgSCv3w5/cYBXEauPvCavKuDN29+UhbrIIb/aWpSo0NFRYUrYO2QrVTZYjbz8p
m0SUGNGhPJT0jY644IFfF7ezfuBeLukKiRnGQRCPAOjCe/BocHFug85+bmFYDhHc
kq/u0j9hOfK4I6nGkFzW
=G3jA
-----END PGP SIGNATURE-----

--rJ8inJ6ig7iY3YX9--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
