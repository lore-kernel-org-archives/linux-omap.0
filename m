From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: omap: Trigger bus recovery in lockup case
Date: Sat, 28 Oct 2017 22:52:55 +0200
Message-ID: <20171028205255.56qryat6eanhwfcz@ninjato>
References: <e9b43138-6c01-bc99-9bac-355823bc0c19@ti.com>
 <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wy624xugb77ouchi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
Sender: linux-i2c-owner@vger.kernel.org
To: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org


--wy624xugb77ouchi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (!(systest & OMAP_I2C_SYSTEST_SCL_I_FUNC))
> +		return -ETIMEDOUT; /* recovery would not fix SCL */

I'd rather return EBUSY here. It is not that the transaction timed out.
If you agree, I can fix it locally, no need to resend.

Rest looks good, thanks!


--wy624xugb77ouchi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln07iIACgkQFA3kzBSg
KbbpxQ//QMmLAQm/VQOHTlK+CRIO1Jc6isWKcbscQ6ZViyUzZ+0yWJmvniS4eftb
NnwTxswdvyddzpSE7xMUx0KKRNJyKO35gPf+6vqXKVPiwFClm3PN+/kz16wVYL4U
5zCsShukqKUl7iuXOKNMoqj5eEEhoFio2d/nFX9ILZyDwfIElYK9ZHzCpMsmUqYU
kdi+t7UVqpyNQgT3BGBBkrZaIDsLwvqWjblvn6hc8/yE5MEdlK0Pav6AXVNtF+9H
sPkYULXr6OYDMYuHBLfiGj61xUP/AP19QvatazEKsOETWb9j5KBT5f4u7M5oQwql
KQb4M25nkf6FsvCnV93LCtlQlgISx+Pegl5MRv4yJqZEjmy1J1Yg8Wq82tg5KvJL
uskUFD8vrQP5JhfZk8VWZQhHF7mFiN5DEAQ+gQqLRvDnPUXGf5334Jf8AT51bqCu
eGfD+PdohiCPE7Q3eSzZy3AWbGVqOvV8V9Bh0CCfZVLVSUaCfx67vJyig7eRfoPP
BiCx3DPVkUxaXPZ7sQ7RoAqeGIsSYeTUKaPVeNRcW0GHH0yYMwH/YemAuS1cbMEV
yj+JRnmNVGDOQQbVgKzJ6jQHBcD8gQpbLPolg14z/vRZAPTT08Z51cje2h0KvrNq
HaMhzhmvZKa23QkUxOP7KKQiv/DM9HabMNfHBQ4t7iTu8XP+hPo=
=TkmH
-----END PGP SIGNATURE-----

--wy624xugb77ouchi--
