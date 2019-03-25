From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Mon, 25 Mar 2019 14:40:20 +0100
Message-ID: <20190325134020.GA3375@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <CAHp75Vc-WYUJgaDPuWUn-_0Cizq=MG7N2cdHJxaEbad+xntcjQ@mail.gmail.com>
 <20190312154501.6v2symbq6eutp6dj@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312154501.6v2symbq6eutp6dj@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This series seems like a valid approach to me if we still want to
> respect the locking.

And I am leaning to that it is good enough. I think pragmatism is OK
here: The users who want this feature simply want to reboot their
system, mostly development systems. They can't reboot otherwise. Except
for the HW switch they are currently using anyhow.

The panic fault-injector can create an inconsistent situation on the I2C
bus when you want to reboot after an OOPS while a transfer was in
progress. However, if rebooting in such scenarios is critical for you,
you a) shouldn't reboot via I2C, and/or b) should have a watchdog in
place. We can't guarantee to always fix this sitution. At best, we could
just try to be better for some cases. However, this would mean having a
backdoor to skip the locking scheme which doesn't sound right. Maybe
just accepting the deadlock is not too bad because it will reliably
point out a design flaw of the system (hopefully during the development
stage)?

Final call for other thoughts/comments.

PS: I am still interested in the use of in_atomic() here. I wonder if it is
correct. If a change is needed, it should probably be a seperate series,
though.


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyY2kAACgkQFA3kzBSg
KbZo2g//dCNbQqq7JCJ5Lv/VujuOvXfvIAhTdixDdvjH0OB63oi+g7uOczVtHA3C
MwOtHz0SzrK28zgFKP54noME6BxsaNA/wkFGRidTz5e1SbxgEuDBefLKTjo6eXWV
w4qE87SZteJtKQhMTu2fMELiwDQoI3mVfWuBEucdhIqa9zumT6RALS5z/miAzr6E
M53RUZ+k/tOanoOyuDN99mvhL3YSKNqPXe6Ixayx5VX9tVZAi+ua2nl9STbdsIio
lwiBv3A4i/DEw7SMl3hxJfyQs2CE3y7Ix7EDJE85pGGruCY7QD9HpH6KNadmhg2q
YMtSymts2f5jy1ZKtdrd9R7oR/Ihw6ZyaUME3qU92igmnAdIOJsDXPVoWQruSsLE
6z0v5rsqQ6Vk+hSUbKEC6Ild80zEuKOcuQW12dHeZI+m6+7duLlvafp9RnKBK0pO
bkmJchXcOTwLUUT/Y93zmI2cbPrGwx6Bjkbyv2I5O7asAxDHTJBG6qjBeaLaxrpq
8PoNHnbrfNburNrmt90qCM/5MTT1B1VK+ghoy2vLD0mjf0Y9DQd4WyCyK1+p781Q
CdqGh08ptk2VCdnRe8/WBjHIJ4T4FVM43nrDx+86nVXbgmHYhjYF5LPEl1K9svpe
loGz64ibwn+UIG/8rZZaYauCzqdgYjGRHtp807khprYzC/KfHI0=
=gywM
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
