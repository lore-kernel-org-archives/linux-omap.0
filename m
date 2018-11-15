From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression in next with spi return from transfer_one()
Date: Thu, 15 Nov 2018 14:12:41 -0800
Message-ID: <20181115221241.GQ2089@sirena.org.uk>
References: <20181115211451.GH53235@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x9l1eQe8PlYqUxyS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115211451.GH53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--x9l1eQe8PlYqUxyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 15, 2018 at 01:14:51PM -0800, Tony Lindgren wrote:

> Commit 810923f3bf06 ("spi: Deal with slaves that return from
> transfer_one() unfinished") causes a regression at least on
> droid 4 with SPI PMIC and regulators on the PMIC. During boot
> the device just hangs there waiting for rootfs to appear on
> MMC. Reverting 810923f3bf06 makes things work again.

> Any ideas why this might be?

Wow, that's not obvious...  as far as I can tell the code in the !slave
case is identical so unless the controller is somehow getting mistakenly
flagged as a slave it looks like it should be something to do with it
being pushed into a function.  Could you try logging what the timeout
ends up getting set to?

--x9l1eQe8PlYqUxyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvt71UACgkQJNaLcl1U
h9CJOgf/coh5BBc03VYfTvL6HEMsKXePgtJNRKz+QuDJSY4XAT2ptoh8WfnAMqHt
25SqyCI41HYw6ah7O5Mm3Cky0zIyGCUwfYPj27a//Zw/vtK7mLLzE3ThB86HkPgo
J7xnbwpqJPGOyS9Exkxix/hwlxSADUiOm+Qz1o/XPtDRpCEBzxy3KCuzRhQh9/NN
OvjAkba5DDmlTZsIVzVVfrN/Kv/vkKbkX3/WrXsoTz7NbOBJK0VlpCoxsE4mb6Hi
jyosFs26bVd1rF3BJ6gEeWkt5Hc+TZmJ094tnnn3mupXyfgRzol1eeylA3LZ9Fef
I3QsWhOPoNlYbVNUroNhPFT41aboXA==
=OIp2
-----END PGP SIGNATURE-----

--x9l1eQe8PlYqUxyS--
