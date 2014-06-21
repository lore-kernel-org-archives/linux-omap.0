From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: palmas: Fix SMPS enable/disable/is_enabled
Date: Sat, 21 Jun 2014 11:22:29 +0100
Message-ID: <20140621102229.GO5099@sirena.org.uk>
References: <1403285183-15926-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v8qIemIc9aARI1kK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403285183-15926-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, acourbot@nvidia.com, gnurou@gmail.com, j-keerthy@ti.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--v8qIemIc9aARI1kK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 12:26:23PM -0500, Nishanth Menon wrote:
> We use regmap regulator ops to enable/disable and check if regulator
> is enabled for various SMPS. However, these depend on valid
> enable_reg, enable_mask and enable_value in regulator descriptor.

Applied, thanks.

--v8qIemIc9aARI1kK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVziAAoJELSic+t+oim9sX0P/R0RluukDF7FH7LD5M7wlFAk
v50GMWpJD3cvOlxLOdCA/qV3Q/3O6o0ekfF6b6Lfg9xhrYdmskNOFtYctT6LxYMZ
9oPWPP9W9ij1Szw7B0h+AvTxyPzsREH4AnKaVhM91rStAOku6KlZ6R6n+DOLHpVK
6bkLFW+LU0uYgWNVsD9SyFe3zvJwYIR76oevJK+t8tbQoXjMHvxppaXntd7pEts5
JA4Qu7KL5LMNV7iAO+cu5j4lu/AnsUAk+cto5rfvBYJ/r2fc1flqzs85hF/aDyG+
U6OB7p8YeRz7Jy6AZYpSSHOghNeKeW2DBbmwZqXnTRsLTWzxpUBaQWJ3WxXp3dTR
pjS/ecivOhok7cXSsmJkSk9EpZKYc6eM1YU4Svqsa9p6MhKsI7jNkEUC1IQoTNfB
GVEZQChtNWdlETSexspjAZKCoUiqpphqvPW+S9ZvbKYjyEEGJknyJ6Hr8V9bi5zI
ny79LBvfvsSl5M5A2Xb8EC+XIrXttZ69zb/ilM5KNu1E4nTkB5CV1knORHw1W+yS
frc3+GP3cFD4dkUsFaH/VpdwBiDEbaR/0ODGEJ26Mr3FdewynJsiV4zhY2nht3zo
rhJUTQZKFbFD2jD7dtvMmHM1hDzgtT88uSrA4x91tuJag0DToqKrBy0mJn2rmfsK
AcAeIcxxw0IJfweYZy09
=x59U
-----END PGP SIGNATURE-----

--v8qIemIc9aARI1kK--
