From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
Date: Tue, 7 Jun 2016 13:04:12 +0100
Message-ID: <20160607120412.GU7510@sirena.org.uk>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <574F6674.3010100@ti.com>
 <20160607042853.GA22406@atomide.com>
 <10295246.2MDnqWQbb8@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FfX2iGK5t5ehHnsE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10295246.2MDnqWQbb8@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Bill Mills <wmills@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--FfX2iGK5t5ehHnsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2016 at 10:09:46AM +0200, Arnd Bergmann wrote:

Please start new threads for things like this - there's no obvious
relevance to me in either the subject or even the first couple of pages
of the message so it very nearly got deleted unread.  It's very common
to get copied on irrelevant stuff so things with no obvious motivation.

> REGULATOR_FIXED_VOLTAGE is needed by a lot of platforms that usually
> don't select it, so it might be good to add a 'default y' to its Kconfig
> symbol, or we could add 'select REGULATOR_FIXED_VOLTAGE if REGULATOR'
> to all platforms that need it. The driver is about 1.5KB in size, compared
> to about 50KB for the regulator core.

The platforms should do this - I wouldn't say it's *that* common,
especially not as a build time dependency with things moving to DT.

--FfX2iGK5t5ehHnsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVrg6AAoJECTWi3JdVIfQ6H0H/124OpuozX7YZtRUusdR141P
zZXBNNoNLis5MTsn6Fb2L1NnGpDVojHWxgr05H7lEmXNddDHxlPG36RWsmNeWRvY
3mi9+d19VBJD3doMjEQMt5xIBvaMLcGmZHSNG0dhf7enAj3WeGzfeyOCFu5/L88V
Nqkhr22bpGUzACka5KdKHv/mdAGQmeK/w4gP8cpgnbnqxvrjUAziJv1m9Fk+dyEG
bj5aQmpzbs1xD/vjClBKNsYlr+oZ5egq7DLzMdQ76kTjNLlLxmilRqF3OZdP9gzs
nznQT7LSfqsL6If3oibPZCO34ifA3Hp15u31UGF65HTSu3TkBn4PoS3rruD6H84=
=vr6b
-----END PGP SIGNATURE-----

--FfX2iGK5t5ehHnsE--
