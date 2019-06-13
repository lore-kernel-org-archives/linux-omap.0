From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561
 regulator support
Date: Thu, 13 Jun 2019 18:32:48 +0100
Message-ID: <20190613173248.GP5316@sirena.org.uk>
References: <20190612144620.28331-1-j-keerthy@ti.com>
 <20190613154552.GL5316@sirena.org.uk>
 <bfb19336-fbe9-06d8-25d3-f2e0b8ea6c9b@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zn4k3Q+N5puqXur4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bfb19336-fbe9-06d8-25d3-f2e0b8ea6c9b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--zn4k3Q+N5puqXur4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2019 at 10:32:45PM +0530, keerthy wrote:
> On 6/13/2019 9:15 PM, Mark Brown wrote:
> > On Wed, Jun 12, 2019 at 08:16:20PM +0530, Keerthy wrote:

> > > patches 1/3 2/3 are already applied to linux-next.

> > This doesn't build without those patches:

> They are already on next. Do you want me to resend them as well?

That's no good, it still breaks the build of my tree.  I can't apply
this until the code is in my tree, either through a shared branch or
through Lihus' tree.  I see I acked the patch, I'll have been expecting
the patch to be applied to Lee's tree.  If that's not possible or
there's no branch then please resend after the merge window.

--zn4k3Q+N5puqXur4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CiMAACgkQJNaLcl1U
h9CTIwf9Fmh40EtSogz1kbW5Y6D4/CrNI3ad/hB3hEl3kBob++f4JYXKFzSJBlTm
wcnkN150boPQ/MwZGrrcWBMJ0YzbsGEeHcftINv+AB2r3yCUfwa7Ab7zvu8epDRy
+1UTdgM/NzgOOrFFkuWfjoDm4tn4m1WrcAcdVC9Zm1SAtKgVZYDUZCiHiYRng/+F
iXZrzcnaGXN/6ZPzdf8PPAIu5ssCHh1dXG2ccqgiC6LQuxvZF0NkUOvKenRuzSGu
fTkwLLkUn6jQyNkJ5NCcfoR0rpaFgtngZUk3Tp+QrAlxbYGKFM4flKN5U/H9hq5i
JoAQYqCjLQf4GWwBTl8hszhR26LllQ==
=lSLB
-----END PGP SIGNATURE-----

--zn4k3Q+N5puqXur4--
