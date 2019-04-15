From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
Date: Mon, 15 Apr 2019 14:04:41 +0200
Message-ID: <20190415120441.ka65mytvxsuzul4v@ninjato>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
 <59d32414-3859-d614-dc41-cc0a1bc63301@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lhxkp6eumrz5hzmr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59d32414-3859-d614-dc41-cc0a1bc63301@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Lengfeld <contact@stefanchrist.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


--lhxkp6eumrz5hzmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I guess the question is if it is allowed to have .master_xfer_atomic
> but not .master_xfer (and similarly for .smbus_xfer{,_atomic})? Maybe
> that decision should be made explicit? And perhaps enforced?

xfer_atomic callbacks are optional. One xfer callback is mandatory. I
did a check for falling back to master_xfer_atomic if there is no
suitable smbus_xfer_atomic. I will think about the vice-versa case you
mentioned. Yet, this is indeed a super corner case, so I prefer to fix
this incrementally.

> I don't care deeply about the above though, so feel free to do
> something about it, or
>=20
> Reviewed-by: Peter Rosin <peda@axentia.se>

Thanks for the review!


--lhxkp6eumrz5hzmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0c1kACgkQFA3kzBSg
KbY5og//XeihKLEc7DDv97Bd8+50Rbfgz2b1tUDb5iCLL0Ttpw1Kx/NFjesHZN2I
saEndxnDFct6Pb9ygV/yYRkKckqIUXzG5DMp/bDhUw+aFeSwSn6nPhSSSU1hsXG3
yHhSJhKPb3oFr+hQhdZ8dz9skH6NhdZggxQ1pFcCeTOvZ9DcJllm3dxLqZWnGNxk
+F1lyDyJBHyUWa2OzuMi908/nTR5DWPIy3rTUKYAq2teWyHMok3KR8v8FW8EsqTa
AffUcR1KV9JgVVAm79S1J1H+3IOLtt6Arh9GXvwkgiiJqvXtiygTQbA6rgTPYi9K
ZHKh3fv+T6wtOfSAPXSWacGz8k8NJoTsT64ge+IDNIV769/H7W6GgVGa8ScjEWYh
zPjEV/P8lkfI8HQ1mbcFZebFLIhdg6ki1z4TVq4HADwbgoT3uZdYwzhgnlAO7uGm
iWe9+rLUm1YXl9k5pOLpZYHkhvy2d/Rsm0WOMuQLXTDXP8yjMD+tWJcHKPy0rqDG
LV1Eqo18K+FXwBYu4hFKhblVMOtkFeDI7rk90e+BDOiN6FMOqGNoo8PslcT1T9Qe
Lv+ZJo3bjhHgJiZJsCtzZJD/JsopOptF7zEK7zh4j8TSgyWD1BPBgg80IRdwVKnF
QKUYvkby2DOPx8dFWrfLxzC5EHsWtPaHq2NibN5HlMcBRB4WYlk=
=lPUY
-----END PGP SIGNATURE-----

--lhxkp6eumrz5hzmr--
