From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 16:13:06 -0500
Message-ID: <20150309211306.GC22341@saruman.tx.rr.com>
References: <20150309205157.GE5140@atomide.com>
 <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <binmlist@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
> Hi,
>=20
> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Add a minimal driver for dm816x USB. Otherwise we can just use
> > the existing musb_am335x and musb_dsps on dm816x.
>=20
> dm816x has the almost identical usbss as that in am335x, we should be
> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?

Tony's using the same musb glue layers, this is just a phy driver,
right ?

--=20
balbi

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/gziAAoJEIaOsuA1yqREMYoP/2393aw4HGu2WWhJ7qQZPaOw
9VlDrT4crnwf6adKof09f75VdvT02OTPOJnxibGFnKDYj+upG52ewyyHkfB98bhi
5nG/MMa5f/g/v9cR02V3RT3ZQ+YGT7RG9829fjpRs8OuLu2xInaSumr1qyl7k1wf
JnTCbYhST7pOfp9AppcTQm+yjIhOecNXXiYRhwYcCf75GqVpMFoZHSdMs2lofjT/
TOYVzRGTjL28KrRp7hRDlpYkscOp/4fg7Y2NY3K4GlHan3wk3M0xziuiuo/+VSsv
OdXVUpxfdp3jwg12H+/kFyn+XDijJB6ZFUTgZmm8mamL+FBCnfb8EL9uwQV4fRFX
9E4hNbe7KeyqJv6pIxBn5/6DVDkiZtUfZ68fGC6vO6ZX/9lUVfmgHu7c3C8J8FBl
Lm8oPmZrozuBdxvu8Rm1cn0uDhXW4ERj0+JVvbBYAJcjqE02hztqFwIrnTFVFwza
ARgufxVLH8ooQ8rt9K2u/fjahxVjaFlkJGU1M8omkW4+P/vTILjjYyhzj/SZJAUI
0WJS2QMVmJEBYR7OdFCRooMNo97FVdgXGk/omqAQAfDab3RaErOtzlEtXb1PaV3q
Xwmj1s7lEwU5LTokCd6lBl6mEYygwp+UtcBqRiXEY9DUAoVQ3SAgYqCBg2ajbcpC
/HB+bzu61haK03sW/Bll
=XviG
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
