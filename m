From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 06/17] i2c: omap: improve 1p153 errata handling
Date: Thu, 14 Jun 2012 14:48:05 +0300
Message-ID: <20120614114804.GS13602@arwen.pp.htv.fi>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-7-git-send-email-balbi@ti.com>
 <20120614111746.GB31187@n2100.arm.linux.org.uk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pd495SECmvzXpBRb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120614111746.GB31187-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--pd495SECmvzXpBRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 14, 2012 at 12:17:46PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 01:20:39PM +0300, Felipe Balbi wrote:
> > -static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int=
 *err)
> > +static int errata_omap3_1p153(struct omap_i2c_dev *dev)
> >  {
> > -	unsigned long timeout =3D 10000;
> > +	unsigned long	timeout =3D 10000;
> > +	u16		stat;
>=20
> Eww, no, not more of this "lets add tabs to align auto variable
> declarations".  This is detrimental when you add another variable whose
> type is longer than the current indentation - you have to reformat the
> entire block.
>=20
> It's really not worth it.  Stick to just using one space, like the rest
> of the kernel code.  Like the code which Linus writes.  And thereby help
> to avoid future "pointless churn" whinges.

fair enough, no need to get so over the top like that, it's just a tab.
Will fix it.

--=20
balbi

--pd495SECmvzXpBRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2c90AAoJEIaOsuA1yqREqWwP/1L/byV1tKu697GN5ppq9lZf
JmS7y2+HVmnuqMIIxSX2dZAyJb4Md0n3oJJQW5eUvSVhY3m/lm8lAjCWIWl6paib
r3SdqRWSN2sixurb8RSn7P2231bp/W/K5agwnlfQP/nz6fXM8zNPomz5OiQ4udUx
6pSv5gMq9JYoPxDCg1A7mAlHbBUlSB/LSO4P4e65fUodGEAoCcyPbssudHt7W5bA
sAb/yaZfPSSWIlm+hhKbbDkQbKVKY4Ga5C8hvWBxk3+aLwCCtlg1o+Frwj8t0Xos
aSdsnSv5kfjStDXSJM8vRU63QOe6xbZlECpRaFIfPqSfIfIZN6JunnXsZ+l8q7Hh
qN4l5yNMwsZG+ieaF1HlU5ApreDuD0KuR4thQuEYI/WZKpX1KE63pAzTazyrvEqS
vdb5cXCfhtnQC6I7rrBQaAJznJ04LY/qQsu2gU0QNZ4gCO+wfjSz6ntpofakqz+O
bSpv5jXQTY61V8ZpBjhB12N8PPOfWsvHa+XcZ9b7EXbigg+MvCdB28ofBIyl2YAl
BzhcSlzPg3W/pkzBLDPIpAEDnz7FxOIMqlxJoya+DCZpuIkZWjbHPKyRh79sL7Ny
Wxj2yIA4ibDL8m3UL6bSuTvEX2PLFIjFYsqJ5Vv7QLlwOMLUJ6126MmuvOHTAx4m
YcHOHkSLoLgSr6CC6syU
=xbuS
-----END PGP SIGNATURE-----

--pd495SECmvzXpBRb--
