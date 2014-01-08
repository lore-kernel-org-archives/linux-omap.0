From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
Date: Wed, 8 Jan 2014 11:52:44 +0100
Message-ID: <20140108105244.GA21607@earth.universe>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <1389161742-10533-2-git-send-email-rogerq@ti.com>
 <20140108090808.GB16313@earth.universe> <52CD23E0.8030400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3583513833253500568=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52CD23E0.8030400@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, arnd@arndb.de, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, "Kristo, Tero" <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============3583513833253500568==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 08, 2014 at 03:39:36PM +0530, Roger Quadros wrote:
> > What about the other clocks acquired in drivers/mfd/omap-usb-host.c? Sh=
ouldn't
> > all of those be provided by via the DT phandle?
>=20
> All those clocks are identically named across the OMAP SoCs and are uniqu=
e for each
> SoC, so providing DT phandle for all of them is not required.
>=20
> The init_60m_fclk was renamed to l3init_60m_fclk in OMAP5, and hence the =
need for
> this binding.

I understand the intention of this patch. I was just wondering if
all the clocks should be referenced from DT even if that is not
strictly needed at the moment. This would make clocks similar to
other resources like regulators, gpios, irqs, ...

Having the clocks referenced from DT looks cleaner to me. It means I
can check the DT file for any resources used by a driver. It also
creates some kind of consistency in the kernel.

> > Should the clk_get be changed to of_clk_get()/of_clk_get_by_name() in t=
he
> > driver? This would potentially remove the need of the init_60m_fclk nam=
e.
>=20
> If we use of_clk_xxx() then we'll need to update DT nodes for OMAP4 and O=
MAP3 as
> well to explicitly provide the clock phandle.

I'm aware of this.

-- Sebastian

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSzS38AAoJENju1/PIO/qaYBQQAJwK7bcy6P0pe/RwjZons0Yp
IOeiux+lm0IAJRJZRwReHlmCKTT6T+ZNFubNqDhJh48w93fOOzerp1X829N0oMXv
7W44n0u5mCh1GBkERwfNvo8ZaSmhuQYsAoS/VQ0ySXNRAQbGu65+lSgu+iKJTlPk
l8J12zx/0rg+zV16OZhfs5YUGi08WkIr6E6aVpMhutw6poX+7DIY7UCtzA9X7hvE
AnvbB4Mv3g3vivHicxYQz2iK0hWRSrMkpjnyPJRBSDYSd6iRmOdKc03zCEJG20yn
KT0T+8+Hli5+sN83UjHUgZ0Qxt+LdCVenyBBQqTXdIcjlK5JKF8yYaJu/gLqx6yd
ypcGgW4cZRP5wKH9swru6cHlvMH04IiA0r+HryaNYquFvHvEe+iC0t9mf/S4gvTx
q0aigQ7wlcgDvvR5TFs+GyyZlgixplrY5sKWmJhXjGUUs6Ds3maJ/tbBSzda6B2c
2AOJOohnV02dNTCoYNrYLoMaUAqryLuZ1hQcRTY/qODtoUUMf+FgJhsPirHnCDem
bSuvzBJTzoZRxLJWGmWjzaZ3upz2Y0XZo4wYsUIU00fBGUXGXJyeFyg2K7bH8y5I
PDjK7xP3mQCemyfLtp1FGz0jUAPbjLVdHfrWH6Ajj9S4OBihKpNt+qj6RH9kmP5g
ty4FY3VgK3wDTDIQzo+f
=cuWS
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


--===============3583513833253500568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3583513833253500568==--
