From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
Date: Thu, 9 Jun 2016 11:32:03 +0100
Message-ID: <20160609103203.GT7510@sirena.org.uk>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <10295246.2MDnqWQbb8@wuerfel>
 <20160608094747.GG22406@atomide.com>
 <8052110.nPS5mbu3uO@wuerfel>
 <20160609065035.GJ22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W4x25ryriZDTVjgp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160609065035.GJ22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, Bill Mills <wmills@ti.com>
List-Id: linux-omap@vger.kernel.org


--W4x25ryriZDTVjgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2016 at 11:50:35PM -0700, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [160608 09:06]:

> > The downside would be any users that want the options we enable there
> > turned off and have them silently enabled when upgrading the kernel.

> I think the long term solution here might be to generate the .config
> out of dts files..

That would be cool!

--W4x25ryriZDTVjgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWUWiAAoJECTWi3JdVIfQojwH/1nfnHGJdEDhQOOxMs3crk4Z
IW6nx9qgrCsukZj0Tw3/mp9WFbixxJwEDPfDxH2fsD6tRpCvWQ/XtGh51/LVjTwn
uDQhHTwEHK1hyZ+x4i+JWWhav9SMTK5f9qnu4EM3YsQHWEW3DR92U7jo2iMm325b
0zV+tQN3QqXSBvilMBZFlhDlcYo5j6gEIuP+bBeh5gAU9ilf7P+ZfrBeXtHaESQK
lvZfKus/Ninavw/ROfCL1J8qNsOm/qwZ0D2CLjE0NJtw1NAVZTQWrLSEbgsizXZJ
fZP5wc2TeBWF8RS6BIyq0DtaKWMLe4IKLNHKJOsO9kPzbgvzaiv5ZDpLWjqntO0=
=Kwkt
-----END PGP SIGNATURE-----

--W4x25ryriZDTVjgp--
