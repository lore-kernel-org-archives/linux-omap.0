From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Date: Wed, 19 Dec 2018 12:38:12 +0000
Message-ID: <20181219123812.GC8130@sirena.org.uk>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com>
 <5C191770.9090804@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C191770.9090804@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 05:51:12PM +0200, Roger Quadros wrote:

> We could combine control and debug into one iomap and use
> 2 regmap ranges. But this is really working around the
> regmap_mmio limitation of not being able to use more than one ioremaps.

> Mark, any suggestions?

If they're separate regions why not create separate regmaps for them?

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwaO7MACgkQJNaLcl1U
h9CPAAf+JAJfMczZd9xWyVAVv7Y2r8nFraMHd9wq/ySUeg1xb21Z/SQVmCUslHh7
9UU6yn6+/XyROW73zqXbP7zzT+3+mzquT+7KktzazB8xsFkBlnCAm+xZEhycxms8
NKpf41WNkJPsZW6WURLTP8m7A+7pCsPbvNBn2Q7WboKBQBO83+rcv0gO6h2w0wMd
7igarIg4CEWqgCKtEh1kJjbEOxvJEWe9GUuYIvEpbY4c4EZifMyOTjwUxmS5t6zZ
gf6t6SJ7JJZbCUn27apsktUSnCJEvuG7gZyHfhALtpJG3cTC5hd38qwD0iSH7AP9
Y8eIQLz2+hpUjd+K7BLhCF0VDv1O2A==
=ZgHj
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
