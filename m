From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] Input: tsc2005 - simplify drvdata acquisition
Date: Thu, 16 Jul 2015 00:02:21 +0200
Message-ID: <20150715220220.GC2591@earth>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-4-git-send-email-sre@kernel.org>
 <20150715213107.GB24393@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715213107.GB24393@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 15, 2015 at 02:31:07PM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 15, 2015 at 02:13:27PM +0200, Sebastian Reichel wrote:
> > Do not convert device to spi_device just for getting
> > the driver data, since spi_get_drvdata() just calls
> > dev_get_drvdata().
>=20
> Even though at the moment they all share the same data I consider them
> logically different and so would prefer not to substityte one for
> another.

I guess your problem is with mixing spi_*_drvdata and dev_*_drvdata
calls? In that case I will also change spi_set_drvdata to
dev_set_drvdata, so that spi_*_drvdata is not used at all.

This will still reduce lines of code and flatten the way for tsc2004
support (which is i2c based).

-- Sebastian

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVpthsAAoJENju1/PIO/qa7LMP/3A1lkiqxG5wHy7t1DNnbb3v
7mz2FRDEz+Pgl77ExvFU5hLGMXI9m01Hy1Hko73pJNQ3xIeSOYZb9ZtLlNrMLLeY
eOKfTIhLFbDIGqhLHaPEvdsZW+/ONcVfWNSAqswrO/MsVJgR+wUH/8hpZKY6sk6v
xybQ4MCLqkbp/KRovfblLg9i7F39MoH2rZlZa3kXzj4fIxiLuBgchjctS/uGEnWi
80NU+1nWpYShFG29d3IgSTMmRb2/vZUDTXbQO/I09ppq4yBRot7FJswinRn6h1NQ
5Gxu8LiP1/M/TXd8/sVKB8n5zeRtwxG8WXavWa3UAjIce0zpLJs0VCBlXxHLAlVL
fxy5ArecpPeo/Ugsyf2c7OwILPhrFdUC+hsD5xG/eK2o/3NJlUkdBB+IlAr7NPMr
vIe+eXZ+Drk7GLUtPUiJCYVxSxGzEkvn/RX0vQ+C8zzSBFUZeGd8NOfMD4HbdJkA
O/1R6vjHs6eJEmTedqz5HXRxCrjo9ahRzpoi7NZb4K5o8YGvZ2c4xdEhGUnGeB+I
6qFBnnPk0Dky4H3XOFWWSzr70xS3FVH+uUz5NkzP9y5z4HGFhFLqyY/dOoq413Bt
2Bo27CCSFiQv4QCaLq81sYdbrrCNl8QtyQ9cyVRIkUpJcIFA765Zv/jsSYml4yjU
UXevZ3Lz3BSVT6iEf5Y+
=QmUx
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
