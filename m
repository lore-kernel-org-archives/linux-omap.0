From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5] i2c: omap: correct usage of the interrupt enable
 register
Date: Wed, 19 Jun 2013 12:05:09 +0200
Message-ID: <20130619100509.GD2950@katana>
References: <1370245040-14753-1-git-send-email-oleksandr.dmytryshyn@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370245040-14753-1-git-send-email-oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--wLAMOaPNJ0fu1fTG
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

Last paragraph should be below "---".

>=20
> Verified on OMAP4430.
>=20
> Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!


--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwYJUAAoJEBQN5MwUoCm2j4AP/1F5wnUamC3jUqG125RbwgIh
zT2GN9bn/zV1QfLjLfECgfbhTXxtyjg9QQk+4Cl+EzaEAgRO6zYh/HmCHLNdCl7k
7pcF6XLJQ4GSyCRlPUn8nvdk1/hRZnQRXSUbBMx8bhEaSgqSmARJxwlVAmn/HVJv
1cPaT+WAIw/zYBWx4LtTvcimDO5K24gQMpn7GD7Ptjf3YqHzKhA/2QDVmmK6e6aC
BI7QIj69FqfljcAPvxT3Gis/2Ph/wyamrN1SSdlmZ3U6A0Ag8A0A37pizYHETg14
XHIJjiK5O/IIzuKlxZ/FD5Bg+hRY65NXjL08QmTbM3TYJH/WLzZ6zh7WMh4J5rtv
KXqM1nM0r/BKpUF16jPu2Q14gU6nhnq8Ad3NupTX2o1RPPmF+mwaKKVYfOCXJSqj
XsaJFuRvtBV10Oa2ta1ID1PZHL3yepfUbRxdDHw8ZcxMVlsQLzHEsFImo0Mkghc0
EZNs2JIYy4tk+eIFtadntCYj43mufA9FSN/b8pWrcxWJQJl80tHIy4wdhfykUpPW
CfjZCwsFCYb/FXaDvw0ddodjJUTDhLVEEGfO4i/KdwAJzdM1tpC17Y5aGoLn7Sjd
zzaAQpaHkJQXaA596oEEAl98mPhsmWB/m5ohZ9rEEubOv6CE9b7xci7IpGSt/u2C
0V7X0DGAqSpp7eF+2OqX
=Y/pC
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
