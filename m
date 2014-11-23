From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: omap: implement workaround for handling invalid
 BB-bit values
Date: Sat, 22 Nov 2014 22:43:06 -0600
Message-ID: <20141123044306.GA19898@saruman>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416518925-20679-3-git-send-email-al.kochet@gmail.com>
 <20141121160808.GM7508@saruman>
 <20141122132309.GC2679@katana>
 <B6D9B4D7-25CB-456F-88B4-EB6A53E33A9D@gmail.com>
 <20141122180222.GA9698@katana>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141122180222.GA9698@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 07:02:22PM +0100, Wolfram Sang wrote:
> On Sat, Nov 22, 2014 at 05:06:10PM +0300, Alexander Kochetkov wrote:
> >=20
> > 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 16:23, Wolfram Sang <=
wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> >=20
> > > Huh, I can't apply this one? Which kernel version is this based on?
> >=20
> > v.3.13-rc8
>=20
> Wow, that's old. Can you please rebase the series on top of 3.18-rc4? Or
> my i2c/for-next? Or at the very least 3.17?
>=20
> @Felipe: With which kernel did you test the series? Also, 3.13?

maybe there was a typo? I tested on v3.18-rc3 :-)


--=20
balbi

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcWXZAAoJEIaOsuA1yqRE1C0P/iGX6Y9cgqX6v7Z7ypYoL/ck
VWHwwtcmm6qSZjOvin/Xd9LQiiBLlq1AJ61u2bYwQK3PqvYbjUXJobZPs0fBYr1z
tI6TslWLs4C2Yr40TX5mKnhmWZfKaQtItrbrKA18OUhKxH17NIwZHkHh7URJZ+2K
2thnp8aEYYHLMzBoANmIcTN9wsG/xObHSi5qYj5U0l5ltuiIPo4MeCJyQ0QNsSde
wKXpX/YkdF8c6YECTp74VH7d+hSgCwwuTY0vIPOjk2tZHNnj44cFl42ulX+WG0ib
cRbE+HruahgK2kGzYULwaoKLUcEVRV5/jV3mMqhyPQwTokjdRKxZP67vmVsfbBTU
K76XVGK73lSgVNO7/OLKQDLkwGO2Jlg3Fq4x5MmzGkImP0D2nyoM3Zh0h3rHDK24
RCmqkcyuslHUNQO78WZvYzPFZHavUibm1yTQfgezcJt3LW+gnv2cxVkALwdLToae
YLsezKdAULXQkNHodLSg2Xw/K5H0zGMm9Vc0Z/19eTda4G5JpH63dy1V/nfvfC8E
C6z3Q2UkMIZa6kt/u6Rwgwn2kYVW6lZ3L+WcMIZ0Ah1omF9Ty5D9WvKhjgWyZU7k
gDKyrmAcrrR8ly7+idlD+gU7+VgwUiHjLcMdr7L8umAB6KxkkNEOTbVppCPnhW5Y
CvI4RAFX+Hzyorx5GFEX
=nLGk
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
