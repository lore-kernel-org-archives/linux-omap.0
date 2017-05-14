From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/9] regulator: palmas: Drop unnecessary static
Date: Sun, 14 May 2017 19:13:23 +0900
Message-ID: <20170514101323.235p6jflfproucmv@sirena.org.uk>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
 <1493928654-18768-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7umbma5pm3ap6xio"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493928654-18768-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--7umbma5pm3ap6xio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 04, 2017 at 10:10:51PM +0200, Julia Lawall wrote:
> Drop static on a local variable, when the variable is initialized before
> any use, on every possible execution path through the function.

When sending a bunch of changes like this please either send the cover
letter to everyone or send each patch separately (this seems like it
stands alone just fine).  The first question when only one patch in a
series is visible is always what are the interdependencies.

--7umbma5pm3ap6xio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYLcIACgkQJNaLcl1U
h9BsWgf8DkF8kyGJlAqKsU2kTDfRZeovyuQK4RK8YZtgrZRlXC/cLnObCQMpTpiu
JtvnmRk3gNvG/klpdXOJfEEIkBk9KsEjYJ0XrUHqWsXjUy898O0OkwaD9wAc3FWk
ne0QSmaAcMJyqzuz79UORRvPoac/wSB8S7rOyAfO/qbTQ/k4hlpRwbirexkaFqCQ
g8cX2gcnrIEuTP2S1tYnUCSeAzlFrykFe47oG2MUCoue5QNmXc/D2G26jPs0loxN
FpI2lQG/KF6psXYxaJ3Ah9yla+B3SqrJ/wWz+fr9ZXaXoLkyWf4QFStCmJnnj7Cm
PsZaG1FjwFqarz3KQ9kvU/jiBJQ0tg==
=0afU
-----END PGP SIGNATURE-----

--7umbma5pm3ap6xio--
