From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic implementation
 if !od
Date: Thu, 14 Feb 2013 19:57:19 +0200
Message-ID: <20130214175719.GB25891@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <20130214112043.GQ17852@n2100.arm.linux.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44738 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758307Ab3BNR5f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 12:57:35 -0500
Content-Disposition: inline
In-Reply-To: <20130214112043.GQ17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2013 at 11:20:43AM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 14, 2013 at 01:15:52PM +0200, Felipe Balbi wrote:
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct omap_device *od =3D to_omap_device(pdev);
> >  	int ret;
> > =20
> >  	ret =3D pm_generic_runtime_suspend(dev);
> > =20
> > +	if (!od)
> > +		goto out;
> > +
> >  	if (!ret)
>=20
> What's wrong with the single line change per function of:
>=20
> -	if (!ret)
> +	if (!ret && to_omap_device(pdev))
>=20
> ?

nothing, will change. Let me just check if the other folks are ok with
the patchset.

--=20
balbi

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHSV/AAoJEIaOsuA1yqRE250P/0mBn85901nUoPwv2uaFtd0z
yxDVLoxub2o//0GV6Uf19HyqlrYIBYQNwvzyMKWoqHt5RHpvERrepJxD5E4/oTi9
4Cr9GpuF6xiTLh6aIcwZTN/16C3Iy2Mp55BWn8i3VUL63oSBCdbpMvUas61eMNtf
U2NelDP5z3TvtZ3p23rh0luTLmKxeaJWX94I3pJVuFwXAI+yo1JIIk5LnS4D0Guz
3CIit+nxbAi6TSmUrTn3vTy2eg25BsFJwGUzGQOp8ba7PNzO04SZ7ahxx+IIjIV5
0i/APN2eaQCUMhCvCVHxNJz5DBmlWSj8BSBz2eS0GtWBFJ9REA5P9y8CKHEAKsb8
7OX7CRvGmNCqVjxQq3Z4FEyKZ6T/0qtwoGQTsKY1VGrwCy55sKq+ltwPbdORaxyc
Eka3CMNWzVUCkP+rPaDuYTKWIWDap7q510T+ZmOdlQXNmwHzcHbZhOfuaiLxPiF7
lmHNlweUsizpRTM8mN/petqNJVsfbf6qoihumS/7mK4bqglzA4N3JMLSmbcdDsaS
LR1XZ1HXfp0jeQJ0FzwrBoR5MaNEqgdX+HfsjTiX63NapVYkjxAQToEZRly4Kger
Waf65Zc03Fdo4IkoDUyOdY4GeyPmj6uRHauoxdYVC2w2JEjgncwcFu0FG/JSs2Qq
xg5uSErWpQ0LuMHO708f
=ggkl
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
