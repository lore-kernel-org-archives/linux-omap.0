From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to
 word length"
Date: Tue, 15 Jan 2019 00:07:51 +0000
Message-ID: <20190115000751.GN11073@sirena.org.uk>
References: <20190113204905.29795-1-david@lechnology.com>
 <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
 <bb7e13ee-f6ed-a619-c56e-53aad91a1432@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="muT+E17Lr9urPYYJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb7e13ee-f6ed-a619-c56e-53aad91a1432@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Vignesh R <vigneshr@ti.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--muT+E17Lr9urPYYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 05:50:34PM -0600, David Lechner wrote:
> On 1/14/19 6:30 AM, Vignesh R wrote:

> > Oops, that's unfortunate. I see ili9225 is using bits_per_word = 16.
> > I believe commit b682cffa3ac6d9d broke spi_transfers where
> > bits_per_word anything other than 8 bits.
> > I don't have ili9225 HW but was able emulate this condition using a SPI
> > flash as slave on AM335x and successfully reproduced the issue. Could
> > you test if this diff[1] helps in fixing the regression without needing
> > to revert commit b682cffa3ac6d9d?

> Yes, this changes fixes the problem. Thanks!

Excellent!  Vignesh, can you post a formal patch please and I'll get it
merged?

--muT+E17Lr9urPYYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9JFYACgkQJNaLcl1U
h9ApQQf+JngYgg+9axbvrDu2ynOzMBfQv4geh11lfBgwzY7SXADxRHuDtFh4VdQl
snxbKo8w1T3egW+Bde5rB+2+8N/vreWuVyiMldtwskxEfeDl15xNNM2gyBgVv3us
kf/h4Hg5r6YBdwawzrKu6VRt5QohWHlx89MxzzxWXe3YGLCLoLaO4GKgVNfr3KHU
jhlrJhj0fQ6cIxRx3Avln7I5xCOHnBSDyfWMzKaD2YFlkhLX4zbu85Veo6goWtCy
PST5E82nv6iAEydkLDYITBfenjKfOUHKysLUhWLbqaCYgcWMGej381hEFA+PXtGt
L0gQTFCRIsav8h64y4NSmBbR/gZUqg==
=9Wx9
-----END PGP SIGNATURE-----

--muT+E17Lr9urPYYJ--
