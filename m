From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 09/15] twl4030_charger: allow max_current to be managed
 via sysfs.
Date: Sat, 7 Mar 2015 21:37:01 +0100
Message-ID: <20150307203701.GK5233@earth>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.46323.stgit@notabene.brown>
 <20150302210525.GN13270@amd>
 <20150305172600.30951e70@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150305172600.30951e70@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Mar 05, 2015 at 05:26:00PM +1100, NeilBrown wrote:
> [...]
> +What: /sys/class/power_supply/twl4030_ac/max_current
> +      /sys/class/power_supply/twl4030_usb/max_current
> +Description:
> +       Read/Write limit on current which which may
> +       be drawn from the ac (Accessory Charger) or
> +       USB port.
> +
> +       Value is in micro-Amps.
> +
> +       Value is set automatically to an appropriate
> +       value when a cable is plugged on unplugged.
                                        ^^
s/on/or

-- Sebastian

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+2FtAAoJENju1/PIO/qaJFMP/2oUA1CMeyV4HgPlCf/pdoZw
t0eqv47xn6uHwGzjooullxD98lMTIF5+W9Fas+Tw0tmua9XGp5E2Ms5Tvm74GNzo
iUmfBJwKYZE8U1U0jU5mbUhH4wk0/jhCjWGKDvsAKpacZyuuN/icKuaXOXIzYOWe
25s9joG/vVqe0a8veKw40Crl+xwvwkIufVoYvYFmAw1j+3m4olpBWvn0gNo8HNzL
P5oeiMAI7tTS0FpnxZUqcPC8IeGUqvo9l7SATBrWgnKpqXkjmZD+NAS8Zxo2edbW
JZd9PCjtXASOmmpwAnq+9wsf2c+ulUkfdp0hp0v1RFg+l2F5ico59imiX29D//Az
MMEc4T8lb5sqAFXzN0tSZ0AQcBH/i/0lP4845rJBcU0b6l4WgEchZ73Uy4NzVchd
hObEjJz5YJJjFnkrq9Vt/0RsjYw53vYi9Un27ovJC3j1w4xvIkNg/ZLf9E7A9HJs
01lb3dv/bmXlnZjmnRUkJpjIEwXfJw9j2a7JitCrfzwkWgueyj/uYgAWDqzOPp0O
iqn9cNoJeJ+qHgGR1vIJQvfjMVndd6UTbdwIAj9/ZYnjRXllH//Ah9oZkRl5Oj82
YaOM4dWUZk721VikuY4k/zb8og3f3JdiRTe/8i7QHufF9g+Af0ozgeT3X7p7p9tB
zIRDbmlcY0CW8TDFTpxm
=srTy
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
