From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5] i2c: omap: correct usage of the interrupt enable
 register
Date: Wed, 12 Jun 2013 20:20:47 +0200
Message-ID: <20130612182046.GC3018@katana>
References: <1370245040-14753-1-git-send-email-oleksandr.dmytryshyn@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370245040-14753-1-git-send-email-oleksandr.dmytryshyn@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2013 at 10:37:20AM +0300, Oleksandr Dmytryshyn wrote:
> We've been lucky not to have any interrupts fire during the suspend
> path, otherwise we would have unpredictable behaviour in the kernel.
>=20
> Based on the logic of the kernel code interrupts from i2c should be
> prohibited during suspend. Kernel writes 0 to the I2C_IE register in
> the omap_i2c_runtime_suspend() function. In the other side kernel
> writes saved interrupt flags to the I2C_IE register in
> omap_i2c_runtime_resume() function. I.e. interrupts should be disabled
> during suspend.
>=20
> This works for chips with version1 registers scheme. Interrupts are
> disabled during suspend. For chips with version2 scheme registers
> writting 0 to the I2C_IE register does nothing (because now the
> I2C_IRQENABLE_SET register is located at this address). This register
> is used to enable interrupts. For disabling interrupts
> I2C_IRQENABLE_CLR register should be used.
>=20
> Because the registers I2C_IRQENABLE_SET and I2C_IE have the same
> addresses, the interrupt enabling procedure is unchanged.
>=20
> I've checked that interrupts in the i2c controller are still enabled
> after writting 0 to the I2C_IRQENABLE_SET register. With this patch
> interrupts are disabled in the omap_i2c_runtime_suspend() function.
>=20
> Patch is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> tag: v3.10-rc2
>=20
> Verified on OMAP4430.
>=20
> Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>

Kevin, I think you are fine with this patch now?


--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuLv+AAoJEBQN5MwUoCm2agoP/0Xdkhgc0bekBGA8p/GLMg37
5iCp2bk0l94wGbd4gG7PvpKGZDom9el2BFmmM9moE7K/58MDe0e/yqNSFBBjtwLT
Xbgbzul2t/kdmizJ5AXZ/LEKRSlc2fZV3WhgOTw3NyMi0mUvVP3YqtbPT4zgsq9D
c7jZ5ER05PxAFJyj6noMMR3DYHmBWbLYp17/E7cTvzVO2GnUTS2JuZbkgX7AT+tz
OST3AvdK883un8j9JHmHiQDHJh6qfA8dwbkIs42K/t8pZHF8JRocLOY8L04RUJO3
qfORi+dUcgYBLcgCpIxbuR4Y+EYcSwLJVPDtixQrOWMmb180PtlFc1909d6cKkqB
hZBEwnXdHkx10OjkT+4ens6yvZAh6/8q0MdKbG8RRPAQNlFvyKsDKRho16lz07yb
b8L+wlUqjDbzZ+pnrX+eXXba2whOn9vm0p17gAENL1hvl0HSQjCPaVrZMUEgMp6K
9jdI2mCaCkkVcDJSVfJizWJpgVvIi0sOobaNyzThJsqJle4G24kS3cPajjsj3HkX
i9cCwxhDKdIrY+o7E53ZqcO9v7ZlAe1TuMLfOi1cXBxQU1unOEtbxs0bAyvFUSzD
g7VJU/k01Gv7Dye0Eajn9qrtY2o6PJEeRm1gbkYngDHy/ndQ14UiyoQgXUv4hJam
bULgo8KlEVzHie4nRVco
=+2iR
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
